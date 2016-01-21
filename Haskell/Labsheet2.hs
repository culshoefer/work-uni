{-# LANGUAGE ParallelListComp #-}
import Data.Char

inRange :: Int -> Int -> [Int] -> [Int]
inRange a b []     = []
inRange a b (x:xs) = if x>=a && x<=b then x:(inRange a b xs) else inRange a b xs

inRange' :: Int -> Int -> [Int] -> [Int]
inRange' a b xs = filter (\x -> x>=a && x<=b) xs

countPositives :: Real a => [a] -> Int
countPositives [] = 0
countPositives (x:xs) = if x > 0 then 1 + rest else rest
 where rest = countPositives xs

countPositives' :: Real a => [a] -> Int
countPositives' xs = foldl (\acc x -> acc + 1) 0 (filter (>0) xs)

capitalised :: String -> String
capitalised (x:[]) = toUpper x : []
capitalised xs = capitalised (init xs) ++ [toLower (last xs)]

--capitalised' :: String -> String
--capitalised' xs = foldr (\x acc -> [toLower x]:acc) 
                        

title :: [String] -> [String]
title (x:[]) = capitalised x : []
title xs = title (init xs) ++ [if (length (last xs) >= 4) then capitalised (last xs) else map toLower (last xs)]

isort :: Ord a => [a] -> [a]
isort [] = []
isort (k:xs) =  foldr (\x acc -> if x<=k then x:accisort(xs)


merge :: Ord a => [a] -> [a] -> [a]
merge [] [] = []
merge [] (x:xs) = x: merge [] xs
merge (x:xs) [] = x: merge xs []
merge (x1:xs1) (x2:xs2) = if (x1<x2) then x1: merge xs1 (x2:xs2) else x2 : merge (x1:xs1) xs2

msort :: Ord a => [a] -> [a]
msort xs
    | length xs <= 1 = xs
    | otherwise = merge (msort (take halfLength xs)) (msort (drop halfLength xs))
    where halfLength = (length xs) `div` 2


rotor :: Int -> String -> String
rotor a xs
    | a < 0 || a >= length xs  = error "Please enter a valid offset"
    | otherwise = take (length xs) (drop a (cycle xs))

makeKey :: Int -> [(Char, Char)]
makeKey offset = zip ['A'..'Z']  (rotor offset ['A'..'Z'])

lookUp :: Char -> [(Char, Char)] -> Char
lookUp x xs = head [b | (a,b) <- xs, a==x]

encipher :: Int -> Char -> Char
encipher o c = lookUp c (makeKey o)

normalise :: String -> String
normalise xs = filter (\x -> isDigit x || isLetter x) (map convertToUpper xs)
  where convertToUpper x = if isLetter x then toUpper x else x

encipherStr :: Int -> String -> String
encipherStr o xs = map (\x -> if (isLetter x) then encipher o x else x) (normalise xs)

decipher :: String -> [String]
decipher xs = [encipherStr o xs | o <- [0..25]]