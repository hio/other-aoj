
module Cubic (main) where

main :: IO ()
main = do
  x <- readInt
  putStrLn $ show $ cubic x

readInt :: IO Int
readInt = do
  line <- getLine
  return $ read line

cubic :: Int -> Int
cubic x = x * x * x
