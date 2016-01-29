###############################################
### OBJECT ORIENTED PROGRAMMING: S3 CLASSES ###
###############################################

# What is object-oriented programming?
# OOP makes for clearer, more reusable code. 

# Although different from the familiar OOP 
# languages like C++, Java, and Python, R is 
# very much OOP:

# Following characteristics are key to R:

# Everything you touch in R-ranging from 
# numbers to character strings to matrices
# -is an object.

# R promotes encapsulation, which is 
# packaging separate but related data
# items into one class instance. Encapsulation 
# helps you keep track of related
# variables, enhancing clarity.

# R classes are polymorphic, which means that
# the same function call leads to different
# operations for objects of different classes. 
# For instance, a call to print() on an object 
# of a certain class triggers a call to a print
# function tailored to that class. Polymorphism 
# promotes reusability.

# R allows inheritance, which allows 
# extending a given class to a more 
# specialized class.

##### S3 CLASSES

# The original R structure for classes, known 
# as S3, is still the dominant class paradigm
# in R use today. Indeed, most of R's own 
# built-in classes are of the S3 type.

# An S3 class consists of a list, with a class 
# name attribute and dispatch capability added.
# The latter enables the use of generic 
# functions, as we witnessed previously.

##### S3 Generic Functions

# R is polymorphic, in the sense that the same 
# function can lead to different operations 
# for different classes. You can apply plot(), 
# for example, to many different types of 
# objects, getting a different type of plot
# for each. The same is true for print(), 
# summary(), and many other functions.

# This allows a uniform interface to different 
# classes. Also, they are easier to remember !
# Functions that work with polymorphism, such 
# as plot() and print(), are known as generic 
# functions. When a generic function is called,
# R will then dispatch the call to the proper 
# class method, meaning that it will reroute 
# the call to a function defined for that 
# object's class.

##### EXAMPLE: OOP in lm() Linear Model Function
# simple regression analysis run 
# using R's lm() function.

# What does lm() do?

lm
example(lm)
# The output of this help query will tell you, 
# among other things, that this function
# returns an object of class "lm".

# We create an instance of this object 
# and then print it:

x <- c(1,2,3)
y <- c(1,3,8)
lmout <- lm(y ~ x)
class(lmout)
lmout

# We printed out the object lmout. 
# R interpreter then saw that lmout was an 
# object of class "lm" and thus called
# print.lm(), a special print method for the 
# "lm" class. 

# In R terminology, the call to the generic 
# function print() was dispatched to the 
# method print.lm() associated with the 
# class "lm".

# We look at the generic function and the 
# class method:

print

print.lm

# print() consists solely of a call to 
# UseMethod(). This is actually the 
# dispatcher function in view of print()'s 
# role as a generic function.

# The point is that the printing depends
# on context, with a special print function 
# called for the "lm" class. 

# Now we print this object with its class
# attribute removed:

unclass(lmout)

# author of lm() made print.lm() much more
# concise.

##### Finding the Implementations 
##### of Generic Methods

# One can find all implementations of a 
# given generic method by calling methods():

methods(print)

# Asterisks denote nonvisible functions, 
# meaning ones that are not in the default
# namespaces. 

##### WRITING S3 CLASSES

# S3 classes have a rather cobbled-together 
# structure. A class instance is created
# by forming a list, with the components 
# of the list being the member variables
# of the class. 

# The "class" attribute is set by hand by
# using the attr() or class() function, 
# and then various implementations of
# generic functions are defined. We can 
# see this in the case of lm() by inspecting
# the function:

lm

# the basic process is there. A list was 
# created and assigned to z, which will 
# serve as the framework for the "lm" class
# instance.

# Some components of that list, such as 
# residuals, were already assigned when
# the list was created. In addition, the 
# class attribute was set to "lm".

# We look at an example of how to write 
# an S3 class.

# Continuing our employee example we could
# write this:

j <- list(name="Joe", salary=55000, union=T)
class(j) <- "employee"

# we check the attributes:
attributes(j) 

# Before we write a print method for this 
# class, let's see what happens when we
# call the default print():

j

# j was treated as a list for printing 
# purposes.

# Now we write our own print method:

print.employee <- function(wrkr) {
  cat(wrkr$name,"\n")
  cat("salary",wrkr$salary,"\n")
  cat("union member",wrkr$union,"\n")
}

# Any call to print() on an object of 
# class "employee" should now be referred
# to print.employee(). We check:

methods(,"employee")

# We can simply try it out:

j

##### Using Inheritance

# Inheritance enables the formation of
# new classes as specialized versions of 
# older classes.

