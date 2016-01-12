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

