################################################
#######           MORE LISTS            ########
################################################

# Lists are unique. Vector is an indexed set of objects.
# All objects in vector are of same type - numeric, 
# character or logical - called the 'mode' of the vector.
# Like a vector, a list is also an indexed set of objects,
# but unlike a vector the elements of a list can be of
# different types, including other lists. The mode of
# a list is a list.

# This is where a list gets its versatility and power:
# A list might contain an individual measurement, a
# vector of observations on a single response variable,
# a dataframe, or even a list of dataframes containing
# the results of several experiments.

# In R, lists are the preferred structures for collecting 
# and storing complicated function output. 

# Dataframes are specialized kinds of lists.

# Can create a list with list() command, using
# comma-separated arguments; Single square brackets
# are used to select a sublist (or a component). Double 
# square brackets are used to select a single element.

my.list <- list("one", TRUE, c(2,7,3,8), c("f", "o", "u", "r"))
my.list
my.list[2]    # single bracket selects second sublist
my.list[[4]]  # double bracket extracts a single element of 4th comp.
my.list[[4]][3] # can select elements in comp. vector
my.list[[2]][2] # there is no second element
my.list[3]    # selects third sublist

# See above, you use double square brackets to
# indicate list elements (components), then single
# square brackets to indicate vector elements.

# The elements (components) of a list can be
# named when the list is created in the form
# of name1 = x1, name2 = x2 and so on, or they
# can be named later by assigning a value to the
# names attribute.

# Unlike a dataframe, the elements of a list DO NOT
# have to be named.

# Names can be used (with quotes) when indexing with
# single or double square brackets:

a <- c(25,35,45)
names(a) <- c("Larry","Curly","Moe")
a
my.list1 <- list(my.list,a)
my.list1    # Note now have two double brackets for 1st 4
my.list1[1]    # first sublist
my.list1[2]   # can call second sublist; only two, not five
my.list[[1]]  # first element of 1st sublist
my.list1[[2]] # calls vector w/ named elements in 2nd sublist
my.list1[[2]][2]  # 2nd element of vector
names(my.list1)[[2]] <- "stooges"
my.list1[2]
my.list1['stooges']
my.list1[['stooges']]['Curly']

# Create the list components with names
my.list2 <- list(first = "one", second = TRUE, third = 3, fourth = c("f", "o", "u", "r"))
my.list2
names(my.list2)

my.list2[4]     # can call 4th component by index
my.list2$fourth # can call fourth component by name

names(my.list2) <- c("First element", "Second element", "Third element","Fourth element")
my.list2  # have changed names in list

# Unlist() command will 'flatten' a list, that is,
# return it to a vector:

x <- list(1, c(2, 3), c(4, 5, 6));x
unlist(x)

# Many complicated functions produce list objects as
# their output. Least squares regression, the regression
# object output is a list:

lm.xy <- lm(y~x, data = data.frame(x = 1:5, y = 1:5))
lm.xy
summary(lm.xy) # summary is a generic function gives results of lm

# is an "lm" object:
class(lm.xy)
mode(lm.xy)
str(lm.xy)
names(lm.xy)

# First element 'coefficients' is vector giving
# intercept and slope
lm.xy$coefficients

# Second element 'residuals' gives residuals, and so on
lm.xy$residuals

# EXAMPLE: Victorian Football League (VFL) 1897
# became Australian Football League (AFL) in 1990.
# Show teams that have played in FVL and AFL and
# years they have won premiership as a list.

# Each vector is an element of dates, named
# after team that won.

premierships <- list(
  Adelaide = c(1997, 1998),
  Carlton = c(1906, 1907, 1908, 1914, 1915, 1938, 1945, 1947,
              1968, 1970, 1972, 1979, 1981, 1982, 1987, 1995),
  Collingwood = c(1902, 1903, 1910, 1917, 1919, 1927, 1928, 1929,
                  1930, 1935, 1936, 1953, 1958, 1990),
  Essendon = c(1897, 1901, 1911, 1912, 1923, 1924, 1942, 1946,
               1949, 1950, 1962, 1965, 1984, 1985, 1993, 2000),
  Fitzroy_Brisbane = c(1898, 1899, 1904, 1905, 1913, 1916, 1922, 1944,
                       2001, 2002, 2003),
  Footscray_W.B. = c(1954),
  Fremantle = c(),
  Geelong = c(1925, 1931, 1937, 1951, 1952, 1963, 2007),
  Hawthorn = c(1961, 1971, 1976, 1978, 1983, 1986, 1988, 1989, 1991, 2008),
  Melbourne = c(1900, 1926, 1939, 1940, 1941, 1948, 1955, 1956,
                1957, 1959, 1960, 1964),
  N.Melb_Kangaroos = c(1975, 1977, 1996, 1999),
  PortAdelaide = c(2004),
  Richmond = c(1920, 1921, 1932, 1934, 1943, 1967, 1969, 1973,
               1974, 1980),
  StKilda = c(1966),
  S.Melb_Sydney = c(1909, 1918, 1933, 2005),
  WestCoast = c(1992, 1994, 2006)
)

