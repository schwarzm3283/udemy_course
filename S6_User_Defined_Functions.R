#########################################
#####    User-Defined Functions     #####
#########################################

### NOTE: Materials Beyond line 482 is
### OPTIONAL . . . these are not User-
### Defined. They are native R functions
### that are useful to know, time permitting.

# Writing user-defined functions is pretty
# straightforward. They are objects of mode
# function. The functions that 'come with'
# R are also written in R and to not differ
# substantially from user-defined functions.

# A function is defined by an assignment of 
# the form 

# name <- function(arg_1, arg_2, .) expression

# The expression is an R expression, (usually 
# a grouped expression), that uses the arguments, 
# arg_i, to calculate a value. The value of the 
# expression is the value returned for the function. 

# A call to the function then usually takes the 
# form name(expr_1, expr_2, .) and may occur 
# anywhere a function call is legitimate. 

# Example calculates a 2-sample t-statistic:
twosam <- function(y1, y2) {
  n1  <- length(y1); n2  <- length(y2)
  yb1 <- mean(y1);   yb2 <- mean(y2)
  s1  <- var(y1);    s2  <- var(y2)
  s <- ((n1-1)*s1 + (n2-1)*s2)/(n1+n2-2)
  tst <- (yb1 - yb2)/sqrt(s*(1/n1 + 1/n2))
  return(tst)
}

# Create some data
# Normally distributed random sample of 100 with
# a mean of 0, standard deviation of 1 (approximately)
# male data:
male1 <- rnorm(100)
male1
# what is mean of male vector of data?
mean(male1)
# What is standard deviation?
sd(male1)

# female data
female1 <- rnorm(100)
female1
# what is mean of female vector of data?
mean(female1)
# What is standard deviation?
sd(female1)

# Put them in a data frame
data1 <- data.frame(male1,female1)
# take a look
head(data1)

# We call the function and look at tstat
tstat1 <- twosam(data1$male1, data1$female1)
# looking for a tstat of +1.96 (or -1.96)
tstat1 # is not significant

# do it again but deliberately make them 
# significantly different
# Normally distributed random sample of 100 with
# a mean of -1.5, standard deviation of 6 (approximately)
# male data:
male2 <- rnorm(100,-1.5,6)
male2
# what is mean of male vector of data?
mean(male2)
# What is standard deviation?
sd(male2)

# female data mean of +1.5, stand deviation of 6
female2 <- rnorm(100,1.5,6)
female2
# what is mean of female vector of data?
mean(female2)
# What is standard deviation?
sd(female2)

# Put them in a data frame
data2 <- data.frame(male2,female2)
# take a look
head(data2)

# We call the function and look at tstat
tstat2 <- twosam(data2$male2, data2$female2)
# looking for a tstat of +1.96 (or -1.96)
tstat2 # they are significantly different

### Named arguments and defaults

# if arguments to called functions are given 
# in the "name=object" form, they may be given
# in any order. Consider:

fun1 <- function(data, data.frame, graph, limit) {
  [function body omitted]
}

# then the function may be invoked in several
# ways, for example 

# here argument data=d, data.frame=df,
# graph=TRUE and limit=20.
ans <- fun1(d, df, TRUE, 20)

# here the order changes, but we used the
# argument names for graph and limit
# so it is equivalent to the first above
ans <- fun1(d, df, graph=TRUE, limit=20)

# same here, if use formal names when we
# call the function, the order of the argu-
# ments is immaterial
ans <- fun1(data=d, limit=20, 
            graph=TRUE, data.frame=df)

# All of the above calls to the fun1()
# function are equivalent. 

# If arguments have default values, they 
# may be omitted altogether from the call:
fun1 <- function(data, data.frame, 
                 graph=TRUE, limit=20) { . }

# it could be called as 
ans <- fun1(d, df)

# is equivalent to the three cases above,
# but this changes one of the defaults
ans <- fun1(d, df, limit=10)

# Note that defaults may be arbitrary 
# expressions,even involving other 
# arguments to the same function.

### The '...' argument
# Accepts any number of arguments, is
# open-ended. 

# Calculates means and variances of any number of vectors: 
many.means <- function(...){
  data <- list(...)
  n <- length(data)
  means <- numeric(n)
  vars <- numeric(n)
  for (i in 1:n){
    means[i] <- mean(data[[i]])
    vars[i] <- var(data[[i]])
  }
  print(means)
  print(vars)
  invisible(NULL)
}

# Let’s try it out ! : 
x <- rnorm(100);x
y <- rnorm(200);y
z <- rnorm(300);z

# what are the means and std dev?
x; mean(x); sd(x)
y; mean(y); sd(y)
z; mean(z); sd(z)

