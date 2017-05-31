module Main where

import System.Environment
import Parser
import Printer

-- Programa recebe um ficheiro HTML como argumento para realizar o parsing
main :: IO ()
main = do
    [file] <- getArgs
    text <- readFile file
    prettyPrint $ parsing text
