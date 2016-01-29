##################################################
#####      SORTING EFFICIENCIES EXERCISE     #####
##################################################

min.idx <- function(x) {
  # returns index of the smallest element of x
  m <- Inf  # smallest element so far
  j <- 0    # position of m in x
  for (i in 1:length(x)) {
    if (x[i] < m) {
      m <- x[i]
      j <- i
    }
  }
  return(j)
}

selection.sort <- function(x) {
  # sort x using selection sort
  n <- length(x)
  y <- rep(0, n)  # vector of sorted elements
  for (i in 1:n) {
    j <- min.idx(x)
    y[i] <- x[j]
    x <- x[-j]
  }
  return(y)
}

x <- c(6,2,9,3,19,22)
x
selection.sort(x)

# use two functions again
insert2 <- function(x, y) {
  # insert x into increasing list y
  # uses fewer comparisons and thus faster than insert
  # uses the conventions that y[0] == c() and y[0:k] == y[1:k] (k >= 1)
  for (i in 1:length(y)) {
    if (x <= y[i]) {
      return(c(y[0:(i-1)], x, y[i:length(y)]))
    }
  }
  return(c(y, x))
}

insertion.sort <- function(x) {
  # sort x using insertion sort
  y <- x[1]
  for (xi in x[-1]) {
    y <- insert2(xi, y)
  }
  return(y)
}

x <- c(6,2,9,3,19,22)
x
insertion.sort(x)

bubble.sort <- function(x) {
  # sort x using bubblesort algorithm
  # flag swap.made T if inner loop made a swap
  swap.made <- TRUE  # ensures inside loop executed at least once
  while (swap.made) {
    swap.made <- FALSE
    for (i in 1:(length(x)-1)) {
      if (x[i] > x[i+1]) {
        # a swap has been found at i
        swap.made <- TRUE
        y <- x[i]
        x[i] <- x[i+1]
        x[i+1] <- y
      }
    }
  }
  return(x)
}  

x <- c(6,2,9,3,19,22)
x
bubble.sort(x)

quick.sort <- function(x) {
  # sort x using quicksort algorithm
  # if length(x) <= 1 then already sorted
  if (length(x) <= 1) return(x)
  # can now assume length(x) >= 2
  smalls <- c() # elements of x < x[1]
  bigs <- c()   # elements of x >= x[1]
  for (i in 2:length(x)) {
    if (x[i] < x[1]) {
      smalls <- c(x[i], smalls)
    } else {
      bigs <- c(x[i], bigs)
    }
  }
  # recursively use quicksort to sort smalls and bigs
  return(c(quick.sort(smalls), x[1], quick.sort(bigs)))
}

quick.sort2 <- function(x) {
  # version of quicksort using preallocated arrays
  # uses the conventions that y[0] == c() and y[0:k] == y[1:k] (k >= 1)
  # if length(x) <= 1 then already sorted
  if (length(x) <= 1) return(x)
  # can now assume length(x) >= 2
  smalls <- rep(0, length(x)-1)
  bigs <- rep(0, length(x)-1)
  j <- 0  # smalls[1:j] are elements of x < x[1]
  k <- 0  # bigs[1:k] are elements of x >= x[1]
  for (i in 2:length(x)) {
    if (x[i] < x[1]) {
      j <- j + 1
      smalls[j] <- x[i]
    } else {
      k <- k + 1
      bigs[k] <- x[i]
    }
  }
  # recursively use quicksort to sort smalls and bigs
  return(c(quick.sort(smalls[0:j]), x[1], quick.sort(bigs[0:k])))
}

x <- c(6,2,9,3,19,22)
x
quick.sort(x)
x
quick.sort2(x)

set.seed(600617)
# comparison using a short vector
x <- runif(300)
print(system.time(bubble.sort(x)))
print(system.time(selection.sort(x)))
print(system.time(insertion.sort(x)))
print(system.time(quick.sort(x)))
print(system.time(quick.sort2(x)))
print(system.time(sort(x)))  # R-native function
# using a longer vector
x <- runif(5000)
print(system.time(selection.sort(x)))
print(system.time(insertion.sort(x)))
print(system.time(quick.sort(x)))
print(system.time(quick.sort2(x)))
print(system.time(sort(x)))  # R-native function

# and an even longer vector
x <- runif(50000)
print(system.time(quick.sort(x)))
print(system.time(quick.sort2(x)))
print(system.time(sort(x)))  # R-native function

# R-native function is the fastest
# followed by quick.sort2
# and finally quick.sort