# str() summarizes the structure of list or DF:
str(premierships)

# who won premiership in ????

year <- 1967
for (i in 1:length(premierships)) {
  if (year %in% premierships[[i]]) {
    winner <- names(premierships)[i]
  }
  
}

winner # was Richmond in 1967
# Now we examine how to vectorize this example

########################################################
################# THE APPLY FAMILY  ####################
########################################################

# Apply family very useful for manipulating lists and dataframes.
# Apply functions allow you to easily apply a function to all
# or to selected elements of a list or dataframe.

#########################################################
#####################  TAPPLY  ##########################
#########################################################

# tapply vectorizes application of a function to subsets 
# of data, summarizing by levels of a factor variable:
ufc <- read.csv("c:/temp/ufc.csv")
ufc$height.m
levels(ufc$species)
tapply(ufc$height.m, ufc$species, mean)

# General form of tapply is:
# tapply(X, INDEX, FUN, ...)

# 1) where X is target vector to which function will be applied;
# 2) INDEX is a factor, same length as X, which is used
#    to group elements of X (INDEX is coerced to a factor);
# 3) FUN is function to be applied to subvectors of X
#    corresponding to a single level of INDEX;

# tapply returns a one-dimensional array the same length
# as levels(INDEX), whose i-th element is the result of
# applying FUN to X[INDEX == levels(UNDEX)[i]] (plus any 
# additional arguments given by ...).

# EXAMPLE: Upper Flat Creek data gain:
# tapply calculates average height by species:

tapply(ufc$height.m, ufc$species, mean)

# Too many digits, round off:

round(tapply(ufc$height.m, ufc$species, mean), digits = 1)

# How many examples do we have of each species?
# Could use table() or equivalently:

tapply(ufc$species, ufc$species, length)

# INDEX argument can also be a list of factors
# in which case output is an array with dimensions
# equal to length of each factor, with each element
# given by applying FUN to subset of X indexed by
# a specific factor combination.

# EXAMPLE: average height by species and plot:

head(tapply(ufc$height.m, ufc[c("plot", "species")], mean))
ht.ps <- tapply(ufc$height.m, ufc[c("plot", "species")], mean)
round(ht.ps[1:5,], digits=1)

# Note from NA's above that most plots only contain
# a couple of different species.

###########################################################
#### Applying Functions to Lists lapply() and sapply() ####
###########################################################

# Have used sapply and apply to 'operate' a function to a
# vector or array (eg calculate row and column totals for
# a matrix).

#########################################################
################  SAPPLY and LAPPLY  ####################
#########################################################

# Can 'operate' a function to a list using either sapply
# or lappy:

# The lapply (X, FUN, ...) function applies the function
# FUN to each element of list X and returns a list. The
# sapply(X, FUN, ...) function applies the function FUN
# to each element of (either list or vector) X, and tries
# to return the results in a vector or a matrix if it can.
# Otherwise, results from sapply come back in a list.

# The (...) argument at the end of the formal argument
# list allows you to pass extra parameters to FUN (not to
# sapply or lapply)

# EXAMPLE: Obtain mean diameter, height, and volume of
# trees in Upper Flat Creek dataset:

head(ufc) # if no volume column, do this:
ufc$volume.m3 <- pi * (ufc$dbh.cm/200)^2 * ufc$height/2
head(ufc) # is volume.m3 there as last column?

# lapply returns results as a list:

lapply(ufc[4:6], mean)

# sapply smashes the same results down to a vector
# with a names attribute:

sapply(ufc[4:6], mean)

# Using VFL/AFL premiership data, here is vectorized
# way to find out who won in 1967:

in.1967 <- function(x) return(1967 %in% x) # returns x for 1967
names(premierships)[sapply(premierships, in.1967)]

# Using sapply we can calculate the number of
# premierships won by each team:

sort(sapply(premierships, length)) # number in each element

# Can restrict list of premierships to post-1990 AFL era
# using lapply:

(AFL <- function(x) x[ x >= 1990]) # for x >= 1990

# create premierships.AFL subset and show structure:

(premierships.AFL <- lapply(premierships, AFL))
str(premierships.AFL) # shows a list of 16

