##################################################
#####         EXERCISE #3 FOR LOOPS          #####
##################################################
#####      SIMULATE THE GAME OF CRAPS        #####
##################################################

# The game of craps is played as follows. First, 
# you roll two six-sided dice; let x be the sum of
# the dice on the first roll. If x = 7 or 11 you 
# win, otherwise you keep rolling until either you 
# get x again, in which case you also win, or
# until you get a 7 or 11, in which case you lose.

# Write a program to simulate a game of craps. You 
# can use the following snippet of code to simulate 
# the roll of two (fair) dice:

# x <- sum(ceiling(6*runif(2)))

play <- function() {
start.point <- sum(ceiling(6*runif(2)))

if (start.point %in% c(7,11)){
  cat("come out roll is" ,start.point,"\n")
  stop("you won!")
}
cat("come out roll is" ,start.point," \n")
curr.roll <- function() {
  x <- sum(ceiling(6*runif(2)))
  return(x)
}

x <- curr.roll()
while(!(x %in% c(start.point, 7))){
  cat("roll is ", x, " roll again\n")
  x <- curr.roll()
}
  
if (x == start.point) {
  cat("roll is ",x," you won\n")
}
else if(x == 7) {
  cat("roll is ", x," you lost\n")
}
else {
  cat("WTF\n")
}
}

  
  




