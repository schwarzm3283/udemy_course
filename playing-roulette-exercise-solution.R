#################################################
#####   Playing Roulette Exercise Solution  #####
#################################################

# One plays roulette repeatedly at a casino. 
# In a single play, one bets $5 on "red" and 
# that player wins $5 with probability 18/38 
# and loses $5 with probability 20/38. If the 
# roulette game (with the same bet) is played 
# 20 times, then the individual play winnings 
# can be viewed as a sample of size 20 selected 
# with replacement from the vector (5, -5),
# where the respective probabilities are given 
# in the vector (18/38, 20/38). These play 
# winnings can be simulated using the function 
# sample() with the prob vector that gives the 
# sampling probabilities. 

sample(c(5, -5), size=20, 
       replace=TRUE, 
       prob=c(18 / 38, 20 / 38)) 


# (a) Write a short function to compute the sum 
# of the winnings from 20 plays at the roulette 
# wheel. Use the replicate() function to repeat 
# this "20 play simulation" 10000 times. Find the 
# approximate probability that the total winning 
# is positive. 

roulette = function(){
  winnings = sample(c(5, -5), 
                    size=20, 
                    replace=TRUE,
         prob=c(18 / 38, 20 / 38))
  sum(winnings)
}

s = replicate(10000, roulette())

mean(s > 0)

# (b) The number of winning plays is a binomial 
# random variable with 20 trials where the 
# probability of success is 18/38. Using the 
# pbinom() function, find the exact probability 
# that your total winning is positive and check 
# that the approximate answer in part (a) is 
# close to the exact probability. 

# The probability the total winning is positive
# is equal to the probability P(X > 10), where
# X is binomial(20, 18/38)

1 - pbinom(10, size=20, prob=18/38)

# (c) Suppose you keep track of your cumulative 
# winning during the game and record the number 
# of plays P where your cumulative winning is 
# positive. If the individual play winnings are 
# stored in the vector winnings, the expression 
# cumsum(winnings) computes the cumulative 
# winnings, and the expression 
# sum(cumsum(winnings)>0) computes a value of P. 
# Adjust your function from part (a) to compute 
# the value of P. Simulate the process 500 times 
# and construct a frequency table of the outcomes. 
# Graph the outcomes and discuss which values of 
# P are likely to occur. 

roulette2 = function(){
  winnings = sample(c(5, -5), 
                    size=20, 
                    replace=TRUE,
                    prob=c(18 / 38, 20 / 38))
  sum(cumsum(winnings)>0)
}

s = replicate(500, roulette2())
table(s)
plot(table(s))
