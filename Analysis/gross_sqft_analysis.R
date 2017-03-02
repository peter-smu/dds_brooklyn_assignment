# Author: Asha Mohan
# Read rollingsales_statenisland.csv and do exploratory analysis
# Plot the price of houses whose gross square feet is between 2000 and 2500


setwd("/Users/ASHMOHAN 1/Desktop/Data_Science/SMU_Term1_Doing_Data_science/Project1/dds_statenisland_assignment")

# So, save the file as a csv and use read.csv instead
statenisland_data <- read.csv("Data/rollingsales_statenisland.csv", header = TRUE, sep = ",")

## Check the data
head(statenisland_data)
summary(statenisland_data)
str(statenisland_data)
names(statenisland_data)

# Format some columns like square feet columns
statenisland_data$LAND.SQUARE.FEET <- as.numeric(gsub("[^[:digit:]]", "", statenisland_data$LAND.SQUARE.FEET))
statenisland_data$GROSS.SQUARE.FEET <- as.numeric(gsub("[^[:digit:]]", "", statenisland_data$GROSS.SQUARE.FEET))
statenisland_data$YEAR.BUILT <- as.numeric(as.character(statenisland_data$YEAR.BUILT))
statenisland_data$SALE.PRICE <- as.numeric(gsub("[^[:digit:]]", "", statenisland_data$SALE.PRICE))
statenisland_data$SALE.PRICE
#Remove all the values that are NA
actual_sale <- statenisland_data$SALE.PRICE[!(is.na(statenisland_data$SALE.PRICE))]
#Finally get rid of sale value < 1000 as its not possible. 
actual_sale_final <- actual_sale[actual_sale > 1000]
actual_sale_final

## for now, let's look at family homes of 2000 - 2500 square feet and plot the prices
st.mid_size_home <- statenisland_data$LAND.SQUARE.FEET[which(statenisland_data$LAND.SQUARE.FEET > 2000 & statenisland_data$LAND.SQUARE.FEET < 2500)]
st.mid_size_home_value <- statenisland_data$SALE.PRICE[which(statenisland_data$LAND.SQUARE.FEET > 2000 & statenisland_data$LAND.SQUARE.FEET < 2500)]
count(st.mid_size_home)
hist(st.mid_size_home)
plot(st.mid_size_home, st.mid_size_home_value,main="Mid Size House Prices", xlab="Sale Price in dollars", ylab="Square feet", pch=19)
