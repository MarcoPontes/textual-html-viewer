module Parser (
    parsing
) where

import Text.Parsec
import Text.Parsec.String

data Container = Newline | Text String | Container String [Container] deriving Show

parseNewline :: Parser Container
parseNewline = do
    string "\n"
    spaces
    -- notFollowedBy $ char '<'
    return Newline

parseString :: Parser Container
parseString = do
    word <- many1 (noneOf "\n<")
    return $ Text word

main :: Parser Container
main = do
    spaces
    char '<'
    tag <- many1 (noneOf ">") <* char '>'
    word <- many (try main <|> try parseString <|> try parseNewline)
    spaces
    string "</" <* string tag <* char '>'
    return $ Container tag word

parsing :: String -> Container
parsing text = case parse main "MyParser" text of
    Left err -> error (show err)
    Right value -> value
