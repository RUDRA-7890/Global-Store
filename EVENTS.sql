DROP TABLE IF EXISTS product_details
CREATE TABLE product_details ( Row_ID int,Order_ID	varchar(100),Order_Date date,Ship_Date date,Ship_Mode varchar(30),Customer_ID varchar(30),Customer_Name varchar(200),Segment varchar(50),City varchar(30),State_ varchar(30),Country varchar(30),Postal_Code int,Market varchar(10),	Region varchar(30),	Product_ID varchar(50),	Category varchar(20),Sub_Category varchar(30),Product_Name varchar(30),Sales numeric(10,2),Quantity int,Discount numeric(10,2),Profit numeric(10,2),Shipping_Cost numeric(10,2),Order_Priority varchar(20)
)

SELECT * FROM product_details

COPY product_details FROM 'C:\Users\polla\Downloads\archive (2)\Global_Superstore.csv' CSV HEADER 
ALTER TABLE product_details
ALTER COLUMN  city TYPE varchar(80)

-- data cleaning 
SELECT * FROM product_details
WHERE 
Row_ID IS NULL OR 	
Order_ID  IS NULL OR 
Order_Date	 IS NULL OR 
Ship_Date  IS NULL OR 
Ship_Mode  IS NULL OR 	
Customer_ID  IS NULL OR 
Customer_Name  IS NULL OR 
Segment  IS NULL OR 
City  IS NULL OR 
State_	 IS NULL OR 
Country  IS NULL OR 
Market  IS NULL OR 
Region  IS NULL OR 
Product_ID  IS NULL OR 
Category  IS NULL OR 
Sub_Category  IS NULL OR 
Product_Name  IS NULL OR 	
Sales IS NULL OR 
Quantity  IS NULL OR 
Discount  IS NULL OR 
Profit	 IS NULL OR 
Shipping_Cost  IS NULL OR 
Order_Priority  IS NULL OR
Postal_Code  IS NULL 

SELECT Postal_Code,
       COALESCE('NULL', 'NA') AS Postal_Code
FROM product_details

UPDATE product_details
SET Postal_Code = '0'
WHERE Postal_Code IS NULL;

--INSIGHTS 
--1.Retrieve all product names and their corresponding sales from Dataset???
--QUERY 
SELECT Product_Name, SUM(Sales) AS Total_sales
FROM product_details
WHERE Sales IS NOT NULL AND Product_Name IS NOT NULL
GROUP BY Product_Name
ORDER BY Total_sales  DESC 

--2.Calculate the total sales for all products in Dataset
-- QUERY
SELECT SUM(Sales) AS Total_sales
FROM
 product_details
WHERE 
	Sales IS NOT NULL

--3.Find the product with the highest sales in Dataset
SELECT Product_Name, Total_sales,Ranking
FROM (
	SELECT Product_Name, SUM(Sales) AS Total_sales,
	RANK()OVER(PARTITION BY Product_Name ORDER BY SUM(Sales)) AS Ranking
	FROM product_details
	GROUP BY Product_Name
	) AS RankedSales
WHERE Ranking = 1
ORDER BY  Total_sales DESC 
LIMIT 1

--5. Find the product with the lowest sales in Dataset 
--QUERY
SELECT Product_Name, SUM(Sales) AS Total_sales
FROM 
	product_details
WHERE 
	Sales IS NOT NULL AND Product_Name IS NOT NULL
GROUP BY Product_Name
ORDER BY Total_sales 
LIMIT 1
	
--5.Retrieve all products with a quantity greater than 5 from Dataset
-- QUERY
SELECT Product_Name,Quantity
FROM product_details
WHERE Quantity > '5'
ORDER BY Quantity DESC

--6.Calculate the average profit for each product in Dataset 
SELECT 
	Product_Name,
	CAST(AVG(Profit)AS numeric(10,1)) AS Avg_profit
FROM 
	product_details
WHERE 
 	Product_Name IS NOT NULL
GROUP BY
	Product_Name
ORDER BY 
	Avg_profit DESC 

--7.Find the products with negative profit in Dataset
-- QUERY 
SELECT 
	Product_Name,
	Profit
FROM 
	product_details
WHERE 
 	Profit < 0
ORDER BY 
	profit 

--8.Calculate the total shipping cost for each product in Dataset
--query
SELECT 
	Product_Name,
	CAST(SUM(Shipping_Cost)AS numeric(10,1)) AS Total_Shipping_Cost
FROM 
	product_details
WHERE 
 	Product_Name IS NOT NULL
GROUP BY
	Product_Name
ORDER BY 
	 Total_Shipping_Cost DESC 

--9.Calculate the average discount for each product in Dataset
--QUERY
SELECT 
	Product_Name,
	CAST(AVG(Discount)AS numeric(10,1)) AS Avg_discount
FROM 
	product_details
WHERE 
 	Product_Name IS NOT NULL
GROUP BY
	Product_Name
ORDER BY 
	Avg_discount DESC 

--10.Calculate the total quantity for each product in Dataset
--QUERY 
SELECT 
	Product_Name,
	CAST(SUM(Quantity)AS numeric(10,1)) AS Total_quantity
FROM 
	product_details
WHERE 
 	Product_Name IS NOT NULL
GROUP BY
	Product_Name
ORDER BY 
	Total_quantity DESC 

--11.Find the average shipping cost for each order priority in Dataset
--QUERY
SELECT 
	Order_Priority,
	CAST(AVG(Shipping_Cost)AS numeric(10,1)) AS Avg_shipping_cost
FROM 
	product_details
WHERE 
 	Order_Priority IS NOT NULL
GROUP BY
	Order_Priority
ORDER BY 
	Avg_shipping_cost DESC 

--
--12.find the average shipping cost for each ship mode.
--QUERY
SELECT 
	Ship_Mode,
	CAST(AVG(Shipping_Cost)AS numeric(10,1)) AS Avg_shipping_cost
FROM 
	product_details
WHERE 
 	Ship_Mode IS NOT NULL
GROUP BY
	Ship_Mode
ORDER BY 
	Avg_shipping_cost DESC 

--13. find the total sales for each product category.
--QUERY
SELECT
	Category,
	CAST(SUM(Sales)AS numeric(10,1)) AS Totalsales
FROM 
	product_details
WHERE 
 	Sales IS NOT NULL
GROUP BY
	Category
ORDER BY 
	Totalsales DESC 


--14.find the average shipping cost for each ship mode.
--QUERY
SELECT 
	Ship_Mode,
	CAST(AVG(Shipping_Cost)AS numeric(10,1)) AS Avg_shipping_cost
FROM 
	product_details
WHERE 
 	Sales IS NOT NULL
GROUP BY
	Ship_Mode
ORDER BY 
	Avg_shipping_cost DESC 

--15.find the total count of products for each ship mode
--QUERY
SELECT 
	Ship_Mode,
	COUNT(*) AS total_countofproducts
FROM 
	product_details
WHERE 
 	Ship_Mode IS NOT NULL
GROUP BY
	Ship_Mode
ORDER BY 
	total_countofproducts DESC

--16.Find the correlation between discount and profit in Dataset
-- QUERY
00