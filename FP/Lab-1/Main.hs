{-
 - Name: Palcu Liana-Daniela.
 - Number: 117106643.
 - Assignment: 1.
 -}

--This function called knight1 takes a Bool argument and returns its argument. Knight always says the true 
--(represented by a Bool argument) so a knight function always returns its argument.

knight1 :: Bool -> Bool
knight1 q = q

--This function called knave1 takes an argument which has the Bool type and returns the complement of its argument which obviously has the same type, Bool type.
--Knave always lies, so a knave function will return the complement of what he says.For this, I used a built-in Haskell function, "not".Basically, we build
--a new function using an old function.
knave1 :: Bool -> Bool
knave1 q = not q

--This function called knight2 takes an argument which has the Bool type and returns this argument. It was implemented by using pattern matching technique.
--Pattern matching consists of specifying patterns to which some data should conform and function returns data according to those patterns.
knight2 :: Bool -> Bool
knight2 True = True
knight2 False = False

--This function called knave2 takes an argument which has the Bool type and return the complement of its argument. It was implemented by using lambda expression.
--Lamba expressions are using to create anonymous function that can be passed to high-order functions.
knave2 :: Bool -> Bool
knave2 = \q -> not q

--This function called knave3 takes an argument which has the Bool type and return the complement of its argument. We used partial application as implementation,
--which means that function takes fewer arguments than it has. This technique is very useful when you want to apply a function to another function.
knave3 :: Bool -> Bool
knave3 = not

--This function called inhabitants returns a list of functions. Each of these function takes a Bool argument and returns this argument or its complement.
--Basically, this function build a list of functions.
inhabitants :: [Bool -> Bool]
inhabitants = [knight1, knight2, knave1, knave2, knave3]

--This function called getInhabitant takes an Int as argument and return the ith member from the list inhabitants. It was built by using an old function,
-- (!!) which returns the ith member from a list. I used this this type (Bool -> Bool) because the result is a function defined previously.
getInhabitant :: Int -> (Bool -> Bool)
getInhabitant i = inhabitants !! i

--This function called ask takes an Int and a Bool as its arguments and returns the value that is returned if you called the ith member of inhabitants list
--and pass the Bool argument to it. We apply the first argument to the getInhabitant function whose result is a function which takes the Bool argument and apply
--to it. This kind of function is called curried function.
ask :: Int -> Bool -> Bool
ask i b = (getInhabitant i) b

--This function called double_negation takes a Bool argument and returns the result of a compose function.
--This function is not similar with knave1 because when you compose it with itself it's like you are writing not not b which means b.
--For example if the value of b is True, first it is applied to knave1 from the right whose result will be False. And this value it is used as argument for
--the function knave1 from the left whose result will be True as the argument given to the double_negation function. It is similar with knight1 function.
double_negation :: Bool -> Bool
double_negation b = (knave1.knave1) b

--This function called interrogate1 takes as its arguments a function and a Bool value which is applied to this function. It returns the Bool argument, that means
--the function (first argument) should not modify this argument. I used the idea described previously, by using composition of function with itself will not change
--the result.
interrogate1 :: (Bool -> Bool) -> Bool -> Bool
interrogate1 func b = (func.func) b

--This function called interrogate2 uses the same idea as interrogate1, but it is implemented by using lambda expressions.
interrogate2 :: (Bool -> Bool) -> Bool -> Bool
interrogate2 = \func -> \b -> (func.func) b

--This function called interrogate3 uses the same idea as interrogate3, but it is implemented by using partial application. It takes only one argument to create
--a function which takes the second argument and return the same result.
interrogate3 :: (Bool -> Bool) -> Bool -> Bool
interrogate3 func = (func.func)

 





