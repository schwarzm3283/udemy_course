################################################
#######              LISTS              ########
################################################

## Lists can combine elements of different modes.

# Technically, a list is a vector
# An ordinary vector is an 'atomic' vector.
# List referred to as 'recursive' vectors
# (components can be broken down into smaller
# components)

# Consider employee database:
# Employee
# name (character)
# salary (numeric)
# union membership (boolean)

# Here is Joe:
j <- list(name="Joe", salary= 55000, union=T)
j

# Component names, called 'tags' are optional

jalt <- list("Joe", 55000, T)
jalt # But is better programming style

# Can abbreviate j$sal
j$sal  # left off 'alary'

# Since list are vectors, they can be created
# using vector():
z <- vector(mode ="list")
z[["abc"]] <- 3
z

##### GENERAL LIST OPERATIONS

# List Indexing, can access several ways
j$salary       # same as
j[["salary"]]  # same as
j[[2]]

# Can refer to list compnents by numerical indices,
# treating the list as a vector using 
# double brackets [[]]

# three ways + to access component c of list 1st:
# lst$c
# lst[["c"]] or lst["c"] # same
# lst[[i]]   or lst[i] i is index of c # same

# Both single- and double-bracket indexing access
# list elements in vector-index fashion, with one
# BIG difference from atomic vector indexing

# If sngle brackets are used, the result is
# another list, a sublist of the first list

j[1:2] # returns a list

j2 <- j[2]
j2     # also returns a list

class(j2)

str(j2)

# Subsetting operation returned another list consisting
# of the first two elements of original list j.
# 'returned' is correct. Single brackets '[]' are functions

# '[[]]' only reference a single component, the result 
# has the type of the component
j[[1:2]] # err
j2a <- j[[2]]
j2a
class(j2a)

### Adding and Deleting List Elements
# New components can be added only AFTER a list is created:
z <- list(a="abc",b=12)
z

z$c <- "sailing" # add a 'c' component
# was it added?
z

# Can also add components via a vector index
z[[4]] <- 28
z[5:7] <- c(FALSE,TRUE,TRUE)
z

# Can delete a list component by setting it to NULL
z$b <- NULL
z # Note indices of remaining components all moved up 1

## Getting the size of a list
# Since list is a vector can obtain number of
# components (not number of elements) using length()
length(z)

## Text Concordance

# Pertains to web search and text mining
# Write findwords() which determines which words are
# in a text file and locations

# Input file is testconcord.txt:
#----------------------------------------------------------------------
# The [1] here means that the first item in this line of output is
# item 1. In this case, our output consists of only one line (and one
# item), so this is redundant, but this notation helps to read
# voluminous output that consists of many items spread over many
# lines. For example, if there were two rows of output with six items
# per row, the second row would be labeled [7].
#----------------------------------------------------------------------

# To find words, we replace all nonletter characters with blanks
# and get rid of punctuation and capitalization. We are not 
# using string functions for this purpose

# The new file is testconcorda.txt:
#----------------------------------------------------------------------
# the    here means that the first item in this line of output is
# item   in this case  our output consists of only one line  and one
# item  so this is redundant  but this notation helps to read
# voluminous output that consists of many items spread over many
# lines  for example  if there were two rows of output with six items
# per row  the second row would be labeled
#----------------------------------------------------------------------

# word 'item' occupies the 7th, 14th, and 27th
# word positions in the file

## Program findwords
findwords <- function(tf) {
  # read in the words from the file, 
  # into a vector of mode character
  # txt is vector of string variables
  txt <- scan(tf,"")
  # initialize local variable wl
  wl <- list() 
  for (i in 1:length(txt)) {
    wrd <- txt[i]  # i-th word in input file
    # when i=4, wrd="that"; wl[["that"]] does not exist yet
    # so wl[["that"]]=NULL so can concatenate it. 
    # wl[["that"]] becomes one element vector (4). When
    # i=40, wl[["that"]] will become (4,40)
    wl[[wrd]] <- c(wl[[wrd]],i)
  } 
  return(wl)
}

