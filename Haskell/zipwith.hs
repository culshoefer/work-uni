zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' f xs ys = [f x y | (x,y) <- (zip xs ys)]

absDiff :: Float -> Float -> Float
absDiff x y = abs (x - y)

nearEq :: Float-> Float -> Float -> Bool
nearEq small x y = small > absDiff x y

propDist :: [Float] -> Bool
propDist xs = all (<1) xs && nearEq 0.0001 1.0 (sum xs)

rv :: [a] -> [Float] -> [(a, Float)]
rv nums vals | propDist2 vals && (length vals == length nums) = zip nums vals
   	     | otherwise = []
	     where propDist2 xs = all (<1) xs && nearEq 0.0002 1.0 (sum xs)