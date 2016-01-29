##############################################
#####      R PROGRAMMING STRUCTURES      #####
##############################################

### Control Statements

### Loops; Looping over vector sets

# means one iteration of loop
# for each component of vector x
# with n taking on the values
# of those components

x <- c(5,12,13)
for (n in x) print (n^2)

# While and repeat
# uses break

# i takes on values 1, 5, 9 and 13
# then condition i <= 10 fails
# so i is 13
i <- 1
while(i <=10) i <- i+4
i

# does same thing
# is always TRUE so
# use break to exit
i <- 1
while(TRUE) { # similar loop to above
  i <- i+4
  if (i > 10) break
}
i

# same thing but
# repeat has no boolean exit condition
# so again use break
i <- 1
repeat { # similar loop to above
  i <- i+4
  if (i > 10) break
}
i

# 'next' can also be used . . instructs
# interpreter to skip remainder of current
# iteration of loop and proceed directly
# to next one, but can be confusing:

# Note 'for' construct works on any vector:

sim <- function(nreps) {
   commdata <- list()
   commdata$countabsamecomm <- 0
   for (rep in 1:nreps) {  
      commdata$whosleft <- 1:20  
      commdata$numabchosen <- 0  
      commdata <- choosecomm(commdata,5)
      # here is a next statement:
      # if if condition in next line holds
      # skips the three lines after and 
      # control goes back to 'for' above
      if (commdata$numabchosen > 0) next   
      commdata <- choosecomm(commdata,4)  
      # here is a next statement:
      # does same as above next. . goes
      # back to for
      if (commdata$numabchosen > 0) next   
      commdata <- choosecomm(commdata,3)  
   }
   print(commdata$countabsamecomm/nreps)
}

# can replace nexts with nested if's:
# easier to understand because are only two
# levels

sim <- function(nreps) {
  commdata <- list()
  commdata$countabsamecomm <- 0
  for (rep in 1:nreps) {  
    commdata$whosleft <- 1:20  
    commdata$numabchosen <- 0  
    commdata <- choosecomm(commdata,5)
    if (commdata$numabchosen == 0) {
      commdata <- choosecomm(commdata,4)  
      if (commdata$numabchosen == 0) 
        commdata <- choosecomm(commdata,3)
    }
  }
  print(commdata$countabsamecomm/nreps)
}

### if-else

# syntax can be confusing all
# braces are needed.
# right brace before else tells
# R parser is if-else instead of if

r <- 4

if (r==4) {
  x <- 1
} else {
  x <- 3
  y <- 4
}
x
y

r <- 10

if (r==4) {
  x <- 1
} else {
  x <- 3
  y <- 4
}
x
y

# Return Values
# can be any R object
# can be a list, or even a function

# return() explicitly transmit a value
# back to caller otherwise is the value
# of the last executed statement

# returns count of odd numbers
# the argument

vec1 <- 1:10

oddcount <- function(x) {
  k <- 0
  for (n in x) {
    if (n %% 2 == 1) k <- k+1
  }
  return(k)
}

oddcount(vec1)

# can simplify by removing return()

vec2 <- 1:20

oddcount <- function(x) {
  k <- 0
  for (n in x) {
    if (n %% 2 == 1) k <- k+1
  }
  k # do not have to say return(k)
}

oddcount(vec2)

# but this does not work
# because returns NULL invisibly

vec3 <- 1:15

oddcount <- function(x) {
  k <- 0
  for (n in x) {
    if (n %% 2 == 1) k <- k+1
  }
  # leave k out
}

oddcount(vec3)

### Environment and Scope Issue

# A function is a 'closure' and
# consists of arguments and body and
# an 'environment' made up of collection
# of objects present at time function
# is called

# Top-Level Environment

rm(list=ls())

w <- 12

# function f() created at top-level
# which is the interpreter command prompt

f <- function(y) {
  d <- 8
  h <- function() {
    return(d*(w+y))
  }
  return(h())
}
environment(f)

# function ls() lists 
# objects of an environment

ls()

# Get more info from ls.str()
ls.str()


