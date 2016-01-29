#################################################
######      PERFORMANCE ENHANCEMENT       ######
#################################################
#
# In computer science curricula, a common
# theme is the trade-off between time and
# space. In order to have a fast-running 
# program, you may need to use more memory
# space.

# But to conserve memory space, you might
# need to settle for slower code. In the 
# R language, this trade-off is of particular
# interest because:
#  . R is an interpreted language. Many of the 
# commands are written in C and do run in fast
# machine code. But other commands, and your
# R code, are pure R and thus interpreted. 
# So, your R applications may run more slowly 
# than you would like.

# . All objects in an R session are stored 
# in memory. More precisely, all objects are
# stored in R's memory address space. 

# R places a limit of 2^31 - 1 bytes
# on the size of any object, even on 
# 64-bit machines and even if you have lots
# of RAM. 

# How do you make R code run faster?

# Optimize through vectorization, use of
# byte-code compilation.

# Write the key, CPU-intensive parts in a
# compiled language like C\C++

# Write code in parallel R.

### For Loops can be trouble, but rather than
# avoiding them, write R code to enable
# vectorization.

# Can vecorize instead of looping sometimes:
# z<-x+y # more compact, faster than for loop
# for (i in 1:length(x)) z[i]<-x[i]+y[i]

# We do timing comparison
x <- runif(1000000)
y <- runif(1000000)

z <- vector(length=1000000)
system.time(z <- x + y)
# user system elapsed
# 0.02   0.00    0.02
system.time(for (i in 1:length(x)) z[i]<-x[i]+y[i])
# user system elapsed
# 3.24   0.00    3.24

# version without loop hundreds of
# times faster. While timings may vary 
# from one run to another (a second run 
# of the loop version had elapsed time of 
# 22.958), in some cases.

# sources of slowdown in the loop version.

# numerous function calls are involved in 
# the loop version of previous code:

#  . Though syntactically the loop looks 
# innocuous, for() is, in fact, a
# function.

# . The colon : looks even more innocuous, 
# but it's a function too. For

# 1:10 is actually the : function called 
# on the arguments 1 and 10:
":"(1,10)
# [1] 1 2 3 4 5 6 7 8 9 10

# . Each vector subscript operation 
# represents a function call, with calls 
# to [ for the two reads and to 
# [<- in the case of the write.

# One type of vectorization is vector 
# filtering For instance, let's rewrite our
# function oddcount() from previously:

oddcount <- function(x) {
  k <- 0 # assign 0 to k
  for (n in x) {
    # %% is the modulo operator:
    if (n %% 2 == 1) k <- k+1 
  }
  return(k)
}

oddcount(c(1,3,5))
# [1] 3

oddcount(c(1,2,3,7,9))
# [1] 4

# make it interesting, sampling 100,000
# from vector 1:1000000 with replacement
x <- sample(1:1000000,100000,replace=T)

# how long?
system.time(oddcount(x))
# user  system elapsed 
# 0.14    0.00    0.14 

# rewrite oddcount for vectorization:
oddcount <- function(x) return(sum(x%%2==1))
# how long?
system.time(oddcount(x))
# user  system elapsed 
# 0.01    0.00    0.01

# many times as fast

# There is no explicit loop here, and even 
# though R will internally loop through
# the array, this will be done in native 
# machine code. 

# Examples of other vectorized functions 
# that may speed up your code are ifelse(),
# which(), where(), any(), all(), cumsum(), 
# and cumprod(). In the matrix case, you
# can use rowSums(), colSums(), and so on. 

# In "all possible combinations" types of 
# settings, combin(), outer(), lower.tri(), 
# upper.tri(), or expand.grid() r useful.

# apply() eliminates an explicit loop, but 
# is actually implemented in R rather than
# C and thus will usually not speed up your 
# such as lapply(), can be very helpful 
# in speeding up your code.

#### Extended Example: Achieving Better
#### Speed in a Monte Carlo Simulation

# Simulations can run for days Here, we
# look at two simulation examples:

# program MaxNorm.R:
sum <- 0
nreps <- 100000
for (i in 1:nreps) {
  # generate 2 N(0,1)s
  xy <- rnorm(2) 
  sum <- sum + max(xy)
}
print(sum/nreps)

# Here's a revision (faster, we hope):

