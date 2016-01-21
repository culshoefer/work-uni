mult :: (Num a) => [a] -> a
mult = foldr1 (*)

posList :: [Int] -> [Int]
posList = filter (>0)

trueList :: [Bool] -> Bool
trueList = foldr1 (&&)

evenList :: (Integral a) => [a] -> [a]
evenList = filter even

maxList :: (Ord a) => [a] -> a
maxList = foldr1 (\x acc -> if x>acc then x else acc)

inRange :: Int -> Int -> [Int] -> [Int]
inRange a b = filter (\x -> x >= (min a b) && x <= (max a b))

countPositives :: (Floating a, Ord a) => [a] -> Integer
countPositives = foldr (\x acc -> if x > 0 then acc + 1 else acc) 0

myLength :: [a] -> Integer
myLength = \xs -> foldr (+) 0 $ map (\_ -> 1) xs

myMap :: (a -> b) -> [a] -> [b]
myMap f = foldr (\x acc-> f x : acc) []

myLength' :: [a] -> Integer
myLength' = foldr (\_ acc -> succ acc) 0
