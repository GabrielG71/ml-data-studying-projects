from pyspark.sql import SparkSession
import os

project_root = r"C:\Users\Gabriel\Documents\ml-data-studying-projects\advanced-version"
jdbc_jar = os.path.join(project_root, "drivers", "mssql-jdbc-13.2.1.jre11.jar")

print(f"JAR existe? {os.path.exists(jdbc_jar)}")

spark = SparkSession.builder \
    .appName("Test-SQLServer") \
    .config("spark.jars", jdbc_jar) \
    .master("local[*]") \
    .getOrCreate()

# PORTA 1434 (não 1433!)
jdbc_url = "jdbc:sqlserver://localhost:1434;databaseName=master;trustServerCertificate=true"
properties = {
    "user": "sa",
    "password": "Pipocando@2",
    "driver": "com.microsoft.sqlserver.jdbc.SQLServerDriver"
}

try:
    df = spark.read.jdbc(
        url=jdbc_url,
        table="(SELECT 1 as test, 'OK' as status) as t",
        properties=properties
    )
    df.show()
    print("✅ SQL Server funcionando!")
except Exception as e:
    print(f"❌ Erro: {str(e)[:200]}")
finally:
    spark.stop()