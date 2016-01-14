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
## Matrix maker(row, col) generates a numeric matrix.
## Unless user specifies values of (either or both)
## the row x col dimension attributes, matrix.maker()
## randomly generates a matrix with (5 to 10) rows and
## (5 to 10) columns. Numers in cells are randomly-
## generated integers between 1 and 100.

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


# simple function randomly creates and returns
# a numeric, character or logical vector. Each
# vector is either: (1) length x (if specified)
# or (2) 5-10 random elements.
vector.maker <- function(x=sample((5:10),1)) {
  vec <- list(sample(1:100,x),
              sample(letters,x),
              sample(c(rep(T,25),rep(F,25)),x))
  unlist(sample(c(vec[1],vec[2],vec[3]),1))
}

vector.maker()
vector.maker(5)
vector.maker(sample(5:10,1))

##################   MATRIX  MAKER   ########################

# matrix maker(row, col) generates a numeric matrix.
# Unless user specifies values of (either or both)
# the row x col dimension attributes, matrix.maker
# randomly generates a matrix with (5 to 10) rows and
# (5 to 10) columns. Numers in cells are randomly-
# generated integers between 1 and 100.

matrix.maker <- function(nrow=sample(5:10,1),
                         ncol=sample(5:10,1),
                         data = sample((1:100),15120,replace=T)){
  matrix(data, nrow, ncol)
  }

matrix.maker()
matrix.maker(5,2)
