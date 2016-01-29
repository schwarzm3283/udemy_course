############################################
##### PERFORMING MATH AND SIMULATIONS  #####
############################################

# R has built-in functions for many math
# and stat operations

# Calculating a probability
# Suppose we have n independent events,
# and the ith event has probability
# p-sub-i of occurring. What is the 
# probability of exactly one of those
# events occurring?

# Suppose n=3 and have events A, B and C
# Then P(exactly one event occurs) =
# P(A and not B and not C) +
# P(not A and B and not C) +
# P(not A and not B and C)

# If our probabilities p-sub-i are in
# vector p, and the ith element is the
# probability that event i occurs and
# the others do not occur, then

# Probability of exactly one event i
# occurring and the others not occurring

# Probability p-sub-i are contained
# in the vector p:

# Program: exactlyone.R
# But no live data
exactlyone <- function(p) {
  # notp creates vector of all 
  # "not occur" probs by recycling
  notp <- 1 - p
  tot <- 0.0
  for (i in 1:length(p))
    # notp[-1] computes product of all
    # elements of notp, except for the
    # ith
    tot <- tot + p[i] * prod(notp[-i])
  return(tot)
}

# We say event A has 0.55 probability of
# occurring, event B has 0.40 probability
# and event C has 0.60 probability. Then
# the probability of exactly one (A, B or 
# C) occurring is:

p <- c(0.55,0.40,0.60)

exactlyone(p)

# Cumulative Sums and Products

# R functions cumsum() and cumprod()
# return cumulative sums and products
# of a series of vector elements

x <- c(12,5,13)
cumsum(x)
cumprod(x)

# Minima and Maxima

# Big difference between min() and pmin()
# min() just returns minimum of a vector
# pmin() returns minimum of corresponding
# elements in two vectors

z <- matrix(c(1,5,6,2,3,2), nrow=3)
z

# computes smallest value in both
min(z[,1],z[,2])

# returns smallest in pairwise matches
pmin(z[,1],z[,2])

# pmin() can have multiple arguments
pmin(z[1,],z[2,],z[3,])

# max() and pmax() functions work same way

# Function Minimization/Maximization

# can be done with nlm() and optim()
# Example find smallest value of
# f(x) = x squared - sin(x)
?nlm

# uses Newton-Raphson approach to find
# roots with a starting guess at 8

nlm(function(x) return (x^2-sin(x)),8)

# minimum value is -0.23246...
# at x = 0.45...
# 5 iterations of Newton Raphson

## Calculus

# R does calculus operations
# derivatives
D(expression(exp(x^2)),"x")

# integration
integrate(function(x) x^2,0,1)

### Functions for Statistical Distributions

# d for density or prob mass dist (pmf)
# p is cumulative dist function (cdf)
# q for quantiles
# r for random number generation (rng)

# example: simulate 1,000 chi-square
# variates with 2 dof and find mean

mean(rchisq(1000,df=2))

# compute 95th percentile of chi-sq
# distribution with 2 dof

qchisq(0.95,2)

# first argument is a vector so can
# compute 50th and 95th percentile of
# chi-sq distribution with 2 dof

qchisq(c(0.5,0.95),2)

#### Linear Algebra Operations on
#### Vectors and Matrices

# can multiple vector by a scalar
y <- c(1,3,4,10)
y
2*y

# compute inner product (dot product)
# of two vectors
crossprod(1:3,c(5,12,13))

# same as (1,2,3) times (5,12,13)

# computed function is (1 x 5) + (2 x 12)
# + (3 x 13) = 5+24+39 = 68

# For matrix multiplication use %*%
a <- matrix(c(1,3,2,4),nrow=2)
a
b <- matrix(c(1,0,-1,1),nrow=2)
b
a %*% b

# function solve() solves systems of
# linear equations and also finds inverse
# matrices 

#  x1 + x2 = 2
# -x1 + x2 = 4

a <- matrix(c(1,1,-1,1),nrow=2,ncol=2)
a
b <- c(2,4)
b
# solve simultaneous linear equations
solve(a,b)

# compute inverse of a
solve(a)

# function diag() extracts the diagonal
# of a square matrix (useful for obtaining
# variances from a covariance matrix and
# for constructing a diagonal matrix)

# with diag() if argument is a matrix,
# it returns a vector and vice versa. If
# the argument is scalar, diag() returns
# the identity matrix of specified size.

m <- matrix(c(1,7,2,8),nrow=2)
m

# argument is a matrix
dm <- diag(m)
dm

# argument is a vector
diag(c(1,8))

# argument is a scalar
diag(3)

### Set Operations

# R has some handy set operations
# union(x,y)
# intersect(x,y)
# setdiff(x,y)
# setequal(x,y)
# c %in% y
# choose(n,k)

# Some simple examples:
x <- c(1,2,5)
y <- c(5,1,8,9)
union(x,y)
intersect(x,y)
setdiff(x,y)
setdiff(y,x)
setequal(x,y)
setequal(x,c(1,2,5))
2 %in% x
2 %in% y
choose(5,2)

# Also, you can write your own binary operations,
# for instance, consider coding the symmetric
# difference between two sets - that is, all 
# the elements belonging to exactly one of the
# two operand sets.

# Because the symmetric difference between sets
# x and y consists exactly of those elements
# in x but not y and vice versa, the code consists
# of easy calls to setdiff() and union():

# Program: symdiff.R
symdiff <- function(a,b) {
  sdfxy <- setdiff(x,y)
  sdfyx <- setdiff(y,x)
  return(union(sdfxy,sdfyx))
}

# We give it a spin:
x
y
symdiff(x,y)

