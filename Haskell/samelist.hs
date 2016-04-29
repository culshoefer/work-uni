sameList :: (Eq a) => [a] -> [a] -> Bool
sameList [] [] = True
sameList [] _ = False
sameList _ [] = False
sameList (x:xs) (y:ys) = xs == ys && sameList xs ys

sumPosSqr :: [Int] -> Int
sumPosSqr = foldr (+) 0 . map (^2) . filter (>0)

wonkyLen :: IO ()
wonkyLen = do
		xs <- getLine
		putStrLn(show $ 1 + length xs)