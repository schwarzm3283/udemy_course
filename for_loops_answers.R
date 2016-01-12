##for loop first anser
x <- sample(1:100, 20);x


find.min <- function(x){
  x.min <- x[1]
for(i in 1:length(x)) {
  if (x[i] < x.min) {
    x.min <- x[i]
   }
  }
  return(x.min)
}

##For loop second answer
v1 <- sort(sample(1:50, 10))
v2 <- sort(sample(1:50, 10))

merg.vec <- function(v1,v2) {
  i <- 1
  j <- 1
  z <- rep(0, (length(v1) + length(v2)))
  while (i <= length(v1) && j <= length(v2)) {
    if (v1[i] < v2[j]) {
      z[i+j-1] <- v1[i]
      i <- i+1
    }
    else {
      z[i+j-1] <- v2[j]
      j <- j+1
    }
  }
  if (j > length(v2)) {
    z[(i+j-1):length(z)] <- v1[i:length(v1)]
  } else if (i > length(v1)) {
    z[(i+j-1):length(z)] <- v2[j:length(v2)]
  } else {
    cat('ERROR!\n')
  }
  return(z)
}

##for loop thrid answer
