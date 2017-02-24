# dds_brooklyn_assignment
DDS Assignment for 2017.03.02

Synopsis

    This project is to record and analyse the rolling sales of properties in staten island. The data includes different kind of properties from one, two family houses, condos, vacant land, commercial units etc. Details on square feet, address, tax, sale price and data are available for analysis. 

Code Example

Read the csv formatted data

read.csv("Data/rollingsales_statenisland.csv", header = TRUE, sep = ",")

Clean some of the fields in the data

statenisland_data$YEAR.BUILT <- as.numeric(as.character(statenisland_data$YEAR.BUILT))
statenisland_data$SALE.PRICE <- as.numeric(gsub("[^[:digit:]]", "", statenisland_data$SALE.PRICE))

Plot histograms.

Motivation

The project is a first project done to understand how to interact with GitHub, R Studio and push and pull files between the two. 

Installation

Install R Studio and create account in GitHub

API Reference

Not used

Tests
Run under R-Studio.

Contributors

Peter Kouvaris
Asha Mohan
Heidi Nguyen

License
Opensource