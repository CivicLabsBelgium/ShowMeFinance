# Mapping job of an ISIN identifer with the [OpenFIGI API](https://www.openfigi.com/api). 

The API allows to retreive metadata on financial products with POST requests taking various identification systems as arguments. 
The ISIN number is the identifier used in this example. The ISIN (International Securities Identification Number) is the most common identifier for financial products. The attribution of ISIN numbers is managed by Standard and Poor's.
Since 2018, the ESMA (European Securities and Market Authority) publishes the [Systematic Internaliser calculations](https://www.esma.europa.eu/data-systematic-internaliser-calculations) (SI lists).
The ESMA aims at publishing the volume and number of transactions of financial products over the European Union. 

By mapping the SI lists with the OpenFIGI API, it is possible to obtain more detailed information on financial products. 
Following the initial goal to obtain information on the secondary market of sovereign bonds and investigate vulture funds, 
the focus is here on a sovereign bond from Italy. Sovereign bonds are found in the Non-equity CSV files of the ESMA Systematic Internaliser Calculations. 

Posterior to the mapping job, the original CSV file from the SI list has been uploaded and cleaned in RStudio, 
this part is dealt with in (INTERNAL LINK)  

## Data from the ESMA

First row in the ESMA list “nonequity_si_calculations”, where one bond (ISIN) = one row:   

Calculation From Date | Calculation To Date | ISIN | Transactions in the EU | Turnover in the EU 
----------------------|---------------------|------|------------------------|-------------------
1/1/2018 | 6/30/2018 | IT0005137614 | 9,895 | 140,000,000,000.000


The Italian bond is the first of the list by transactions and turnover, note the period of calculation. 
This is from an early list where data was still incomplete. 

Mapping on the OpenFIGI API with the httr package: 

```R
library(httr)

mapurl <- "https://api.openfigi.com/v2/mapping"

AAB <- POST(mapurl, body = '[{ "idType": "ID_ISIN", "idValue": "IT0005137614" }]', content_type_json())
content(AAB)
```

The response from the console:

```R
> IT0 <- content(AAB)
> str(IT0)
List of 1
 $ :List of 1
  ..$ data:List of 1
  .. ..$ :List of 12
  .. .. ..$ figi               : chr "BBG00B3KMP34"
  .. .. ..$ name               : chr "CCTS EU"
  .. .. ..$ ticker             : chr "CCTS F 12/15/22 EU"
  .. .. ..$ exchCode           : chr "MOT"
  .. .. ..$ compositeFIGI      : NULL
  .. .. ..$ uniqueID           : chr "COUV9933598"
  .. .. ..$ securityType       : chr "EURO-ZONE"
  .. .. ..$ marketSector       : chr "Govt"
  .. .. ..$ shareClassFIGI     : NULL
  .. .. ..$ uniqueIDFutOpt     : NULL
  .. .. ..$ securityType2      : chr "Corp"
  .. .. ..$ securityDescription: chr "CCTS Float 12/15/22"
  ```

The property `exchcode` stands for trading floor, the value `MOT` is the code designating [the multilateral trading facility for fixed income regulated by Borsa Italiana](https://www.lseg.com/areas-expertise/our-markets/borsa-italiana/fixed-income-markets/mot), a branch of London Stock Exchange.

More information on the metadata in the response in the Guide (INTERNAL LINK)
