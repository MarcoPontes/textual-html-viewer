module Printer (
    prettyPrint
) where

import Parser
import System.Console.ANSI


-- Realiza a impressão adequada a cada tag
prettyPrint :: Container -> IO()
prettyPrint pack =
  case pack of
    Container tag list depth ->
      case tag of
        "p" -> do
          putStrLn ""
          mapM_ prettyPrint list
          putStrLn ""
        "em" -> do
          setSGR [SetItalicized True]
          mapM_ prettyPrint list
          setSGR [SetItalicized False]
        "h1" -> do
          setSGR [SetConsoleIntensity BoldIntensity, SetColor Foreground Vivid Blue]
          mapM_ prettyPrint list
          putStrLn ""
          setSGR [Reset]
        "h2" -> do
          setSGR [SetItalicized True, SetColor Foreground Vivid Cyan]
          mapM_ prettyPrint list
          putStrLn ""
          setSGR [Reset]
        -- TO DO: Implementação de Listas
        -- "ul" -> do
        --   putStrLn ""
        --   mapM_ printUL list
        -- "ol" -> do
        --   putStrLn ""
        --   mapM_ printOL list
        _ ->
          mapM_ prettyPrint list
    Text tag depth ->
      putStr tag
