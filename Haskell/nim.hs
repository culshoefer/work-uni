import System.Random
import Data.List
import Data.Maybe
import Control.Monad

data Binary = Zero | One deriving (Show, Eq)
type BinaryNumber = [Binary]

---returns a random value between the limits specified
rd :: Int -> Int -> IO Int
rd low high = getStdRandom (randomR (low , high))

---just gets a line and converts it to an int
getInt :: IO Int
getInt = do
	 a <- getLine
	 return (read a :: Int)

---will draw the number of stars in the line, specified by the list e.g. drawStars [2, 1] will draw two stars on line one, one star on line two
drawStars :: [Int] -> IO ()
drawStars [] = putChar '\n'
drawStars all@(x:xs) | x == 0 = do
                                  putChar '\n'
                                  drawStars xs
                     | otherwise = do
                                  putChar '*'
                                  drawStars ((x-1):xs)

---reduces list entry at point specified by second argument of the quantity specified by the third argument
reduce :: [Int] -> Int -> Int -> [Int]
reduce [] _ _ = error "Can't reduce empty list"
reduce (x:xs) 0 n | n < 1 = error "Entered input smaller than 1, illegal input"
       	      	  | x <= n = (0:xs)
                  | x > n  = ((x-n):xs)
reduce all@(x:xs) a n | a < 0 = error "Entered input smaller than 0, illegal input"
       	      	  | a > length all = error "Cannot reduce list at input greater than possible"
		  | n < 1 = error "Entered input smaller than 1, illegal input"
       	      	  | otherwise = x:(reduce xs (a-1) n)

---just for readability: Is the list all zeroes?
noStarsLeft :: [Int] -> Bool
noStarsLeft stars = all (==0) stars

---one star left --> all rows either zeros or ones and exactly one row has a one, only relevant for misere game
oneStarLeft :: [Int] -> Bool
oneStarLeft stars = length zones == length stars && (length ones == 1)
	    	  where ones = filter (==1) stars
	    	  	zones = filter (\x -> x <= 1 && x >= 0) stars

twoHeapsLeft :: [Int] -> Bool
twoHeapsLeft xs = 2 == (length xs - (length $ filter (==0) xs))

---a wrapper for the nimgame class with default settings
nimGameWrapper :: IO()
nimGameWrapper = nimGame [1..5] 0 0 False

--nimGame Stars StartPlayer Playmode
nimGame :: [Int] -> Int -> Int -> Bool -> IO()
nimGame stars p mode misere | not misere && noStarsLeft stars = do 
	      	     	      putStrLn $ "Player " ++ show nextPlayer ++ " won!"
	      	     	    | misere && oneStarLeft stars = do
			      putStrLn $ "Player " ++ show p ++ " won!"
  			    | otherwise = do
			      drawStars stars
			      r <- getInt
			      s <- getInt
			      nimGame (reduce stars (r-1) s) nextPlayer mode misere
			   where nextPlayer = (p+1) `mod` 2

---wrapper for the no chance game
nimGameNoChanceWrapper :: IO()
nimGameNoChanceWrapper = nimGameNoChance [1..5] 0 False

---'AI' currently doesn't support misere play. Otherwise always executes the optimal move
nimGameNoChance :: [Int] -> Int -> Bool -> IO()
nimGameNoChance stars p misere | not misere && noStarsLeft stars = do 
	      	     	      putStrLn $ "Player " ++ show nextPlayer ++ " won!"
	      	     	    | misere && oneStarLeft stars = do
			      putStrLn $ "Player " ++ show p ++ " won!"
  			    | p == 0 = do
			      drawStars stars
			      r <- getInt
			      s <- getInt
			      nimGameNoChance (reduce stars (r-1) s) nextPlayer misere
			    | otherwise = nimGameNoChance (reduce stars oRow oStars) nextPlayer misere
			   where nextPlayer = (p+1) `mod` 2
			   	 optimalMove = getOptimalMove stars
			   	 oRow = fst optimalMove
				 oStars = snd optimalMove

---wrapper for the random game
nimGameRandomComputerWrapper :: IO()
nimGameRandomComputerWrapper = nimGameRandomComputer [1..5] 0 False

---Computer does random moves. Silly computer.
nimGameRandomComputer :: [Int] -> Int -> Bool -> IO()
nimGameRandomComputer stars p misere | not misere && noStarsLeft stars = do 
	      	     	      	       putStrLn $ "Player " ++ show nextPlayer ++ " won!"
	      	     	      	     | misere && oneStarLeft stars = do
			      	       putStrLn $ "Player " ++ show p ++ " won!"
  			    	     | p == 0 = do
			      	       drawStars stars
			      	       r <- getInt
			      	       s <- getInt
			      	       nimGameRandomComputer (reduce stars (r-1) s) nextPlayer misere
			    	     | otherwise = do
			      	       r <- fst m
			      	       s <- snd m
			      	       nimGameRandomComputer (reduce stars r s) nextPlayer misere
			   	     where nextPlayer = (p+1) `mod` 2
			   	     	   m = getRandomMove stars

