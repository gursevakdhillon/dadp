# Databricks notebook source
# MAGIC %md
# MAGIC #### Notebook to load raw data to bronze layer, delta table using spark sql

# COMMAND ----------

# MAGIC %sql
# MAGIC ---Create Bronze schema
# MAGIC CREATE SCHEMA hive_metastore.bronze
# MAGIC

# COMMAND ----------

# MAGIC %sql
# MAGIC ---Create delta table for trips
# MAGIC CREATE TABLE IF NOT EXISTS bronze.stg_trips
# MAGIC USING DELTA
# MAGIC LOCATION "/delta/trips"

# COMMAND ----------

# MAGIC %sql
# MAGIC ---- Create delta table for payments
# MAGIC CREATE TABLE IF NOT EXISTS bronze.stg_payments
# MAGIC USING DELTA
# MAGIC LOCATION "/delta/payments"

# COMMAND ----------

# MAGIC %sql
# MAGIC -- Create delta table for rider
# MAGIC CREATE TABLE IF NOT EXISTS bronze.stg_riders
# MAGIC USING DELTA
# MAGIC LOCATION "/delta/riders"

# COMMAND ----------

# MAGIC %sql
# MAGIC ----Create delta table for stations
# MAGIC CREATE TABLE IF NOT EXISTS bronze.stg_stations
# MAGIC USING DELTA
# MAGIC LOCATION "delta/stations"