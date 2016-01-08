  vec.maker.num <- function(len=5) {
    if (!(len %in% 5:20)) stop(paste(("Error")))
    rand.vec <- sample(1:10,len, replace=FALSE)
    return(rand.vec)
  }
  
vec.maker.num()


vec.maker.alph <- function(len=5) {
  if (!(len %in% 5:20)) stop(paste(("Error")))
  rand.vec <- sample(letters,len, replace=FALSE)
  return(rand.vec)
}

vec.maker.alph(10)

vec.maker.bool <- function(len=5) {
  if (!(len %in% 5:20)) stop(paste(("Error")))
  rand.vec <- sample(c(TRUE, FALSE),len, replace=TRUE)
  return(rand.vec)
}

vec.maker.bool(3)