# Program MaxNorm2.R:
nreps <- 100000
# this time we generate all the
# random variates at once, storing
# them in matrix xymat, with one
# (X,Y) pair per row:
xymat <- matrix(rnorm(2*nreps),ncol=2)
maxs <- pmax(xymat[,1],xymat[,2])
print(mean(maxs))

# this line speeded thing up a lot:
# xymat <- matrix(rnorm(2*nreps),ncol=2)

# Next, we find all the max(X,Y) values, 
# storing those values in maxs, and then
# simply call mean().

# It is easier to program, and we believe 
# it will be faster. Let's check that.

# Have original code in the file MaxNorm.R 
# and the improved version in MaxNorm2.R.

getwd()
file.exists("MaxNorm.R")
file.exists("MaxNorm2.R")

# let her fly:
system.time(source("MaxNorm.R"))
# [1] 0.5607319
#    user  system elapsed 
#    0.62    0.01    0.97 


system.time(source("MaxNorm2.R"))
# [1] 0.5638554
#    user  system elapsed 
#    0.03    0.00    0.07

# some 20 x as fast. We did
# achieve huge improvement in
# speed, but it was at the 
# expense of using more memory,
# by keeping random numbers in
# an array instead of generating
# and discarding them one pair at
# a time.

#### Another Example, more complicated

# Urn 1 contains ten blue marbles and 
# eight yellow marbles.

# Urn 2 has six blue and six yellow.

# We draw a marble at random from urn 1,
# transfer it to urn 2, and then draw a
# marble at random from urn 2.

# What is the probability that the
# second marble is blue?

# We use a simulation:
# perform nreps repetitions of the
# marble experiment, to estimate
# P(pick blue from Urn 2)
sim1 <- function(nreps) {
  # 10 blue marbles in Urn 1
  nb1 <- 10 
  # number of marbles in 
  # Urn 1 at 1st pick
  n1 <- 18 
  # number of marbles in 
  # Urn 2 at 2nd pick
  n2 <- 13 
  # number of repetitions in
  # which get blue from Urn 2
  count <- 0 
  for (i in 1:nreps) {
    # 6 blue marbles orig. in Urn 2
    nb2 <- 6 
    # pick from Urn 1 and put in Urn 2; 
    # is it blue?
    if (runif(1) < nb1/n1) nb2 <- nb2 + 1
    # pick from Urn 2; is it blue?
    if (runif(1) < nb2/n2) count <- count + 1
  }
  # est. P(pick blue from Urn 2)
  return(count/nreps) 
}

# Here we do it without loops, using apply():
sim2 <- function(nreps) {
  nb1 <- 10
  nb2 <- 6
  n1 <- 18
  n2 <- 13
  # pre-generate all our random numbers, 
  # one row per repetition
  u <- matrix(c(runif(2*nreps)),nrow=nreps,ncol=2)
  # define simfun for use in apply(); 
  # simulates one repetition
  simfun <- function(rw) {
    # rw ("row") is a pair of random numbers
    # choose from Urn 1
    if (rw[1] < nb1/n1) nb2 <- nb2 + 1
    # choose from Urn 2, and return 
    # boolean on choosing blue
    return (rw[2] < nb2/n2)
  }
  z <- apply(u,1,simfun)
  # z is a vector of booleans but they can be treated as 1s, 0s
  return(mean(z))
}

# Here, we set up a matrix u with two 
# columns of U(0,1) random variates.
# The first column is used for our 
# simulation of drawing from urn 1, 
# and the second for drawing from urn 2.

# This way, we generate all our random 
# numbers at once, which might save a 
# bit of time, but the main point is to 
# set up for using apply(). Toward that 
# goal, our function simfun() works on 
# one repetition of the experiment-that 
# is, one row of u. 

# We set up the call to apply() to go
# through all of the nreps repetitions.
# Note that since the function simfun() 
# is declared within sim2(), the locals
# of sim2()-n1, n2, nb1, and nb2-are 
# available as globals of simfun(). 

# Also, since a Boolean vector will 
# automatically be changed by R to 1s 
# and 0s, we can find the fraction
# of TRUE values in the vector by 
# simply calling mean().

# We compare performance:
system.time(print(sim1(100000)))
# [1] 0.5086
#   user system elapsed
#   1.00   0.00    1.72

