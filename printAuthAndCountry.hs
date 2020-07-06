-- import database libraries
import Database.HDBC.PostgreSQL
import Database.HDBC
{-
Define a function that will fetch all rows from the table authority,
get the connected countries, and print them to the screen in a friendly format.
-}
printAuthAndCountry = do
  -- Connect to the Database
  conn <- connectPostgreSQL "dbname=smf"
  -- to test the connection
  t <- getTables conn
  putStrLn (if t == [] then "no table found" else head t)
  -- or? if t == [] then putStrLn "no table found"
  --                else mapM putStrLn t

  -- run the query and store the results in r
  r <- quickQuery' conn
       "SELECT iso, countryname from country order by iso" []

  -- convert each row into a string
  let stringRows = map convRow r

  -- print a title
  putStrLn "Show Me Finance --- Countries"
  putStrLn "ISO  Country Name"
  putStrLn " "
  -- print the rows output
  mapM_ putStrLn stringRows

  -- and disconnect from the database
  disconnect conn

  where convRow :: [SqlValue] -> String
        convRow [sqlISO, sqlCountryName] =
          show iso ++ ": " ++ name
          where iso = (fromSql sqlISO)::String
                name = (fromSql sqlCountryName)::String
        convRow x = fail $ "Unexpected result: " ++ show x