# we call function many.means()
many.means(x,y,z)
# [1]  -0.039181830  0.003613744  0.050997841
# [1]      1.146587     0.989700     0.999505

### Scope
# The symbols which occur in the body of a 
# function can be divided into three classes:
# 1) formal parameters, 
# 2) local variables and 
# 3) free variables. 

# The formal parameters of a function are 
# those occurring in the argument list of
# the function. Their values are determined 
# by the process of binding the actual function
# arguments to the formal parameters. 

# Local variables are those whose values are
# determined by the evaluation of expressions 
# in the body of the functions.

# Variables which are not formal parameters 
# or local variables are called free variables.
# Free variables become local variables if 
# they are assigned to. 

# clear memory first
# see what is there
ls()
# clear it all out
rm(list=ls())

# Consider the following function definition. 

f <- function(x) {
  # z <- 10
  # z <- z^0.5
  y <- 2*x
  print(x)
  print(y)
  print(z)
}

# x is a formal parameter, 
# y is a local variable, and
# z is a free variable. 

# call the function
f(2)

# assignment a value to z in global workspace
z <- 3

# what is in the workspace?
ls()

# call it again
f(2)

# now put assign z <- 10 within the function

f <- function(x) {
  # z is now a local variable
  z <- 10
  z <- z^0.5
  y <- 2*x
  print(x)
  print(y)
  print(z)
}

# call it again
f(2)

# Lexical scope and mutatable state
# In R the free variable bindings are resolved
# by first looking in the environment in which
# the function was created. 

# This is called lexical scope.
# We define a function called cube. 

cube <- function(n) {
  sq <- function() n*n
  n*sq()
}

# There is a function within a function here.
# Function sq() is first defined, and then
# executed (locally) within cube(). It is
# only when sq() is called on the third line
# that n finally takes a value, first in sq()
# where it becomes n times n, and then on the
# third bottom line, where it becomes n cubed.
# So the cube of n is what gets returned by
# the cube() function.

# The variable n in the function sq is not
# an argument to that function. It is a free 
# variable and the scoping rules must be used
# to ascertain the value associated with it. 

# Under static scope (S-PLUS) the value is 
# that associated with a global variable named n. 

# Under lexical scope (R) it is the parameter
# to the function cube since that is the 
# active binding for the variable n at the time
# the function sq was defined. 

# The difference between evaluation in R and
# evaluation in S-PLUS is that S-PLUS looks
# for a global variable called n while R 
# first looks for a variable called n in the
# environment created when cube was invoked. 

## The 'S' language does not have this
## same set of lexical scoping properties. 
## 'S' cannot find a value for n when 
## this same function is defined and
## executed in 'S':

## first evaluation in S
# S> cube(2)
# Error in sq(): Object "n" not found
# Dumped
# S> n <- 3
# S> cube(2)
# [1] 18
## then the same function evaluated in R
cube(2)
# [1] 8

# Lexical scope can also be used to give
# functions mutable state. In the following
# example we show how R can be used to mimic
# a bank account. A functioning bank account
# needs to have a balance or total, a function
# for making withdrawals, a function for making
# deposits and a function for stating the current
# balance. We achieve this by creating the three
# functions within open.account() and then returning
# a list containing them. When open.account() is
# invoked it takes a numerical argument total and
# returns a list containing the three functions. 

# Because these functions are defined in an
# environment which contains total, they will
# have access to its value. 

# The special assignment operator, <<-,  
# is used to change the value associated
# with total. This operator looks back in 
# enclosing environments for an environment
# that contains the symbol total and when it
# finds such an environment it replaces the value, 
# in that environment, with the value of right
# hand side. If the global or top-level environment
# is reached without finding the symbol total 
# then that variable is created and assigned to there.

# For most users <<- creates a global variable
# and assigns the value of the right hand side
# to it. Only when <<- has been used in a
# function that was returned as the value
# of another function will the special
# behavior described here occur. 

# open.account() simply returns a list
# containing three functions (deposit(),
# withdraw() and balance())
open.account <- function(total) {
  list(
    deposit = function(amount) {
      if(amount <= 0)
        stop("Deposits must be positive!\n")
      total <<- total + amount
      cat(amount, "deposited.  Your balance is", total, "\n\n")
    },
    withdraw = function(amount) {
      if(amount > total)
        stop("You don't have that much money!\n")
      total <<- total - amount
      cat(amount, "withdrawn.  Your balance is", total, "\n\n")
    },
    balance = function() {
      cat("Your balance is", total, "\n\n")
    }
  )
}

ross <- open.account(100)
# ross is a list with the 3
# functions in it and the value
# of 100 stored
str(ross)

robert <- open.account(200)
# robert is a list with the 3
# functions in it and the value
# of 200 stored
str(robert)

