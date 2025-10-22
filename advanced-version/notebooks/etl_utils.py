import requests
import logging
from pyspark.sql import SparkSession
from pyspark.sql.functions import col, explode, split, to_date, year, avg, count, round
from pyspark.sql.types import StructType, StructField, StringType, IntegerType, FloatType

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

TMDB_API_KEY = "241abcb6a8de5f1147f09a5f83b41282E"
TMDB_BASE_URL = "https://api.themoviedb.org/3"

def get_tmdb_data(imdb_id):
    """
    Fetch TMDB data for a given IMDb ID.
    Returns dict with popularity, budget, revenue, or None on error.
    """
    try:
        url = f"{TMDB_BASE_URL}/find/{imdb_id}?api_key={TMDB_API_KEY}&external_source=imdb_id"
        response = requests.get(url)
        response.raise_for_status()
        data = response.json()
        movie_results = data.get('movie_results', [])
        if movie_results:
            movie = movie_results[0]
            return {
                'popularity': movie.get('popularity'),
                'budget': movie.get('budget'),
                'revenue': movie.get('revenue')
            }
        return None
    except Exception as e:
        logger.error(f"Error fetching TMDB for {imdb_id}: {e}")
        return None

def standardize_dates(df):
    """
    Standardize startYear to date format and extract year.
    """
    return df.withColumn("startYear", col("startYear").cast(IntegerType())) \
             .withColumn("movie_year", col("startYear").cast(StringType()))  # For simplicity, keep as year string

def standardize_ratings(df):
    """
    Cast ratings to float and round to 1 decimal.
    """
    return df.withColumn("averageRating", col("averageRating").cast(FloatType())) \
             .withColumn("averageRating", round(col("averageRating"), 1)) \
             .withColumn("numVotes", col("numVotes").cast(IntegerType()))

def enrich_with_tmdb(spark, df):
    """
    Enrich IMDb DF with TMDB data using UDF.
    Note: This is row-wise; for large datasets, batch or use Pandas UDF for efficiency.
    """
    from pyspark.sql.functions import udf
    from pyspark.sql.types import MapType, FloatType, LongType
    
    tmdb_udf = udf(get_tmdb_data, StructType([
        StructField("popularity", FloatType()),
        StructField("budget", LongType()),
        StructField("revenue", LongType())
    ]))
    
    return df.withColumn("tmdb_data", tmdb_udf(col("tconst"))) \
             .select("*", "tmdb_data.*") \
             .drop("tmdb_data")

def aggregate_genre_trends(df):
    """
    Aggregate trends: Count movies, avg rating, avg popularity per genre/year.
    Explode genres since multi-valued.
    """
    exploded_df = df.withColumn("genre", explode(split(col("genres"), ","))) \
                    .filter(col("genre") != "\\N")
    
    trends_df = exploded_df.groupBy("movie_year", "genre") \
                           .agg(
                               count("*").alias("movie_count"),
                               round(avg("averageRating"), 2).alias("avg_rating"),
                               round(avg("popularity"), 2).alias("avg_popularity"),
                               round(avg("budget"), 0).alias("avg_budget"),
                               round(avg("revenue"), 0).alias("avg_revenue")
                           ) \
                           .orderBy("movie_year", "genre")
    return trends_df