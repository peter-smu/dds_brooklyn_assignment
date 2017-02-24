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

## do a bit of exploration to make sure there's not anything
## weird going on with sale prices
attach(staten)
hist(sale.price.n) 
detach(staten)

## keep only the actual sales

staten.sale <- staten[staten$sale.price.n!=0,]
plot(staten.sale$gross.sqft,staten.sale$sale.price.n)
plot(log10(staten.sale$gross.sqft),log10(staten.sale$sale.price.n))

## for now, let's look at 1-, 2-, and 3-family homes
staten.homes <- staten.sale[which(grepl("FAMILY",staten.sale$building.class.category)),]
dim(staten.homes)
plot(log10(staten.homes$gross.sqft),log10(staten.homes$sale.price.n))
summary(staten.homes[which(staten.homes$sale.price.n<100000),])


## remove outliers that seem like they weren't actual sales
staten.homes$outliers <- (log10(staten.homes$sale.price.n) <=5) + 0
staten.homes <- staten.homes[which(staten.homes$outliers==0),]
plot(log10(staten.homes$gross.sqft),log10(staten.homes$sale.price.n))
