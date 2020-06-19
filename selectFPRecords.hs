import System.IO
import Data.Char
-- import Text.ParserCombinators.Parsec


-- main = interact (unlines . filter (isFPR lFP) . lines)
-- main = interact (unlines . filter (elem 'a') . lines)
main :: IO ()
main = do
  ih <- openBinaryFile "exchcode_non_eq_may19.csv" ReadMode
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

-- main :: IO ()
-- main = do
-- temporarily use a test FP ISO codes
--        let l = ["CH", "IE", "HK", "NL"]
{-  parse FP ISO codes to produce the list of codes whose records are to be kept in the transactions output file -}
-- file containing fiscal paradises codes
--       fph <- openBinaryFile "fp-ISO.csv" ReadMode
-- as a test, just copy a file
--       ih <- openBinaryFile "exchcode_non_eq_may19.csv" ReadMode
--       oh <- openBinaryFile "output.csv" WriteMode       
-- build list of 2 characters (apart maybe for the first one) fiscal paradises ISO codes
--       listISO <- buildFPL fph
--       print listISO
       
--       mainloop ih oh
-- file containing the operations to be selected
--       opFileh <- openBinaryFile "exchcode_non_eq_may19.csv" ReadMode
-- filter, and retain selected records
--       selectedRecordsh <- openBinaryFile "sr" WriteMode

-- 
--       mainloop opFile selectedRecordsh
--       interact id
-- close all files
--       hClose fph
--       hClose ih
--       hClose oh
--        hClose opFileh
--        hClose selectedRecordsh

-- build the FP list
-- buildFPL :: Handle -> IO String
-- buildFPL h =
--   do ineof <- hIsEOF h
--      if ineof -- ineof
--         then return []
--         else do inpStr <- hGetLine h
--                 next <- buildFPL h
--                 return $ inpStr ++ ['\n'] ++ next

--       inpStr <- readFile "input.txt"
--       writeFile "output.txt" (map toUpper inpStr)
{-
This code will be used to parse the FP csv file to build a list of FP ISO codes.

csvFile = endBy line eol
line = sepBy cell (char ',')
cell = quotedCell <|> many (noneOf ",\n\r")

-- when a cell contains a comma, it is quoted
quotedCell = 
    do char '"'
       content <- many quotedChar
       char '"' <?> "quote at end of cell"
       return content

-- if a quoted cell contains a quote, the quote is repeated
quotedChar =
        noneOf "\""
    <|> try (string "\"\"" >> return '"')
    
-- end of line characters
eol =   try (string "\n\r")
    <|> try (string "\r\n")
    <|> string "\n"
    <|> string "\r"
    <?> "end of line"

parseCSV :: String -> Either ParseError [[String]]
parseCSV input = parse csvFile "(unknown)" input

main =
    do c <- getContents
       case parse csvFile "(stdin)" c of
            Left e -> do putStrLn "Error parsing input:"
                         print e
            Right r -> mapM_ print r
-}
{- as a test, just copy the file
mainloop :: Handle -> Handle -> IO ()
mainloop i o = do
  ineof <- hIsEOF i
  if ineof then return ()
           else do inpStr <- hGetLine i
                   hPutStrLn o inpStr
                   mainloop i o
-}