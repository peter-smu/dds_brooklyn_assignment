############################################
## Asha Mohan, Peter Kouvaris, Heidi Nguyen.
## MSDS 6306 
## Assignment Unit 6 
############################################

# use read.csv to import the cleaned data set
staten <- read.csv("./Data/clean_staten.csv")

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

## summary of the data set after removing outliners. 
summary(staten.homes)

## It appears that there's a positive correlation between price and gross sqft
## larger homes sold for higher price. 
## correlation is r = 0.55870
cor(log10(staten.homes$gross.sqft),log10(staten.homes$sale.price.n))

## linear regression line of 
plot(log10(staten.homes$gross.sqft) ~ log10(staten.homes$sale.price.n), main="Fig.5: Regression of log(Sales Price) ~ log(Gross Sqft) for 1 to 3 \n Family Dwelling (>$100K and > 100 gross sqft)")
abline(lm(log10(staten.homes$gross.sqft) ~ log10(staten.homes$sale.price.n)), col="red")
