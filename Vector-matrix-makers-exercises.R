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

#######  CAN USE THESE SIMPLE VECTOR MAKERS  #########
# clear out workspace
rm(list=ls())

vector.maker.num <- function() {
  sample(1:10,5)
}

vector.maker.num()

# Create a user-defined function "vector.maker.alph()"

vector.maker.alph <- function() {
  sample(letters,5)
}

vector.maker.alph()

# Create a user-defined function "vector.maker.bool()" 
# that generates a vector of logical values (T's 
# and F's). 

vector.maker.bool <- function() {
  sample(c(rep(T,5),rep(F,5)),5)
}

vector.maker.bool()