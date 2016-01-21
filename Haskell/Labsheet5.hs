import System.Random

getLineRepeatedly :: String -> IO ()
getLineRepeatedly [] = putStrLn("Player 1 won")
getLineRepeatedly xs = do
                     x <- getLine
                     putStrLn(xs)
                     getLineRepeatedly x

drawStars :: [Int] -> IO ()
drawStars [] = putChar '\n'
drawStars all@(x:xs) | x == 0 = do
                                  putChar '\n'
                                  drawStars xs
                     | otherwise = do
                                  putChar '*'
                                  drawStars ((x-1):xs)

reduce :: [Int] -> Int -> Int -> [Int]
reduce [] _ _ = error "Can't reduce empty list"
reduce (x:xs) 0 n | x <= n = (0:xs)
                  | x > n  = ((x-n):xs)
reduce (x:xs) a n = x:(reduce xs (a-1) n)

--nimGame Stars StartPlayer Playmode
nimGame :: [Int] -> Int -> Int -> IO()
nimGame stars p m | all (==0) stars = do putStrLn("Player " ++ show ((p+1) `mod` 2) ++ " won!")
                  | otherwise = do
                     drawStars stars
                     r <- getLine
                     s <- getLine
                     let rowNum = read r
                         staNum = read s
                     nimGame (reduce stars (rowNum-1) staNum) ((p+1) `mod` 2) m

binary :: Int -> [Int]
binary 0 = []
binary n | n `mod` 2 == 0 = (binary $ div n 2) ++ [0]
         | otherwise = (binary $ div n 2) ++ [1]

rd :: Int -> Int -> IO Int
rd low high = getStdRandom (randomR (low , high))

emptyRows :: [Int] -> Int
emptyRows = length . filter (==0)

--bds :: Int -> Int -> Int
--a bds b = 