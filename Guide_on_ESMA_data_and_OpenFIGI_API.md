# Understanding the ESMA data and the OpenFIGI API


## The ESMA data on financial transactions in the EU


[Data sets published by the European Securities and Markets Authority (ESMA)](https://www.esma.europa.eu/data-systematic-internaliser-calculations) in the frame of the MIFID II directive. 

> According to Article 4(1)(20) of Directive 2014/65/EU (MiFID II) investment firms dealing on own account when executing client orders over the counter (OTC) on an organised, frequent, systematic and substantial basis are subject to the mandatory systematic internaliser (SI) regime. 


![\Data set from the Systematic Internaliser calculations](https://github.com/CivicLabsBelgium/ShowMeFinance/blob/master/Images/Screenshot_2019-05-16%20guide%20on%20SI%20and%20OpenFIGI%20(0).png)

* Col. A and B give the starting and ending dates of the Systematic Internaliser calculations. Market participants are required by the ESMA to submit their transactions figures on a voluntary basis if they pass a given threshold. This policy is known as the Systematic Internaliser regime. Above the threshold, a market participant receives the denomination “systematic internaliser” from the ESMA. Other denominations are used and are being discussed in an effort to regulate Over-The-Counter (OTC) platforms.

* Col. C shows the ISIN number. Each financial product is registered by the ESMA under its own ISIN. ISIN’s are managed by Standard and Poor’s as a proprietary standard. 

* Col. D shows the total number of transactions for the given ISIN during the period of calculation. Transaction data is collected from registered european electronic trading platforms (ETP). 

* Col E. is the total turnover of the calculated transactions, it shows the sum in euros that was spent over the period of calculation to exchange the ISIN in col C. 


## Information available through the [OpenFIGI API](https://www.openfigi.com/api)


Free and public API using FIGI, an open standard for identifying financial instruments managed by Bloomberg. The API allows for “mapping” financial products, that is, to extract metadata associated with a given instrument by making a POST request containing identifiers of the said instrument. OpenFIGI accepts identifiers of various types.  


### Example of mapping request


![https://www.openfigi.com/api#introduction](https://github.com/CivicLabsBelgium/ShowMeFinance/blob/master/Images/Screenshot_2019-05-16%20guide%20on%20SI%20and%20OpenFIGI%20(1).png)





![](https://github.com/CivicLabsBelgium/ShowMeFinance/blob/master/Images/Screenshot_2019-05-16%20guide%20on%20SI%20and%20OpenFIGI%20(2).png)


On the left the properties, on the right their corresponding values. Each value is an attribute of the financial instrument identified on top of the response by its FIGI number. Depending of the request, the response may contain more than one mapping job. For example, a request can be made for an ISIN (`idValue` in the body of the request) corresponding to many composite FIGI’s at the market level (`compositeFIGI` in the response). More on this below. 

The httr package for R allows to use http verbs like POST with web API’s. 
Follow this link for an example of [mapping request of an Italian sovereign bond](https://github.com/CivicLabsBelgium/ShowMeFinance/blob/master/OpenFIGI_mapping_in_R.md).

```R
library(httr)

mapurl <- "https://api.openfigi.com/v2/mapping"

AAB <- POST(mapurl, body = '[{ "idType": "ID_ISIN", "idValue": "IT0005137614" }]', content_type_json())
content(AAB) 
```
The `POST`function takes a body argument in the form of an array of objects (or mapping jobs): `[{...}, {...}, ...]`.


### Example of mapping request for an equity traded on multiple trading floors 


```R
library(httr)

mapurl <- "https://api.openfigi.com/v2/mapping"

responseEq <- POST(mapurl, body = '[{ "idType": "ID_ISIN", "idValue": "US4592001014" }]', content_type_json())

content(responseEq)
```

JSON response from the console: 

```
[[1]]$`data`[[141]]
[[1]]$`data`[[141]]$`figi`
[1] "BBG00JX0P1F5"

[[1]]$`data`[[141]]$name
[1] "INTL BUSINESS MACHINES CORP"

[[1]]$`data`[[141]]$ticker
[1] "IBM*"

[[1]]$`data`[[141]]$exchCode
[1] "MU"

[[1]]$`data`[[141]]$compositeFIGI
[1] "BBG000HW8Q13"
```

At least 36 mapping jobs in the response, from [[115]] to [[141]], each corresponding to a different trading floor (`exchCode`)

To prevent lengthy responses, [OpenFIGI has a rate limit](https://www.openfigi.com/api#rate-limit) , which can be raised with an API key obtainable with an email address attached to a valid domain:


### Formatting a request


#### ISIN and FIGI identifiers 


Since ISIN and FIGI are the two identifiers used for mapping the SI lists from ESMA on OpenFIGI, only these are discussed here. 

The table below comes from [the OpenFIGI documentation on the API](https://www.openfigi.com/api#post-v2-mapping), it shows the identifier elements of a mapping request. `idType` gives the type of identifier used and `idValue` gives the actual number identifying the instrument. 

![](https://github.com/CivicLabsBelgium/ShowMeFinance/blob/master/Images/Screenshot_2019-05-16%20guide%20on%20SI%20and%20OpenFIGI%20(3).png)


The request needs at least the IdType and idValue of the instrument. 

Third party identifiers are standards created by various organisations to identify traded instruments. 

IN the link below, the [list of available identifiers](https://www.openfigi.com/api#v2-idType-values)  to make requests to OpenFIGI:  

To identify a given instrument across countries and trading floors, a combination of properties are needed in the mapping request.  

The ISIN is the identifier used in the SI lists. It’s the most common identifier worldwide: 


![](https://github.com/CivicLabsBelgium/ShowMeFinance/blob/master/Images/Screenshot_2019-05-16%20guide%20on%20SI%20and%20OpenFIGI%20(4).png)


A mapping job of the SI lists would contain at least the ISIN codes. 

Bloomberg developed the FIGI identifier to address the complexity of competing identification standards:


![](https://github.com/CivicLabsBelgium/ShowMeFinance/blob/master/Images/Screenshot_2019-05-16%20guide%20on%20SI%20and%20OpenFIGI%20(5).png)


The FIGI is used to identify a single instrument across all markets. As a global identifier, it is similar to the ISIN.  

The composite FIGI links an instrument to its global FIGI at the trade venue level. It is designed to replace the various third party identifiers used by market participants.


![](https://github.com/CivicLabsBelgium/ShowMeFinance/blob/master/Images/Screenshot_2019-05-16%20guide%20on%20SI%20and%20OpenFIGI%20(6).png)


The share class FIGI is a third layer of identification for instruments traded in multiple countries:


![](https://github.com/CivicLabsBelgium/ShowMeFinance/blob/master/Images/Screenshot_2019-05-16%20guide%20on%20SI%20and%20OpenFIGI%20(7).png)


The security ID number gives some description of the instrument. In the example below, IBM is the company emitting the bond, 7 stands for 7% interest rate and 10/30/25 is the maturity date.


![](https://github.com/CivicLabsBelgium/ShowMeFinance/blob/master/Images/Screenshot_2019-05-16%20guide%20on%20SI%20and%20OpenFIGI%20(8).png)


### Other exploitables properties in mapping requests


OpenFIGI allows for mapping request detailing specific properties of the instruments. Below is an overview of what kind of information to expect with the most relevant properties. 


#### Trading floors


![](https://github.com/CivicLabsBelgium/ShowMeFinance/blob/master/Images/Screenshot_2019-05-16%20guide%20on%20SI%20and%20OpenFIGI%20(9).png)

Request for instruments exchanged on a specific trading floor. Useful for targeting marketplaces in Europe for example. 
Here's [the full list of codes](https://www.openfigi.com/api/enumValues/v2/exchCode) under this property. 
The codes are mostly impossible to read at first look, it will be necessary to join them to their human readable names. 

*Post mapping:* 
- Analysing network of trading floors for centrality.  
- Ranking trading floors by volume and specialty.
- Combining with market sector and security type.  

The following property is the ISO list of marketplaces[](https://www.openfigi.com/api/enumValues/v2/micCode). `micCode` is equivalent to `exchCode` but the list is a bit shorter.


![](https://github.com/CivicLabsBelgium/ShowMeFinance/blob/master/Images/Screenshot_2019-05-16%20guide%20on%20SI%20and%20OpenFIGI%20(10).png)



#### Currency


![](https://github.com/CivicLabsBelgium/ShowMeFinance/blob/master/Images/Screenshot_2019-05-16%20guide%20on%20SI%20and%20OpenFIGI%20(11).png)


Filtering a mapping request by currency. Searching for equities traded in euro could be a way to narrow the search in OpenFIGI for europeans trading floors. This property doesn’t appear in the mapping response, it can only be used to narrow a mapping request. 


#### Market sector


![](https://github.com/CivicLabsBelgium/ShowMeFinance/blob/master/Images/Screenshot_2019-05-16%20guide%20on%20SI%20and%20OpenFIGI%20(12).png)


Market sectors include categories such as equity, government bonds or commodity. [Here's the full list of values](https://www.openfigi.com/api/enumValues/v2/marketSecDes), it’s short.  


*Post mapping:* 
- Counting instruments by market sector.
- Combining with trading floors and countries.
- Translate codes in human-readable names. 
- Network analysis for centrality.


#### Security type


![](https://github.com/CivicLabsBelgium/ShowMeFinance/blob/master/Images/Screenshot_2019-05-16%20guide%20on%20SI%20and%20OpenFIGI%20(13).png)


The [list of values for security type](https://www.openfigi.com/api/enumValues/v2/securityType) is long and detailed. First thing to do should be translating the codes into human readable names. It seems redundant to request a mapping job with a combination of ISIN identifier and security type, but after mapping the whole ESMA list, typology will be useful. One important caveat is the veracity of ESMA data regarding derivatives, which constitute the majority of security types. It should be assessed whether or not numbers can be trusted.  


*Post mapping:*
- Making codes human-readable 
- Batching security type values following a typology adapted to communication 
- Combine typology with properties such as trading floors and countries for counts and stats