### The Scope Hierarchy
# scope is hierarchical
# w is global; This means is is global
# to f(), while d is local to f().

# But also, we have function h() being
# local to f(), and f() is in turn
# global to h().

# same true for y

# So h()'s environment consists of whatever
# objects are defined by h() when h() comes
# into existence, that is, when it is
# actually called.

# if you call f() multiple times, h()
# comes into existence multiple times and
# then 'goes back to sleep' when control
# returns to f()

# h <- function() {
#   return(d*(w+y))
# }

# What is in h()'s environment?
# Objects d and y created within f(),
# plus f()'s environment w.

# Have multiple nestings of environments

f(2)

# call f(2) set local variable d to 8,
# followed by the call h(). This
# evaluated d*(w+y) or 8*(12+2) = 112.

# looks 'up' for w, finds at top level

# h() is local to f(), invisible at top level
h

# Environments created by inheritance like this
# are referred to by their memory locations

f <- function(y) {
  d <- 8
  h <- function() {
    return(d*(w+y))
  }
  print(environment(h))
  return(h())
}

f(2)

# Functions have no side effects
w <- 12
f <- function(y) {
  d <- 8
  w <- w + 1
  y <- y - 2
  print(w)
  h <- function() {
    return(d*(w+y))
  }
  return(h())
}

t <- 4
f(t)

w

t

# Extended Example: A Function to DIsplay
# the Contents of a Call Frame

# When debugging you often want to know
# values of local variables in your current
# location.

# Might also want to know values of locals
# in the parent location, one from which
# local function was called

# Consider this code:
# BUT DO NOT RUN YET ! :
f <- function(){
  a <- 1
  return(g(a)+a)
}

g <- function(aa){
  b <- 2
  aab <-h(aa+b)
  return(aab)
}

h <- function(aaa){
  c <- 3
  return(aaa+c)
}

# So f() calls g() which calls h()

# In debugging your code you often want to know
# values of local variables in your current
# function. But you may also want to know
# values of the locals in the parent function,
# the one from which the current function was
# called...next example displays these values.

# New example does this and more:

# Variable 'upn' in the number of frames
# we want to go up in the call stack

# shows the values of the local variables 
# (including arguments) of the
# frame upn frames above the one from 
# which showframe() is called; if
# upn < 0, the globals are shown; 
# function objects are not shown

showframe <- function(upn) {
  # determine the proper environment
  if (upn < 0) {
    env <- .GlobalEnv
  } else {
    env <- parent.frame(n=upn+1)
  }
  # get the list of variable names
  vars <- ls(envir=env)
  # for each variable name, print its value
  for (vr in vars) {
    vrg <- get(vr,envir=env)
    if (!is.function(vrg)) {
      cat(vr,":\n",sep="")
      print(vrg)
    }
  }
}

# We try it out, insert some calls into g():

g <- function(aa) {
  b <- 2
  showframe(0)
  showframe(1)
  aab <- h(aa+b)
  return(aab)
}

# then we run it:
f()

# get() function fetches the object itself
# given the name of the function

m <- rbind(1:3,20:22)
m

get("m")

# here we deal with current call frame, but in
# our showframe() function, we are dealing
# with various levels in the environment
# hierarchy so we need to specify the level 
# via the envir argument of get():

# vrg <- get(vr,envir=env)

# Level itself is determined by calling 
# parent.frame():

# if (upn < 0){
#   env <- .GlobalEnv
# } else {
#   env <- parent.frame(n=upn+1)
# }

# Note ls() can also be called in context
# of a particular level, so you can
# choose a level of interest and inspect
# whatever variables are in there.

# vars <- ls(envir=env)
# for (vr in vars) { . . .}
# above code picks up names of all local
# variables in given frame and loops 
# through them, setting things up so get()
# can do its work


# There are no pointers or references in R
# like those in C language

# Note x does not change:

x <- c(13,5,12)
sort(x)
x

# If we want x to change must reassign
# the argument x

x <- sort(x)
x

