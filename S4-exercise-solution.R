###############################################
#####     WRITING S4 CLASSES EXERCISE     #####
#####       WITH SOLUTION: TEACHER        #####
###############################################

# Question #1
# Write R code to create a new S4 class 'teacher'. 
# A teacher object should have at least three slots: 
# name (character),salary (numeric),and phd (logical). 
# The value of the phd slot is either TRUE or FALSE, 
# depending on whether the S4 teacher object is 
# doctorally-qualified or not (that is, does s/he 
# possess a terminal degree, a PhD? Or not?).

# Define an S4 teacher class:
setClass("teacher",
         representation(name = "character",
                        salary = "numeric",
                        phd = "logical"))
getClass("teacher")
getSlots("teacher")

# Create two or three S4 teacher objects and mix 
# up their names, salaries, and terminal degree 
# qualifications.

# Create teacher class objects:

# Geoff:
geoff <- new("teacher", 
             name="Geoff", 
             salary=24000, 
             phd=FALSE)

# Bob:
bob <- new("teacher",
           name="Bob",
           salary=44000,
           phd=TRUE)

# Mary:
mary <- new("teacher",
            name="Mary",
            salary=34500,
            phd=FALSE)

# Bill:
bill <- new("teacher",
            name="Bill",
            salary=52750,
            phd=TRUE)

# Question #2
# Implement a generic show method for the specific 
# S4 teacher class objects that "pretty prints" the 
# teacher's name, his/her salary, and whether that 
# teacher is doctorally qualified or not, for example: 
# "Geoff is paid a salary of 24000 and Geoff is not 
# doctorally-qualified."

# Show method, similar to print for S3 classes
setMethod(f = "show", signature = "teacher",
          definition = function(object) {
            cat(object@name, "is paid a salary of", 
                object@salary, "and\n")
            cat(object@name)
            if(object@phd) {
              cat(" is") 
            } else { 
              cat(" is not") 
            }
            cat(" doctorally-qualified.")
          })

show(geoff)
show(bob)
show(mary)
show(bill)