# We could form a new class devoted to 
# hourly employees, "hrlyemployee", as a 
# subclass of "employee":

k <- list(name="Kate", 
          salary= 68000, 
          union=F, 
          hrsthismonth= 2)

class(k) <- c("hrlyemployee","employee")

# Our new class has one extra variable: 
# hrsthismonth. The name of the new class
# consists of two character strings, 
# representing the new class and the old
# class. Our new class inherits the methods 
# of the old one. For instance,
# print.employee() still works on the new 
# class:

k

# Simply typing k resulted in the call 
# print(k). In turn, that caused UseMethod()
# to search for a print method on the first 
# of k's two class names, "hrlyemployee". 
# That search failed, so UseMethod() tried 
# the other class name, "employee", and 
# found print.employee(). It executed the 
# latter.

# in inspecting the code for "lm", you saw this line:
# class(z) <- c(if(is.matrix(y)) "mlm", "lm")

# You can see that "mlm" is a subclass of 
# "lm" for vector-valued response variables.

##### EXTENDED EXAMPLE: A Class for Storing 
##### Upper-Triangular Matrices

# write an R class "ut" for upper-triangular 
# matrices. These are square matrices whose 
# elements below the diagonal are zeros, 
# such as:.

# 1  5 12
# 0  6  9
# 0  0  2

# Can save storage space by storing only
# nonzero portion of the matrix.

# The component mat of this class will 
# store the matrix. To save on storage 
# space, only the diagonal and above-
# diagonal elements will be stored and in
# column-major order. Storage for the matrix
# above consists of the vector (1,5,6,12,9,2),
# and the component mat has that value.

# We include a component ix in this class, 
# to show where in mat the various columns
# begin. For the preceding case, ix is 
# c(1,2,4), meaning that column 1 begins at 
# mat[1], column 2 begins at mat[2], and 
# column 3 begins at mat[4]. This allows 
# for handy access to individual elements 
# or columns of the matrix.

# Here is our code:

# class "ut", compact storage of 
# upper-triangular matrices

# utility function, returns 1+...+i
sum1toi <- function(i) return(i*(i+1)/2)

# create an object of class "ut" 
# from the full matrix inmat (0s included)

# ut() function below is a constructor, it
# creates an instance of the class

ut <- function(inmat) {
  n <- nrow(inmat)
  # start to build the object
  # using a list
  rtrn <- list() 
  class(rtrn) <- "ut"
  # main member variables of class will be
  # mat and idx, implemented as components
  # of the list. Here we allocate memory for
  # these two components
  rtrn$mat <- vector(length=sum1toi(n))
  rtrn$ix <- sum1toi(0:(n-1)) + 1
  # this loop fills in rtrn$mat column by column
  # and assigns rtrn$idx element by element
  ################################################
  #### all of this for loop could be replaced with
  #### rtrn$mat <- inmat[row(inmat) <= col(inmat)]
  #### (see notes that follow after all the code)
  ################################################
  for (i in 1:n) {
    # store column i
    ixi <- rtrn$ix[i]
    rtrn$mat[ixi:(ixi+i-1)] <- inmat[1:i,i]
    }
  return(rtrn)
}

# one of three methods we create for ut class
# uncompress utmat to a full matrix
expandut <- function(utmat) {
  # numbers of rows and cols of matrix
  n <- length(utmat$ix) 
  fullmat <- matrix(nrow=n,ncol=n)
  for (j in 1:n) {
    # next 2 lines are key
    # fill jth column
    start <- utmat$ix[j]
    fin <- start + j - 1
    # above-diag part of col j
    abovediagj <- utmat$mat[start:fin]
    # jth data copied to full matrix:
    # rep() generates lower 0's in matrix
    fullmat[,j] <- c(abovediagj,rep(0,n-j))
    }
  return(fullmat)
}

# 2th method we create is for printing
# it uses expandut
# print matrix
print.ut <- function(utmat)
  # this call of print for a 'ut' object
  # is dispatched to print.ut()
  print(expandut(utmat))

