libname ch3data '/home/u64191330/P4B_st/Chapter 3/Data';
libname ch3res '/home/u64191330/P4B_st/Chapter 3/Results & Code';

/* Exercise 1 */
DATA ch3res.smsales;
INFILE '/home/u64191330/P4B_st/Chapter 3/Data/supermarket_sales.txt';
INPUT @1 Invoice_ID $11.
	  @12 Branch $1.
	  @13 City $9.
	  @22 Customer_Type $6.
	  @28 Gender $6.
	  @34 Product_Line $22.
	  @56 Unit_Price 5.2
	  @61 Quantity 2.
	  @63 Tax_5 7.4
	  @70 Total 8.4
	  @78 Date mmddyy9.
	  @87 Time time5.
	  @92 Payment $11.
	  @103 Rating 3.1;
FORMAT Date date9. Time time5.; 
RUN;

*a);
DATA ch3res.smsales1;
SET ch3res.smsales;
DROP City Time Payment;
RUN;

*b);
DATA ch3res.smsales1;
SET ch3res.smsales1;
WHERE Product_Line IN ('Health and beauty', 'Home and lifestyle') AND Total > 200; 
RUN;

*c);
DATA ch3res.smsales2 (Keep=Invoice_ID Product_Line Tax_5 Total Date Total_Without_Tax);
SET ch3res.smsales;
Total_Without_tax = Total - Tax_5;
WHERE Product_Line LIKE 'Food and beverages';
LABEL Total = 'Total price including tax' 
      Total_Without_tax = 'Total price excluding tax';
RUN;

/* Exercise 2 */
DATA ch3res.employees;
INFILE '/home/u64191330/P4B_st/Chapter 3/Data/employees.txt';
INPUT ID $ Surname $ Name $ City $ Sex $ Cod $ Salary Birth date7.;
FORMAT Birth date9.;
RUN;

*a);
DATA ch3res.employees1;
SET ch3res.employees;
WHERE Sex = 'M' AND Birth > '01JAN1950'D;
RUN;

*b);
DATA ch3res.employees2;
SET ch3res.employees;
WHERE Surname LIKE 'A%' OR Surname LIKE 'B%' OR Surname LIKE 'C%'; *where substrn(surname, 1, 1) in ('A', 'B', 'C');
Birth_month = MONTH(Birth);
RUN;

*c);
DATA ch3res.employees3;
SET ch3res.employees;
IF Cod='ME1' THEN SalaryA = Salary + 1100;
ELSE IF Cod='ME2' THEN SalaryA = Salary + 1200;
ELSE IF Cod='ME3' THEN SalaryA = Salary + 1300;
ELSE SalaryA = Salary + 1000;
RUN;

*d);
DATA ch3res.employees3;
SET ch3res.employees;
SELECT (Cod);
	WHEN ('ME1') SalaryA = Salary + 1100;
	WHEN ('ME2') SalaryA = Salary + 1200;
	WHEN ('ME3') SalaryA = Salary + 1300;
	OTHERWISE SalaryA = Salary + 1000;
END;
RUN;

/* Another possibility */
DATA ch3res.employees3;
SET ch3res.employees;
SELECT;
	WHEN (Cod = 'ME1') SalaryA = Salary + 1100;
	WHEN (Cod = 'ME2') SalaryA = Salary + 1200;
	WHEN (Cod = 'ME3') SalaryA = Salary + 1300;
	OTHERWISE SalaryA = Salary + 1000;
END;
RUN;

/* Exercise 3 */
PROC IMPORT OUT=ch3res.churn
	DATAFILE='/home/u64191330/P4B_st/Chapter 3/Data/churn.xlsx'
	DBMS=xlsx
	REPLACE;
	GETNAMES=Yes;
RUN;

*a);
DATA ch3res.churn1;
	SET ch3res.churn;
	Begin_age = Age - Tenure;
	Salary_while_cust = 14 * EstimatedSalary * Tenure;
	Invest = Balance / Salary_while_cust *100;
RUN;

/* Another option - Using the MAX function */
DATA ch3res.churn1;
SET ch3res.churn;
Begin_age = Age - Tenure;
Salary_while_cust = 14 * EstimatedSalary * MAX(Tenure, 1);
Invest = Balance / Salary_while_cust * 100;
RUN;

/* Another option - Using IF's and ELSE's */
DATA ch3res.churn1;
SET ch3res.churn;
Begin_age = Age - Tenure;
IF Tenure <= 0 THEN Salary_while_cust = 14 * EstimatedSalary;
ELSE Salary_while_cust = 14 * EstimatedSalary * Tenure;
Invest = Balance / Salary_while_cust * 100;
RUN;

/* The two other code options are intended to solve the issue in which Salary_while_cust can 
be 0 due to the fact that Tenure can have 0 as a value, and any multiplication by 0 leads to a 
value of 0. Due to this when you are creating variable Invest you can have divisions by 0 which 
produces a warning */

*b);
DATA ch3res.churn1 (KEEP=CustomerID Geography CreditScore rBalance);
SET ch3res.churn1;
rBalance = ROUND(Balance);
Geography = UPCASE(Geography);
RUN;

*c);
DATA ch3res.churn2;
SET ch3res.churn;
WHERE SURNAME LIKE 'A%';
RUN;
