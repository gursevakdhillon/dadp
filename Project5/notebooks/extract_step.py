# Databricks notebook source
# MAGIC %md
# MAGIC ### Notebook to write the raw files uploaded to dbfs in delta format to new location

# COMMAND ----------

#####File read options

# file type
file_type = "csv"

# CSV options
infer_schema = "false"
first_row_is_header = "false"
delimiter = ","

# COMMAND ----------

###Create Trips table

##File loation and column names
file_location_trips = "/FileStore/tables/trips.csv"

col_names_trips = ['trip_id', 'rideable_type','started_at','ended_at','start_station_id','end_station_id','rider_id']

# The applied options are for CSV files. For other file types, these will be ignored.
df = spark.read.format(file_type) \
  .option("inferSchema", infer_schema) \
  .option("header", "false") \
  .option("sep", delimiter) \
  .load(file_location_trips)\
  .toDF(*col_names_trips)

df.write.format("delta").mode("overwrite").save("/delta/trips")
  

# COMMAND ----------

###Create Riders Table

##File loation and column names
file_location_riders = "/FileStore/tables/riders.csv"

col_names_riders = ['rider_id', 'first','last','address','birthday','account_start_date','account_end_date','is_member']

# The applied options are for CSV files. For other file types, these will be ignored.
df = spark.read.format(file_type) \
  .option("inferSchema", infer_schema) \
  .option("header", "false") \
  .option("sep", delimiter) \
  .load(file_location_riders)\
  .toDF(*col_names_riders)


df.write.format("delta").mode("overwrite").save("/delta/riders")


# COMMAND ----------

###Create Payments table

##File loation and column names
file_location_payments = "/FileStore/tables/payments.csv"

col_names_payments = ['payment_id', 'date','amount','rider_id']

# The applied options are for CSV files. For other file types, these will be ignored.
df = spark.read.format(file_type) \
  .option("inferSchema", infer_schema) \
  .option("header", "false") \
  .option("sep", delimiter) \
  .load(file_location_payments)\
  .toDF(*col_names_payments)

df.write.format("delta").mode("overwrite").save("/delta/payments")

# COMMAND ----------

###Create Payments table

##File loation and column names
file_location_stations = "/FileStore/tables/stations.csv"

col_names_stations = ['station_id', 'name','lattitude','longitude']

# The applied options are for CSV files. For other file types, these will be ignored.
df = spark.read.format(file_type) \
  .option("inferSchema", infer_schema) \
  .option("header", "false") \
  .option("sep", delimiter) \
  .load(file_location_payments)\
  .toDF(*col_names_stations)

df.write.format("delta").mode("overwrite").save("/delta/stations")

# COMMAND ----------

print(dbutils.fs.ls('/delta'))