system.time(print(sim2(100000)))
# [1] 0.5086
#   user system elapsed
#   1.14   0.00    1.72

# In spite of the many benefits of 
# functional programming, this approach
# using apply() doesn't help. 

# In fact, it was slower.

# We try vectorizing this simulation:
sim3 <- function(nreps) {
  nb1 <- 10
  nb2 <- 6
  n1 <- 18
  n2 <- 13
  u <- matrix(c(runif(2*nreps)),
              nrow=nreps,ncol=2)
  # set up the condition vector. These two
  # lines are where most of the work gets
  # accomplished:
  cndtn <- u[,1] <= nb1/n1 & u[,2] <= (nb2+1)/n2 |
           u[,1] > nb1/n1 & u[,2] <= nb2/n2
  return(mean(cndtn))
}

# To get that, we reasoned out which 
# conditions would lead to choosing
# a blue marble on the second pick, 
# coded them, and then assigned them to
# cndtn.

# Remember that <= and & are functions; 
# in fact, they are vector functions,
# so they should be fast:
system.time(print(sim3(100000)))
# [1] 0.5086
#   user system elapsed
#   0.01   0.00    0.01

# In principle, the approach we took to 
# speed up the code here could be applied
# to many other Monte Carlo simulations. 

# However, it's clear that the analog
# of the statement that computes cndtn 
# would quickly become quite complex,
# even for seemingly simple applications.

# Also, the approach would not work in 
# "infinite-stage" situations, with an
# unlimited number of time steps. 

# Here, we are considering the marble
# example as being two-stage, with two 
# columns to the matrix u.

##### Extended Example: 
##### Generating a Powers Matrix

# We generate a matrix of powers
# of the predictor variable:
# forms matrix of powers of the 
# vector x, through degree dg
powers1 <- function(x,dg) {
  pw <- matrix(x,nrow=length(x))
  prod <- x # current product
  for (i in 2:dg) {
    prod <- prod * x
    pw <- cbind(pw,prod)
  }
  return(pw)
}

# One glaring problem is that cbind() 
# is used to build up the output matrix,
# column by column. This is very costly 
# in terms of memory-allocation time.

# It's much better to allocate the full 
# matrix at the beginning, even though
# it will be empty, as this will mean 
# incurring the cost of only one
# memory-allocation operation.
# forms matrix of powers of the vector 
# x, through degree dg
powers2 <- function(x,dg) {
  pw <- matrix(nrow=length(x),ncol=dg)
  prod <- x # current product
  pw[,1] <- prod
  for (i in 2:dg) {
    prod <- prod * x
    pw[,i] <- prod
  }
  return(pw)
}

# powers2() is a lot faster

x <- runif(1000000)
system.time(powers1(x,8))
#   user system elapsed
#  0.776  0.356   1.334

system.time(powers2(x,8))
#   user system elapsed
#  0.776  0.356   1.334

# And yet, powers2() still contains a loop.
# Maybe we can use outer() with the call 
# outer(X,Y,FUN)

# This call applies function FUN() to
# all possible pairs of elements of
# x and elements of Y. Default value 
# of FUN() is multiplication.
powers3 <- function(x,dg) return(outer(x,1:dg,"^"))

# For each combination of element of 
# x and element of 1:dg (resulting in
# length(x) × dg combinations in all), 
# outer() calls the exponentiation function
# ^ on that combination, placing the results 
# in a length(x) × dg matrix. This is
# what we need, and as a bonus, the code 
# is quite compact. Is it faster?

system.time(powers3(x,8))
#  user system elapsed
# 1.336  0.204   1.747

# No, it disappoints, is the worst
# performance yet.

# We try cumprod():

powers4 <- function(x,dg) {
  repx <- matrix(rep(x,dg),nrow=length(x))
  return(t(apply(repx,1,cumprod)))
}

# Let's try it:
system.time(powers4(x,8))
#   user system elapsed
# 28.106  1.120  83.255

# Here we made multiple copies of x, 
# since the powers of a number n are
# simply cumprod(c(1,n,n,n...)). But 
# in spite of using two C-level functions,
# the performance was disastrous.

# Moral is that performance issues 
# can be unpredictable. You must be armed 
# with an understanding of the basic issues, 
# vectorization, and the memory aspects
# explained later. And then you still must
# try various approaches.

