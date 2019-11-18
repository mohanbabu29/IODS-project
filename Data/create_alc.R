# Mohan, 15.11.2019, Alc consumption and student performance (logistic regression analysis)

# Reference to the source data
url <- "http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets"

# Location of math class data
url_math <- paste("~/IODS-project/data/student/student-mat.csv", sep = "/")

# Print out url_math
url_math

# read the math class questionaire data into memory
math <- read.table(url_math, sep = ";" , header=TRUE)

# Location for portuguese class data
url_por <- paste("~/IODS-project/data/student/student-por.csv", sep = "/")

# Print out url_por
url_por

# read the portuguese class questionaire data into memory
por <- read.table(url_por, sep = ";", header = TRUE)

# str of math data
str(math)
#There are 395 observations and 33 variables in math data

# dimensions of math data
dim(math)

# str of Por data
str(por)
# There are 649 observations and 33 variables in por data

# dimensions of por data
dim(por)


# math and por are available

# access the dplyr library
library(dplyr)

# joining the math and por data sets with identifiers
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

# join the two datasets by the selected identifiers
math_por <- inner_join(math, por, by = join_by, suffix = c(".math", ".por"))

# see the new column names
math_por

# glimpse at the data
glimpse(math_por)


# print out the column names of 'math_por'
colnames(math_por)

# create a new data frame with only the joined columns
alc <- select(math_por, one_of(join_by))

# columns that were not used for joining the data
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

# print out the columns not used for joining
notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column  vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# glimpse at the new combined data
glimpse(alc)

# defining a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# defining a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)

# Glimpse of the joined and modified data
glimpse(alc)

setwd(("~/IODS-project/Data/student"))
write.csv(alc, 'alc.csv')
