# Walmart-Sales

# PROJECT OVERVIEW
This project aims to predict Walmart store sales and analyze various factors that influence sales trends using SQL Server Management Studio (SSMS) and Power BI. The dataset includes historical sales, markdown events, and economic indicators such as CPI, Unemployment, and Fuel Prices.

# PROJECT OBJECTIVES

- Build a model that accounts for seasonal variations in sales.
  
- Analyze the impact of markdowns,fuel prices, and economic indicators on sales trends.

- Visualize the insights using Power BI dashboards.

# DATA SOURCE
The data used in this project is gotten from https://www.kaggle.com/datasets/aslanahmedov/walmart-sales-forecast

The project utilizes the following datasets:
Train Table: Weekly sales data for stores.
Test Table: Data for sales prediction.
Features Table: Store-related data and economic indicators (Fuel Price, CPI, Unemployment).
Stores Table: Information about different store types and sizes.

# DATA PROCESSING

- SQL Calculations
Data transformation and cleaning, including:
Handling missing markdown values (N/A) by converting them to 0.
Aggregating sales data by year and store type.
Creating key measures such as Total Sales, Average Fuel Prices, and Markdown Effects on Sales.

- Power BI visualization

# INSIGHTS GAINED 

Markdown events had a little impact on boosting sales.

Fuel prices showed a significant impact on sales trends.

The economic indicator CPI showed minimal influence on sales compared to markdowns.
Overall best store had the best time during Festive periods across all year . 


