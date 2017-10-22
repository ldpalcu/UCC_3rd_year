--Using library functions, define a function halve :: [a] -> ([a],[a])
--that splits an even-lengthed list into two halves.

halve :: [a] -> ([a],[a])
halve a = (take (length a `div` 2) a, drop (length a `div` 2) a)

halve1 :: [a] -> ([a],[a])
halve1 as = (take n as, drop n as)
       where n = length as `div` 2

--Define a function third :: [a] -> a that returns the third element in a
--list that contains at least this many elements
third1 :: [a] -> a
third1 as = as !! 2

third2 :: [a] -> a
third2 as = head (tail (tail as))

third3 :: [a] -> a
third3 (_:_:x:_) = x

safetail :: [a] -> [a]
safetail as = if null as then as else tail as

safetail1 :: [a] -> [a]
safetail1 as | null as = as
             | otherwise = tail as

safetail2 :: [a] -> [a]
safetail2 [] = []
safetail2 (_:as) = as

(||) :: Bool -> Bool -> Bool
False || False = False
True || _ = True






