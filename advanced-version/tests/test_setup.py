from pyspark.sql import SparkSession
import pandas as pd
import requests

def test_pyspark():
    print("🔥 Testando PySpark...")
    spark = SparkSession.builder \
        .appName("Test") \
        .master("local[*]") \
        .getOrCreate()
    
    df = spark.createDataFrame([(1, "teste")], ["id", "value"])
    df.show()
    spark.stop()
    print("✅ PySpark OK!")

def test_tmdb():
    print("\n🎬 Testando TMDB API...")
    from tmdbv3api import TMDb, Movie
    import os
    from dotenv import load_dotenv
    
    load_dotenv()
    
    tmdb = TMDb()
    tmdb.api_key = os.getenv('TMDB_API_KEY')
    
    movie = Movie()
    popular = movie.popular()
    print(f"✅ TMDB OK! Filmes populares: {len(popular)}")
    print(f"   Exemplo: {popular[0].title}")

if __name__ == "__main__":
    test_pyspark()
    test_tmdb()