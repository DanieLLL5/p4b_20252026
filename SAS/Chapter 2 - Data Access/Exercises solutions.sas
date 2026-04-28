libname ch2data '/home/u64191330/P4B_st/Chapter 2/Data';
libname ch2res '/home/u64191330/P4B_st/Chapter 2/Results & Code';

/* Exercise 1 */
*a); 

DATA ch2res.smsales1;
INFILE '/home/u64191330/P4B_st/Chapter 2/Data/supermarket_sales.txt' firstobs=100 obs=200;
INPUT Invoice_ID $ 1-11
	  Branch $ 12
	  Total 70-77
	  Date $ 78-86;
RUN;
* From log note: The dataset has 101 observations and 4 variables;

*b);
FILENAME sales '/home/u64191330/P4B_st/Chapter 2/Data/supermarket_sales.txt';

DATA ch2res.smsales2;
INFILE sales;
INPUT @1 Invoice_ID $11.
	  @12 Branch $1.
	  @13 City $9.
	  @34 Product_Line $22.
	  @70 Total 8.4
	  @78 Date mmddyy9.;
FORMAT Date date9.;
RUN;

*c);
DATA ch2res.smsales2;
INFILE sales obs=300;
INPUT @1 Invoice_ID $11.
	  @12 Branch $1.
	  @13 City $9.
	  @34 Product_Line $22.
	  @70 Total 8.4
	  @78 Date mmddyy9.;
FORMAT Date date9.;
IF Total GT 200;
RUN;

*d);
DATA ch2res.smsales2;
INFILE sales;
INPUT @1 Invoice_ID $11.
	  @12 Branch $1.
	  @13 City $9.
	  @34 Product_Line $22.
	  @70 Total 8.4
	  @78 Date mmddyy9.;
FORMAT Date date9.;
IF Product_Line = 'Health and beauty' OR Product_Line = 'Home and lifestyle';
RUN;

/* Exercise 2 */
*a);
FILENAME emp '/home/u64191330/P4B_st/Chapter 2/Data/employees.txt';

DATA ch2res.employees1;
INFILE emp;
INPUT ID $ Surname $ Name $ City $ Sex $ Cod $ Salary Birth $;
RUN;
* The dataset has 148 observations;

/* Importing through proc import */
PROC IMPORT out=ch2res.employees1
	DATAFILE=emp
	DBMS=DLM
	REPLACE;
	GETNAMES=No;
RUN;

*b);
DATA ch2res.employees1;
	SET ch2res.employees1;
	RENAME
		Var1 = ID
		Var2 = Surname
		Var3 = Name
		Var4 = City
		Var5 = Sex
		Var6 = Cod
		Var7 = Salary
		Var8 = Birth;
RUN;
	

*c);
DATA ch2res.employees1;
INFILE emp;
INPUT ID $ Surname $ Name $ City $ Sex $ Cod $ Salary Birth $;
IF Salary > 30000;
RUN;

*d);
DATA ch2res.employees1;
INFILE emp;
INPUT ID $ Surname $ Name $ City $ Sex $ Cod $ Salary Birth $;
IF Sex = 'M';
RUN;

/* Exercise 3 */
*a);
DATA ch2res.invoices1;
INPUT Invoice_ID Date date7. Customer_ID $ Gender $ Product_ID $ Quantity Unit_Price Total;
CARDS;
1001 27MAR23 C062 F P023 2 60 120
1002 05JUN23 C052 F P005 2 100 200
1003 04JUL23 C002 M P011 3 50 150
1004 27SEP23 C187 M P020 1 200 200
1005 09JAN24 C229 M P033 2 80 160
1006 13FEB24 C034 F P104 1 150 150
;
RUN;

*b);
DATA ch2res.invoices2;
INPUT Invoice_ID Date date7. Customer_ID $ Gender $ Product_ID $ Quantity Unit_Price Total;
FORMAT Date ddmmyy10.;
IF Gender = 'M' AND Total <= 160;
CARDS;
1001 27MAR23 C062 F P023 2 60 120
1002 05JUN23 C052 F P005 2 100 200
1003 04JUL23 C002 M P011 3 50 150
1004 27SEP23 C187 M P020 1 200 200
1005 09JAN24 C229 M P033 2 80 160
1006 13FEB24 C034 F P104 1 150 150
;
RUN;

*c);
DATA ch2res.invoices3;
INPUT Invoice_ID Date date7. Customer_ID $ Gender $ Product_ID $ Quantity Unit_Price Total;
IF 120 <= Total <= 150; * IF Total >= 120 And Total <= 150;
CARDS;
1001 27MAR23 C062 F P023 2 60 120
1002 05JUN23 C052 F P005 2 100 200
1003 04JUL23 C002 M P011 3 50 150
1004 27SEP23 C187 M P020 1 200 200
1005 09JAN24 C229 M P033 2 80 160
1006 13FEB24 C034 F P104 1 150 150
;
RUN;


/* Exercise 4 */
*b);
PROC IMPORT OUT=ch2res.adidas_us_sales 
	DATAFILE='/home/u64191330/P4B_st/Chapter 2/Data/adidas_us_sales.xlsx'
	DBMS=xlsx 
	REPLACE;
	GETNAMES=YES;
RUN;

/* Exercise 5 */

*a);
/* Boring variable naming */
DATA ch2res.walmart_sales;
INFILE '/home/u64191330/P4B/Chapter 2/Data/walmart_sales.txt';
INPUT Store $ Dept $ Week yymmdd10. Sales Holiday $;
FORMAT Week date9.;
RUN;

/* Actually interesting variable naming */
/*
DATA ch2res.walmart_sales;
INFILE '/home/u64191330/P4B/Chapter 2/Data/walmart_sales.txt';
INPUT Diagon_Alley $ Chamber $ School_term yymmdd10. Galleons Triwizard_week $;
FORMAT Triwizard_week date9.;
RUN;
*/

*b);
DATA ch2res.walmart_sales;
INFILE '/home/u64191330/P4B/Chapter 2/Data/walmart_sales.txt';
INPUT Store $ Dept $ Week yymmdd10. Sales Holiday $;
Sales_Per_Day = Sales / 7;
FORMAT Week date9. Sales_Per_Day 7.2;
RUN;

/* Doing it with interesting variable naming */
/*
DATA ch2res.walmart_sales;
INFILE '/home/u64191330/P4B/Chapter 2/Data/walmart_sales.txt';
INPUT Diagon_Alley $ Chamber $ School_term yymmdd10. Galleons Triwizard_week $;
Galleons_Per_Day = Galleons / 7;
FORMAT Triwizard_week date9. Galleons_Per_Day 7.2;
RUN; */

/* Exercise 6 */

/*
data new-data; * Invalid data set name (contains a dash);
	infile prob4data.txt; * Needs quotes around file name and specify the path;
	input x1 x2 * Missing a semicolon at the end of the line;
	y1 = 3(x1) + 2(x2); * To be correct it should be: y1 = 3*x1 + 2*x2;
	y2 = x1 / x2;
	new_variable_from_x1_and_x2 = x1 + x2 – 37; * It is not an error but it is not advisable to have long variable names
run; 
*/