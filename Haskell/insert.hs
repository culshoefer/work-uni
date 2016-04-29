insert :: Int -> [Int] -> [Int]
insert y xs = [a | a <- xs, a<=y] ++ [y] ++ [a | a <- xs, a > y]

insert' :: Int -> [Int] -> [Int]
insert' y [] = [y]
insert' y (x:xs) | x < y = x:(insert' y xs)
	  	 | otherwise = y:(x:xs)

prop_insert :: Int -> [Int] -> Bool
prop_insert y xs = insert y xs == insert' y xs

ones :: a -> Int
ones a = 1

myLength::  [a] -> Int
myLength [] = 0
myLength (x:xs) = 1 + myLength xs

myLength' :: [a] -> Int
myLength' = foldr (+) 0 . map ones

prop_myLength :: [a] -> Bool
prop_myLength xs = myLength xs == myLength' xs