
# Mohan Babu, 24.11.2019, Data wrangling exercise human development.

# reading the human development data into r
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii<- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# summaries of the data sets
str(hd)
dim(hd)
summary(hd)
str(gii)
dim(gii)
summary(gii)

# hd data included 195 observations of 8 varaibles and gii data includes 195 observations of 10 variables

# Renaming variables with shorter names in hd data
names(hd)[1] <- 'HDI.Rank'
names(hd)[2] <- 'Country'
names(hd)[3] <- 'HDI'
names(hd)[4] <- 'Life.Exp'
names(hd)[5] <- 'Edu.Exp'
names(hd)[6] <- 'Edu.Mean'
names(hd)[7] <- 'GNI'
names(hd)[8] <- 'GNI.Minus.Rank'


# Renaming variables with shorter names in gii data
names(gii)[1] <- 'GII.Rank'
names(gii)[2] <- 'Country'
names(gii)[3] <- 'GII'
names(gii)[4] <- 'Mat.Mor'
names(gii)[5] <- 'Ado.Birth'
names(gii)[6] <- 'Parli.F'
names(gii)[7] <- 'Edu2.F'
names(gii)[8] <- 'Edu2.M'
names(gii)[9] <- 'Labo.F'
names(gii)[10] <-'Labo.M'

# mutating gii data

gii <- mutate(gii, Edu2.FM = Edu2.F/Edu2.M)
gii <- mutate(gii, Labo.FM = Labo.F/Labo.M)


# Joining the two datasets
human <- inner_join(hd, gii, by = 'Country')
str(human)

# Writing the joined DF to a file.
write.table(human, file = "human.csv", sep = "\t", col.names = TRUE)




# Data wrangling for exercise 5, Mohan Babu, 1.12.2019


# Loading human data and structure,dimensions of the data
library(stringr)
load(human)
str(human)
dim(human)
summary(human)

# looking at the structure of the GNI column in 'human'
str(human$GNI)

# human data set now consists of 195 observations and 19 variables including HDI.Rank, Country, HDI, Life.exp, Edu.Exp,Edu.mean,GNI etc.

  
# Mutating human data: transforming the GNI variable to numeric
str_replace(human$GNI, pattern=",", replace ="")%>% as.numeric

# Excluding unneeded variables and columns to keep
keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")

# select the 'keep' columns
human <- select(human, one_of(keep))

# print out a completeness indicator of the 'human' data
complete.cases(human)

# print out the data along with a completeness indicator as the last column
data.frame(human[-1], comp = complete.cases(human))

# filter out all rows with NA values
human_ <- filter(human, complete.cases (human))

# look at the last 10 observations
tail(human, 10)

# last indice we want to keep
last <- nrow(human) - 7

# choose everything until the last 7 observations
human_ <- human[1:last, ]

# add countries as rownames
rownames(human) <- human$Country

# remove the Country variable
human_ <- select(human, -Country)
str(human_)

# Writing the joined DF to a file.
write.table(human, file = "human_.csv", sep = "\t", col.names = TRUE)
