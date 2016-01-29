###############################################
### OBJECT ORIENTED PROGRAMMING: S4 CLASSES ###
###############################################

# BASIC S3 CLASS R OPERATORS

# Operation                  S3    
# Define class               Implicit in Constructor Code
# Create object              Build list, set class attr
# Reference member variable  $                            
# Implement generic f()      Define f.classname()
# Declare generic            UseMethod()

# BASIC S4 CLASS R OPERATORS

# Operation                  S4      
# Define class               setClass()
# Create object              new()
# Reference member variable  @
# Implement generic f()      setMethod()
# Declare generic            setGeneric()

##### WRITING S4 CLASSES

# We define an S4 class by calling setClass().

? setClass

setClass("employee",
   representation(
      name="character",
      salary="numeric",
      union="logical")
)

# We defined a new class, "employee", with
# three member variables of the specified types.

# Now we create an instance of this class, 
# for Joe, using new(), a built-in
# constructor function for S4 classes:
joe <- new("employee",name="Joe",
           salary=55000,union=T)
joe

# create S4 class "nurse"
setClass("nurse",
         representation(
           name="character",
           licensed="logical",
           prescribe="logical")
)

mary <- new("nurse",name="Mary",
           licensed=T,prescribe=T)
mary

# Note member variables are called slots, 
# referenced via the @ symbol, example:
joe@salary

mary@prescribe

# can also use the slot() function to 
# query Joe's salary:
slot(joe,"salary")
slot(mary,"prescribe")

# can assign components similarly giving Joe raise:
joe@salary <- 65000
joe

mary@prescribe <- F
mary

# a bigger raise:
slot(joe,"salary") <- 88000
joe

# an advantage of using S4 is safety. S4 does
# some error checking absent with S3 Classes; For
# example, we misspell "salary"
joe@salry <- 23000

### Implementing a Generic Function on an S4 Class

# You define an implementation of a generic 
# function on an S4 class using setMethod(). 

# We implement show(), generic "print" 
# for S4 classes.
# It prints just by typing name of variable:
joe

# Since joe is an S4 object, the action here is 
# that show() is called. In fact, we would get
# the same output by typing this:
show(joe)

# We override that with the following code:
# first argument is name of generic function;
# second argument gives class name.
setMethod("show", "employee",
          # we then define the new function
   function(object) {
     inorout <- ifelse(object@union,"is",
                       "is not")
     cat(object@name,"has a salary of",
         object@salary,
         "and",inorout, "in the union", "\n")
     }
)

# We override generic show() function
# for new S4 'nurse' class with this code:
# first argument is name of generic function;
# second argument gives class name.
setMethod("show", "nurse",
          # we then define the new function
          function(object) {
            inorout <- ifelse(object@licensed,"is",
                              "is not")
            cat(object@name,inorout, "licensed", "\n")
          }
)

# The first argument gives the name of the generic 
# function for which we will define a class-
# specific method, and the second argument gives 
# the class name. We then define the new function.

# We try out show() method for 'employee' class:
joe

# We use show() methods for 'nurse' class:
mary

# but then mary loses her license
mary@licensed <- F

mary

# Which class to use? Is a personal choice-
# Convenience of S3 or safety of S4

### Managing Your Objects

# Functions to manage large collection of objects
# that you will accumulate:
# ls() function
# rm() function
# save() function

# Several functions that tell you more about 
# the structure of an object, such as
# class() and mode() functions
# exists() function

###########################################
## Listing Your Objects with ls() Function

# ls() command lists all of your current objects. 
# ls() has a "pattern=" argument for wildcards.

# lists objects with a specified pattern:
ls()

# list objects with string "ut" somewhere in name
ls(pattern="ar")

###############################################
## Removing Specific Objects with rm() Function

liz <- new("nurse",name="Liz",
            licensed=T,prescribe=F)

bill <- new("nurse",name="Bill",
            licensed=F,prescribe=F)

amy <- new("nurse",name="Amy Smith",
            licensed=T,prescribe=T)

liz;bill;amy

ls()

# Use rm() to remove objects:
# removes these six named objects from workspace
rm(amy,bill)

# removes the six specified objects (a, b, etc).
# "list=" argument of rm() makes it easier to
# remove multiple objects. This code assigns all 
# of our objects to list, removing everything:
rm(list = ls())

# pattern argument also useful for ls():

tom <- new("nurse",name="Thomas",
           licensed=T,prescribe=T)

toby <- new("nurse",name="Toby",
               licensed=T,prescribe=T)

tommy <- new("nurse",name="Thomas",
                licensed=T,prescribe=T)
  
ls()

ls(pattern="to")

ls(pattern="om")

rm(list=ls(pattern="om"))
ls()

# We found two objects with the string "to"
# and then removed them as confirmed by the second 
# call to ls().

################################################
## Saving a Collection of Objects with save()
?save
# Calling save() will write objects to disk and
# for subsequent retrieval by load():

# generate data
z <- rnorm(100000)

# draw a histogram and save output of
# hist in variable hz which is an object of
# class 'histogram'
hz <- hist(z)

# to use hz object later, we save it to a file
# on disk called "hzfile"
save(hz, file="hzfile")

# "hzfile" is in directory path on disk
file.exists("hzfile")

# see what is in workspace:
ls()

# remove object 'hz' from workspace
rm(hz)

# check to see what was removed, hz is gone
ls()

# now load file "hzfile"
load("hzfile")

# is hz in workspace? yes?
ls()

# graph window pops up:
plot(hz)

# we generate some data, draw a histogram. But
# we save the output of hist() in a variable, hz. 
# hz variable is an object of class "histogram"

# Anticipating that we will want to reuse this
# object later, we use the save() function to save
# object to file hzfile. hz can then be reloaded in 
# a later session using load(). 

############################################
## The exists() Function

# Tells you whether object is in the workspace
# unlike ls(), just returns a true or false

exists("liz")
