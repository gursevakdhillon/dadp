# Divvy Bike Share Data Warehouse Project

## Project Overview

Given 4 tables in 3NF for Divvy Bike Share Program in Chicago. Create a Datawarehouse for following business outocomes. Use STAR schema to design warehouse.

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