# We call it:
file.exists('testconcorda.txt')
findwords('testconcorda.txt')

# returned list has one component per word
# with word's components showing positions
# within file where that word occurs

# list is most appropriate structure for this
# explain what is going on in the for loop

# Accessing List Components and Values
# If list components do have tags, you
# can obtain them with names()
names(j)

# unlist() turns it into a vector
# in this case a vector of character strings
# so you can retrieve the values
ulj <- unlist(j)
class(ulj)

# But if we start with numbers
# we end up with numbers

z <- list(a=5,b=12,c=13)
y <- unlist(z)
class(y)
y

# Mixed case
w <- list(a=5,b="xyz")
wu <- unlist(w)
class(wu)
wu

# R chooses the lowest common denominator:
# character strings....there is a precedence
# structure with unlist: "Vectors are coerced 
# to the highest type of components in the
# hierarchy NULL < raw< logical < integer
# < real < complex < character < list <
# expression: pairlists are treated as lists.

# However, note that R did give each element of 
# vector wu a name, we can remove by setting=NULL

names(wu) <- NULL
wu

# or can remove directly with unname()

wu <- unlist(w)
wu
wun <- unname(wu)
wun

### Applying functions to list
# Function lapply() works like apply() but on lists
# calling specified function of each component of
# list (or vector coerced to a list) and returns
# another list.

lapply(list(1:3,25:29),median)

# Sometimes list returned by lapply() could be
# simplified to a vector or matrix...this is 
# what sapply() does (simplified [l]apply)

sapply(list(1:3,25:29),median)

#### EXTENDED EXAMPLE: Text Concordance, Continued

file.exists('testconcorda.txt')
findwords('testconcorda.txt')

# Would be nice to sort the returned list

## Program alphawl
# sorts wrdlst, the output of findwords() 
# alphabetically by word
alphawl <- function(wrdlst) {
  # words are names of components, can extract:
  nms <- names(wrdlst) # the words
  # sort the words
  sn <- sort(nms)  # same words in alpha order
  # return rearranged version  
  # Note use of single brackets, not double
  # because are not subsetting the list
  return(wrdlst[sn])  
}

# Try it:
alphawl(findwords('testconcorda.txt'))

# Works fine

# We can sort by word frequency similarly:
## Program freqwl
# orders the output of 
# findwords() by word frequency
freqwl <- function(wrdlst) {
  # sapply will return a vector of word frequencies
  freqs <- sapply(wrdlst,length)  
  # order() more direct than sort()
  # order() returns indices of a sorted vector
  return(wrdlst[order(freqs)])
}

# example of what order() does, very handy
x <- c(12,5,13,8)
order(x)

# We try it. Output indicates x[2] is smallest 
# element in x, x[4] is second smallest, etc
freqwl(findwords('testconcorda.txt'))

# We can also plot most important words

file.exists('nyt.txt')
findwords(tolower('nyt.txt'))

## Program nytplot
ssnyt <- freqwl(findwords(tolower('nyt.txt')))
nwords <- length(ssnyt)
freqs9 <- sapply(ssnyt[round(0.9*nwords):nwords],length)
barplot(freqs9, main="FREQUENCY  OF  NEW  YORK  TIMES  WORDS  ABOUT  R")

## Recursive lists
# Can have lists within lists
b <- list(u = 5, v = 12)
b
c <- list(w = 13)
c
a <- list(b,c)
a

# a is a two-component list, with each component also
# itself being a list.

# Note the concatenate function c() has an optional
# argument recursive, which controls whether flattening
# occurs when recursive lists are combined.

# Here recursive default is FALSE, so obtain a
# recursive list, with the c component of the
# main list itself being another list.
c(list(a=1,b=2,c=list(d=5,e=9)))

# In second call, with recursive set to TRUE
# we get a single list as a result; only the
# names look recursive

# (Is odd that setting recursive = TRUE
# produces a nonrecursive list, but it does)
c(list(a=1,b=2,c=list(d=5,e=9)),recursive=T)
