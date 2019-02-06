select 'FIO: Khamtsova Olga';

select 'OVER example';
select 
userId, movieId,
(rating - MIN(rating) OVER (PARTITION BY userId))/(MAX(rating) OVER (PARTITION BY userId) - MIN(rating) OVER (PARTITION BY userid)) as normed_rating,
AVG(rating) OVER (PARTITION BY userId) as avg_rating
FROM (
    SELECT DISTINCT
        userId, movieId, rating
    FROM ratings
    WHERE userId <> 1 LIMIT 1000
) as sample
ORDER BY userId, rating DESC LIMIT 30;
 
CREATE TABLE IF NOT EXISTS keywords (
    movieid int,
    tags varchar (255),
);

\copy keywords FROM '/home/olga/keywords.csv' DELIMITER ',' CSV HEADER

with top_rated as (select movieid,
avg(rating) as avg_rating
from ratings
group by movieid having count(rating) > 50 order by avg_rating desc, movieid asc
limit 150) 
select keywords.movieid, tags into top_rated_tags from keywords 
inner join top_rated on keywords.movieid=top_rated.movieid;

\copy (SELECT * FROM top_rated_tags) TO 'top_rated_tags_file.csv' WITH CSV HEADER DELIMITER as E'\t';


