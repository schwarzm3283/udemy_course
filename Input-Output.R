###############################################
######           INPUT / OUTPUT          ######
###############################################

# Important but mostly underemphasized

# Have R Functions for accessing keyboard
# and monitor....we will look at scan()
# readline(), print() and cat() functions

##### scan() Function

## Number of ways to read data from a file
## scan() probably most flexible. scan()
## reads a vector of values has many options
## scan() also returns a vector of values.
## General form of scan()(only some parameters):

## scan(file="", what=0, n= -1, sep="", skip=0, quiet=FALSE)

## all are optional. Defaults:
## file: file to read from; "" (nothing) is keyboard
## what: example of mode of data;
## what: 0 default numeric; " " for character
## n: number elements to read; n = -1 to end of file
## sep: character to separate values; "" means 'any'
## skip: # lines to skip before read, default is 0 # for example, have descriptive text on top
## quiet: whether scan() reports number values read (F is default)

# We have four files:

# z1.txt
# 123
# 4 5
# 6

# z2.txt
# 123
# 4.2 5
# 6

# z3.txt
# abc
# de f
# g

# z4.txt
# abc
# 123 6
# y

# We will suppress warnings
options(warn=-1)

# We put the all in the default directory
getwd() # see what directory is

# confirm files are there
file.exists("z1.txt")
file.exists("z2.txt")
file.exists("z3.txt")
file.exists("z4.txt")

# We use the scan() function on each

# get four integers, numeric mode
scan("z1.txt")

# one is real number, so other are real
scan("z2.txt")

# get an error
scan("z3.txt")

# all text, we assign a character string to what
# 'what' specifies the mode
# indicates we want character mode
scan("z3.txt", what="")

# mixed text and numbers
scan("z4.txt") # get an error

# first item is a character string so
# it also treats the others as characters
scan("z4.txt", what="")

# typical usage is to assign it to variable
v <- scan("z1.txt")
v

# scan() assumes items separated by whitespace
# which includes blanks, linefeeds/carriage return

# optional sep argument for anything else

# z3.txt contains:
# abc
# de f
# g

x1 <- scan("z3.txt",what="")

x2 <- scan("z3.txt",what="",sep="\n")

# "de" and "f" are separate elements of x1:
x1

# but not of x2
x2

x1[2]

x2[2]

# scan() useful function to read in entire
# file at once, but can read line by line as
# we will see.

# Can also use scan to read from keyboard
# by specifying an empty string for filename:
v <- scan("")

# Note R prompts with index of next item read:

# 1: 13 7 18
# 4: 5 4 2
# 7: 4
# 8: <hit enter right away>
#  Read 7 items

# We signal end of input with empty line

# argument quiet=TRUE suppresses 
# number of items read

scan("z3.txt",what="")
scan("z3.txt",what="",quiet=TRUE)

##### readline() Function

# For reading in single line from keyboard

w <- readline()

# yws fg a

w

# readline() usually called with optional prompt:

myinits <- readline("enter your initials: ")

# GSH

myinits

##### Printing to the Screen
##### with print() and cat() functions

# At top level of interactive mode, can print
# value of a variable or expression by
# typing name, but this does not work from
# within a function....in that case, can
# use print() function

x <- 1:3
print(x^2)

# print() is generic so actual function
# called depends on class of object printed

# For example a "table" class object is
# printed by print.table() function

# cat() is generally preferred to print as
# print() can only print one expression as
# you get those nasty index numbers

print("xyz")

# is 'neater':
cat("xyz\n")

# but we needed to supply our end-of-line
# character "\n" or next call would continue
# on same line (but not in interactive mode)

x
cat(x)
cat("abc")

# arguments to cat() are printed out
# with intervening spaces
cat(x,"abc","de\n")

# if don't want spaces, set sep="" (empty string)
cat(x,"abc","de\n",sep="")

# can use any string for sep= including
# new line "\n"
cat(x,"abc","de\n",sep="\n")

# also sep= can be a vector of strings
x <- c(7,23,55,3,66)
x
cat(x,sep=c(".",".",".","\n","\n"))

## R infrastructure for importing data.

# TEXT Files not same as binary files
# Most text files have ASCII characters
# or some other human language like GB: Chinese

# Say we have file "y1.txt":
# John 25
# Mary 28
# Jim 19

### readLines() Function

# Can read file all at once:
file.exists("y1.txt")
y1 <- readLines("y1.txt")
y1

# Have dealt with numeric and logical modes.
# Recall a 'string' of characters is said to 
# be mode 'character'

# Strings are denoted with " " and single ' ' 
# (synonymous)

