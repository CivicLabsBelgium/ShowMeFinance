# ShowMeFinance

## There’s something wrong with finance data  

- Increasing role of technology is making finance more global and intricate by the day, while concentrating wealth and knowledge in a small portion of the population. 
- Due to complexity and remoteness, finance data is hardly accessible to stakeholders in the current debates on questions such as ecology, human rights or sovereign debt.  
- There's a knowledge gap between finance and the institutions representing the interest of the general public: governments, law courts or the press. This gap has the effect of fostering defiance towards political and judicial institutions, thus popularizing authoritarian regimes and threatening the Rule of Law. 
- On the side of finance, the same defiance results in the adoption of tax evading schemes relying of tax havens inside and outside Europe, reinforcing sovereign debt, income inequality and negative sentiment towards institutions. 

 
## How to fix it 

- Leveraging collaborative programming methods and tools to pass actionable information to the general public in visual form and clear language. 
- Open sourcing information on trade markets to improve transparency and promote ethical finance. 
- Moving from competition to collaboration in market analysis to build up accountability and trust.
- Using free and open databases and API's to improve financial literacy and raise awareness on economical issues.
- Investigating toxic debt and vulture funds to address systemic risk and destructive financial practice.




## In practice: Mapping European financial data to the OpenFIGI API 

- Objectives 

Propagate and analyse the data on financial transactions released by the [European Securities and Market Authority](https://www.esma.europa.eu/data-systematic-internaliser-calculations) (ESMA)
Combine this data with publicly available API’s in order to enrich and refine the information to transmit to the public.

- [The OpenFIGI API](https://www.openfigi.com/api)
 
A free and public API using an open standard for identifying financial instruments, the FIGI, managed by Bloomberg. The API allows for “mapping” financial products, that is, to extract metadata associated with a given instrument by making a POST request containing identifiers of various types.
The identifier found in the ESMA data is the ISIN, managed by Standard and Poor’s. Each financial product in the lists possesses an ISIN, which can be used to retrieve metadata from OpenFIGI. 
