##############################################
#####    CHARACTER MANIPULATION WITH R   #####
##############################################

# R contains a full complement of functions 
# which can manipulate character data.

# Basics of Character Data

# Character values in R can be stored as 
# scalars, vectors, or matrices, or they
# can be columns of a data frame or elements 
# of a list. 

# When applied to objects like this, length()
# function will report the number of character 
# values in the object, not the number of 
# characters in each string. 

# To find the number of characters in a 
# character value, the nchar function can be 
# used. Like most functions in R, nchar is 
# vectorized. 

# Names of the fifty states in U.S. can be
# found in the vector state.name. 

# To find the lengths of the states' names:

nchar(state.name)

##### Displaying and Concatenating 
##### Character Strings

# Character values are displayed when their 
# name is types or when passed to the print() 
# function. However, it is often more 
# convenient to print or display these 
# objects directly without the subscripts 
# that the print function provides. 

# The cat() function combines character values 
# and prints them to the screen or a file 
# directly, coercing its arguments to 
# character values:

x = 7
y = 10

cat('x should be greater than y, but x =',
    x,'and y =',y,'\n')

# Note use of a newline (\n). cat() always prints 
# a newline when encounters a newline character.

# With multiple strings passed to cat, or when 
# argument is a vector of character strings, 
# the fill= argument can be used to insert
# newlines into the output string. 

# If fill= set to TRUE, the value width option 
# used to determine linesize, although cat()
# will not insert newlines into individual 
# elements input:

cat('Long strings can','be displayed over',
    'several lines using','the fill= argument',
    fill=40)

cat('Long strings can','be displayed over',
    'several lines using','the fill= argument',
    fill=20)

# fill=10 does not truncate longer strings
cat('Long strings can','be displayed over',
    'several lines using','the fill= argument',
    fill=10)

# paste() function allows more control over
# character values are concatenated. In its 
# simplest usage, this function will accept 
# an unlimited number of scalars, and join 
# them together, separating each scalar with
# a space by default. 

# Can use a character string other than a 
# space with sep= argument. paste() also
# converts any non-character object to mode
# character:
paste('one',2,'three',4,'five')

# paste() inserts one space as separator
# by default.

# collapse= to specify character string
# to insert between each element, but
# only when joining elements in a vector:
paste(c('one','two','three','four'),
      collapse=' hello ')

# collapse works, coerces integers to char:
paste(c(7,1,13,22),
      collapse=' hello ')

# note collapse= must be used in above case,
# sep= has no effect when applied to a vector:
paste(c('one','two','three','four'),
      sep='---',collapse=' hello ')

# collapse does not work with indiv elements:
paste(7,1,13,22,
      collapse=' hello ')

# note collapse= does not work when applied
# to individual character elements to join:
paste('one','two','three','four',
      sep='-&-',collapse=' hello ')

# When multiple arguments passed, paste()
# vectorizes the operation, recycling shorter 
# elements when necessary, so can generate
# variable names with a common prefix:
paste('X',1:5,sep='')
paste(c('X','Y'),1:5,sep='')

# can use sep= to control what is in between
# each set of values that are combined, and
# collapse= to specify to use when joining
# those individual values:
paste(c('X','Y'),1:5,
      sep='*',collapse='|')

# same sort of operations can be applied
# to multiple arguments to paste:
paste(c('X','Y'),1:5,'^',
      c('a','b'),sep='_',collapse='|')

# by omitting collapse= argument, individual
# pasted pieces are returned separately
# rather than a single string:
paste(c('X','Y'),1:5,'^',
      c('a','b'),sep=' ')

# returns same but as one long string:
paste(c('X','Y'),1:5,'^',
      c('a','b'),collapse='|')

##### Working with Parts of Character Values

# Cannot access individual characters of
# character strings through subscripting. 

# substring() function can be used either 
# to extract parts of character strings or 
# to change the values of parts of character 
# strings.

