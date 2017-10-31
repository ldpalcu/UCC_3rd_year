{-
 -Name: Palcu Liana-Daniela
 -Number: 117106643
 -Assignment: 03.
-}

import Data.List
import Data.Char

--This purpose of this assignment is about implementing an English to
--Pin Latin translator
--We use the next two rules for translating words:
--1. For a word that starts with a consonant sound, the letters before 
--the initial vowel are moved to the end of the word and then we add 
--ay to the end of the word;
--2. For a word that starts with a vowel sound, we add way to the end of the word.
main :: IO ()
main = do line <- getLine
          putStrLn (translate_both line)

--translate_both function applies Rule 1 and Rule 2
--by composing two functions consonant_translate which
--applies Rule 1 and vowel_translate which applies Rule 2
translate_both :: String -> String
translate_both = consonant_translate.vowel_translate

--consonant_translate is implemented by using a high-order
--function "map" which applies the Rule 1 for every word which begins with a consonant from
--the list of words returned by parse function.
--After the words are translated I used the concat function
--to make a string again 
consonant_translate :: String -> String
consonant_translate phrase = concat (map (build_consonant_word.translate) (parse phrase))

--vowel_translate is implemented by using a high-order function
--"map" which applies the Rule 2 for every word which begins with a vowel from the list
--of words returned by parse function.
--After the words are translated I used concat function to make a string again.
vowel_translate :: String-> String
vowel_translate phrase = concat (map build_vowel_word (parse phrase))

--is_vowel checks if a character is a vowel
is_vowel :: Char -> Bool
is_vowel c = c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u'

--is_consonant checks if a character is a consonant
is_consonant :: Char -> Bool
is_consonant x = if (not (is_vowel x)) && isLetter x then True else False

--translate function returns a tuple whose first element is a string
--by consonants or an empty string and the second element is the rest of the word
translate :: String -> (String,String)
translate word = span (is_consonant) word 

--build_consonant_word function builds a word which follows
--the Rule 1
build_consonant_word :: (String,String) -> String
build_consonant_word tuple = if fst(tuple) == "" then snd(tuple) else snd tuple ++ fst tuple ++ "ay"

--build_vowel_word function builds a word which follows the Rule 2		          
build_vowel_word :: String -> String
build_vowel_word word = if is_vowel(head(word)) then word ++ "way"
					     else word

--parse function transforms a string in a list of words
--by using make_the_list function
parse :: String -> [String]
parse [] = []
parse phrase = make_the_list (span (isLetter) phrase)

--make_the_list function takes a tuple of strings as argument
--and returns a list of words and non-letters characters in order
--which they appear in the original string
--if the first element of tuple is an empty string that means
--it is a non-letter value then I append the first character from the
--second element as a string to final list and then I recall the parse function with
--the second element from tuple without first character
--else it means I have a word and I append it to the list and then
--I recall the parse function with the second element from tuple
make_the_list :: (String,String) -> [String]
make_the_list result = if fst(result) == "" then [head(snd(result))]:parse (tail(snd(result))) 
						else fst(result):parse (snd(result))



