#################################################
#####        STRING MANIPULATION IN R       #####
#################################################

# R is a statistical language but character
# strings are surprisingly important as well. 
# Ranging from birth dates stored in medical 
# research data files to textmining apps,
# character data is quite prominent in R 
# programs. Accordingly, R has a number of
# string-manipulation utilities.

#### An Overview of String-Manipulation Functions

# We go over basic here, omitting some arguments
# and we do not cover all string manipulation
# functions in R

##### grep()

# The call grep(pattern,x) searches for a 
# specified substring pattern in vector x of
# strings. If x has n elements-that is, it 
# contains n strings-then grep(pattern,x) 
# returns a vector of length up to n. Each 
# element of this vector will be the index 
# in x at which a match of pattern as a 
# substring of x[i]) was found.

# grep returns index

grep("Pole",c("Equator",
              "North Pole",
              "South Pole"))

# found matches in second and third vector element

# grepl (for logical) returns TRUE or FALSE

grepl("Pole",c("Equator",
              "North Pole",
              "South Pole"))

# found matches in second and third vector element

# to return the matching value of the entire
# string where the match is found (instead of index) 
# use argument value=TRUE

grep("Pole",c("Equator",
              "North Pole",
              "South Pole"),value=TRUE)

##### nchar()

# nchar(x) returns the length of a string x. 

nchar("South Pole")

# note: a blank space is a character. Also, note
# the results of nchar() will be unpredictable 
# if x is not in character mode. For example:

nchar(NA)

# is 2

nchar(factor("abc"))

# returns an error

# For more consistent results on nonstring objects,
# use Hadley Wickham's stringr package on CRAN.

##### paste()

# paste(...) concatenates several strings, 
# returning the result in one long string:

paste("North","Pole")

# default space put between 'North' and 'Pole'

paste("North","Pole",sep="")

# sep = "" means no space

paste("North","Pole",sep=".")

paste("North","and","South","Poles")

# often cat() preferred to paste because paste
# returns [1] indexes and quote marks "...."
# cat() does not so cat() better to write
# output from programs:

cat("North","and","South","Poles")

# use of cat() in program
(x_list <- seq(1, 9, by=2))

# initialize to zero
sum_x <- 0

# keep summing through vector
for (x in x_list){
  sum_x <- sum_x+x
  cat("The current loop element is",x,"\n")
  cat("The cumulative total is",sum_x,"\n")
}

sum(x_list)

##### sprintf()

# sprintf(...) assembles a formatted string from 
# the provided parts:

i <- 8
s <- sprintf("the square of %d is %d",i,i^2)
s

# the function prints to the string s. What are we
# we printing? The function says to first print 
# "the square of" and then print the value
# of i and then the square of i.

##### substr()

# substr(x,start,stop) returns the substring in 
# the given character position range start:stop 
# in the given string x. Here's an example:

substring("Equator",3,5)

##### strsplit()

# strsplit(x,split) splits a string x into an 
# R list of substrings based on identified
# splitting character in second argument:

strsplit("6-16-2011",split="-")

##### regexpr()
 
# regexpr(pattern,text) finds the character 
# position of only the first instance of
# pattern within text:

regexpr("uat","Equator")

# "uat" did indeed appear in "Equator," 
# starting at character position 3.

##### gregexpr()
 
# gregexpr(pattern,text) is the same as regexpr(), 
# but it finds all instances (not just the first )
# of pattern:

gregexpr("iss","Mississippi")

# it also returns the length of each match

# finds that "iss" appears twice in "Mississippi," 
# starting at character positions 2 and 5.

##### Regular Expressions (Can be very complex)

# When dealing with string-manipulation functions 
# in programming languages, the notion of regular 
# expressions sometimes arises. In R, you must 
# pay attention to this point when using the 
# string functions grep(), grepl(), regexpr(),
# gregexpr(), sub(), gsub(), and strsplit().

# A regular expression is like a wild card. 
# It's shorthand to specify broad classes of 
# strings. For example, the expression "[au]" 
# refers to any string that contains either of 
# the letters a or u. You could use it like this:

grep("[au]",c("Equator",
              "North Pole",
              "South Pole"))

# elements 1 and 3 of ("Equator","North Pole",
# "South Pole")-that is, "Equator" and "South 
# Pole"-contain either an a or a u.

# A period (.) represents any single character: 

grep("o.e",c("Equator",
             "North Pole",
             "South Pole"))

# searches for three-character strings in which 
# an o is followed by any single character, which 
# is in turn followed by an e. Here is an example 
# of the use of two periods to represent any pair 
# of characters:

grep("N..t",c("Equator",
              "North Pole",
              "South Pole"))