# here's a binary operand for determining whether
# one set u is a subset of another set v. This
# property is equivalent to the intersection of
# u and v being equal to u:

# Program: %subsetof%.R
"%subsetof%" <- function(u,v) {
   return(setequal(intersect(u,v),u))
}

c(3,8) %subsetof% 1:10

c(3,8) %subsetof% 5:10

# The function combn() generates all combinations
# of n elements, taken m at a time. We
# find the subsets of {1,2,3} of size 2:

c32 <- combn(1:3,2)
c32
class(c32)

# The results are the columns. The subsets of
# {1,2,3} of size 2 are (1,2), (1,3), and (2,3).

# You can also specify a function to be called
# by combn() with each combination. So we can
# find the sum of numbers in each subset:

combn(1:3,2,sum)

### Simulation Programming in R

# Simulation is one the most common uses of R.

# Built-In Random Variate Generators

# R has functions to generate variates from a
# number of different distributions. For example,
# rbinom() generates binomial or Bernoulli
# random variates.

# You wnat to find the probability of getting at
# least four heads out of five tosses of a coin:

# We generate 100000 variates from a binomial
# distribution with 5 trials w/ p(success) = 0.5

x <- rbinom(100000,5,0.5)
table(x)
# for those with value 4 or 5
# note (x >= 4) is TRUE or FALSE

mean(x >= 4)

# Other functions:
# rnorm() for normal distribution
# rexp() for exponential
# runif() for uniform
# rgamma() for gamma
# rpois() for Poisson, and others

# Here we find E[max(X,Y)] . . the expected
# value of the maximum of independent N(0,1)
# random variables X and Y:

# N(0,1) is normal with mean of 0 and sd of 1

sum <- 0
nreps <- 100000
for (i in 1:nreps){
  # generate 2 N(0,1)'s
  # generate 100,000 pairs
  xy <- rnorm(2)
  # find and add the maximum for each pair to sum
  sum <- sum + max(xy)
}
# average and print the maximum for all pairs
print(sum/nreps)
?rnorm
# Program: emax.R does same thing efficiently.
# The program generates double nreps values.
# First nreps value simulates X and remaining
# nreps value represents Y. pmax() computes
# pair-wise maxima (not same as max())
emax <- function(nreps) {
   x <- rnorm(2*nreps)
   # only difference is have one vector x here 
   # and are finding max between current one
   # and next one, through the entire vector:
   maxxy <- pmax(x[1:nreps],
                 x[(nreps+1):(2*nreps)])
   return(mean(maxxy))
}

emax(100000)

### Obtaining the Same Random 
### Set of Numbers in Repeated Runs

# R documentation states that all random-number
# generators use 32-bit integers for seed values.
# So, other than round-off error, the same
# initial seed should generate the same stream
# of numbers.

# Otherwise, R will generate a different random
# stream from run to run. Call set.seed()

# for example:
set.seed(123)

# need to reset the seed after each function
# if you want next function to start at same point

# Probability Problem: Three committees, of sizes
# 3, 4 and 5, are chosen from 20 people. What is
# the probability that persons A and B are
# chosen for the same committee? Person A has
# ID 1 and person B has ID 2

# This is a combinatorial problem

# Set up list comdat (in second function)
# is list commdata in first function

# comdat (commdata) components:

# commdata$whosleft - simulate random selection of
# the committees by randomly choosing from this
# vector. Each time we choose a committee, we
# remove the committee members' ID. Is initialized
# to 1:20 when no one has been selected.

# commdata$numabchosen - count of how many among
# people A and B chosen so far. If we choose a 
# committee and find this to be positive, we can
# skip choosing the remaining committees for
# this reason: If this number is 2, we know
# that A and B are not on the same committee.

# commdata$countabsamecomm - store a count of
# the number of times A and B are on the same
# committee.

# Program: commsim.R (two functions)
sim <- function(nreps) {
   # will store all our info about the 3 committees
   # initialize commdata to be an empty list
   commdata <- list()  
   # initialize A and B as not on the same comm
   commdata$countabsamecomm <- 0
   for (rep in 1:nreps) {
      # potential comm members 1 to 20
      # who's left to choose from
      # initialize it to include everyone
      commdata$whosleft <- 1:20  
      # number among A, B chosen so far
      # initialize it as 0
      commdata$numabchosen <- 0  
      # choose committee 1, and check 
      # for A,B serving together
      # call choosecomm() with comm of 5
      commdata <- choosecomm(commdata,5)
      # if A or B already chosen, no need 
      # to look at the other comms.
      # next tells R to skip if true
      if (commdata$numabchosen > 0) next  
      # choose committee 2 and check
      commdata <- choosecomm(commdata,4)
      # next tells R to skip if true
      if (commdata$numabchosen > 0) next  
      # choose committee 3 and check
      commdata <- choosecomm(commdata,3)
   }
   print(commdata$countabsamecomm/nreps)
}

choosecomm <- function(comdat,comsize) {
   # choose committee members randomly
   committee <- sample(comdat$whosleft,comsize)
   # count how many of A and B were chosen
   comdat$numabchosen <- length(intersect(1:2,committee))
   # If A and B both chosen, increment
   # countabsamecomm by 1
   if (comdat$numabchosen == 2) 
      comdat$countabsamecomm <- comdat$countabsamecomm + 1
   # delete chosen committee members from the set
   # of people we now have to choose from
   comdat$whosleft <- setdiff(comdat$whosleft,committee)
   return(comdat)
}

x <- replicate(1000,sim(1))
mean(x)

# over long haul (many replications) prob = 0.10

##################################################