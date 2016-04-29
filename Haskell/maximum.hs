maximum' :: Ord a => [a] -> a
maximum' [] = error "maximum of empty list"
maximum' [x] = x
maximum' (x:xs)
	| x > maxTail  = x
	| otherwise = maxTail
	where maxTail = maximum' xs

sameHead :: (Eq a) => [a] -> [a] -> Bool
sameHead [] _ = False
sameHead _ [] = False
sameHead (x:xs) (y:ys) = x == y

biggerThan :: (Ord a, Num a) => Int -> [a] -> [a]
biggerThan _ [] = []
biggerThan n (x:xs) | (fromIntegral n) < x  = x:(biggerThan n xs)
	     	    | otherwise = biggerThan n xs