This project is for practicing datalake ETL processs involving extraction, loading and transformation noteboook.


# Azure Data Lake for Bike Share (Divvy) Analytics

## Project Overview

Given 4 tables in 3NF for Divvy Bike Share Program in Chicago. Create a Datalake for following business outocomes. Use STAR schema to design etl process and datalake.

---

## Source Tables

Tables:

- Rider  
- Trip  
- Station  
- Payment  

---

## Business Outcomes Required

### 1) Analyze how much time is spent per ride

a) Based on date and time factors such as day of week and time of day  

b) Based on which station is the starting and / or ending station  

c) Based on age of the rider at time of the ride  

d) Based on whether the rider is a member or a casual rider  

### 2) Analyze how much money is spent

a) Per month, quarter, year  

b) Per member, based on the age of the rider at account start  

---

## Data Processing Requirements

Data is given in csv files.

- Data is to be uploaded to postgres sql db  
- Data is ingsted into datalake raw folder  
- Create External tables on top of datalake data  
- Create fact and dimension tables based on the STAR schema in accordance with above business outcomes

### Solution Should Contain 
  - STAR schema pdf in pdf format
  - Notebook to write data in delta lake format (data is uplpoaded to dbfs from the csv file provided by udacity)
  - Notebook (SQL based) to create bronze layer (schema) table on top of data stored in the dela storage
  - Noteook to transform this data as per STAR schema and write the fact and dimension table to gold layer (Schema) in delta format
