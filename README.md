📊 Netflix Movies and TV Shows Data Analysis using SQL


![Netflix Logo](https://github.com/Rohitvihan/Netflix_data_analysis_using_sql/blob/main/Netfliximg.png)


🧾 Overview:-



This project performs data analysis on Netflix’s content catalog using SQL. The objective is to derive insights from the data to help understand trends in content type, regional distribution, genre, and user engagement patterns. The project is ideal for aspiring data analysts to practice real-world SQL queries and data exploration.


📌 Objectives:-


Analyze distribution between Movies and TV Shows.

Find the most frequent ratings and genres.

Identify trends by release year, country, and director.

Explore keyword-based content filtering and actor popularity.

Work with real-world data structures using SQL.


🗂️ Dataset:-


Source: Kaggle (Netflix Movies and TV Shows Dataset)


Schema Includes:-


show_id, type, title, director, casts, country, date_added, release_year, rating, duration, listed_in, description


🧱 Schema Setup:-


sql

Copy

Edit

DROP TABLE IF EXISTS netflix;

```sql
CREATE TABLE netflix (
    show_id      VARCHAR(5),
    type         VARCHAR(10),
    title        VARCHAR(250),
    director     VARCHAR(550),
    casts        VARCHAR(1050),
    country      VARCHAR(550),
    date_added   VARCHAR(55),
    release_year INT,
    rating       VARCHAR(15),
    duration     VARCHAR(15),
    listed_in    VARCHAR(250),
    description  VARCHAR(550)
);
```

🧪 Findings & Insights:-


India is among the top contributors to Netflix content.


Most frequent ratings:-


TV-MA, TV-14.

Longest duration content helps identify binge content.

Some content lacks proper metadata (NULL directors).

Actors like Salman Khan frequently appear in recent Indian movies.


✅ Conclusion:-


This project provided insights into the global content landscape on Netflix. 

By using SQL to explore genre, duration, rating, and actor patterns, we developed analytical skills relevant for data roles.
