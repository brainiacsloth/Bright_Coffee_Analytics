Bright Coffee Analytics – README
Introduction

This project explores the sales performance of Bright Coffee using SQL Server (SSMS) and Power BI. 
The main goal is to understand profit, sales trends, and product performance across time and store locations. 
SQL was used for preparing and structuring the data, while Power BI was used for creating visuals and insights. 
The project plan and outline were carried out on Miro.

Work in SQL (SSMS)

I began by importing the raw transaction data into SQL and storing it in a table called [dbo].[BrightCoffeeTransactions]. 
To make the data more useful, I created a profit column using the formula transaction_qty × unit_price. 
NB: The profit columnn was only created in MS Excel and Power BI, but it was not part of the saved view. 
I create the calculated column to allow me to measure profit directly at the transaction level.
I then used date functions to extract useful time parts from purchase_date, such as year, month, week, and day. 
This made it easier to group sales over different time periods. 
I also applied CASE statements to create a time_bucket column, which grouped sales into clear categories: Early Morning, Morning, Afternoon, Evening, and Night.

Finally, I created a SQL view that brought together all the important fields and calculations. 
This view acted as a clean dataset for Power BI and reduced the need for repeated calculations inside Power BI.
The view was saved as complete_transactions_BrightCoffee. I exported that flat file into a CSV for minor assessments in MS Excel. 

Work in Power BI

Once the SQL view was connected to Power BI, I created several measures to track key business metrics. 
These included Total Revenue, Total Profit, Total Products Sold, Average Weekly Profit, Profit Margin, and Average Products per Transaction. 
I also created measures to compare weekday vs weekend sales and to monitor month-over-month changes.

I designed cards in the dashboard to highlight top KPIs like Total Sales Qty, Total Revenue, and Average Weekly Profit. 
For deeper insights, I built visuals such as bar charts for profit by product and category, a matrix comparing stores by sales and profit, and a line chart showing profit trends by month.
I also included a time bucket analysis to show how profit shifts throughout the day.

Key Insights

The dashboard makes it clear which products and categories are the most profitable. 
It shows differences between store locations, with some performing consistently better than others. 
It also reveals how customer buying behavior changes between weekdays and weekends. 
The time bucket analysis provides an extra layer, showing when during the day the most profit is generated.
Finally, the monthly breakdown shows how profit and sales evolve across time.
