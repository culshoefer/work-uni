-- HOFT.hs
-- Higher Order Function Tutorial

-- defined in point free style and allowing empty lists


-- question 1.
sqList :: [Integer] -> [Integer]
sqList  = map (\x -> x*x) 

sumSqList :: [Integer] -> Integer
sumSqList = foldr (+) 0 . sqList

posList :: [Integer] -> Bool
posList = foldr (&&) True . map (>0)

fMin :: Ord a => (Integer -> a) -> Integer -> a
fMin f n = minimum $ map f [0..n]

eqF :: Eq a => (Integer -> a) -> Integer -> Bool
eqF f n = foldr (&&) True $  map ((== f(0)) . f) [0..n]

posF :: (Num a, Ord a) => (Integer -> a) -> Integer -> Bool
posF f n = foldr (&&) True $ map ((> 0) . f) [0..n]

incOrd :: Ord a => [a] -> Bool
incOrd xs = foldr (&&) True $ map (\(x,y) -> x <= y) $ zip xs (tail xs)

twice :: (a -> a) -> a -> a
twice f x = f $ f x

iter :: Integer -> (a -> a) -> a -> a
iter 0 f x = x
iter n f x = iter (n-1) f $ f x 

double :: Integer -> Integer
double n = 2*n

powerOfTwo :: Integer -> Integer
powerOfTwo 0 = 1
powerOfTwo n = iter (n-1) double 2