# Now we call withdraw() function
# within the ross list
ross$withdraw(30)
# Now we call balance() function
# within the ross list
ross$balance()
# Now we call balance() function
# within the robert list
robert$balance()

ross$deposit(50)
ross$balance()
ross$withdraw(500)
robert$balance()
robert$deposit(500)
robert$balance()

# Function charplot() with two essential (x and y) 
# and two optional arguments (pc and co): 

charplot <- function(x,y,pc=16,co="red"){
  plot(y~x,pch=pc,col=co)}

# To execute, you only need to provide x and y:
charplot(1:10,1:10)

# To get a different plotting symbol:
charplot(1:10,1:10,17)

# For navy-colored circles:
charplot(1:10,1:10,co="navy")	

# To change both plotting symbol and color:
charplot(1:10,1:10,15,"green")

# Function charplot() with two essential (x and y) 
# and two optional arguments (pc and co): 

charplot <- function(x,y,pc=16,co="red"){
  plot(y~x,pch=pc,col=co)}

# Reversing arguments does not work:
charplot(1:10,1:10, "green",15)

# Order unimportant if specify both variable names:
charplot(1:10,1:10,co="green",pc=15)

# Functions in R return only one 'thing'
?pmax

# Example of a function returning a single value
parmax <- function (a,b){
  c <- pmax(a,b)
  median(c)
}

#TRY IT OUT
x <- c(1,9,2,8,3,7)
y <- c(9,2,8,3,7,2)
parmax(x,y)

pmax(x,y)
pmin(x,y)

# Unassigned last line median(c) returns a value:
# [1] 8

# But you can 'trick' R using a list to return multiple values
# Multiple returns example:
parboth <- function (a,b){
  c <- pmax(a,b)
  d <- pmin(a,b)
  answer <- list(median(c),median(d))
  names(answer)[[1]] <- "median of the par maxima"
  names(answer)[[2]] <- "median of the par minima" 
  return(answer)
}

# Example using the same data as before:
parboth(x,y)
$'median of the par maxima'
# [1] 8
$'median of the par minima'
# [1] 2

# Anonymous functions
(function(x,y){z <- 2*x^2 + y^2; x+y+z})(0:7,1)
# [1] 2 5 12 23 38 57 80 107

# Function that works with one or two arguments
plotx2 <- function(x,y=z^2){
  z <- 1:x
  plot(z,y,type="l")
}

# TRY IT:
par(mfrow=c(1,2))
plotx2(12)
plotx2(12,1:12)

# Loops and repeats
for (i in 1:5) print(i^2)
# [1] 1
# [1] 4
# [1] 9
# [1] 16
# [1] 25

### LOOPS AND REPEATS: OPTIONAL MATERIAL
### FROM THIS POINT FORWARD
j <- k <- 0
for (i in 1:5){
  j <- j + 1
  k <- k + i*j
  print(i+j+k)
}
# [1] 3
# [1] 9
# [1] 20
# [1] 38
# [1] 65

# Two other looping functions: repeat() and while(). 

# First the while() function:
fac2 <- function(x){
  f <- 1
  t <- x
  while(t>1){
    f <- f*t
    t <- t-1}
  return(f)
}

# We test the function on the numbers 0 to 5:
sapply(0:5,fac2)
# [1] 1 1 2 6 24 120

# Finally we demonstrate the use of the repeat() function: 
fac3 <- function(x){
  f <- 1
  t <- x
  repeat {
    if (t<2) break
    f <- f*t
    t <- t-1 }
  return(f) 
}

# We test the function on the numbers 0 to 5:
sapply(0:5,fac3)
# [1] 1 1 2 6 24 120

# Let’s compare two ways of finding the 
# maximum number in a vector of 10 million 
# random numbers from a uniform distribution:
x <- runif(10000000) 

# First using vector function max(): 
system.time(max(x))
# [1] 0.13 0.00 0.12 NA NA # 0.12 seconds to solve

# Using a for loop
pc <- proc.time()
cmax <- x[1]
for (i in 2:10000000){
  if(x[i]>cmax) cmax <- x[1]
}
proc.time()-pc
# 21 seconds to complete
#  user system elapsed
# 21.15  0.03   21.03

# Replace y with negative or positive values:
z <- ifelse(y < 0,-1,+1)

# Convert Area into new, two-level factor: 
data <- read.table("c:\\temp\\worms.txt",header=T)
attach(data)
ifelse(Area > median(Area),"big","small")
# [1]    "big"   "big" "small" "small" . . .
# [10] "small" "small"   "big"   "big" . . .
# [19] "small" "small"

detach(data)

