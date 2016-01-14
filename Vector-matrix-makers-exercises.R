################################################
########## VECTOR MAKER  MODIFIED ##############
################################################
##########   ALSO MATRIX MAKER    ##############
################################################

## Modify your vector makers (or use mine from
## previous day) and modify the three vector
## maker functions (repeated below) so that:
## 1) They are one function, vector.maker()
## 2) When you call it, it randomly returns
## either a numeric, character, or logical
## vector.
## 3) Still have an optional argument for
## length of returned vector
## 4) BUT, if length not specified, length
## should be RANDOM NUMBER between 5 and 10.
## (Not exactly five elements like last time).

vector.maker <- function(len=sample(5:10,1)) {
  if (!(len %in% 5:10)) stop(paste(("Error")))
  x <- sample(1:3,1)
      if (x==1){
        rand.num <- sample(1:10,len, replace=FALSE)
        return(rand.num)
      }
      else if (x==2) {
        rand.alph <- sample(letters,len, replace=FALSE)
        return(rand.alph)
      }
      else {
        rand.bool <- sample(c(TRUE, FALSE),len, replace=TRUE)
        return(rand.bool)
      }
  }
#############  MATRIX MAKER  ##################
## Create a function matrix.maker(row,col)
## matrix.maker(row, col) generates a numeric matrix.
## Unless user specifies values of (either or both)
## the row x col dimension attributes, matrix.maker()
## randomly generates a matrix with (5 to 10) rows and
## (5 to 10) columns. Numers in cells are randomly-
## generated integers between 1 and 100.

## NOTE: Is OK to use matrix() function INSIDE your
## user-defined matrix.maker() function

matrix.maker <- function(row=sample(5:10,1), col=sample(5:10,1)) {
  x <- (row * col)
  y <- sample(1:100,x, replace = TRUE)
  rand.matrix <- matrix(y, nrow = row, ncol = col)
  return(rand.matrix)
}