# substring() also accepts a first= argument
# specifying the first character of the 
# desired substring, and a last= argument
# specifying the last character. 

# Otherwise, last= defaults to a large number
# so specifying just a start= value will 
# operate from that character to the end of
# the string. 

# substring() is vectorized, operating on 
# multiple strings at once:
substring(state.name,2,6)

# Notice in the case of strings that have fewer
# characters than specified in the last=
# argument (Ohio or Texas), substring() returns
# as many characters as it finds with no 
# padding provided.
                                                          function can be used to pad a series of character values to a common size; see
                                                          Section 2.13.)
# Vectorization takes place for the first= and 
# last= arguments as well as for character
# vectors passed to subscript. 

mystring = 'dog cat duck'

# point here is that substring gets vectorized
# goes from one string to several
substring(mystring,c(1,5,9),c(3,7,12))

# Can find locations of particular characters 
# within a character string, but the string
# must first be converted to a character vector 
# with the individual characters.

# Can do by passing a vector consisting of all 
# the characters to be processed as both the 
# first= and last= arguments, and then applying
# which to the result:
  
state = 'Mississippi'
# use nchar() to figure out how long string is:
end = nchar(state);end
# is a good 'trick':
ltrs = substring(state,1:end,1:end);ltrs
which(ltrs == 's') 

# The assignment form of substring() allows 
# replacement of selected portions of character
# strings, but substring will only replace parts
# of the string with values that have the same
# number of characters; if a string that's 
# shorter than the implied substring is provided, 
# none of original string is overwritten:

# only replaces 3 characters, not 5:
mystring = 'dog cat duck'
substring(mystring,5,7) = 'tiger'
mystring

# only replaces one character, not 3:
mystring = 'dog cat duck'
substring(mystring,5,7) = 'b'
mystring

##### Breaking Apart Character Values

# strsplit() function can use a character 
# string or regular expression to divide
# a character string up into smaller pieces. 

# First argument is character string to break 
# up, second argument is character value or
# regular expression to be used to break up 
# the string.

# strsplit() always returns a list:
## strsplit divides a character string
sentence = 'R is a free software environment for statistical computing'
nchar(sentence)
parts = strsplit(sentence,' ')
parts
class(parts)

# can access thru first element (only) of list:
length(parts)
length(parts[[1]])

# if input to strsplit is vector of character 
# strings, can use sapply to process results 
# for each of the strings:
some.text = c('R is a free software environment for statistical computing',
              'It may be compiled and run on many UNIX machines')
result = strsplit(some.text,' ')
result
class(result)
# will return # elements in each component:
sapply(result,length)

# if structure of output unimportant, all of
# split parts can be combined with unlist():
allparts = unlist(result)
class(allparts)
allparts

# Because strsplit can accept regular 
# expressions to decide where to split a
# a character string, can handle many situations
# for example, can find multiple empty spaces:
str = 'one  two   three four'
strsplit(str,' ')

# using an empty string as splitting character
# strsplit() can return a list of individual 
# characters from vector of character strings:

# By using a regular expression representing
# one or more blanks (+ modifier) we can extract
# only the nonempty strings:
strsplit(str,' +')

# Using empty string as splitting character,
# can return list of individual characters from
# vector of character strings:
words = c('one two','three four')
words
strsplit(words,'') 

##### Regular Expressions

# Regular expressions are a method of expressing 
# patterns in character values which can then be
# used to extract parts of strings or to modify 
# those strings in some way. Regular expressions
# are supported in the R functions: strsplit(),
# grep(), sub(), and gsub(), as well as in the 
# regexpr() and gregexpr() functions which are
# the main tools for working with regular 
# expressions in R.

# The backslash character (\) is used in regular
# expressions to signal that certain characters
# with special meaning in regular expressions 
# should "escape" and be treated as normal
# characters. 

# So two backslash characters must be entered
# into an input string anywhere that special 
# characters need to be escaped.

