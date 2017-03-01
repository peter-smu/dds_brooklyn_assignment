#uploading data
staten_data <- read.csv("./Data/rollingsales_statenisland.csv")
# Author: Benjamin Reddy
# Taken from pages 49-50 of O'Neil and Schutt

#require(gdata)
#require(plyr) #Added by Monnie McGee
#install the gdata and plyr packages and load in to R.
library(plyr)
library(gdata)

# So, save the file as a csv and use read.csv instead
staten <- read.csv("./Data/rollingsales_statenisland.csv")

## Check the data
head(staten)
summary(staten)
str(staten) # Very handy function!

## clean/format the data with regular expressions
## More on these later. For now, know that the
## pattern "[^[:digit:]]" refers to members of the variable name that
## start with digits. We use the gsub command to replace them with a blank space.
# We create a new variable that is a "clean' version of sale.price.
# And sale.price.n is numeric, not a factor.
staten$SALE.PRICE.N <- as.numeric(gsub("[^[:digit:]]","", staten$SALE.PRICE))
count(is.na(staten$SALE.PRICE.N))

names(staten) <- tolower(names(staten)) # make all variable names lower case
## Get rid of leading digits
staten$gross.sqft <- as.numeric(gsub("[^[:digit:]]","", staten$gross.square.feet))
staten$land.sqft <- as.numeric(gsub("[^[:digit:]]","", staten$land.square.feet))
staten$year.built <- as.numeric(as.character(staten$year.built))

write.csv(staten,"./Data/clean_staten.csv")