##################################################
#####   SAPPLY() AS ALTERNATIVE TO LOOPS     #####
#####    INTRO TO PROGRAMMING EXERCISE       #####
##################################################

# sapply() or lappy() as alternative to loops.
# they take care of deciding what output to create.
# and you don't need intermediate vector or matrix
# to store results

# let's generate matrices of random numbers and
# determine greatest correlation coefficient 
# between any of the variables in the matrix.

# Write a function (call it 'maxcor') that:
# (1) creates an n x m matrix (n rows and m
# columns) from a randomly generated normally
# distributed set of n x m numeric elements.
# (2) executes the cor() function against the
# matrix to determine all of the pairwise
# correlations among the matrix elements.
# (3) selects the maximum correlation value
# element produced by cor() in the matrix; and
# (4) returns that maximum correlation value.

# Then use the sapply() function to run your
# maxcor() function 1,000 times. Assign the
# resulting vector of 1,000 values to a
# variable "maxcors". What is the expected
# value of the mean of all of the 1,000
# maximum correlations? Does this result
# surprise you? Why or why not?