# Although the double backslash will display 
# when the string is printed, nchar() or cat()
# can verify that only a single backslash is 
# actually included in the string.

# For example, in regular expressions, a period 
# (.) is ordinarily matched by any single char-
# acter. To create a regular expression that 
# would match file names with an extension of 
# ".txt", we could use a regular expression:

# is really 8 characters
expr = '.*\\.txt'

# only counts 7
nchar(expr)

# only 'sees' 7:
cat(expr,'\n')

# Single backslashes, like those which are part 
# of a newline character (\n), will be seen
# correctly inside of regular expressions. One 
# way to avoid need for quotes or double 
# backslashes is to use the readline() function 
# to enter regular expressions into R.

expr = readline()
# type in concole .*\.txt and then hit enter
# sees 7 characters
nchar(expr)

expr = readline()
# type in concole .*\\.txt and then hit enter
# sees 8 characters
nchar(expr)

##### Basics of Regular Expressions

## SEE SLIDES

# Regular expressions are simply character 
# strings so they can be manipulated like 
# any other character strings.

# vertical bar (|) used in regular expressions 
# to express alternation. To create a regular
# expression that would be matched by several 
# different strings, we can combine the strings
# using the bar as a separator:

strs = c('chicken','dog','cat')
expr = paste(strs,collapse='|')
expr

# Variable expr could now be used as a regular 
# expression to match any of the words in the
# original vector.

##### Using Regular Expressions

## grep()

# First we use grep() without regular expression
# then with regular expressions

# grep() function accepts a regular expression 
# and a character string or vector of character
# strings, and returns the indices of those 
# elements which are matched. 

# argument value=TRUE argument will return the 
# actual strings which matched the expression
# instead of the indices.

# using grep() without regular expressions:

install.packages("DAAG")
library(DAAG)
data(Cars93)
head(Cars93[,1:8])

# to output column indices of variables in
# Cars93 beginning with 'MPG' we can say
grep('MPG',names(Cars93))

# to output variable names in Cars93 cols 1-8
# beginning with 'MPG' we can use value=TRUE
grep('MPG',names(Cars93),value=TRUE)

# to create data frame with just these variables
head(Cars93[,grep('^MPG',names(Cars93[,1:8]))])

str1 = c('The R Foundation',
         'is a not for profit organization',
         'working in the public interest')

grep('profit',str1)

# If string passed to grep has no match in any
# inputs, grep returns empty numeric vector
str2 = c(' It was founded by the members',
         'of the R Core Team in order',
         'to provide support for the R project')

grep('profit',str2)

# any() function tests whether string occurs:
any(grep('profit',str1))
any(grep('profit',str2))

# using grep() with regular expressions

# One important use of grep is to extract a set 
# of variables from a data frame based on their
# names. For example, the LifeCycleSavings data 
# frame contains two variables with information 
# about the percentage of population less than
# 15 years old (pop15) or greater than 75 years 
# old (pop75). 

head(LifeCycleSavings)

# Since both of variables begin with the 
# string "pop", we can find their indices
# or values using grep:
grep('^pop', names(LifeCycleSavings))
grep('^pop', names(LifeCycleSavings), value=TRUE)

# Can create a data frame with just these 
# variables, we can use the output of grep
# as a subscript:

# getting column indices with 'pop':
head(LifeCycleSavings[,grep('^pop',names(LifeCycleSavings))])

# To find regular expressions without regard to 
# the case (upper or lower), use 
# ignore.case=TRUE argument: 

# search for string dog without case-specificty:

inp = c('run dog run',
        'work doggedly',
        'CAT AND DOG')
inp

# ignores case:
grep('\\<dog\\>',inp,ignore.case=TRUE)

# regexpr() and gregexpr() functions tell where 
# regular expressions were found. If there is
# no match, value of -1 is returned.

# The output attribute match.length also provides 
# information about exactly which characters 
# were involved in the match.

# regexpr() provides information about first 
# match only in string.

