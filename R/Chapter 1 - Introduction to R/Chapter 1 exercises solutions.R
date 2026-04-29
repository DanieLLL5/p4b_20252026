# Chapter 1 exercises 

# 1. Expressions
# 1.1.
#a)
123 * 321 # 39483
42 ** 2  # 1764
34 - 2 * 6 # 22
4 + 2 == 42 # FALSE
1 + sum(2, 3) # 6

#b)
x <- 1 + sum(2, 3)

#c)
x <- 123 * 321

#d)
x <- 42
x

# 1.2.
(-2)^4 # 16
12+5*pi # 27.70796
3^(7-4) + sqrt(2) # 28.41421
sqrt(((5-2)^2 + (7-3)^2)) # 5
(20 + 18 + 24)/3 # 20.(6)
(20 * 8 * 24)^(1/3) # 15.65947

# 1.3.
a <- 1
b <- -5
c <- 6
A <- pi*6371^2

# 1.4.
A==a #FALSE
A=a # Now the value of A is 1
c((-b - sqrt(b^2 - 4*a*c))/2*a, (-b + sqrt(b^2 - 4*a*c))/2*a) # 2 and 3

# 2.Vectors

# 2.1.
#a)
salespeople <- c("Alice", "Bob", "Charlie", "David", "Francis")
sales <- c(8500, 7200, NA,9000, 6300)
joint <- c("Alice", "Bob", "Charlie", "David", 
           "Francis", 8500, 7200, NA,9000, 6300)

#b)
salespeople[5]
sales[5]

#c)
sales[3] <- 8000

#d)
mean(sales) #If you have missing values you would need to use mean(sales, na.rm = T)

#e)
sales <- sales + 200
sales

#f)
sales[1:3]

#g)
salespeople[1:(length(salespeople)-3)]

#h)
salespeople[sales >= 8200]  

#i)
salespeople[sales >= 7000 & sales < 8800]

#j)
sample(sales, 4) # If you want a sampling with replacement you need to do sample(sales, 4, replace = T)

#k)
salespeople_sales <- sales
names(salespeople_sales) <- salespeople
salespeople_sales

# 2.2.
a <- c("L", 3, 3, T) # All elements were converted to string
b <- c(F, 4, 1, 7) # The Boolean FALSE is converted to its binary representation 0 

# 3. Matrices
# 3.1.
#a)
performance <- sample(1:10, length(salespeople), replace = T)

#b)
sales_data <- matrix(c(sales, performance), ncol=2)
colnames(sales_data) <- c('sales', 'performance')
sales_data

#c)
rownames(sales_data) <- salespeople

#d)
t(sales_data)

# 3.2.
set.seed(42) # for reproducibility
sales2 = sample(5000:10000, 20)
sales_data2 = matrix(sales2, nrow=5, ncol=4)

# 3.3.
colnames(sales_data2) <- c('Vault33', 'Los Angeles Ruins', 'Shady Sands', 'New California')
rownames(sales_data2) <- c('LucyMacLean', 'Maximus', 'Cooper Howard', 'Hank MacLean', 'Thaddeus')
sales_data2

# 3.4.
sales_data2[2,3]
sales_data2["Maximus", "Shady Sands"]
sales_data2[2, "Shady Sands"]
sales_data2[2,]
sales_data2[, "Vault33"]
sales_data2[1:3,-4]

# 3.5.
rowMeans(sales_data2)
colMeans(sales_data2)

# 3.6.
set.seed(42)
ma = matrix(as.integer(runif(16, 1, 20)), 4, 4)

ma + 1
ma * 2
ma * ma
ma %*% ma # Matrix multiplication

# 4. Data Frames
# 4.1.
sales_datadf <- data.frame(sales_data2)

# 4.2.
dim(sales_datadf)

# 4.3.
sales_datadf[(sales_datadf$Vault33 >= 6000) &
               (sales_datadf$Los.Angeles.Ruins >= 6000) &
               (sales_datadf$Shady.Sands >= 6000) &
               (sales_datadf$New.California >= 6000), ]
# or
sales_datadf[apply(sales_datadf, 1, function(x) all(x > 6000)), ]

# or 
subset(sales_datadf,
       Vault33 >= 6000 &
         Los.Angeles.Ruins >= 6000 &
         Shady.Sands >= 6000 &
         New.California >= 6000
)

# 5. Factors 
# 5.1.
#a)
region <- factor(c('north', 'south', 'south', 'south', 'east', 'west', 'south'))
levels(region)

#b)
region2 <- factor(c('south', 'south', 'west'))
levels(region2) <- levels(region)
levels(region2)

# OR 
region2 <- factor(c('south', 'south', 'west'), levels=levels(region))
region2


#c)
region3 <- factor(x = c('west', 'south', 'central', 'south'), levels = levels(region))
region3 # The value central is assigned as NA since it is not in the levels of the factor

#d)
gen = c('m', 'f', 'm', 'm', 'f', 'f', 'm')
gen = factor(gen)

table(gen) # frequency table
table(region) # frequency table
table(gen, region) # contingency table

#e)
region[1:3] # The levels remain the same as before
factor(region[1:3]) # If we do it like this we only keep the levels of the selected subsection

#f)
performance = c('poor', 'poor', 'good', 'excellent', 'excellent', 'good', 'good')
performance = factor(performance, levels = c("poor", "good", "excellent"), ordered = TRUE)
performance

as.integer(performance)
# Comparing the values of 2 sales representatives
performance[4] > performance[3]

