# Data wrangling for exercise 6. Mohan babu. 8.12.2019.


# PART I.Reading the BPRS data
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)

# Look at the (column) names of BPRS in wide from
names(BPRS)

# Look at the structure of BPRS in wide from
str(BPRS)

# BPRS data, in which 40 male subjects were randomly assigned to one of two treatment groups and each subject was rated on the brief psychiatric rating scale (BPRS) measured before treatment began (week 0) and then at weekly intervals for eight weeks. The BPRS assesses the level of 18 symptom constructs such as hostility, suspiciousness, hallucinations and grandiosity; each of these is rated from one (not present) to seven (extremely severe). The scale is used to evaluate patients suspected of having schizophrenia.
# In the wide form of BPRS data, we have 11 variables "treatment" "subject"   "week0"     "week1"     "week2"     "week3"     "week4"     "week5"     "week6"     "week7"     "week8". In wide from a subject's repeated responses are in a single row and each response is in separate column.

# Brief summaries of the variables in wide from
summary(BPRS)

# Access the packages dplyr and tidyr
library(dplyr)
library(tidyr)

# Coverting categorical variables treatment & subject to factors
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

# Converting wide form of BPRS data to long form
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)

# Extract the week number
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))

# Take a glimpse at the BPRSL data
glimpse(BPRSL)

# Look at the (column) names of BPRS in long from
names(BPRSL)

# Look at the structure of BPRS in long from
str(BPRSL)

# Brief summaries of the variables in long from
summary(BPRSL)

# In the wide form of BPRS data, we have 11 variables "treatment" "subject"   "week0"     "week1"     "week2"     "week3"     "week4"     "week5"     "week6"     "week7"     "week8". In wide from a subject's repeated responses are in a single row and each response is in separate column. In the long form the variables are "treatment" "subject"   "weeks"     "bprs"      "week"      "stdbprs" . It now contains 360 observations and 6 variables. In the long form of the data we have in each row representing one time point per subject. So each subject will have data in multiple rows. Any variable that do not change aross time will have the same value ib all rows.



# Part II. Reading the RATS data
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

# checking variable names in RATS data in wide form
names(RATS)

# Looking at the structure of RATS data in wide from
str(RATS)

# Data from a nutrition study conducted in three groups of rats. The groups were put on different diets, and each animal's body weight (grams) was recorded repeatedly (approximately) weekly, except in week seven when two recordings were taken) over a 9-week period. In the wide form the data includes 16 observations of 13 variables namely "ID"    "Group" "WD1"   "WD8"   "WD15"  "WD22"  "WD29"  "WD36"  "WD43"  "WD44"  "WD50"  "WD57"  "WD64".

# Brief summaries of the variables in wide from
summary(RATS)

# # Coverting categorical variables ID and Group to factors 
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

# Glimpse the data
glimpse(RATS)

# Convert data to long form
RATSL <- RATS %>%
  gather(key = WD, value = Weight, -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD,3,4))) 

# Glimpse of the RATS data in long form
glimpse(RATSL)

# Look at the (column) names of BPRS in long from
names(RATSL)

# Dimensions of the RATS data in long form
dim(RATSL)

# Brief summaries of the variables in wide from
summary(RATSL)

# In the wide form the RATS data includeed 16 observations of 13 variables namely "ID"    "Group" "WD1"   "WD8"   "WD15"  "WD22"  "WD29"  "WD36"  "WD43"  "WD44"  "WD50"  "WD57"  "WD64", with each rat's repeated weight measurements in a single row and weekdays in columns.In the long form the data now shows 176 observations with 5 variables ID,Group, WD, Weight and time, Each row represent one time point per rat, so each rat will have data in multiple rows.

