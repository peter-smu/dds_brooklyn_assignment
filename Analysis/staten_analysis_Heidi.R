############################################
## Asha Mohan, Peter Kouvaris, Heidi Nguyen.
## MSDS 6306 
## Assignment Unit 6 
############################################

#load required packages
library(plyr)
library(gdata)

# Save the file as a csv and use read.csv instead
staten <- read.csv("./Data/rollingsales_statenisland.csv")

## Check the data
head(staten)
summary(staten)
str(staten) # Very handy function!

## clean/format the data with regular expressions
## pattern "[^[:digit:]]" refers to members of the variable name that
## start with digits. We use the gsub command to replace them with a blank space.
# Create create a new variable that is a "clean' version of sale.price.
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

## keep only the actual sales where price is not $0 
staten.sale <- staten[staten$sale.price.n!=0,]
plot(staten.sale$gross.sqft,staten.sale$sale.price.n,main="Fig.1: Sales Price vs. Gross Sqft")
plot(log10(staten.sale$gross.sqft),log10(staten.sale$sale.price.n),main="Fig.2: Log(Sales Price) vs. Log(Gross Sqft)")

## Look at 1-, 2-, and 3-family homes
staten.homes <- staten.sale[which(grepl("FAMILY",staten.sale$building.class.category)),]
## Number of 1-, 2-, and 3-family homes 
dim(staten.homes)
## Plot of sales price vs. land square footage.
plot(log10(staten.homes$gross.sqft),log10(staten.homes$sale.price.n),main="Fig.3: log(Sales Price) vs. log(Gross Sqft) for 1 to 3 \n Family Dwelling")
## Explore those homes with sale prices < 100000, which look like outliner.  
summary(staten.homes[which(staten.homes$sale.price.n<100000),])
## Explore homes with sqft < 100 ft
summary(staten.homes[which(staten.homes$gross.sqft<100),])


## remove outliers that seem like they weren't actual sales (WITH PRICE <= $100000 AND SQFT < 100)
staten.homes$outliers <- (log10(staten.homes$sale.price.n) <=5) + (log10(staten.homes$gross.sqft) <=2)
staten.homes <- staten.homes[which(staten.homes$outliers==0),]
plot(log10(staten.homes$gross.sqft),log10(staten.homes$sale.price.n),main="Fig.4: log(Sales Price) vs. log(Gross Sqft) for 1 to 3 \n Family Dwelling (>$100K and > 100 gross sqft)")


