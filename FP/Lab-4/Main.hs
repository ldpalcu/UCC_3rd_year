{-
 - Name: Daniela Palcu
 - Number: 117106643
 - Assignment: 04
 -}
module Main where
--The purpose of this assignment is to implement a representation
--for polymorphic lists using user-defined recursive algebraic data
--types and functions on these new types by pattern matching on the
--constructors of the data types.

--algebraic data type called List created using the new style
data List a = Nil | Cons { value :: a 
                          ,next :: List a
                         } deriving (Show)  

--insert function takes two arguments: the first is the List and the
--second is the element. I used the type Ord because it allows us to
--perform comparision operations. This function should insert its value
--argument in the ordered position of its list argument. After this
--operation the list should be always sorted.
insert :: Ord a => List a -> a -> List a  
insert Nil x = Cons {value = x, next = Nil}
insert (Cons {value = y, next = ys}) x | x <= y = 
    (Cons { value = x, next = Cons {value = y, next =ys}}) 
                                       | otherwise = 
    Cons { value = y, next = (insert ys x)}

--foldr' represents the implementation of foldr. 
--It works the same as foldr but on the List data type.
foldr' :: (a -> b -> b) -> b -> List a -> b
foldr' f b Nil = b
foldr' f b (Cons {value = x, next = xs}) = f x (foldr' f b xs)

--foldl' represents the implementation of foldl.
--It works the same as foldl but on the List data type
foldl' :: (b -> a -> b) -> b -> List a -> b
foldl' f b Nil = b
foldl' f b (Cons {value = x, next = xs}) = foldl' f (f b x) xs

--pretty_print is a function which takes a list of List data type
--and transform it into a string which looks like a general list.
--I used Show type because the List type use it so that it can be
--printed.This function uses another function pretty_print_help
--which takes the same arguments but helps the pretty_print function
--so that the string can begin with the "[".When the list it will
--have only one argument it will print the argument and "]".
pretty_print :: Show a => List a -> String
pretty_print Nil = "[]"
pretty_print (Cons {value = y, next = ys}) = 
    "[" ++ show y ++ "," ++ pretty_print_help ys

pretty_print_help :: Show a => List a -> String
pretty_print_help (Cons {value = y, next = Nil}) = show y ++ "]"
pretty_print_help (Cons {value = y, next = ys}) = 
    show y ++ "," ++ pretty_print_help ys

--create_from_list function takes one argument, a general list which
--will be transformed into a list of List data type.
--I used foldr to create the list and function insert. Because the
--insert function requires Ord type I used it also here.
--Because the insert function takes a list and then an element I
--used the flip function so that the foldr function work properly.
--If I use only insert, it will give me an error.
create_from_list :: Ord a => [a] -> List a
create_from_list [] = Nil
create_from_list xs = foldr (flip insert) Nil xs

main = putStrLn $ pretty_print $ create_from_list list
    where list = [1,2,3,5,4] :: [Int]

 
