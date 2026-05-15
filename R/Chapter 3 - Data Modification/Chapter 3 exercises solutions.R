# Chapter 3 exercises solutions

# Before starting let's install and read the necessary libraries
# Uncomment the cell below if tidyverse is not yet installed in your computer
#install.packages('tidyverse') 
library(tidyverse)
library(dplyr)

# Setting up the working directory
setwd('C:/Users/dcaridade/Downloads/p4b_20252026/R/Chapter 3 - Data Modification')
getwd()

# 1. Data Modification
# 1.1.
adidas_us_sales <- readRDS('Data/adidas_us_sales.rds')

#a) 
filter(adidas_us_sales, Total_Sales > 650000)
filter(adidas_us_sales, City == 'Miami' | City == 'Los Angeles')
filter(adidas_us_sales, quarter(Invoice_Date) == 3)
filter(adidas_us_sales, Units_Sold > 700 & Total_Sales > 400000)
filter(adidas_us_sales, Price_per_Unit < 20 | Price_per_Unit > 70)

#b)
arrange(adidas_us_sales, Total_Sales)

#c)
arrange(adidas_us_sales, desc(Operating_Profit))
arrange(adidas_us_sales, Operating_Profit)

#d)
select(adidas_us_sales, Retailer, Invoice_Date, Total_Sales, Operating_Margin)


