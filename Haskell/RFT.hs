-- RFT.hs 
-- Recursive functions tutorial 

import Test.QuickCheck

elemNum :: Eq a => a -> [a] -> Integer
elemNum x [ ] = 0
elemNum x (y:ys) | x == y     = 1 + elemNum x ys
                 | otherwise  = elemNum x ys

unique' :: Eq a => [a] -> [a] -> [a]
unique' [ ] ys = [ ]
unique' (x:xs) ys | elemNum x ys == 1 = x : (unique' xs ys)
                  | otherwise         = unique' xs ys

unique :: Eq a => [a] -> [a]
unique xs = unique' xs xs

prop_elemNumUnique :: Eq a => a -> [a] -> Bool
prop_elemNumUnique x xs = elemNum x (unique xs) < 2

insert :: Ord a => a -> [a] -> [a]
insert x [ ] = [x]
insert x (y:ys) | x > y     = y : (insert x ys)
                | otherwise = x : (y : ys)

isort :: Ord a => [a] -> [a]
isort [ ] = [ ]
isort (x:xs) = insert x (isort xs)

insert' :: Ord a => a -> [a] -> [a]
insert' x [ ] = [x]
insert' x (y:ys) | x == y = insert' x ys
                 | x < y = y : (insert' x ys)
                 | otherwise = x : (y:ys)


