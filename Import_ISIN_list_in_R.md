# Wrap the import operation in one R function


The .csv files containing the lists of financial products identifiers (ISIN numbers) are released by the [European Securities and Markets Authority](https://www.esma.europa.eu/data-systematic-internaliser-calculations)  

Set directory:

```R
setwd("filepath/example")
```

x = the .csv file name, for ex.: nonequity_si_calculations_-_publication_file 15-10-18 - SI calculations.csv

```R
import_SI.csv <- function(x)
{
```

Import .csv from directory, set up column names and classes, set decimal sign to "."

```R 
 SI_import <- read.csv(x, header = TRUE, dec = ".", 
                        col.names = c("From", "To", "ISIN", "Transactions", "Turnover"), 
                        colClasses = c("character", "character", "character", "character", "character"))                          
```

Change the format of col. "From" and "To" into date 

```R 
SI_import$From <- as.Date(SI_import$From, format = "%m/%d/%Y")
SI_import$To <- as.Date(SI_import$To, format = "%m/%d/%Y")
``` 

Remove "," after thousands

```R 
SI_import$Transactions <- gsub(",","", SI_import$Transactions)
SI_import$Turnover <- gsub(",","", SI_import$Turnover)
```   

Change col. Transactions and Turnover into numeric 

```R
SI_import$Transactions <- as.numeric(SI_import$Transactions)
SI_import$Turnover <- as.numeric(SI_import$Turnover)
```     

Replace zero's by NA's 

```R  
SI_import[SI_import == 0] <- NA 
```  

Return the table SI_import

```R  
return(SI_import)
}
``` 
