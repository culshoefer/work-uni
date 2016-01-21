import Test.QuickCheck
import Data.Char

halfEvens :: [ Int ] -> [ Int ]
halfEvens xs  = [if x `mod` 2 == 0 then x `div` 2 else x | x <- xs]

prop_he :: [Int] -> Bool
prop_he xs = halfEvens xs == map (\x -> if x `mod` 2 == 0 then x `div` 2 else x) xs

inRange :: Int -> Int -> [Int] -> [Int] 
inRange lower upper xs = [ x | x <- xs, x <= upper, x >= lower]

inRange' :: Int -> Int -> [Int] -> [Int]
inRange' a b xs = filter (\x -> x>=a && x<=b) xs

prop_inRange :: Int -> Int -> [Int] -> Bool
prop_inRange a b xs = inRange a b xs == inRange' a b xs

countPositives :: [ Int ] -> Int
countPositives xs = sum [1 | x <- xs, x > 0]

prop_cp :: [Int] -> Bool
prop_cp xs = countPositives xs == (length $ filter (>0) xs)

rotor :: Int -> String -> String
rotor a xs
    | a < 0 || a >= length xs  = [] --error "Please enter a valid offset"
    | otherwise = take (length xs) (drop a (cycle xs))

rotor' :: Int -> String -> String
rotor' a xs
    | a < 0 || a >= length xs  = [] --error "Please enter a valid offset"
    | a == 0 = xs
    | otherwise = rotor (a-1) $ tail xs ++ [head xs] 

prop_r :: Int -> String -> Bool
prop_r a xs = rotor a xs == rotor' a xs

makeKey :: Int -> [(Char, Char)]
makeKey offset = zip ['A'..'Z']  (rotor offset ['A'..'Z'])

lookUp :: Char -> [(Char, Char)] -> Char
lookUp x xs = head [b | (a,b) <- xs, a==x]

encipher :: Int -> Char -> Char
encipher o c = lookUp c (makeKey o)

prop_e :: Int -> Char -> Bool
prop_e 0 c | c `elem` ['A'..'Z'] = encipher 0 c == c
           | otherwise = True
prop_e n c | (n <25 && n > 0 && c `elem` ['A'..'Z']) = (encipher (26-n) $ encipher n c) == c
           | otherwise = True

normalise :: String -> String
normalise xs = filter (\x -> isDigit x || isLetter x) (map convertToUpper xs)
  where convertToUpper x = if isLetter x then toUpper x else x

prop_norm :: String -> Bool
prop_norm xs = length xs >= length ( normalise xs)

procStack :: (Num a, Read a) => [a] -> String -> [a]
procStack (x : y : ys) "*" = (y * x) : ys
procStack (x : y : ys) "+" = (y + x) : ys
procStack (x : y : ys) "-" = (y - x) : ys
procStack xs numString = read numString : xs

evalRPN :: (Num a, Read a) => String -> a
evalRPN = head . foldl procStack [] . words

words' :: String -> [String]
words' xs = foldr (\x acc -> if isSpace x then []:acc else (x:(head acc)):(tail acc)) [[]] xs

unwords' :: [String] -> String
unwords' = foldr1 (\x acc -> x ++ " " ++ acc)

--p_w :: String -> Bool
--p_w xs = unwords' (words xs) = xs

