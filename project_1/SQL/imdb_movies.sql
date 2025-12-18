
--           imdb movies project

-- Creating and using the database 
DROP DATABASE IF EXISTS IMDB_MOVIES;
create database IMDB_MOVIES;

use imdb_movies;

-- creating director table structure
CREATE TABLE `directors` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(255),
  `gender` INT,
  `uid` INT,
  `department` VARCHAR(255)
);

-- Enable local file importing functionality.
SET GLOBAL local_infile = 1;

-- Verify that local file importing is now active
SHOW VARIABLES LIKE 'local_infile';

-- Importing data
LOAD DATA LOCAL INFILE 'C:/Users/sadaa/Downloads/Datamites/Project_2_SQL/Directors.csv'
INTO TABLE directors
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS
(name, id, gender, uid, department);

select * from directors;

--  movies table structure
CREATE TABLE `movies` (
  `id` int NOT NULL AUTO_INCREMENT,
  `original_title` varchar(200) DEFAULT NULL,
  `budget` int DEFAULT NULL,
  `popularity` int DEFAULT NULL,
  `release_date` text,
  `revenue` bigint(20) DEFAULT NULL,
  `title` text,
  `vote_average` double DEFAULT NULL,
  `vote_count` int DEFAULT NULL,
  `overview` text,
  `tagline` text,
  `uid` int DEFAULT NULL,
  `director_id` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
);

LOAD DATA LOCAL INFILE 'C:/Users/sadaa/Downloads/Datamites/Project_2_SQL/Movies.csv'
INTO TABLE movies
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS
(id, original_title, budget, popularity, release_date, revenue, title, vote_average, vote_count,
overview, tagline, uid, director_id);

select * from movies;

-- To turn off/disable local_infile functionality.
SET GLOBAL local_infile = 0;
SHOW VARIABLES LIKE 'local_infile';


--        data exploration

show tables;
describe movies;
describe directors;

-- Count the total no of rows
SELECT COUNT(*) FROM directors;
SELECT COUNT(*) FROM movies;

SELECT MIN(id), MAX(id) FROM directors;
select distinct department from directors;
select distinct(gender) from directors;
select count(distinct(name)) as total_no_of_directors
from directors;

-- Check for null values
select * from directors
where name is null 
or  id is null
or gender is null
or uid is null
or department is null;

select * from movies
where id is null
 or original_title is null
or budget is null
or popularity is null
or release_date is null
or revenue is null
or title is null
or vote_average is null
or vote_count is null
or overview is null
or tagline is null
or director_id is null;

-- the range of years in the dataset
SELECT MIN(release_date) AS earliest_movie, MAX(release_date) AS latest_movie 
FROM movies;

----- Merging the two tables ----
CREATE TABLE movies_directors AS
SELECT 
  d.id AS director_id,
  d.name AS director_name,
  d.gender,
  d.department,
  m.uid AS movie_uid,
  m.original_title,
  m.budget,
  m.popularity,
  m.release_date,
  m.revenue,
  m.title,
  m.vote_average,
  m.vote_count,
  m.overview,
  m.tagline
FROM directors d
JOIN movies m
ON d.id = m.director_id;

select * from movies_directors;


--             analysis and task


-- a)Can you get all data about movies? 
SELECT *
FROM movies_directors;

--- b)	How do you get all data about directors? ---
select * 
from movies_directors;

--- c)Check how many movies are present in IMDB. 
select count(*) as No_of_movies 
from movies;

--- d) Find these 3 directors: James Cameron ; Luc Besson ; John Woo
SELECT * 
FROM directors
WHERE name IN ('James Cameron', 'Luc Besson', 'John Woo');

--- e)	Find all directors with name starting with S.
select name 
from directors 
where name like "s%";

--- f)Count female directors.
select count(*) AS No_of_female_directors 
from directors 
where gender = 1;

--- g)Find the name of the 10th first women directors.
SELECT * 
FROM directors
WHERE gender = 1
ORDER BY id 
limit 1 OFFSET 9;

--- h)	What are the 3 most popular movies?
select * 
from movies 
order by popularity 
desc limit 3;

--- i)	What are the 3 most bankable movies?
select * 
from movies 
order by revenue desc 
limit 3;

--- j)	What is the most awarded average vote since the January 1st, 2000?
SELECT title, vote_average, release_date, vote_count
FROM movies
WHERE release_date >= '2000-01-01'
ORDER BY vote_average DESC, vote_count desc, release_date
limit 5;

--- k)	Which movie(s) were directed by Brenda Chapman?
select * 
from movies_directors
where director_name ="Brenda Chapman";

--- l)	Which director made the most movies?
SELECT director_name, COUNT(*) AS No_of_Movies
FROM movies_directors
GROUP BY director_name
ORDER BY No_of_Movies DESC
limit 5;

--- m)Which director is the most bankable?
select director_name, sum(revenue) as Total_revenue
FROM movies_directors
group by director_name
order by total_revenue desc
limit 5;
