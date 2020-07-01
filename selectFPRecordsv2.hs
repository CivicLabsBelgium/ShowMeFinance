import System.IO
import Data.Char

main :: IO ()
main = do
  ih <- openBinaryFile "Non_eq_18_19_with_dates.csv" ReadMode
  oh <- openBinaryFile "output.csv" WriteMode
  mainloop ih oh lFP
  hClose ih
  hClose oh

mainloop :: Handle -> Handle -> [String] -> IO ()
mainloop ih oh l =
  do ineof <- hIsEOF ih
     if ineof then return ()
              else do inpStr <- hGetLine ih
                      if (isFPR l inpStr) then hPutStrLn oh inpStr
                                          else return ()
                      mainloop ih oh l


lFP = ["AG", "AI", "AL", "AM", "AO", "AW", "BA", "BH", "BM", "BS",
       "CH", "CK", "CW", "FO", "GI", "GL", "GU", "HK", "IE", "JE",
       "KY", "LU", "ME", "MH", "MK", "MT", "MU",
       "NC", "NL", "NR", "NU", "OM", "PW", "RS", "SG", "TT", "TW",
       "VG", "VI", "VU"]

isFPR :: [String] -> String -> Bool
-- are the last two letters of a record in the list of fiscal paradises
isFPR l r = l2l r `elem` l
  where l2l = reverse . (take 2) . reverse
