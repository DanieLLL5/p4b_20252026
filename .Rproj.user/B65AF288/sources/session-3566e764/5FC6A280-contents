# Chapter 2 - Data access exercises solutions

# Access your current working directory
getwd()

# Set you working directory to the folder of Chapter 2 inside of the
# folder where you have the git repo cloned
setwd("C:/Users/danie/Downloads/p4b_20252026/R/Chapter 2 - Data Access")

# Exercise 1
#a)
smsales <- read.csv('Data/supermarket_sales.csv', header = TRUE)

#b)
write.table(smsales,'supermarket_sales1.txt')
write.csv(smsales,'supermarket_sales1.csv')
write.xlsx(smsales, 'supermarket_sales1.xlsx')

#c)
# Uncomment the cell below if openxlsx is not installed yet
#install.packages("openxlsx") 
library(openxlsx)
write.xlsx(smsales, 'supermarket_sales1.xlsx')

#c)
# Uncomment the cell below if readxl is not installed
#install.packages('readxl')
library(readxl)
smsales1 <- read_xlsx('supermarket_sales1.xlsx') # output in tibble

#d)
smsales2 <- smsales1[smsales1$Product_Line == 'Sports and travel' &
                       smsales1$Total > 150 &
                       smsales1$Total < 250,
                     c('Date', 'Branch', 'Rating', 'Total')
]
head(smsales2)

#e)
write.xlsx(smsales2, 'supermarket_sales2.xlsx')

# 2.
#a)
walmart <- read.table('Data/walmart_sales.txt',
                      col.names = c('Store', 'Dept', 'Week',
                                    'Weekly_Sales', 'IsHoliday'))
#b)
dim(walmart)

# 3.
#b)
saveRDS(adidas_us_sales, 'adidas_us_sales.rds')

#c)
adidas_us_sales1 <- readRDS('adidas_us_sales.rds')
head(adidas_us_sales1)