# What if our function has several variables
# of interest? Trick: Gather them up into a
# list, call the function with this list
# as an argument, have the function return
# the list, and then reassign the original
# list

# This function determines indices of odd
# and even numbers in a vector of integers:

oddsevens <- function(v) {
  odds <- which(v %% 2 == 1)
  evens <- which(v %% 2 == 0)
  list(o=odds,e=evens)
}

obj <- 1:25
oddsevens(obj)

### Writing "Upstairs"

# Cannot write to a global variable, or to
# any variable higher up in the environment
# hierarchy using <- ('gets' symbol)
# So what do you do? 
# (1) Use superassignment operator <<- or
# (2) assign() function

## Writing to nonlocals with Superassignment

two <- function (u){
  u <<- 2*u
  z <<- 2*z
}

x <- 1
z <- 3
u

two(x)
x
z
u


f <- function(){
  inc <- function() {x <<- x + 1}
  x <- 3
  inc()
  return(x)
}

f()

x

# Here inc() is defined within f()
# When inc() is executing and R interpreter
# superassignment to x, it goes up the
# hierarchy and at the first level up,
# the environment within f(), it finds an x.

# So it writes to that one, not x at top level

### Writing to nonlocals with assign()
# Replace superassignment operator with call
# to assign(). assign() always assigns the
# target variable value to the one at the 
# top of the call stack

two <- function (u){
  assign("u",2*u,pos=.GlobalEnv)
  z <- 2*z
}

two(x)
x

u

### Recursion

# 'pivot' is first element
# recursively changes pivot, going through
# the vector of elements
# 'therest' is the vector minus the first element
qs <- function(x) {
  if (length(x) <= 1) return(x)
  pivot <- x[1]
  therest <- x[-1]
  sv1 <- therest[therest < pivot]
  sv2 <- therest[therest >= pivot]
  # calls itself (qs() function) again here:
  sv1 <- qs(sv1)
  # and here . . . is recursive:
  sv2 <- qs(sv2)
  return(c(sv1,pivot,sv2))
}

vec <- c(5,4,12,13,3,8,88)

qs(vec)

### Replacement Functions

# Recall from previous example

x <- c(1,2,4)
names(x)

names(x) <- c("a","b","ab")
names(x)

x

# Look at this line:
# names(x) <- c("a","b","ab")

# What is actually happening is
# x <- "names<-"(x,value=c("a","b","ab")

## What is a replacement function?
# Any assignment statement in which the left
# side is not just an identified (variable name)

## Extended Example: 
# A Self-Bookkeeping Vector Class

# class "bookvec" of vectors that count writes of their elements

# each instance of the class consists of a list whose components are the
# vector values and a vector of counts

# construct a new object of class bookvec
newbookvec <- function(x) {
  tmp <- list()
  tmp$vec <- x  # the vector itself
  tmp$wrts <- rep(0,length(x))  # counts of the writes, one for each element
  class(tmp) <- "bookvec"
  return(tmp)
}

# function to read
"[.bookvec" <- function(bv,subs) {
  return(bv$vec[subs])
}

# function to write
"[<-.bookvec" <- function(bv,subs,value) {
  bv$wrts[subs] <- bv$wrts[subs] + 1  # note the recycling
  bv$vec[subs] <- value
  return(bv)
}

b <- newbookvec(c(3,4,5,5,12,13))

b

b[2]

# try writing:
b[2] <- 88

b[2]

# is write count incremented?
b$wrts

# yes; vectors do their own bookkeeping
# thus, keep track of write counts
# subscripting functions are
# [.bookvec()
# and
# [<-.bookvec()
 
### Anonymous Functions

# Purpose of R function function() is to
# create functions

inc <- function(x) return(x+1)

# Anonymous functions are convenient if they
# are short one-liners or if they are
# called by another function

z <- matrix(1:6,ncol=2)
z

f <- function(x) x/c(2,8)
y <- apply(z,1,f)
y

# Now we bypass middleman
y <- apply(z,1,function(x) x/c(2,8))
y

# What happened here? Third formal argument
# to apply must be a function; This way can
# be clearer than defining the function
# externally