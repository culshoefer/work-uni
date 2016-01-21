import Data.Char

square :: Integer -> Integer
1square x = x*x

pyth :: Integer -> Integer -> Integer
pyth a b = square a + square b

isTriple :: Integer -> Integer -> Integer -> Bool
isTriple a b c = if pyth a b == square c then True else False

isTripleAny :: Integer -> Integer -> Integer -> Bool
isTripleAny a b c =	
	    let sides = [a, b, c]
	    	middle= sum sides - minimum sides - maximum sides
	    in isTriple minimum sides middle maximum sides

isTripleAny' :: Integer -> Integer -> Integer -> Bool
isTripleAny' a b c = isTriple a b c || isTriple a c b || isTriple c b a

--div, mod:: Int -> Int -> Int

halfEvens :: [ Int ] -> [ Int ]
halfEvens xs  = [if x `mod` 2 == 0 then x `div` 2 else x | x <- xs]

inRange :: Int -> Int -> [Int] -> [Int] 
inRange lower upper xs = [ x | x <- xs, x <= upper, x >= lower]

countPositives :: [ Int ] -> Int
countPositives xs = sum [1 | x <- xs, x > 0]

capitalised :: String -> String
capitalised xs = toUpper (head xs) :[toLower x | x <- tail xs] 

title :: [String] -> [String]
title [[]] = [[]]
title x = capitalised x
title (x:xs) = title (init xs) ++ [if length (head xs)>=4 then capitalised (head xs) else lowerMe (head xs)]

title' :: [String] -> [String]
title' xxs = capitalised (head xxs) : [if length xs > 3 then capitalised xs else lowerMe xs  | xs  <- tail xxs]

lowerMe :: String -> String
lowerMe xs = [toLower x | x <- xs]