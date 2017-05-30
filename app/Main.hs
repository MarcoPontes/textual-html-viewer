module Main where

import Parser
import System.Environment
import qualified Text.Show.Pretty as PrettyShow

main :: IO ()
main = do
    [file] <- getArgs
    text <- readFile file
    putStrLn $ PrettyShow.ppShow $ parsing text
