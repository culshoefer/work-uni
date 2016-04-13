---just a small exercise
getLineRepeatedly :: IO [String]
getLineRepeatedly = do
                    x <- getLine
		    if length x == 0 then 
		       return [] 
		    else 
		    	 do
			  xs <- getLineRepeatedly
			  return (x:xs)

---for nim, see file nim.hs