# we searched for four-letter strings consisting 
# of an N, followed by any pair of characters, 
# followed by a t.

# A period is an example of a metacharacter, 
# which is a character that is not taken literally.
# For example, if a period appears in the first 
# argument of grep(), it doesn't actually mean 
# a period; it means any character.

# if you actually want to search for a period 
# using grep() can use this naive approach:

grep(".",c("abc","de","f.g"))

# result should have been 3, not (1,2,3). This 
# call failed because periods are metacharacters. 
# You need to escape the metacharacter nature of 
# the period by using a backslash:

grep("\\.",c("abc","de","f.g"))

# why do we use two backslashes? Because the
# backslash itself must be escaped, which is 
# accomplished by another backslash.

## THIS SHOWS HOW COMPLEX A REGULAR EXPRESSION
## CAN BECOME ! ! 

##### EXTENDED EXAMPLE: Testing a Filename 
##### for a Given Suffix

# Suppose we wish to test for a specified suffix 
# in a filename. We might, for instance want
# to find all HTML files (those with suffix .html, 
# .htm, and so on). Here is R script:

testsuffix <- function(fn,suff) {
  parts <- strsplit(fn,".",fixed=TRUE)
  nparts <- length(parts[[1]])
  return(parts[[1]][nparts] == suff)
}

# We test it:

testsuffix("x.abc","abc")

testsuffix("x.abc","ac")

testsuffix("x.y.abc","ac")

testsuffix("x.y.abc","abc")

# How does the function work? First note that 
# the call to strsplit() on line 2 returns a
# list consisting of one element (because fn 
# is a one-element vector)-a vector of strings.

# For example, calling testsuffix("x.y.abc",
# "abc") will result in parts being a list 
# consisting of a three-element vector with 
# elements x, y, and abc. We then pick up the 
# last element and compare it to suff.

# A key aspect is the argument fixed=TRUE. 
# Without it, the splitting argument '.' 
# (called split in the list of strsplit()'s 
# formal arguments) would have been treated
# as a regular expression. Without setting 
# fixed=TRUE, strsplit() would have just
# separated all the letters.

?strsplit

# Of course, we could also escape the period, 
# as follows:

testsuffix <- function(fn,suff) {
  parts <- strsplit(fn,"\\.")
  nparts <- length(parts[[1]])
  return(parts[[1]][nparts] == suff)
}

# still works:
testsuffix("x.y.abc","abc")

# Here's any alternative approach, more
# complex, but a decent example:

testsuffix <- function(fn,suff) {
  # nchar() gives the string length
  ncf <- nchar(fn)
  # determine where the period would 
  # start if suff is the suffix in fn
  dotpos <- ncf - nchar(suff) + 1
  # now check that suff is there
  return(substr(fn,dotpos,ncf)==suff)
}

# We look at the call to substr() here, 
# again with fn = "x.ac" and suff = "abc". 
# In this case, dotpos will be 1, which 
# means there should be a  period at the
# first character in fn if there is an abc 
# suffix. The call to substr() then becomes
# substr("x.ac",1,4), which extracts the 
# substring in character positions 1 through 
# 4 of x.ac. That substring will be x.ac, 
# which is not abc, so the filename's suffix 
# is found not to be the latter.


##### EXTENDED EXAMPLE: Forming Filenames

# Suppose we want to create five files, 
# q1.pdf through q5.pdf, consisting of
# histograms of 100 random N(0,i2) variates. 
# We could execute the following script:

for (i in 1:5) {
  fname <- paste("q",i,".pdf")
  pdf(fname)
  hist(rnorm(100,sd=i))
  dev.off()
}

# The  point is the string manipulation we 
# use to create the filename 'fname'. 

# The paste() function concatenates the 
# string "q" with the string form of
# the number i. For example, when i = 2, 
# the variable fname will be q 2 .pdf.

# However, that isn't quite what we want. 
# We want to remove the spaces. One solution
# is to use the 'sep' argument, specifying an 
# empty string for the separator:

for (i in 1:5) {
  fname <- paste("q",i,".pdf",sep="")
  pdf(fname)
  hist(rnorm(100,sd=i))
  dev.off()
}

# Or could use the sprintf() function, 
# borrowed from C:

for (i in 1:5) {
  fname <- sprintf("q%d.pdf",i)
  pdf(fname)
  hist(rnorm(100,sd=i))
  dev.off()
}

# For floating-point quantities, note also 
# the difference between %f and %g formats:

sprintf("abc%fdef",1.5)

# [1] "abc1.500000def"

sprintf("abc%gdef",1.5)

# [1] "abc1.5def"

# The %g format eliminated 
# the superfluous zeros.

## String Utilities are used extensively in
## edtdbg debugging tool as we will see in
## that session.