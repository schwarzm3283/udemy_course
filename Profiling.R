#################################################
######           PROFILING IN R:           ######
#################################################
#
# There are often situations where code written 
# in R takes too long to run. The problem can be
# overcome by making use of tools in R, 
# by rearranging the code so that the computations
# are more efficient, or by vectorizing 
# calculations.

# It is essential to determine which computations 
# are slow and in need of improvement. 

# The functions Rprof() and summaryRprof() can be 
# used to profile R commands and provide
# insight into why the code is slow.

# Here we use Rprof() to profile the computation 
# of the median absolute deviation about the median 
# (or MAD) on a large set of simulated data.

# The first call to Rprof initiates profiling. 
# Rprof takes three optional arguments:
# (1) name of the file to print results to, 
# (2) second a logical argument indicating
# whether to overwrite or append existing file; 
# (3) third the sampling interval, in seconds. 

?Rprof

# We use default setting in our example:
Rprof()
mad(runif(1e+07))
# [1] 0.371
Rprof(NULL)

# The second call to Rprof, with the 
# argument NULL, turns profiling off. The
# contents of the file Rprof.out are the 
# active calls, computed every interval
# seconds. These can be summarized by a 
# call to summaryRprof, which tabulates
# them and reports on the time spent in 
# different functions.

summaryRprof()

# The output has three components. There 
# are two arrays, the first sorted by self-
# time and the second sorted by total-time. 

# The third component of the response is
# the total time spent in the execution of 
# the commands.

# Given the command, it is no surprise that 
# all of the total-time was spent in
# the function mad. However, since the 
# self-time for that function is zero, we can
# conclude that computational effort was 
# expended elsewhere. When looking
# at self-time, we see that the bulk of the 
# time is spent in sort.int and runif.

### TIMINGS

# The basic tool for timing is system.time(). 
# This function returns a vector of length five,
# but only three of the values are printed. 

# They are the user cpu time, system cpu time, 
# and elapsed time. Times are reported in seconds,
# the resolution is system specific, but is typically
# to 1/100th of a second.

# In output shown below, the same R code was 
# run three times, simultaneously.

# There is about a 5% difference between the
# system time for the first evaluation and those 
# of the subsequent evaluations. So when 
# comparing the execution time of different methods, 
# it is prudent to change the order, and to repeat 
# the calculations in different ways, to ensure
# that the observed effects are real and important.
system.time(mad(runif(10000000)))
# user system elapsed
# 2.70   0.12   2.82

system.time(mad(runif(10000000)))
# user system elapsed
# 2.003 0.632 2.638

# The optional argument gcFirst is TRUE 
# by default and ensures that R's garbage
# collector is run prior to the evaluation 
# of the supplied expression. By running
# the garbage collector first, it is likely 
# that more consistent timings will be
# produced.

### Managing Memory

# There are some tools available in R to 
# monitor memory usage. In R, memory
# is divided into two separate components: 
# memory for atomic vectors 
# (e.g., integers, characters) and language 
# elements., which are allocated by R (which
                                                                        obtains a large chunk of memory, and then parcels it out as needed) and larger
# R attempts to manage memory effectively 
# and has a generational garbage collector.

# The garbage collector runs automatically 
# whenever storage requests exceed the
# current free memory available. A user can 
# trigger garbage collection with gc()
# which will report the number of Ncells
# (SEXPs) used and number of Vcells
# (vector storage) used, as well as a few 
# other statistics.
gcinfo(verbose=FALSE)
# function gcinfo() can be used to have 
# information print every time the
# garbage collector runs.
gc()
