import Data.Char

square:: Integer -> Integer
square x = x * x 

pyth:: Integer -> Integer -> Integer
pyth a b = (square a) + (square b)

isTriple:: Integer -> Integer -> Integer -> Bool
isTriple a b c = pyth a b == square c

min3:: Integer -> Integer -> Integer -> Integer
min3 a b c = (min a (min b c))

max3:: Integer -> Integer -> Integer -> Integer
max3 a b c = (max a (max b c))

isTripleAny:: Integer -> Integer -> Integer -> Bool
isTripleAny a b c = isTriple (min3 a b c) (sum [a, b, c] - (max3 a b c + min3 a b c)) $ max3 a b c

halfEvens:: [Int] -> [Int]
halfEvens xs = [if x `mod` 2 == 0 then x `div` 2 else x | x <- xs]

inRange:: Int -> Int -> [Int] -> [Int]
inRange low high xs = [x | x <- xs, low <= x, high >= x]

countPositives:: [Int] -> Int
countPositives xs = length [x | x <- xs, x > 0]

countPositives':: [Int] -> Int
countPositives' = length . filter (>0)

capitalised:: String -> String
capitalised (x:xs) = toUpper x:map toLower xs

title:: [String] -> [String]
title (x:xs) = (capitalised x): (foldr (\e acc -> (if ((length e) > 3) then (capitalised e) else (map toLower e)):acc) [] xs)