# 3rd method we create
# multiply one compressed ut matrix by another, 
# returning another ut instance;
# implement as a binary operation:
"%mut%" <- function(utmat1,utmat2) {
  # numbers of rows and cols of matrix
  n <- length(utmat1$ix)
  # we allocate space for product matrix;
  # first argument vector of zeros of length n^2
  utprod <- ut(matrix(0,nrow=n,ncol=n))
  for (i in 1:n) { # compute col i of product
    # let a[j] and bj denote columns j of utmat1 
    # and utmat2, respectively,
    # so that, e.g. b2[1] means element 1 of 
    # column 2 of utmat2
    # then column i of product is equal to
    # bi[1]*a[1] + ... + bi[i]*a[i]
    # find index of start of column i in utmat2
    startbi <- utmat2$ix[i]
    # initialize vector that will become bi[1]*a[1] + ... + bi[i]*a[i]
    prodcoli <- rep(0,i)
    for (j in 1:i) { # find bi[j]*a[j], add to prodcoli
      startaj <- utmat1$ix[j]
      bielement <- utmat2$mat[startbi+j-1]
      prodcoli[1:j] <- prodcoli[1:j] +
        bielement * utmat1$mat[startaj:(startaj+j-1)]
     }
    # now need to tack on the lower 0s
    startprodcoli <- sum1toi(i-1)+1
    utprod$mat[startbi:(startbi+i-1)] <- prodcoli
    }
  return(utprod)
}

# Let's test it.
test <- function() {
  utm1 <- ut(rbind(1:2,c(0,2)))
  utm2 <- ut(rbind(3:2,c(0,1)))
  # matrix multiplication
  # of utm1 and utm2
  utp <- utm1 %mut% utm2
  # print each matrix:
  print(utm1)
  print(utm2)
  print(utp)
  # create and print new matrices:
  utm1 <- ut(rbind(1:3,0:2,c(0,0,5)))
  utm2 <- ut(rbind(4:2,0:2,c(0,0,1)))
  utp <- utm1 %mut% utm2
  print(utm1)
  print(utm2)
  print(utp)
}

test()

# Throughout the code, we take into account 
# the fact that the matrices involved have 
# a lot of zeros. For example, we avoid 
# multiplying by zeros simply by not adding
# terms to sums when the terms include a 0 
# factor. 

# The ut() function is fairly straightforward.
# This function is a constructor, which is a
# function whose job it is to create an 
# instance of the given class, eventually 
# returning that instance. 

# The main member variables of our class 
# will be mat and idx, implemented as
# components of the list. 

# The loop that follows then fills in 
# rtrn$mat column by column and assigns
# rtrn$idx element by element. A slicker 
# way to do this for loop would be to use
# the rather obscure row() and col() 
# functions. The row() function takes a
# matrix input and returns a new matrix 
# of the same size, but with each element
# replaced by its row number. 

# Here's an example:

m <- matrix(1:6,nrow=3)
m

row(m)

# The col() function works similarly.

col(m)

# Using this idea, we could replace the for 
# loop in ut() with a one-liner:
rtrn$mat <- inmat[row(inmat) <= col(inmat)]

# We want our "ut" class to include some methods, 
# not just variables. To this end we include
# three methods:

# expandut() function converts from a compressed 
# matrix to an ordinary one In expandut(), the key 
# lines are 27 and 28, where we use rtrn$ix
# to determine where in utmat$mat the jth column 
# of our matrix is stored. That data is then copied
# to the jth column of fullmat in line 30. Note the
# use of rep() to generate the zeros in the lower 
# portion of this column.

# The print.ut() function is for printing. This 
# function is quick and easy, using expandut(). 
# Any call to print() on an object of type "ut"
# will be dispatched to print.ut(), as in our 
# test cases earlier.

# The "%mut%"() function is for multiplying two 
# compressed matrices (without uncompressing them). 

#### Extended Example: A Procedure for
#### Polynomial Regression

# Consider a statistical regression setting with 
# one predictor variable. Since any statistical
# model is merely an approximation, in principle,
# you can get better and better models by fitting 
# polynomials of higher and higher degrees. 

# But at some point this becomes overfitting, so
# that the prediction of new, future data 
# deteriorates for degrees higher than some value.

# Class "polyreg" deals with this issue. 
# It fits polynomials of various degrees but
# assesses fits via cross-validation to reduce the 
# risk of overfitting.

# Is cross-validation known as the leaving-one-out 
# method. For each point we fit the regression to 
# all the data except this observation, and then
# we predict that observation from the fit. 

# An object of this class consists of outputs
# from various regression models, plus the 
# original data.

# Here is code for the "polyreg" class.
# "polyreg," S3 class for polynomial regression 
# with only one predictor variable

# polyfit(y,x,maxdeg) fits all polynomials up 
# to degree maxdeg; y is vector for response
# variable, x for predictor; creates an object
# of class "polyreg"...This is constructor function:
polyfit <- function(y,x,maxdeg) {
  # form powers of predictor variable, 
  # ith power in ith column
  # could use orthog polys for greater accuracy:
  pwrs <- powers(x,maxdeg) 
  # start to build class here:
  lmout <- list() 
  # create a new class "polyreg"
  class(lmout) <- "polyreg" 
  for (i in 1:maxdeg) {
    lmo <- lm(y ~ pwrs[,1:i])
    # extend the lm class here, 
    # with the cross-validated predictions
    lmo$fitted.cvvalues <- lvoneout(y,pwrs[,1:i,drop=F])
    lmout[[i]] <- lmo
    }
  lmout$x <- x
  lmout$y <- y
  return(lmout)
}

