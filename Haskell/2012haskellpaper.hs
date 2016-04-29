mod' :: Integral a => a -> a -> a
mod' x y | y == 0 = error "Cannot divide by zero"
       	 | x < y = x
       	 | otherwise = mod' (x-y) y

divides :: Integral a => a -> a -> Bool
divides x y = 0 == mod' y x

strictFactors :: (Integral a) => a -> [a]
strictFactors num = [x | x <- [2..(num-1)], x `divides` num]

primesUpTo :: (Integral a) => a -> [a]
primesUpTo n = [x | x <- [2..n], null $ strictFactors x]

primesList :: IO [Int]
primesList = do
	     x <- getLine
	     return (primesUpTo (read x :: Int))

elem' :: (Eq a) => a -> [a] -> Bool
elem' _ [] = False
elem' n (h:hs) = n == h || elem' n hs

alphanums :: String -> String
alphanums = filter (\x -> not (x `elem'` ['.', ',', ';', ' ']))

foldr' :: (a -> b -> b) -> b -> [a] -> b
foldr' _ n [] = n
foldr' f n xs = foldr' f (f (last xs) n) (init xs)

mySum :: (Num a) => [a] -> a
mySum = foldr (+) 0 . map (^3)