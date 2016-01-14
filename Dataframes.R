###########################################
######          DATA FRAMES          ######
###########################################

kids <- c("Jack","Jill")
ages <- c(12,10)
d <- data.frame(kids,ages,stringsAsFactors=FALSE)
d # matrix-like viewpoint
#   kids ages
# 1 Jack   12
# 2 Jill   10

## Accessing Data Frames
d[[1]]
d$kids

d[,1]
getwd()
str(d)

## Example: Exam Grades

# make sure directory is set to c:\temp

# "exams.txt" looks like:
# "Exam 1" "Exam 2" Quiz
# 2.0    3.3  4.0
# 3.3    2.0  3.7
# 4.0    4.0  4.0
# 2.3    0.0  3.3
# 3.9    2.1  1.5
# 2.3    1.0  3.3
# 3.8    2.5  3.6
# 3.3    3.7  4.0
# 3.8    2.0  1.0

examsquiz <- read.table("c://temp/exams.txt",
                        header=T)
examsquiz

# Extracting Subdata Frames
examsquiz[2:5,]

class(examsquiz[2:5,])

examsquiz[2:5,2]

class(examsquiz[2:5,2])
typeof(examsquiz[2:5,2])
mode(examsquiz[2:5,2])

examsquiz[2:5,2,drop=FALSE]

class(examsquiz[2:5,2,drop=FALSE])
typeof(examsquiz[2:5,2,drop=FALSE])
mode(examsquiz[2:5,2,drop=FALSE])

examsquiz[examsquiz$Exam.1 >= 3.8,]

# More on Treatment of NA values

x <- c(2,NA,4)
x
mean(x)
mean(x,na.rm=TRUE)

examsquiz[examsquiz$Exam.1 >= 3.8,]

subset(examsquiz,Exam.1 >= 3.8)

subset(examsquiz,examsquiz$Exam.1 >= 3.8)

# More on incomplete cases, rbind(), cbind()

kids <- c("Jack", NA, "Jillian", "John")
kids
typeof(kids)
class(kids)

states <- c("CA", "MA", "MA", NA)
states
typeof(states)
mode(states)
class(states)

d4 <- data.frame(cbind(kids,states))
d4

complete.cases(d4)

d5 <- d4[complete.cases(d4),]
d5

class(d5)

typeof(d5)

d

rbind(d,list("Laura",19))

eq <- cbind(examsquiz,examsquiz$Exam.2-examsquiz$Exam.1)
class(eq)
# [1] "data.frame"
head(eq)

examsquiz$ExamDiff <- examsquiz$Exam.2 - examsquiz$Exam.1
head(examsquiz)

d

d$one <- 1
d

### Using the apply() function

apply(examsquiz,1,max)

## EXTENDED STUDY: A SALARY STUDY
file.exists("c://temp/2006.csv")
all2006 <- read.csv("c://temp/2006.csv",header=TRUE,as.is=TRUE)
all2006

# exclude hourly-wagers
all2006 <- all2006[all2006$Wage_Per=="Year",]
# exclude weird cases
all2006 <- all2006[all2006$Wage_Offered_From > 20000,]
# exclude hrly prv wg
all2006 <- all2006[all2006$Prevailing_Wage_Amount > 200,]
all2006

all2006$rat <- all2006$Wage_Offered_From / all2006$Prevailing_Wage_Amount

medrat <- function(dataframe) {
  return(median(dataframe$rat,na.rm=TRUE))
}

se2006 <- all2006[grep("Software Engineer",all2006),]
prg2006 <- all2006[grep("Programmer",all2006),]
ee2006 <- all2006[grep("Electronics Engineer",all2006),]

makecorp <- function(corpname) {
  t <- all2006[all2006$Employer_Name == corpname,]
  return(t)
}