# Can restrict premierships to between the years 1970 and 1979:

(between.years <- function(x, a, b) x[a <= x & x <= b])
(premierships.1970s <- lapply(premierships, between.years, 1970, 1979))

##### PUT TREEGROWTH.CSV FILE IN C:/TEMP #####

##############################################
#######    EXAMPLE: Tree Growth   ############
##############################################

# Sample of 66 Grand Fir trees (Abies grandis
# selected from national forests in north and
# central Idaho. Were trees 'dominant' in their
# environment, with no visible crown damage, forks,
# broken tops, etc.

# For each tree, the habitat type and the national
# forest from which it came were recorded. We
# have data from nine national forests and six
# different habitat types.

# For each tree, the height, diameter, and age were
# measured (using tree rings). Then tree was split
# lengthwise to determine the height and diameter
# of tree at any age. Recorded height and diameter
# of each tree at:

# 1) Time tree was felled; and
# 2) At 10-year periods going back in time;

# Diameter of tree measured at 1.37 m (breast height).
# Height is height of main trunk only.

# Data is in treegrowth.csv with each row giving diameter
# at breast height (dbh) in inches and height in feet,
# for a single tree at a given age.

treeg <- read.csv("c://temp/treegrowth.csv")
head(treeg)
str(treeg)

# Here are rows relevant to first two trees:

treeg[1:15,]

# Alternative approach to structure data is to
# collect measurements for each tree together
# in a single variable. We will use a list with
# these elements:

# 1) tree ID number;
# 2) forest code;
# 3) habitat code;
# 4) 3 vectors of:
#    a) age;
#    b) dbh; and
#    c) height measurements (trunk only).

# Each tree record will then be single element
# of a larger list called "trees".


trees <- list() #list of trees
n <- 0 # number of trees in the list of trees

# start collecting information on current tree
current.ID <- treeg$tree.ID[1]
current.age <- treeg$age[1]
current.dbh <- treeg$dbh.in[1]
current.height <- treeg$height.ft[1]
for (i in 2:dim(treeg)[1]) {
  if (treeg$tree.ID[i] == current.ID) {
    # continue collecting information on current tree
    current.age <- c(treeg$age[i], current.age)
    current.dbh <- c(treeg$dbh.in[i], current.dbh)
    current.height <- c(treeg$height.ft[i], current.height)
  } else {
    # add previous tree to list of trees
    n <- n + 1
    trees[[n]] <- list(tree.ID = current.ID,
                       forest = treeg$forest[i-1],
                       habitat = treeg$habitat[i-1],
                       age = current.age,
                       dbh.in = current.dbh,
                       height.ft = current.height)
    # start collecting information on current tree
    current.ID <- treeg$tree.ID[i]
    current.age <- treeg$age[i]
    current.dbh <- treeg$dbh.in[i]
    current.height <- treeg$height.ft[i]
  }
}

# add final tree to list of trees
n <- n + 1
trees[[n]] <- list(tree.ID = current.ID,
                   forest = treeg$forest[i],
                   habitat = treeg$habitat[i],
                   age = current.age,
                   dbh.in = current.dbh,
                   height.ft = current.height)

# Let's see how data on first two trees is structured:

str(trees[1:2])

# We used loops in the above to split the data up. Phil
# Spector used the following more compact solution that uses
# lapply in the second function:

getit <- function(name, x) {
  if (all(x[[name]] == x[[name]][1])) {
    x[[name]][1]
  }
  else {
    x[[name]]
  }
}
repts <- function(x) {
  res <- lapply(names(x), getit, x)
  names(res) <- names(x)
  res
}
trees.ps <- lapply(split(treeg, treeg$tree.ID), repts)
str(trees.ps[1:2])

# We want to plot a curve of height versus age for each tree.
# To do so, we need to know the maximum age and height so we
# can set up the plot region:

max.age <- 0
max.height <- 0
for (i in 1:length(trees)) {
  if (max(trees[[i]]$age) > max.age)
    max.age <- max(trees[[i]]$age)
  if (max(trees[[i]]$height.ft) > max.height)
    max.height <- max(trees[[i]]$height.ft)
}

# Here is a more concise way of calculating max.age
# and max.height, using sapply:

my.max <- function(x, i) max(x[[i]]) #max of element i of list x
max.age <- max(sapply(trees, my.max, "age"))
max.height <- max(sapply(trees, my.max, "height.ft"))

# Plotting is now straightforward:

plot(c(0, max.age), c(0, max.height), type = "n", 
     xlab = "age (years)", ylab = "height (feet)")
for (i in 1:length(trees)) 
  lines(trees[[i]]$age, trees[[i]]$height.ft)