# gregexpr() returns information about 
# all matches found in string.

# regexpr() always returns a vector with -1 
# in positions for no match.

# substr() will extract the strings that matched
# after calculating the ending position from
# regexpr() output and the match.length attribute:

tst = c('one x7 two b1',
        'three c5 four b9',
        'five six seven',
        'a8 eight nine')
tst

wh = regexpr('[a-z][0-9]',tst)
wh

# can find and extract the matching 
# characters with match.length and substring:
res=substring(tst, wh, 
              wh+attr(wh,'match.length')-1)
res

# no match in third string
# can remove non-matches with
res[res != '']

# gregexpr() output is similar to regexpr() 
# except (like strsplit()), gregexpr() always
# returns result in the form of a list
# gregexpr() also returns all matches, 
# not just first
wh1 = gregexpr('[a-z][0-9]',tst)
wh1

# can further process results from gregexpr()
# using substring() for each element of 
# output list

res1 = list()
res1
class(res1)
for(i in 1:length(wh1))
  res1[[i]] = substring(tst[i],
                        wh1[[i]],
                        wh1[[i]] +
                          attr(wh1[[i]],
                               'match.length')-1)
res1

# another way to process output is mapply()
# first mapply argument is a function that 
# accepts multiple arguments; remaining
# arguments are vectors of = lengths whose
# elements will be passed to that function 
# one at a time
getexpr=function(str,
                 greg)substring(str,
                                greg,
                                greg+attr(greg,
                                          'match.length')-1)

# now call mapply with the two vectors:
res2 = mapply(getexpr,tst,wh1)
res2

# mapply uses the input strings as names 
# in the output

##### Substitutions and Tagging

# substitute text based on regular expressions:
# use sub() and gosub() functions; each accepts:
# 1) a regular expression;
# 2) string of what will be substituted 
#    for regular expression;
# 3) string (or strings) to operate on;

# sub() changes only the first occurrence
# gosub() changes all occurrences

# can be used used in financial reports:
values = c('$11,317.35',
           '$11,234.51',
           '$11,275.89',
           '$11,278.93',
           '$11,294.94')
values

# to use as numbers, must remove commas and $ signs
# before as.numeric() function can be used

# want a regular expression to find either 
# commas or $ signs so we use a character 
# class passed to gsub() with an empty
# substitution pattern, providing values
# which can be converted to numbers:
as.numeric(gsub('[$,]','',values))

# when use substitution, can use feature 
# known as tagging. Example: In financial
# reports, often surround negative numbers
# with parentheses.....this is a problem for
# R....they prevent R from recognizing them
# as negative numbers (are unescaped 
# parentheses). 

# We can tag the number in parentheses 
# using a regular expression, and substitute
# the value by preceding it with a minus sign.

# Note difference between literal parentheses 
# (preceded by \\) and the parentheses used 
# for tagging:
values = c('75.99','(20.30)','55.20')
as.numeric(gsub('\\(([0-9.]+)\\)',
                '-\\1',values))

# To extract just tagged pattern from a 
# regular expression we can use regular
# expression beginning and end characters
# (^ and $, respectively) to account for 
# all nontagged characters in the string,
# and thus just specify the tagged expression
# for the substitution string

# EXAMPLE: We want to extract any 
# value preceded by 'value='
str = 'report: 17 value=12 time=2:00'
sub('value=([^ ]+)','\\1',str)

# we expand the regular expression 
# to include all unwanted parts
# and substitution extracts only 
# what we want
sub('^.*value=([^ ]+).*$','\\1',str)

# or could use regexpr() or gregexpr() 
# to find location of match, and apply
# sub() or gsub() to the extracted parts:

# same result as previous example:
str = 'report: 17 value=12 time=2:00' 
greg = gregexpr('value=[^ ]+',str)[[1]]
sub('value=([^ ]+)','\\1', 
    substring(str,greg,greg 
              + attr(greg, 'match.length') - 1))

