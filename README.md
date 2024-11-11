# E-Commerce Data Cleaning Project

This project demonstrates how to clean and prepare an e-commerce dataset using SQL. The dataset used is based on a popular Kaggle dataset. The primary goals of this project are to remove duplicates, standardize data, handle null or missing values, and optimize the database schema for better performance.

## Project Goals
1. **Remove Duplicates** - Detect and remove duplicate entries in the dataset.
2. **Standardize Data** - Clean and format data by trimming unwanted characters and rounding numeric values.
3. **Handle Missing or Null Values** - Identify and handle missing or null values across key columns.
4. **Schema Optimization** - Modify data types and apply indexing for better storage and performance.

## Dataset

- The dataset used is based on an e-commerce dataset available on [Kaggle](https://www.kaggle.com/datasets).
- You can download the dataset from Kaggle or use the `e_commerce.csv` sample provided in the `data` folder.

## SQL Data Cleaning Steps

The entire data cleaning process is handled using SQL, with the following key operations:

1. **Cloning the Table** - The original table is cloned to create a working copy.
2. **Handling Duplicates** - Using the `ROW_NUMBER()` function to identify and remove duplicates.
3. **Standardizing Data** - Removing unwanted characters from string columns and rounding decimal values in numeric columns.
4. **Handling Missing Data** - Checking for null and blank values and deciding how to handle them.
5. **Schema Optimization** - Modifying column types and adding indexes to optimize storage and performance.

The full SQL script can be found in the `sql/data_cleaning.sql` file.

## How to Run the SQL Script

1. Clone this repository to your local machine.
   ```bash
   git clone https://github.com/omkarb40/e-commerce-data-cleaning.git
2. Run the data_cleaning.sql script in your SQL environment (e.g., MySQL Workbench, PostgreSQL, etc.).
3. Optionally, load the dataset into your database by importing the e_commerce.csv file.

## Key SQL Concepts
- CTE (Common Table Expressions): Used to identify duplicate rows.
- Window Functions: The ROW_NUMBER() function is used to identify duplicates.
- Data Type Optimization: Columns like StockCode and Description were changed from TEXT to VARCHAR to save space.
- Indexing: Added indexes on key columns (InvoiceNo, StockCode) to improve performance.