---converts decimal to binary
binary :: Int -> [Int]
binary 0 = []
binary n | n `mod` 2 == 0 = (binary $ div n 2) ++ [0]
         | otherwise = (binary $ div n 2) ++ [1]

---gets the binary representation of an int
getBinary :: Int -> BinaryNumber
getBinary 0 = []
getBinary n | n `mod` 2 == 0 = reverse (Zero:bin)
	    | otherwise = reverse (One:bin)
	  where half = n `div` 2
	  	bin = getBinary half

---gets the int representation of a binary number
getIntFromBinary :: BinaryNumber -> Int
getIntFromBinary xs = foldl' (\acc x -> if x == Zero then 2 * acc else 2 * acc + 1) 0 xs

---will stack overflow
prop_BinConversion :: Int -> Bool
prop_BinConversion a = a == getIntFromBinary (getBinary a)

---add leading zeros until the specified length of the binary number is reached
getBinaryLength :: BinaryNumber -> Int -> BinaryNumber
getBinaryLength b n | length b >= n = b
		    | otherwise = (take toAdd $ repeat Zero) ++ b
		      where toAdd = n - length b

---removes leading zeroes from a binary number
removeLeadingZeroes :: BinaryNumber -> BinaryNumber
removeLeadingZeroes [] = []
removeLeadingZeroes (b:bs) | b == One = (b:bs)
		    	   | otherwise = removeLeadingZeroes bs

---gives back the numbers with leading zeroes added to the shorter one
makeLengthsEqual :: (BinaryNumber, BinaryNumber) -> (BinaryNumber, BinaryNumber)
makeLengthsEqual (a, b) | length a < length b = (getBinaryLength a (length b), b)
		     	| length a > length b = (a, getBinaryLength b (length a))
			| otherwise = (a, b)

---xor on two bits
xor :: Binary -> Binary -> Binary
a `xor` b | a == b = Zero
	  | otherwise = One

---xor on two binary numbers
xorNum :: BinaryNumber -> BinaryNumber -> BinaryNumber
a `xorNum` b = removeLeadingZeroes $ zipWith xor newA newB
  	   where eqLengths = curry makeLengthsEqual a b
	   	 newA = fst eqLengths
		 newB = snd eqLengths

---xor on two ints
decXor :: Int -> Int -> Int
a `decXor` b = getIntFromBinary $ xorNum (getBinary a) (getBinary b)

---binary digital sum of a list of integers
bdsDec :: [Int] -> Int
bdsDec xs = getIntFromBinary . binaryDigitalSum $ map getBinary xs

---successively calls xorSum with each argument
binaryDigitalSum :: [BinaryNumber] -> BinaryNumber
binaryDigitalSum [] = []
binaryDigitalSum xs = foldr1' xorNum xs

---generates an optimal move (no misere game)
getOptimalMove :: [Int] -> (Int, Int)
getOptimalMove stars | twoHeapsLeft stars = optimalMoveTwoHeapsLeft stars
		     | otherwise = (nextHeap, itemsToRemove)
	       where x = bdsDec stars
	       	     hSums = map (\a -> a > (a `decXor` x)) stars
		     maybeNext = elemIndex True hSums
		     nextHeap = if maybeNext == Nothing then -1 else fromJust maybeNext
		     itemsToRemove = if nextHeap == -1 then 0 else (stars !! nextHeap) - ((stars !! nextHeap) `decXor` x)

---generates the optimal move, given that only two heaps are left to play on
optimalMoveTwoHeapsLeft :: [Int] -> (Int, Int)
optimalMoveTwoHeapsLeft stars = (nextHeap, (maximum stars) - (minimum nonZero))
			where maybeNext = elemIndex (maximum stars) stars
			      nextHeap = if maybeNext == Nothing then -1 else fromJust maybeNext
			      nonZero = filter (/=0) stars

---picks a random heap and a random number of items to remove from the stars
getRandomMove :: [Int] -> (IO Int, IO Int)
getRandomMove stars = (nextHeap, itemsToRemove)
	      where nonZero = filter (/=0) stars
	      	    nextHeap = do
		    	      	r<-randomlyChooseHeap stars
				return (fromJust (elemIndex r stars))
		    itemsToRemove = do 
		    		    items <-getItemsToRemove stars nextHeap
				    return items

---given a list of ints, randomly choose one of these
randomlyChooseHeap :: [Int] -> IO Int
randomlyChooseHeap xs = do
	       	 r<-rd 0 ((length nonZero)-1)
		 return (nonZero !! r)
		 where nonZero = filter (/=0) xs

---returns a random number s.t. the value is between 1 and the element at the index specified by the second argument
getItemsToRemove :: [Int] -> IO Int -> IO Int
getItemsToRemove xs index = do
		       		h <- index
		       		sel <- rd 1 (xs !! h)
				return sel
		       		