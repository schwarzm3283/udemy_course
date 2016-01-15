##########################################
######            FACTORS           ######
##########################################

# Factors and Levels

x <- c(5,12,13,12)
xf <- factor(x)
xf

str(xf)
?unclass
class(xf)
unclass(xf)
attr(xf,"levels")

length(xf)

x <- c(5,12,13,12)
xff <- factor(x,levels=c(5,12,13,88))
xff
# [1] 5 12 13 12
# Levels: 5 12 13 88
xff[2] <- 88
xff

xff[2] <- 28

## Common Functions used with Factors

# tapply()

ages <- c(25,26,55,37,21,42)
affils <- c("R","D","D","R","U","D")
tapply(ages,affils,mean)


d <- data.frame(list(gender=c("M","M","F","M","F","F"),
                       age=c(47,59,21,32,33,24),income=c(55000,88000,32450,76500,123000,45650)))
d

d$over25 <- ifelse(d$age > 25,1,0)
d

tapply(d$income,list(d$gender,d$over25),mean)

## The split() Function

d
?split
split(d$income,list(d$gender,d$over25))

g <- c("M","F","F","I","M","M","F")
g
split(1:7,g)

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

## Program findwords revised
findwords <- function(tf) {
  # read in the words from the file, 
  # into a vector of mode character
  txt <- scan(tf,"")
  words <- split(1:length(txt),txt)
  return(words)
}

# Working with Tables

u <- c(22,8,33,6,8,29,-2)
fl <- list(c(5,12,13,12,13,5,13),
           c("a","bc","a","a","bc","a","a"))
tapply(u,fl,length)

table(fl)

###################################################
###########     MORE ON FACTORS      ##############
###################################################

# Three basic types of variables: (1) numeric;
# (2) ordinal; and (3) categorical.

# Ordinal are ordered categories: example..high,
# medium, low. Example categorical: hair color.

# In R the data type for both ordinal and categorical
# is factor. Possible levels of a factor are its
# levels.

# Two reasons for using factors: (1) is necessary to
# represent numeric, ordinal and categorical
# variables in many statistical models; and (2) factors
# can be stored very efficiently.

# Create a factor by applying function factor to some
# vector x. Different values of vector become levels.
# Can also specify levels with levels argument....allows
# more levels than values in vector x. is.factor(x) 
# will check if is a factor, and levels(x) will return
# levels of factor object x.

hair <- c("blond", "black", "brown", "brown", "black", "gray", "none")
is.character(hair)
is.factor(hair)
hair <- factor(hair)
levels(hair)
table(hair)

# output of table is a one-dimensional array
# (not a vector).

# R sorts factors alphabetically:
hair

# Can create an ordered factor with optional
# argument ordered = TRUE
phys.act <- c("L", "H", "H", "L", "M", "M")
phys.act <- factor(phys.act, levels = c("L", "M", "H"), ordered = TRUE)
is.ordered(phys.act)

phys.act[1]
phys.act[2]
phys.act[3]
phys.act[4]
phys.act[5]
phys.act[6]

phys.act[2] > phys.act[1]

phys.act[5]==phys.act[6]
phys.act[1]==phys.act[2]

# Both abbreviations and numerical codes can be
# used to represent the levels of a factor.
# You can change the names of the levels using
# the labels argument. At the same time, it is
# good practive to specify the levels too.

phys.act <- factor(phys.act, levels = c("L", "M", "H"), labels = c("Low", "Medium", "High"), ordered = TRUE)
table(phys.act)

which(phys.act == "High")

# Note that R reports results of operations upon
# factors by the levels we assign, R represents
# factors internally as integers . . . R can coerce
# the factor object into a numeric vector with
# no warning.

hair
mode(hair)
class(hair)

# queries and then coerces
as.vector(hair)
mode(hair)
class(hair)

as.numeric(hair)
class(hair)

c(hair, 5)

x <- factor(c(0.8, 1.1, 0.7, 1.4, 1.4, 0.9))
as.numeric(x)    # does not recover x

as.numeric(levels(x))[x]   # does not recover x

as.numeric(as.character(x))  # does not recover

# Final point about factors....if you subset
# a factor object, you may end up with missing 
# levels, which can cause problems for some
# statistical functions. One solution is to
# define the factor again using factor function.
# Another is to pass the drop = TRUE to the
# subscripting operator.

table(hair[hair == "gray" | hair == "none"])

table(hair[hair == "gray" | hair == "none", drop = TRUE])
