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

#e)
adidas_us_sales <- mutate(adidas_us_sales, Invoice_Year = year(Invoice_Date),
                          Invoice_Month = month(Invoice_Date),
                          Total_Sales_K = Total_Sales / 1e3,
                          Operating_Margin_Perc = Operating_Margin * 100)

#f)
adidas_us_sales %>%
  filter(Invoice_Year == 2021) %>%
  filter(Operating_Profit == max(Operating_Profit, na.rm = TRUE)) %>%
  select(Retailer, Product)

# OR 
adidas_us_sales %>%
  filter(Invoice_Year == 2021) %>%
  arrange(desc(Operating_Profit)) %>%
  select(Retailer, Product) %>%
  print(n = 1)

#g)
adidas_us_sales %>%
  group_by(Retailer) %>%
  summarize(n = n()) 

#h)
adidas_us_sales %>%
  group_by(Invoice_Month) %>%
  summarise(Avg_Total_Sales_K = mean(Total_Sales_K)) %>%
  filter(Avg_Total_Sales_K == max(Avg_Total_Sales_K))

# OR 
adidas_us_sales %>%
  group_by(Invoice_Month) %>%
  summarise(Avg_Total_Sales_K = mean(Total_Sales_K)) %>%
  arrange(-Avg_Total_Sales_K)

# OR 
adidas_us_sales %>%
  group_by(Invoice_Month) %>%
  mutate(Avg_Total_Sales_K = mean(Total_Sales_K)) %>%
  arrange(desc(Avg_Total_Sales_K)) %>%
  select(Invoice_Month, Avg_Total_Sales_K) %>%
  print(n = 1)
