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


Below, the response to the curl command from above: 

![](https://github.com/CivicLabsBelgium/ShowMeFinance/blob/master/Images/Screenshot_2019-05-16%20guide%20on%20SI%20and%20OpenFIGI%20(2).png)


On the left the properties, on the right their corresponding values. Each value is an attribute of the financial instrument identified on top of the response by its FIGI number. Depending of the request, the response may contain more than one mapping job. For example, a request can be made for an ISIN (`idValue` in the body of the request) corresponding to many composite FIGI’s at the market level (`compositeFIGI` in the response). More on this below. 

The httr package for R allows to use http verbs like POST with web API’s. 
Follow this link for an [example of a mapping request with httr](https://github.com/CivicLabsBelgium/ShowMeFinance/blob/master/OpenFIGI_mapping_in_R.md).

```R
library(httr)

mapurl <- "https://api.openfigi.com/v2/mapping"

AAB <- POST(mapurl, body = '[{ "idType": "ID_ISIN", "idValue": "IT0005137614" }]', content_type_json())
content(AAB) 
```