corplist <- c("MICROSOFT CORPORATION","ms","INTEL CORPORATION","intel","
SUN MICROSYSTEMS, INC.","sun","GOOGLE INC.","google")
for (i in 1:(length(corplist)/2)) {
  corp <- corplist[2*i-1]
  newdtf <- paste(corplist[2*i],"2006",sep="")
  assign(newdtf,makecorp(corp),pos=.GlobalEnv)
}

### Merging Dataframes

# merge(x,y)

kids
kids[2] <- "Jill"
kids
states
states[4] <- "HI"
states

d1 <- data.frame(cbind(kids,states))
d1


d2 <- data.frame(cbind(ages=c(10,7,12),kids=c("Jill","Lillian","Jack")))
d2

d <- merge(d1,d2)
d

d3 <- data.frame(cbind(ages=c(12,10,7),pals=c("Jack","Jill","Lillian")))
d3

merge(d1,d3,by.x="kids",by.y="pals")

### Using lapply() and sapply() on Data Frames

d <- data.frame(cbind(kids=c("Jack","Jill"),ages=c(12,10)))
d
d1 <- lapply(d,sort)
d1

is.data.frame(d1)
is.list(d1)
as.data.frame(d1)

#####################################################
###########        MORE DATAFRAMES      #############
#####################################################

# Defining characteristic of vector data structure
# is that all components must be of same mode.....
# to use datasets from real experiments we need to
# group data of differing modes

# Imagine a forestry experiment where we randomly
# select a number of plots and then select a number
# of trees from each plot. For each tree, we measure
# its height and diameter (numeric) and the species
# (character string).

#  Plot  Tree  Species  Diameter (cm)  Height (m)
#   2     1      DF         39           20.5
#   2     2      WL         48           33.0
#   3     2      GF         52           30.0
#   3     5      WC         36           20.7
#   3     8      WC         38           22.5
#   .     .       .          .             .
#   .     .       .          .             .

# Cannot represent as a matrix as they cannot hold
# heterogeneous data (different modes). Lists and DFs
# can also store more complex structures.

# A data frame is a list tailored to meet practical
# needs of representing multivariate datasets.
# Is a list of vectors that must be equal length.
# Each vector (column) represents a variable.
# Each row is an observation or case.
# A column can be of any basic mode of object.
# DFs read into R often using read.table().
# default: read.table(file,header=F,sep="").
# read.table() returns a dataframe.
# file is name of file to be read.
# header refers to column headers (names in file)
# sep = "" means any amount of white space.
# read.csv() for .csv and read.delim() for tab-
# delimited data. Is equivalent to
# read.table(file,header=T,sep="\t")

# Use file ufc.csv in c://temp
ufc <- read.csv("c://temp/ufc.csv")
head(ufc)
tail(ufc)

# Each variable in DF must have unique name.
# We extract a variable with dataframe name and
# a $ sign and the column (variable) name:

x <- ufc$height.m
x[1:5]

# Can also use notation [[?]] to extract
# columns. These are all equivalent expressions:

ufc$height.m
ufc[[5]]
ufc[["height.m"]]

# With a dataframe, you can also extract
# elements directly using matrix indexing:
ufc[1:5,5]

# To select more than one of the variables in df,
# that is, to subset the dataframe, use
# notation [?]. We can also use names in
# this situation. These two are equivalent:

head(ufc[4:5])
head(ufc[c("dbh.cm","height.m")])

head(ufc[4:5])   # equivalent to ufc[,4:5]
head(ufc[,4:5])
head(diam.height <- ufc[4:5])
diam.height[1:5,] # result of selecting columns is df
is.data.frame(diam.height)

# this is ok:
head(x <- ufc[5])

# gives an error, undefined columns:
(x[1:5])

# even though class of ufc is data.frame
# mode of ufc is a list

class(ufc)
mode(ufc)
ufc[5]
mode(ufc[5])
ufc[[5]]
mode(ufc[[5]])

# Can also construct a new data frame
# from collection of existing vectors
# and/or existing data frames using
# function data.frame() w/ general form:
# data.frame(col1 = x1, col2 = x2, ..., df1, df2, ...)

# col1, col2 are column names (given as 
# character strings w/out quotes).
# x1, x2, etc. are vectors of equal length
# df1, df2 are data frames with columns.
# column names may be omitted, then R chooses.
# as same length as vectors x1, x2, etc.

# Can also create new variable within dataframe,
# by naming it and assigning a value. For example,
# shape of a mature trunk can be modelled as an
# elliptic paraboloid so volume = height times
# cross-sectional area at breast height divided
# by two (i.e. half the volume of a cylinder of
# same height and diameter):

ufc$volume.m3 <- pi * (ufc$dbh.cm/200)^2 * ufc$height/2
mean(ufc$volume.m3)

# Equivalently, could assign to ufc[6] or to
# ufc["volume.m3"] or ufc[[6]] or ufc[["volume.m3"]].
# names9df) returns names of dataframe df as a
# vector of character strings. Can change names of df
# passing a vector of character names to names(df):
(ufc.names <- names(ufc))

names(ufc) <- c("P", "T", "S", "D", "H", "V")
names(ufc)

# Note names(df) is not a variable although we can
# assign a value to it. names(df) is an attribute.
# Values an attribute can accept are determined
# by mode of the object. Must have one name per
# column of df and all must be different.

# dim() is attribute of matrix, can change shape
# of matrix just by changing dim attribute.

# Note that dim(df) DOES return number of rows 
# and columns of data frame, dim(df) <- c(x, y)
# generates errors....dim() is not a df attribute
# although function dim() is extended to df's for
# convenience.

# data frame also has row names, by default named
# "1", "2", "3", etc. read.table() and data.frame()
# both have optional argument row.names to specify.
# Can assign names to row.names(df).

# subset() selects rows of data frame, can be
# combined with operator %in%. 
# EXAMPLE: Want height of trees of species DF
# (Douglas Fir) or GF (Grand Fir).

names(ufc) <- c("plot","tree","species","dbh.cm","height.m")
fir.height <- subset(ufc, subset = species %in% c("DF", "GF"),
                     select = c(plot, tree, height.m))

# subset determines rows.
# select argument takes vector of columns, not col names.

head(fir.height)

# %in% operator performs 'many-to-many' matching.
# For vectors x and y (of same mode), expression
# x %in% y returns a logical vector the same
# length as x, whose i-th element is TRUE if
# and only if x[i] is an element of y.

##################################################
#########    WRITING DF TO A FILE   ##############
##################################################

# To write a DF to a file:
# write.table(x,file="",append=F,sep="",row.names=T,col.names=T)

# file: is name of file to write to.

# append: overwrite file or append?

# sep= is separator character within a row.

# row.names is logical value....should we include
# existing row names as first column or another
# character vector of column names.

# col.names is  logical value....should we include
# existing column names as first row, or a character
# vector of column names.

# complete.cases() informs as to row-wise missing values.
# can remove missing value rows with na.omit() function.

######################################################
###########    ATTACHING A DF    #####################
######################################################

# Can attach a DF and reference variables directly,
# without prefix DF$variable.

# Attaching DF makes a copy of each variable
# which is deleted when DF is detached. If you
# change an attached variable, does not change DF.
ufc <- read.csv("c://temp/ufc.csv")
ufc$height.m
height.m
attach(ufc)
max(height.m[species == "GF"])

# When finished with dataframe df, we detach().
# When you attach dataframe, R makes a copy of each
# variable, which is deleted when the dataframe is
# detached. Note below that if you change an attached
# variable you do not change the dataframe:

height.m <- 0 # vandalism
height.m

detach(ufc)
max(ufc$height.m)