# Another use of ifelse()is to override R’s natural inclinations:
# Log of zero in R is -Inf:
y <- log (rpois(20,1.5)); y
# [1] 0.0000000 1.0986123 1.0986123
# [8] . . .          –Inf      -Inf
# [15]  . .          -Inf      -Inf

# We want –Inf to be represented with NA: 
ifelse(y < 0, NA,y)
# [1] 0.0000000 1.0986123 1.0986123
# [8] . . .            NA        NA 
# [15]  . .            NA        NA

# function central to calculate any one of 
# four different measures of central tendency 
# (arithmetic, geometric or harmonic mean; or median):
central <- function(y,measure){
  switch(measure,
         Mean = mean(y),
         Geometric = exp(mean(log(y))),
         Harmonic = 1/mean(1/y),
         Median = median(y),
         stop("Measure not included"))
}

central(rnorm(100,10,2),"Harmonic")
# [1] 9.554712

central(rnorm(100,10,2),4)
# [1] 10.46240

# Shuffles the contents of a vector into a random sequence.
y <- c(8,3,5,7,6,6,8,9,2,3,9,4,10,4,11)

# Here are two samples of y:
sample(y)
# [1] 8 8 9 9 2 10 6 7 3 11 5 4 6 3 4

sample(y)
# [1] 9 3 9 8 8 6 5 11 4 6 4 7 3 2 10

# You can specify the size of the sample with the 2nd argument:
sample(y,5)
# [1] 9 3 4 2 8

# Sampling with replacement
sample(y,replace=T)
# [1] 9 6 11 2 9 4 6 8 8 4 4 4 3 9 3

# In this next sample with replacement there are two 10’s and only one 9:
sample(y,replace=T)
# [1] 3 7 10 6 8 2 5 11 4 6 3 9 10 7 4

# The apply() function is used for applying functions 
# to the rows or columns of matrices or dataframes: 
(X <- matrix(1:24,nrow=4))
#	    [,1] [,2] [,3] [,4] [,5] [,6]
#	[1,]   1    5    9   13   17   21
#	[2,]   2    6   10   14   18   22
#	[3,]   3    7   11   15   19   23
#	[4,]   4    8   12   16   20   24 

# Apply a sum() function across the rows or columns: 
apply(X,1,sum)
# [1] 66 72 78 84

apply(X,2,sum)
# [1] 10 26 42 58 74 90

# Apply functions to individual elements (rows)
apply(X,1,sqrt)

# Apply sqrt to columns
apply(X,2,sqrt)

# Apply your own function definition within apply
apply(X,1,function(x)x^2+x)

# Apply a function to a vector with sapply
sapply(3:7,seq)

# lapply
a <- c("a", "b", "c", "d")
b <- c(1,2,3,4,4,3,2,1)
c <- c(T,T,F)

# Create list object with list() function:
list.object <- list(a,b,c)
class(list.object)
# [1] "list"

# To see contents of list:
list.object 
# [[1]]
# [1] "a" "b" "c" "d"
# [[2]]
# [1] 1 2 3 4 4 3 2 1
# [[3]]
# [1] TRUE TRUE FALSE

# Length returns number of elements comprising each component
lapply(list.object,length)

# Class returns the class of each component
lapply(list.object,class)

# What happens here?
lapply(list.object,mean)

# tapply for summary tables
data <- read.table("c://temp/Daphnia.txt",
                   header=T)
attach(data)
names(data)
# [1] "Growth.rate" "Water" "Detergent" "Daphnia"

# Want mean growth rates for four detergent brands:
tapply(Growth.rate,
       Detergent,
       mean)

# to tabulate mean growth rates for two rivers:
tapply(Growth.rate,
       Water,
       mean)

# to tabulate mean growth rates for three Daphnia clones:
tapply(Growth.rate,
       Daphnia,
       mean)

# calculate means
tapply(Growth.rate,
       list(Daphnia,Detergent),
       mean)

# use an anonymous function
tapply(Growth.rate,
       list(Daphnia,Detergent), 
       function(x)sqrt(var(x)/length(x)))

# All of them
tapply(Growth.rate,
       list(Daphnia,Detergent,Water),
       mean)

# Flat table better in these cases
ftable(tapply(Growth.rate,
              list(Daphnia,
                   Detergent,
                   Water),
              mean))

# More flat table, define 'water'
water <- factor(Water,
                levels=c("Wear","Tyne"),
                is.ordered(Water))
# call ftable()
ftable(tapply(Growth.rate,
              list(Daphnia,
                   Detergent,
                   Water),
              mean))
# always detach the data frame when done
detach(data)

# Use table() for a table of counts
library(DAAG) 
# use tinting dataframe from DAAG 
table(Sex=tinting$sex, 
      AgeGroup=tinting$agegp)