### FUNCTIONAL PROGRAMMING AND 
### MEMORY ISSUES

# Most R objects are immutable, or 
# unchangeable. Thus, R operations are
# implemented as functions that reassign 
# to the given object, a trait that can
# have performance implications.

### Vector Assignment Issues
# Example of issues that can arise, 
# consider this simple looking
# statement:
z[3] <- 8

# this assignment is more complex than 
# it seems. It is implemented via the
# replacement function "[<-" through 
# this call and assignment:

z <- "[<-"(z,3,value=8)

# An internal copy of z is made, 
# element 3 of the copy is changed to 8,
# and then the resulting vector is 
# reassigned to z. 

# So even though we are ostensibly 
# changing just one element of the vector,
# the semantics say that the entire vector 
# is recomputed. 

# For a long vector, this would slow down 
# the program considerably. The same
# is true for a shorter vector if it were 
# assigned from within a loop of our code.

# Sometimes, R does take some measures to 
# mitigate this impact, but is a key point
# to consider when aiming for fast code. 

# You should be mindful of this when 
# working with vectors (and arrays).

# Always look for assignment of vectors
# as first culprit when code runs slowly.

### Copy-on-Change Issues
# Copy-on-change policy
y <- z

# initially y shares the same memory 
# area with z. But if either of them
# changes, a copy is made in a 
# different area of memory, and the
# changed variable will occupy the new 
# area of memory. 

# However, only the first change is
# affected, as the relocating of the 
# moved variable means there are no
# longer any sharing issues. 

# The function tracemem() will report
# these memory relocations.

# R usually adheres to copy-on-change 
# semantics, there are exceptions:
z <- runif(10)
tracemem(z)
# [1] "<0x88c3258>"
z[3] <- 8
tracemem(z)
# [1] "<0x88c3258>"

# The location of z did change; 
# this is the problem

z <- 1:10000000
system.time(z[3] <- 8)
# user  system  elapsed
# 0.180  0.084    0.265

system.time(z[33] <- 88)
# user system elapsed
#    0      0       0

# if copying is done, the vehicle is R's 
# internal function duplicate() or duplicate1()

### Extended Example:
### Avoiding Memory Loss

# Artificial example demonstrates
# memory-copy issues.

# Suppose we have a large number of unrelated
# vectors and, among other things, we want
# to set the third element of each to 8.

# We could store vectors in a matrix, one
# vector per row. But since they might be
# of different length, we choose to store
# them in a list.

# Try it:
m <- 5000
n <- 1000
z <- list()
for (i in 1:m) {
  z[[i]] <- sample(1:10,n,replace=T)
}
system.time(for (i in 1:m) z[[i]][3] <- 8)
#   user system elapsed
#  0.288  0.024   0.321
z <- matrix(sample(1:10,m*n,replace=T),
            nrow=m)
system.time(z[,3] <- 8)
#  user system elapsed
# 0.008  0.044   0.052

# Except for system time (again), 
# the matrix formulation did better.

# One of the reasons is that in the 
# list version, we encounter the memory 
# copy problem in each iteration of loop. 

# But in the matrix version, we encounter
# it only once. 

# And the matrix version is vectorized.
# What about using lapply() on the 
# list version?
set3 <- function(lv) {
    lv[3] <- 8
    return(lv)
}
z <- list()
for (i in 1:m) {
  z[[i]] <- sample(1:10,n,replace=T)
}

system.time(lapply(z,set3))
#   user system elapsed
#  0.100  0.012   0.112

# It is difficult to beat vectorized code !

#### Rprof() Again
# We use Rprof() and summaryRprof()
# to profile our code:

x <- runif(1000000)
Rprof()
invisible(powers1(x,8))
Rprof(NULL)
summaryRprof()

# We see immediately that the runtime 
# of our code is dominated by calls
# to cbind(), which as we noted in the 
# extended example is indeed slowing
# things down.

# The call to invisible() is used to 
# suppress output. We don't want to 
# see the 1,000,000-row matrix returned 
# by powers1().

# We profile powers2() and it does not
# show any obvious bottlenecks.

Rprof()
invisible(powers2(x,8))
Rprof(NULL)
summaryRprof()

#######################################







