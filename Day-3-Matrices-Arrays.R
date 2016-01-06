################################################
#######       MATRICES AND ARRAYS       ########
################################################

# Matrix is a vector with two additional attributes:
# 1) the number of rows; and 2) the number of columns

# Marices have modes, ie numeric, character

### CREATING MATRICES

# Matrix function

# Internal storage matrix is 'column-major-order'
# which means it stores by columns: 1, then 2, etc

(y <- matrix(c(1,2,3,4),nrow=2,ncol=2))

# can leave off one dimen or other

(y <- matrix(c(1,2,3,4),ncol=2))

# returns second column
y[,2]

# can specify individual elements
(y <- matrix(nrow=2,ncol=2))
y[1,1] <- 1
y[2,1] <- 2
y
y[1,2] <- 3
y[2,2] <- 4
y

# can override column-major-order with byrow = T

m <- matrix(c(1,2,3,4,5,6),nrow=2,byrow=T)
m

### GENERAL MATRIX OPERATIONS

# Performing Linear Algebra

y%*%y # mathematical matrix multiplication

3*y # mathematical multiplication of matrix by scalar

y+y # mathematical matrix addition

# Matrix indexing
(z <- matrix(c(1,2,3,4,1,1,0,0,1,0,1,0), nrow=4, ncol=3))
# extracting columns as submatrix
z[,2:3]

(y <- matrix(c(11,21,31,12,22,32),nrow=3,ncol=2))
# extracting rows
y[2:3,]
y[2:3,2]

# can assign values to submatrices
y
y[c(1,3),] <- matrix(c(1,1,8,12),nrow=2)
y

# another example
x <- matrix(nrow=3,ncol=3)
x
y <- matrix(c(4,5,2,3),nrow=2)
y

x[2:3,2:3] <- y
x

## Filtering on Matrices

# Filtering can be done with matrices. You must be careful
# Let's start with a simple example:
x <- matrix(c(1,2,3,2,3,4),nrow=3)
x

x[x[,2] >= 3,] # second and third rows of original 
               # matrix x are TRUE

# another example

z <- c(5,12,13)
x[z %% 2 == 1,] # first and third row of x are TRUE

# can apply vector operations to them:

m <- matrix(1:6,nrow=3)
m

m[m[,1] > 1 & m[,2] > 5,] # only third row true for both conditions

# another

m <- matrix(c(5,2,9,-1,10,11),nrow=3)
m

which(m > 2) # is returning m values as a vector

##################################################
####                                          ####
####         STOP  HERE  ON  OCT  23          ####
####                                          ####
##################################################

### EXTENDED EXAMPLE: Generating a Covariance Matix

# Covariance matrix is always symmetric
# element in row 1, col 2 = element in row 2, col 1

# Working with n-variate normal distribution
# with n rows and n columns 
# If we want each of n variables to have variance=1
# with correlation rho. For n=3 and rho=0.2 we have

#   1  0.2  0.2
# 0.2    1  0.2
# 0.2    1    1

# can generate this kind of matrix with this code:

makecov <- function(rho,n) { # col(), row() returns col#, row#
  m <- matrix(nrow=n,ncol=n)
  m <- ifelse(row(m) == col(m),1,rho) # row(m) returns matrix
  return(m) # integers values, each one showing row # of corr ele of m
  }

makecov(0.2,3)

# For example, can use this  property:
z <- matrix(3:11,nrow=3)
z  # z is 3 x 3
row(z) # returns the indexes of rows in both columns
m
m <- matrix(c(m,4,5,3),nrow=3)
m # none of the element values of m is same as z
z # none of element values of z same as m
col(m) # returns the indexes of columns in both columns
row(z)==col(m) # always true where row = col, false elsewhere
row(m)==col(m) # same return same thing

rho = 0.2
ifelse(row(m)==col(m),1,rho) # puts 1's in diagonal

## we will come back to this property of matrices

#############################################################
#####                                                   #####
#####           STOP  HERE  ON  OCTOBER  23             #####
#####                                                   #####
#############################################################

## Program findols.R
findols <- function(x) {
  findol <- function(xrow) {
    mdn <- median(xrow)
    devs <- abs(xrow-mdn)
    return(which.max(devs))
  }
  return(apply(x,1,findol))
}

## Program makecov
makecov <- function(rho,n) {
  m <- matrix(nrow=n,ncol=n)
  m <- ifelse(row(m) == col(m),1,rho)
  return(m)
}

## Program mind
# returns the minimum value of d[i,j], i != j, 
# and the row/col attaining
# that minimum, for square symmetric matrix d; 
# no special policy on ties
mind <- function(d) {
  n <- nrow(d)
  # add a column to identify row number for apply()
  dd <- cbind(d,1:n)  _label~ddline@
  wmins <- apply(dd[-n,],1,imin)
  # wmins will be 2xn, 1st row being indices and 
  # 2nd being values
  i <- which.min(wmins[2,])
  j <- wmins[1,i] 
  return(c(d[i,j],i,j)) 
}

# finds the location, value of the minimum in a row x
imin <- function(x) { 
                     lx <- length(x)
                     i <- x[lx]  # original row number
                     j <- which.min(x[(i+1):(lx-1)]) 
                     k <- i+j 
                     return(c(k,x[k]))
}

## Program minda
minda <- function(d) {
  smallest <- min(d)
  ij <- which(d == smallest,arr.ind=TRUE)
  return(c(smallest,ij))
}
