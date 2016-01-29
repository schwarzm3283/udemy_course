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

vec1 <- sample(letters, 10)
vec2 <- sample(1:50, 10)
vec3 <- sample(1:50, 20)

df.maker <- function(...){
  vec.list <- list(...)
  ven.length <- length(vec.list)
  len.check <- sapply(vec.list, length)
  
  vector.maker <- function(len=sample(2:9,1)) {
    for (i in 1:len) {
      x <- sample(1:3,1)
      if (x==1){
        rand.num <- sample(1:10,len.check[1], replace=TRUE)
        vec.list[[1+length(vec.list)]] <- rand.num
      }
      else if (x==2) {
        rand.alph <- sample(letters,len.check[1], replace=TRUE)
        vec.list[[1+length(vec.list)]] <- rand.alph
      }
      else {
        rand.bool <- sample(c(TRUE, FALSE),len.check[1], replace=TRUE)
        vec.list[[1+length(vec.list)]] <- rand.bool
      }
    }
    return(vec.list)
  }
  
  if (ven.length == 0) {
    len.check <- sample(5:10,1)
    vec.list <- vector.maker()
    names <- 1:length(vec.list)
    df.result <- data.frame(vec.list)
    colnames(df.result) <- names
    return(df.result)
  }
  else {
  len.measure <- abs(len.check) - mean(len.check)
  if (len.measure[1] != 0) {
    stop("All vectors must be the same length")
  }
  else if (ven.length < 2) {
      vec.list <- vector.maker()
      names <- 1:length(vec.list)
      df.result <- data.frame(vec.list)
      colnames(df.result) <- names
      return(df.result)
    }
    else {
      names <- 1:length(vec.list)
      df.result <- data.frame(vec.list)
      colnames(df.result) <- names
      return(df.result)
    }
  }
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

list.maker <- function(...,len=sample(3:10,1)){
  vec.list <- list(...)
  vector.maker <- function() {
    for (i in 1:len) {
      x <- sample(1:5,1)
      if (x==1){
        rand.num <- sample(1:10,sample(5:50,1), replace=TRUE)
        vec.list[[1+length(vec.list)]] <- rand.num
      }
      else if (x==2) {
        rand.alph <- sample(letters,sample(5:50,1), replace=TRUE)
        vec.list[[1+length(vec.list)]] <- rand.alph
      }
      else if (x==3) {
        row <- sample(5:10,1)
        col <- sample(5:10,1)
        tot <- (row * col)
        y <- sample(1:100,tot, replace = TRUE)
        rand.matrix <- matrix(y, nrow = row, ncol = col)
        vec.list[[1+length(vec.list)]] <- rand.matrix
      }
      else if (x==4) {
        row <- sample(5:10,1)
        col <- sample(5:10,1)
        tot <- (row * col)
        y <- sample(1:100,tot, replace = TRUE)
        rand.matrix <- matrix(y, nrow = row, ncol = col)
        rand.df <- data.frame(rand.matrix)
        vec.list[[1+length(vec.list)]] <- rand.df
      }
      else {
        rand.bool <- sample(c(TRUE, FALSE),sample(5:50,1), replace=TRUE)
        vec.list[[1+length(vec.list)]] <- rand.bool
      }
    }
    return(vec.list)
  }
  if (length(vec.list) > 0) {
    return(vec.list)
  }
  else {
    vec.list <- vector.maker()
    return(vec.list)
    
  }
}

