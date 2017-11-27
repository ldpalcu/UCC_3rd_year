{-
 - Name: Daniela Palcu
 - Number: 117106643
 - Assignment: 05.
 -}
module Main where
-- PART 1

--I defined a data type called TwoValued consisting of two values:One 
--and Two.
--The values of the data type should be comparable, ordered and convertible
--so I used deriving to do this
data TwoValued = One | Two
     deriving (Eq, Ord, Show)

--TwoValued is made as an instance of the class Bounded
--I override the two functions for TwoValued so that minBound will return 
--One and maxBound will return Two
instance Bounded TwoValued where
    minBound = One
    maxBound = Two

-- PART 2
-- I defined a class called Incrementable which provides the next function.
-- The next function takes an argument and returns the smallest value such
-- that a < next a.
class Incrementable a where
    next :: a -> a

--TwoValued is made as an instance of the class Bounded
--I override the next function for TwoValued so that next One will return
--Two and next Two will return undefined because it doesn't exist a value
--bigger than Two.
instance Incrementable TwoValued where
    next One = Two
    next Two = undefined

-- PART 3
--I defined a class called Testable for testing predicates about values
--from types that are Incrementable and orderable (Ord) (the context).
--This class provides a default implementation for its function check.
--The check function take as arguments a predicate and two values, first
--and last.
--The predicate takes as its argument a value between first and last.
--If one of the values doesn't satisfy the condition imposed by predicate
--the check function will return False. If all values satisfy the condition
--the check function will return True. I used the next function from 
--Incrementable class to find the next value until the last. 
class (Ord a, Incrementable a) => Testable a where
    check :: (a -> Bool) -> a -> a -> Bool
    check p start end | start < end = p start && check p (next start) end
                      | start == end = p start
                      | otherwise = True

--TwoValues is made as an instance of Testable class
instance Testable TwoValued

--tests which check if the check function works
test1 :: [Bool]
test1 = [check (==One) first last | first <- ot, last <- ot]
    where ot = [One,Two]

test2 :: [Bool]
test2 = [check (==Two) first last | first <- ot, last <- ot]
    where ot = [One,Two]

-- PART 4

--I made lists of type [a] instances of the Incrementable for values of 
--type a that are in the Incrementable class, in the Ord class, in the
--Enum class, and in the Bounded class.
--I override the next function which takes a list, reverses it, 
--increments every element of it with the help of the next' function.
--The next' function takes a list and if the first element is less than
--maxBound it will increment it (with the help of next function) 
--and the rest of the list will remain the same. If the element is 
--equal with maxBound then the first element will become the 
--the minBound and it increments the second element and the list
--will remain the same.
--If the second element is equal with maxBound I will update it
--with minBound and it will increment the next element and the
--list will remain the same and so on.
instance (Incrementable a,Eq a,Ord a,Bounded a) => Incrementable [a] where
    next = reverse . next' . reverse
      where
        next' :: (Incrementable a, Ord a, Bounded a) => [a] -> [a]
        next' [] = []
        next' (vk:vs) | vk == maxBound = minBound : next' vs
                      | otherwise = (next vk) : vs

 
-- PART 5
-- I made a lists of type [a] instances of the Testable for values of
-- type a that are in the Incrementable class, in the Ord class, in 
-- the Enum class and in the Bounded class so that I can test my check
-- function with  multiple values.
instance (Incrementable a, Eq a, Ord a, Bounded a) => Testable [a]

main = do putStrLn $ show $ test ([One,Two,Two] ==)
          putStrLn $ show $ test ([One,Two,Two] /=)
          putStrLn $ show $ test ([One,Two,Two] <)
          putStrLn $ show $ test ([Two,Two,Two] >=)
          putStrLn $ show $ test (>= [Two,Two,Two])
    where test p = [int p bs [Two,Two,Two] | bs <-bss]
          int p a a' = if check p a a' then 1 else 0
          bs = [One,Two]
          bss = [[a,b,c] | a <- bs, b <- bs, c <- bs]

