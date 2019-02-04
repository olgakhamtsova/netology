select 'FIO: Khamtsova Olga';

select '-- 1.1';
select * from ratings limit 10;

select '-- 1.2';
select * from links                 
where            
imdbid like '%42' and
movieid > 100 and movieid < 1000 LIMIT 10;

select '-- 2.1';
select distinct
imdbid from links
inner join ratings
on links.movieid=ratings.movieid
where ratings.rating = 5 LIMIT 10;

select '-- 3.1';
select count (distinct links.movieid) as count                       
from links LEFT JOIN public.ratings                                   
    ON links.movieid=ratings.movieid where ratings.movieid is null
;

select '-- 3.2';
select userid, avg (rating) as avg_rating, count (rating) as activity
from ratings                                                          
group by userid                                                  
having avg (rating) > 3.5 order by activity desc
limit 10;

select '-- 4.1. Подзапрос? Непонятно, как данную задачу решить с помощью подзапроса. Решила с помощью аггрегирующих функций';
SELECT imdbid                        
FROM public.links INNER JOIN ratings ON links.movieid=ratings.movieid
GROUP BY imdbid HAVING avg (ratings.rating) > 3.5
LIMIT 10;

select '-- 4.2';
with tmp_table as (select userid,
count (rating) as count
from ratings group by userid having count(rating) >10) 
select avg (rating) from ratings left join tmp_table on ratings.userid=tmp_table.userid;