# Can paste strings together paste(...,sep). 
# sep arg is optional, default is " " 
# (one padded space).
x <- "Citroen SM";x
y <- "Jaguar XK150";y
z <- "Ford Falcon GT-HO";z
wish.list <- paste(x, y, z, sep = ", ")
wish.list

# Special characters can be included in strings
# using the escape character \. Use:
# \" for " (to really include a quote mark)
# \n for a newline (throw a carriage return)
# \t to show a tab
# \b to show a backspace
# \\ to show \ (two back slashes for one)

char.vector <- c("123", "34", "6")
char.vector
mode(char.vector)
is.numeric(char.vector)

num.vector <- as.numeric(char.vector)
num.vector
mode(num.vector)
is.numeric(num.vector)

char.vector <- c("abc", "cd", "f")
char.vector
mode(char.vector)
is.numeric(char.vector)
is.character(char.vector)

num.vector <- as.numeric(char.vector)
num.vector
mode(num.vector)
is.character(num.vector)
is.numeric(num.vector)

num.vector <- c(123, 87, 42)
num.vector
mode(num.vector)
typeof(num.vector[1])

char.vector <- as.character(num.vector)
char.vector
mode(char.vector)

# more useful method of converting number
# to character string is 
# format(x,digits,nsmall,width)
# args digits, nsmall, width all optional
num.vector <- c(8/9, pi, 15)
num.vector
class(num.vector)
typeof(num.vector)
?format
format(num.vector) # automatically changes to char
format(num.vector, width=15) # num characters
format(num.vector, nsmall=1) # num decimals left
format(num.vector, digits=1) # num sig digits

## EXAMPLE: Shows how to use formatted output 
## to print a table of numbers. Program writes 
## out the first npowers of the number x.

# program spuRs/resources/scripts/powers.r
# display powers 1 to n of x

# input
x <- 7
n <- 5

# display powers
cat("Powers of", x, "\n")
cat("exponent    result\n\n")

result <- 1
for (i in 1:n) {
  result <- result * x
  cat(format(i, width = 8),
      format(result, width = 10),
      "\n", sep = "")
}

## this source command runs the above program:
file.exists("c://temp/powers.r")
source("c://temp/powers.r")

## Functions format and paste also take vector
## input. Could vectorize this program like this:

cat(paste(format(1:n, width = 8), 
          format(x^(1:n), width = 10),
          "\n"), sep = "")

## There are other functions for greater control:
## sprintf() and formatC() functions. See Help.

## EXAMPLE: Program quartiles1.r (uses data1.txt) 
## Reads a vector
## of numbers and calculates median, 
## 1st quartile and 3rd quartile
## Uses accompanying data file 
## data1.txt -> 8 9 3 1 2 0 7 4 5 6

# program: spuRs/resources/scripts/quartiles1.r
# Calculate median and quartiles.

# Clear the workspace
rm(list=ls())

# Input
# We assume that the file file_name 
# consists of numeric values
# separated by spaces and/or newlines
file.exists("c://temp/data1.txt")
file_name = "c://temp/data1.txt"

# Read from file
data <- scan(file = file_name)
?ceiling
# Calculations
n <- length(data)
data.sort <- sort(data)
data.1qrt <- data.sort[ceiling(n/4)]
data.med <- data.sort[ceiling(n/2)]
data.3qrt <- data.sort[ceiling(3*n/4)]

# Output
cat("1st Quartile:", data.1qrt, "\n")
cat("Median:      ", data.med, "\n")
cat("3rd Quartile:", data.3qrt, "\n")

# This command by itself will run the program:
file.exists("c://temp/quartiles1.r")
source("c://temp/quartiles1.r")

# R has built-in functions for calculating quartiles:
quantile(scan("c://temp/data1.txt"), (0:4)/4)
?quantile

## INPUT FROM THE KEYBOARD
## Can use scan() to read from 
## keyboard with arg file = ""
## scan() must be invoked 
## interactively for keyboard input
## or executed by using source() 
## or within a function

## command readline(prompt) 
## will read a single line of text
?readline
readline(prompt = " ")
(morning.message <- readline(prompt="Enter your morning message here: "))

## EXAMPLE: Roots of a quadratic 2b quad2b.r
## Another program for finding roots of quadratic which
## takes input from the keyboard

## Better just using R console. 
## Try (2, 2, 0) then (2, 0, 2)

# program spuRs/resources/scripts/quad2b.r
# find the zeros of a2*x^2 + a1*x + a0 = 0

# clear the workspace
rm(list=ls())

