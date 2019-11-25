
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
colnames(hd)
colnames(hd)[colnames(hd)=="Human.Development.Index..HDI."] <- "HDI"
colnames(hd)[colnames(hd)=="Life.Expectancy.at.Birth"] <- "LEAB"
colnames(hd)[colnames(hd)=="Expected.Years.of.Education"] <- "EYOE"
colnames(hd)[colnames(hd)=="Mean.Years.of.Education"] <- "MYOE"
colnames(hd)[colnames(hd)=="Gross.National.Income..GNI..per.Capita"] <- "GNI"
colnames(hd)[colnames(hd)=="GNI.per.Capita.Rank.Minus.HDI.Rank"] <- "GNI-HDI.Rank"

# Renaming variables with shorter names in gii data
colnames(gii)
colnames(gii)[colnames(gii)=="Gender.Inequality.Index..GII."] <- "GII"
colnames(gii)[colnames(gii)=="Maternal.Mortality.Ratio"] <- "MorRM"
colnames(gii)[colnames(gii)=="Adolescent.Birth.Rate"] <- "AdoBirtR"
colnames(gii)[colnames(gii)=="Percent.Representation.in.Parliament"] <- "PerRepPar"
colnames(gii)[colnames(gii)=="Percent.Representation.in.Parliament"] <- "PerRepPar"
colnames(gii)[colnames(gii)=="Population.with.Secondary.Education..Female."] <- "edu2F"
colnames(gii)[colnames(gii)=="Population.with.Secondary.Education..Male."] <- "edu2M"
colnames(gii)[colnames(gii)=="Labour.Force.Participation.Rate..Female."] <- "labF"
colnames(gii)[colnames(gii)=="Labour.Force.Participation.Rate..Male."] <- "labM"

# mutating gii data

gii1<-mutate(gii,edu2r=edu2F/edu2M)
gii2<-mutate(gii,labr=labF/labM)

# Joining the two datasets
join_by<-c("Country")
human<-inner_join(gii1, gii2, by=join_by, suffix=c(".gii1", ".gii2"))
str(human)
