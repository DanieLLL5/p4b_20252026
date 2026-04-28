libname ch4data '/home/u64191330/P4B_st/Chapter 4/Data';
libname ch4res '/home/u64191330/P4B_st/Chapter 4/Results & Code';

/* Exercise 1 */
*a);
DATA sales1;
SET ch4data.sales88 ch4data.sales89 ch4data.sales90;
RUN;

*b);
DATA sales2;
SET ch4data.sales88 (IN=a) ch4data.sales89 (IN=b) ch4data.sales90 (IN=c);
IF a=1 THEN Year=1988;
IF b=1 THEN Year=1989;
IF c=1 THEN Year=1990;
RUN;

/* Exercise 2*/
*a);
* Step 1 - Sort the employees dataset;
PROC SORT DATA=ch4data.employees OUT=employees;
BY Cod;
RUN;

* Step 2 - Sort the firm dataset;
PROC SORT DATA=ch4data.firm OUT=firm;
BY Cod;
RUN;

* Step 3 - Merge the employees and firm datasets;
DATA ch4res.employees1;
MERGE employees firm;
BY Cod;
RUN;

*b);
DATA ch4res.employees2;
MERGE employees firm;
BY Cod;
IF first.Cod THEN Total=0;
Total + Salary; * Total = Total + Salary;
*IF last.Cod;
RUN;

*c);
* Step 1 - Drop the unwanted variables and put HeadPerson in uppercase;
DATA ch4res.employees3;
SET ch4res.employees2;
DROP City Name Birth Total;
HeadPerson = UPCASE(HeadPerson);
RUN;

* Step 2 - Sort the dataset by Surname and ID;
PROC SORT DATA=ch4res.employees3;
BY Surname ID;
RUN;

*d);
PROC SQL;
CREATE TABLE ch4res.employees3 AS 
SELECT ID, Surname, Sex, Cod, Salary, UPCASE(HeadPerson) AS HeadPerson
FROM ch4res.employees2
ORDER BY Surname, ID;
QUIT;

/* Explanation of the code above:
PROC SQL indicates that the following code will be written using SQL syntax.
CREATE TABLE functions similarly to the DATA statement in a DATA step. It creates a new dataset 
and allows us to assign a name to it.
SELECT specifies which variables (columns) should be included in the new dataset. This is 
similar to the KEEP statement in a DATA step, as it determines which variables will appear in 
the output dataset.
FROM specifies the dataset (or datasets) from which the data will be retrieved. This is 
conceptually similar to the SET statement in a DATA step, which reads observations from an 
existing dataset.
ORDER BY does the same as the PROC SORT step. It sorts the data based on the variable that we 
define, if it is a character variable the rows will be organised alphabetically, if it is a 
numerical variable it will be organised in an ascending order from the smallest to the 
largest value.
QUIT indicates the end of the PROC SQL step, similar to how RUN signals the end of a DATA step.
*/

/* Exercise 3 */
* Step 1 - Sort the inventory dataset;
PROC SORT DATA=ch4data.inventory OUT=inventory;
BY Model;
RUN;

* Step 2 - Sort the purchase dataset;
PROC SORT DATA=ch4data.purchase OUT=purchase;
BY Model;
RUN;

* Step 3 - Merging the datasets;
DATA pur_price;
MERGE inventory purchase (IN=pur);
BY Model;
IF pur;
TotalCost = Quantity * Price;
FORMAT TotalCost dollar7.2;
RUN;

* Doing it with PROC SQL;
PROC SQL;
CREATE TABLE pur_price AS
SELECT i.Model, i.Price, p.Quantity, (p.Quantity * i.Price) AS TotalCost FORMAT=dollar7.2
FROM ch4data.inventory AS i INNER JOIN ch4data.purchase AS p
ON i.Model = p.Model
ORDER BY i.Model;
QUIT;

/* Exercise 4 */
* Step 1 - Import the customer_base dataset;
PROC IMPORT DATAFILE='/home/u64191330/P4B_st/Chapter 4/Data/customer_base.csv'
	DBMS=CSV
	OUT=ch4res.customer_base;
	GETNAMES=YES;
RUN;

* Step 2 - Import the card_base dataset;
PROC IMPORT DATAFILE='/home/u64191330/P4B_st/Chapter 4/Data/card_base.csv'
	DBMS=CSV
	OUT=ch4res.card_base;
	GETNAMES=YES;
RUN;

* Step 3 - Creating the new dataset that only contains the clients with credit card;
PROC SQL;
CREATE TABLE cust_with_card AS
	SELECT A.Cust_ID, Card_Family, Customer_Segment
	FROM ch4res.card_base AS A, ch4res.customer_base AS B
	WHERE A.Cust_ID = B.Cust_ID AND B.Age < 30;
QUIT;

/* Exercise 5 */
* Step 1 - Import the item category variable;
PROC IMPORT DATAFILE= '/home/u64191330/P4B_st/Chapter 4/Data/item_category.xlsx'
	DBMS=XLSX
	OUT=ch4res.item_category;
	GETNAMES=YES;
RUN;

* Step 2 - Import the daily sales 1;
PROC IMPORT DATAFILE= '/home/u64191330/P4B_st/Chapter 4/Data/daily_sales1.xlsx'
	DBMS=XLSX
	OUT=ch4res.daily_sales1;
	GETNAMES=YES;
RUN;

* Step 3 - Import the daily sales 2;
PROC IMPORT DATAFILE= '/home/u64191330/P4B_st/Chapter 4/Data/daily_sales1.xlsx'
	DBMS=XLSX
	OUT=ch4res.daily_sales2;
	GETNAMES=YES;
RUN;

*a);
DATA ch4res.daily_sales;
	SET ch4res.daily_sales1 ch4res.daily_sales2;
RUN;

*b);
* Step 1 - Sort the daily_sales data set;
PROC SORT DATA=ch4res.daily_sales OUT= daily_sales;
	BY Item_Code;
RUN;

* Step 2 - Sort the item_category data set;
PROC SORT DATA=ch4res.item_category OUT= item_category;
	BY Item_Code;
RUN;

* Step 3 - Merge the 2 data sets with the required transformations;
DATA ch4res.all_daily_sales (DROP=Category_Code);
	MERGE daily_sales item_category;
	BY Item_Code;
	Total_Sales = Quantity_Sold * Unit_Selling_Price;
RUN;

*c);
DATA ch4res.all_daily_sales1 (KEEP= Time Date Item_Name Category_Name Total_Sales);
	SET ch4res.all_daily_sales;
	WHERE Total_Sales > 50 AND Discount = 'No';
	Total_Sales = ROUND(Total_Sales, 0.01);
RUN;

*d);
DATA ch4res.all_daily_sales2 (KEEP= Time Date Item_Name Category_Name Total_Sales Sales_Level);
	LENGTH Sales_Level $11; *set a sufficient length for the variable Sales_Level not to be cut;
	SET ch4res.all_daily_sales;
	IF Total_Sales < 3 THEN Sales_Level = 'Low sale';
	ELSE IF 3 <= total_sales < 5 then sales_level = 'Medium sale';
	ELSE Sales_Level = 'Big sale';
RUN;

* Another option;
DATA ch4res.all_daily_sales2 (keep = time date item_name category_name total_sales sales_level);
	LENGTH Sales_Level $11; *set a sufficient length for the variable Sales_Level not to be cut;
	SET ch4res.all_daily_sales;
	SELECT;
		WHEN (total_sales < 3) sales_level = 'Low sale';
		WHEN (3 <= total_sales < 5) sales_level = 'Medium sale';
		OTHERWISE sales_level = 'Big sale';
		END;
RUN;