# input
cat("find the zeros of a2*x^2 + a1*x + a0 = 0\n")
a2 <- as.numeric(readline("a2 = ")) # use readline for input
a1 <- as.numeric(readline("a1 = ")) # use readline for input
a0 <- as.numeric(readline("a0 = ")) # use readline for input

# calculate the discriminant
discrim <- a1^2 - 4*a2*a0
# calculate the roots depending on the value of the discriminant
if (discrim > 0) {
  roots <- (-a1 + c(1,-1) * sqrt(a1^2 - 4*a2*a0))/(2*a2)
} else {
  if (discrim == 0) {
    roots <- -a1/(2*a2)
  } else {
    roots <- c()
  }
}

# output
if (length(roots) == 0) {
  cat("no roots\n")
} else if (length(roots) == 1) {
  cat("single root at", roots, "\n")
} else {
  cat("roots at", roots[1], "and", roots[2], "\n")
}

## This command sources it:
file.exists("c://temp/quad2b.r")
source("c://temp/quad2b.r")

##### Reading and Writing Files

# We will suppress warnings
options(warn=-1)

# Is more practical than simple I/O
# Typical examples: Reading data frames or matrices
# from files; working with text files; accessing
# files on remote machines; and getting file and
# directory information.

# Reading a Data Frame or Matrix from a File

# Example: File z0.txt
# name age
# John 25
# Mary 28
# Jim 19

# Note first line contains optional header
# which specifies column names

# Could read file in:
file.exists("z0.txt")
z <- read.table("z0.txt",header=TRUE)
z

# note scan() would fail due to mix of 
# numeric and character data (and a header).

# But what about if we have a matrix? There is
# no obvious direct way of reading in a matrix
# from a file, but can use scan() to read in
# matrix row by row

# Example: File x.txt is 5-by-3 matrix
# stored row wise:
# 1 0 1
# 1 1 1 
# 1 1 0
# 1 1 0
# 0 0 1

file.exists("x.txt")

# we read it into a matrix like this:
x <- matrix(scan("x.txt"),nrow=5,byrow=TRUE)
x

# might be better use read.table() and then
# convert with as.matrix().
# We create a function to do this:
read.matrix <- function(filename) {
  as.matrix(read.table(filename))
}

read.matrix("x.txt")
x

## OUTPUT TO A FILE
## Several ways to write output to a file
## Generally use write() or write.table()
## for numeric and cat() for text (or comb).

## write() command has form:

# > write(x, file = "data", ncolumns = if(is.character(x)) 1 else 5,
# +  append = FALSE) # x is the vector to be written

## file: is file to write or append to as characters
## file: "data" is default file in working directory
## file: file = "" writes to screen
## ncolumns: # cols to write vector x
## ncolumns: default is 5 for numeric
## ncolumns: default is 1 for character
## ncolumns: note vectors written row by row
## append: append or overwrite file? F default

## write() converts matrices to vectors
## R stores matrices by columns so should
## pass t(matrix) to write()
(x <- matrix(1:24, nrow = 4, ncol = 6))
write(t(x), file = "c://temp/out.txt", ncolumns = 6)

## cat() more flexible with form:

# > cat(..., file = "", sep = " ", append = FALSE)

## cat() does not automatically write a newline
## after expressions ... must include string "\n".

## Also have functions to write in specific formats
## write.table() writes into a table
## dump() creates a text representation of almost
## any R object that can then be read by source():

(x <- matrix(rep(1:5, 1:5), nrow = 3, ncol = 5))
dump ("x", file = "c://temp/x.txt")
ls()
rm(x); ls()
source("c://temp/x.txt")
x

## useful if you want to create something
## "and save it for later . . "
##

##### Introduction to Connections

# suppress warnings:
options(warn=-1)

# A 'Connection' is R's term for a fundamental
# mechanism used in various R I/O operations.

# Here we use it for file access

# To see a list of those functions, type
?connection

# Example (again) file 'y1.txt':
# John 25
# Mary 28
# Jim 19

# We read it in, line by line:
c <- file("y1.txt","r")
readLines(c,n=1)
readLines(c,n=1)
readLines(c,n=1)
readLines(c,n=1)

# Be better to set up connection so R
# keeps track of our position

c <- file("y1.txt","r")
while(TRUE) {
  rl <- readLines(c,n=1)
  if (length(rl) == 0) {
    print("reached the end")
    break
    } else print(rl)
  }

# If we wish to use "rewind", to start over at
# beginning of file, we can use seek():

c <- file("y1.txt","r")
readLines(c,n=2)

# argument where=0 means position file pointer
# zero characters from start of file
seek(con=c,where=0)

# returns 18 meaning file pointer was at position
# 18 before we made the call

readLines(c,n=1)

# you can close a connection using close()

