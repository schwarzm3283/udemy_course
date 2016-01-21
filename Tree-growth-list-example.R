
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

