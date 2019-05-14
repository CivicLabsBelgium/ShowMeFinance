## Objectives 

Propagate and analyse the data on financial transactions released by the [European Securities and Market Authority](https://www.esma.europa.eu/data-systematic-internaliser-calculations) (ESMA)
Combine this data with publicly available API’s in order to enrich and refine the information to transmit to the public.

### [The OpenFIGI API](https://www.openfigi.com/api)
 
A free and public API using an open standard for identifying financial instruments, the FIGI, managed by Bloomberg. The API allows for “mapping” financial products, that is, to extract metadata associated with a given instrument by making a POST request containing identifiers of various types.
The identifier found in the ESMA data is the ISIN, managed by Standard and Poor’s. Each financial product in the lists possesses an ISIN, which can be used to retrieve metadata from OpenFIGI.  
