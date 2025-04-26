--NETFLIX PROJECT

CREATE TABLE netflix
(
	show_id VARCHAR(6),
	type VARCHAR(10),
	title VARCHAR(150),
	director VARCHAR(208),
	casts VARCHAR(1000),
	country VARCHAR(150),
	date_added VARCHAR(50),
	release_year INT,
	rating VARCHAR(10),
	duration VARCHAR(15),
	listed_in VARCHAR(150),
	description VARCHAR(250)
);

SELECT *FROM netflix;

--TOTAL ROWS
SELECT COUNT(*) AS TOT_ROWS
FROM netflix;

--DIFFERENT TITLES
SELECT DISTINCT(TITLE)
FROM netflix;

--DIFFERENT TYPE OF SHOWS
SELECT DISTINCT(type)
FROM netflix;

--BUSINESS PROBLEMS
--(1)COUNT THE NUMBER OF MOVIES VS TV SHOWS
SELECT type,COUNT(*) AS TOT
FROM netflix
GROUP BY type;

--(2)FIND THE MOST COMMON RATING FOR MOVIES AND TV_SHOWS
SELECT type, rating, total_count
FROM (
    SELECT type, rating, COUNT(*) AS total_count,
           RANK() OVER (PARTITION BY type ORDER BY COUNT(*) DESC) AS rnk
    FROM netflix
    GROUP BY type, rating
) AS ranked_ratings
WHERE rnk = 1;

--(3)LIST ALL MOVIES RELEASED IN A SPECIFIC YEAR(E.G:-2020)
SELECT title,casts
FROM netflix
WHERE release_year='1993';

--(4)FIND THE TOP 5 COUNTRIES WITH THE MOST CONTENT ON NETFLIX
SELECT TRIM(UNNEST(STRING_TO_ARRAY(country, ','))) AS new_count,
       COUNT(*) AS total_content
FROM netflix
WHERE country IS NOT NULL
GROUP BY new_count
ORDER BY total_content DESC
LIMIT 5;

--(5)IDENTIFY THE LONGEST MOVIE(MAX DURATION)
SELECT * FROM netflix
WHERE type='Movie'
AND duration=(SELECT MAX(duration) FROM netflix)

--(6)FIND THE CONTENT ADDED IN THE LAST 5 YEARS
SELECT type, date_added
FROM netflix
WHERE date_added IS NOT NULL
  AND TO_DATE(date_added, 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years';
SELECT CURRENT_DATE - INTERVAL '5 years';

--(7)FIND ALL MOVIES/TV SHOWS DIRECTED BY 'RAJIV CHILAKA'
SELECT type,COUNT(*)
FROM netflix
WHERE director='Rajiv Chilaka'
GROUP BY type;

--(8)LIST ALL TV SHOWS WITH MORE THAN 5 SEASONS
SELECT title, duration
FROM netflix
WHERE type = 'TV Show'
  AND duration LIKE '%Season%'
  AND CAST(SPLIT_PART(duration, ' ', 1) AS INTEGER) > 5;

--(9)COUNT THE NUMBER OF CONTENT ITEMS IN EACH GENRE
SELECT *FROM netflix;
SELECT COUNT(show_id) AS tot_id,
UNNEST(STRING_TO_ARRAY(listed_in,',')) AS tot_cont
FROM netflix
GROUP BY TOT_CONT;

--(10)FIND EACH YEAR AND THE AVERAGE NUMBER OF CONTENT RELEASE
--IN INDIA ON NETFLIX
--i)RETURN TOP 5 YEARS WITH AVG CONTENT RELEASE!
SELECT 
	EXTRACT(YEAR FROM TO_DATE(date_added,'Month DD,YYYY')) AS yr,
	COUNT(*) AS yrl_cont,
	ROUND(
    COUNT(*)::numeric/(SELECT COUNT(*) FROM netflix WHERE COUNTRY='India')::numeric*100
	,2) as avg_cont_per_yr
FROM netflix
WHERE country='India'
GROUP BY yr;

--(11)LIST ALL MOVIES THAT ARE DOCUMENTARIES 
SELECT show_id, title, listed_in
FROM netflix
WHERE listed_in ILIKE '%Documentaries%'
  AND type = 'Movie';

--(12)FIND ALL CONTENT WITHOUT A DIRECTOR
SELECT listed_in,director
FROM netflix
WHERE director IS NULL;

--(13)FIND HOW MANY MOVIES ACTOR 'SALMAN KHAN' APPEARED 
--IN LAST 10 YEARS
SELECT *
FROM netflix 
WHERE casts ILIKE '%SALMAN KHAN%'
AND release_year> EXTRACT(YEAR FROM CURRENT_DATE)-10;

--(14)FIND THE TOP 10 ACTORS WHO HAVE APPEARED IN THE HIGHEST
--NUM OF MOVIES PRODUCED IN INDIA
SELECT 
UNNEST(STRING_TO_ARRAY(casts,',')) AS actors,
COUNT(*) AS tot_content
FROM netflix
WHERE country ILIKE '%INDIA'
GROUP BY actors
ORDER BY 2 DESC
LIMIT 10;




 
