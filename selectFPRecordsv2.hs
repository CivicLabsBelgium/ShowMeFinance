-- comments start with two -, like this : --
-- these two statements import the libraries we need
import System.IO
import Data.Char
-- this is the main loop
-- it will open the input and output files, process them, and close
main :: IO ()
main = do
-- opens input file and get a handle
  ih <- openBinaryFile "Non_eq_18_19_with_dates.csv" ReadMode
-- opens output file and get a handle
  oh <- openBinaryFile "output.csv" WriteMode
-- process
  mainloop ih oh lFP
-- close both files
  hClose ih
  hClose oh

mainloop :: Handle -> Handle -> [String] -> IO ()
mainloop ih oh l =
  -- hIsEOF is True when we reached the end of file
  do ineof <- hIsEOF ih
  -- when the end of file is reached, there is nothing to process anymore
     if ineof then return ()
      -- when we are not at the end of file, read the next line
              else do inpStr <- hGetLine ih
              -- if it's a fiscal paradise record, write the record into the output file
                      if (isFPR l inpStr) then hPutStrLn oh inpStr
                        -- disregard the records that are not fiscal paradise records
                                          else return ()
                      -- get the next record
                      mainloop ih oh l

-- list of 2 letters ISO codes os fiscal paradises
-- this should, in the future, be imported from a database
lFP = ["AG", "AI", "AL", "AM", "AO", "AW", "BA", "BH", "BM", "BS",
       "CH", "CK", "CW", "FO", "GI", "GL", "GU", "HK", "IE", "JE",
       "KY", "LU", "ME", "MH", "MK", "MT", "MU",
       "NC", "NL", "NR", "NU", "OM", "PW", "RS", "SG", "TT", "TW",
       "VG", "VI", "VU"]
-- is the record a fiscal paradise record?
-- takes a list of strings and a string as arguments, and gives a boolean
isFPR :: [String] -> String -> Bool
-- are the last two letters of a record in the list of fiscal paradises ?
isFPR l r = l2l r `elem` l -- are the last 2 characters in the list?
  where l2l = reverse . (take 2) . reverse -- reverses the record, takes the last 2 characters
                                           -- (they are thus reversed), and reverses them.
