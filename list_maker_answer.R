################################################ 
##########    DATA FRAME MAKER    ############## 
################################################ 

##########    ALSO LIST MAKER     ############## 
################################################  

############   DATA FRAME MAKER   ##############  
# Data Frame Maker should accept a variable number 
# of all optional arguments consisting of vectors 
# of any mode, but of equal length and returns a 
# data frame that contains these vectors.   
# If the number of vectors is less than 2,  
# it self-generates 2-9 additional vector of 
# different modes. The function creates a 
# data frame of a variable number of  
# input vectors. The input vectors can be any 
# mode, but must be of same length  

df.maker <- function(...){
  test <- list(...)
  return(test)
}

###############   LIST MAKER    ##########################  
# list.maker(...) accepts a variable number of (optional) 
# arguments which consist of some combination of vectors, 
# matrices, and data frames. list.maker() assembles them 
# into a list which it returns. If there are no calling  
# arguments, list.maker() creates its own list of at least 
# 3 components of differing structures and/or modes.  
# Hint: Is OK to use the previous vector.maker() function 
# in either dataframe.maker() or list.maker().  



