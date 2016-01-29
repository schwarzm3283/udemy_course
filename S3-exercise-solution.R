###############################################
#####     WRITING S3 CLASSES EXERCISE     #####
#####       WITH SOLUTION: STUDENT        #####
###############################################

# Create an S3 class constructor function that 
# instantiates (that is, creates) objects of the 
# new S3 class 'student'. The student() constructor 
# function accepts at least three arguments: gender, 
# age, and GPA, and creates a student object with 
# the specified values for these attributes.

# Create a class object for students
student <- function(name,gender,age,GPA) {
  out <- list(name=name, gender=gender, 
              age=age, GPA=GPA)
  class(out) <- "student"
  # invisible function useful when want
  # function to return values which can be
  # assigned, but which do not print when they
  # are assigned
  invisible(out)
}

# Create an object "Mike"
Mike <- student("Mike Smith","male", 24, 3.8)

# Let's query the Mike object
# Is Mike a list object?
is.list(Mike)

# What is the class of Mike?
class(Mike) # student class

# Let's try to print Mike
print(Mike) # looks like a list

# Let's do it another way:
Mike # same output


# Create a generic print method, print.student(), 
# for individual student objects (as an argument) 
# that prints (to the screen) the values of the 
# student's characteristics and other attributes, 
# each appropriately labeled.

# Print method for student class
print.student <- function(object) {
  cat("\nName =", object$name,
      "\nGender =", object$gender, 
      "\nAge =", object$age, 
      "\nGPA =", object$GPA, "\n") 
}

# Now let's print Mike. What happens?
print(Mike)

