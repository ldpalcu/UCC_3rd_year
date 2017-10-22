 --Chapter5

--Ex1.Sum of the firs one hundred integer squares.
sum100squares :: Int
sum100squares = sum [x^2 | x <- [1..100]]

--Ex2.Returns a coordinate grid of diffrent size
grid :: Int -> Int -> [(Int, Int)]
grid m n = [(x, y)| x <- [0..m], y<-[0..n]]

--EX3.Returns a coordinate square of size n excluding diagonal
square :: Int -> [(Int, Int)]
square n = [(x, y)| (x, y) <- grid 2 2, x/=y]

--Ex4.Replicate-produces a list of identical elements.
replicate :: Int -> a -> [a]
replicate n x = [x | _ <- [1..n]]

--EX5.Returns a list of ttriples whose components are pythaogrean numbers.
pyths :: Int -> [(Int, Int, Int)]
pyths n = [(x, y, z)| x <- [1..n], y <- [1..n], z <- [1..n], x^2 + y^2 == z^2]

--EX6.Define a list of perfect numbers. A number is perfect if it is equal with sum of its factors.
factors :: Int -> [Int]
factors n = [x | x <- [1..n-1], n `mod` x == 0]

perfects :: Int -> [Int]
perfects n = [x | x <- [1..n], x == sum (factors x)]



