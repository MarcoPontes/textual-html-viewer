module Parser (
    parsing,
    Container (..)
) where

import Text.Parsec
import Text.Parsec.String

data Container = Text String Int | Container String [Container] Int

-- Realiza o parsing de texto
parseString :: Int -> Parser Container
parseString depth = do
    words <- many1 (noneOf "<")
    return $ Text words depth

-- Método principal em que é interpretado o HTML
htmlParser :: Int -> Parser Container
htmlParser depth = do
    spaces
    char '<'
    notFollowedBy $ char '/' -- Assegura que estou no ínicio da tag

    tag <- many1 (noneOf ">") <* char '>'
    words <- many (try (htmlParser (depth + 1)) <|> try (parseString (depth + 1)))

    spaces
    string "</" <* string tag <* char '>'

    return $ Container tag words depth

parsing :: String -> Container
parsing text = case parse (htmlParser $ -1) "MyParser" text of
    Left err -> error (show err)
    Right value -> value