# print() for an object fits of class 
# "polyreg": print cross-validated
# mean-squared prediction errors
print.polyreg <- function(fits) {
  maxdeg <- length(fits) - 2
  n <- length(fits$y)
  tbl <- matrix(nrow=maxdeg,ncol=1)
  colnames(tbl) <- "MSPE"
  for (i in 1:maxdeg) {
    fi <- fits[[i]]
    errs <- fits$y - fi$fitted.cvvalues
    # sum of squared prediction errors:
    spe <- crossprod(errs,errs) 
    tbl[i,1] <- spe/n
    }
  cat("mean squared prediction errors, by degree\n")
  print(tbl)
}

# This is utility function to evaluate
# powers and polynomials;
# It forms matrix of powers of 
# the vector x, through degree dg.
powers <- function(x,dg) {
  pw <- matrix(x,nrow=length(x))
  prod <- x
  for (i in 2:dg) {
    prod <- prod * x
    pw <- cbind(pw,prod)
    }
  return(pw)
}

# Another utility function; This function
# finds cross-validated predicted values; could
# be made much faster via matrix-update methods.
lvoneout <- function(y,xmat) {
  n <- length(y)
  predy <- vector(length=n)
  for (i in 1:n) {
    # regress, leaving out ith observation
    lmo <- lm(y[-i] ~ xmat[-i,])
    betahat <- as.vector(lmo$coef)
    # the 1 accommodates the constant term
    predy[i] <- betahat %*% c(1,xmat[i,])
  }
  return(predy)
}

# Utility function to create the polynomial;
# polynomial function of x, coefficients cfs
poly <- function(x,cfs) {
  val <- cfs[1]
  prod <- 1
  dg <- length(cfs) - 1
  for (i in 1:dg) {
    prod <- prod * x
    val <- val + cfs[i+1] * prod
  }
}

# "polyreg" consists of polyfit(), the constructor 
# function, and print.polyreg(), a print function 
# tailored to this class. It also contains
# utility functions to evaluate powers and 
# polynomials and to perform cross-validation.

# We generate some artificial data and
# create an object of class "polyreg" from it, 
# printing out the results.
n <- 60
x <- (1:n)/n; x
y <- vector(length=n); y
# fill up the prediction vector
for (i in 1:n) y[i] <- sin((3*pi/2)*x[i]) + x[i]^2 + rnorm(1,mean=0,sd=0.5)
# maximum degrees of polynomial
dg <- 15
# polyfit fits them up to the 12th and then
# roundoff errors begin to cause problems;
# Note fit is best with polynomial of 4th degree,
# then it begins to degrade:
(lmo <- polyfit(y,x,dg))

# function polyfit() fits polynomial models up 
# through a specified degree (15 here)
# calculating the cross-validated mean squared 
# prediction error for each model.

# The last few values in the output were NA,
# since roundoff error considerations led R to
# refuse to fit polynomials of degrees that high.

# Main work is handled by the function polyfit()
# which creates an object of class "polyreg". 
# That object consists mainly of the objects 
# returned by the R regression fitter lm() for 
# each degree.

# In forming those objects, note this line 514:
# lmo$fitted.cvvalues <- lvoneout(y,pwrs[,1:i,drop=F])
# lmo is an object returned by lm(), but we are 
# adding an extra component to it: fitted.cvvalues.

# Can add a new component to a list anytime and S3
# classes are lists.

# Have a method for the generic function print(), 
# print.polyreg(). Later, we will add a method for 
# the plot() generic function, plot.polyreg().

# To compute prediction errors, we used cross-
# validation, or the leaving-one-out-method in a
# form that predicts each obs from all the others.

# To implement this, we take advantage of R's 
# use of negative subscripts in this line 563:

# lmo <- lm(y[-i] ~ xmat[-i,])

# So we fit the model with the ith observation 
# deleted from our data set.

# BASIC S3 and S4 CLASS R OPERATORS

# Operation                  S3                            S4      
# Define class               Implicit in Constructor Code  setClass()
# Create object              Build list, set class attr    new()
# Reference member variable  $                             @
# Implement generic f()      Define f.classname()          setMethod()
# Declare generic            UseMethod()                   setGeneric()

##### WRITING S4 CLASSES

