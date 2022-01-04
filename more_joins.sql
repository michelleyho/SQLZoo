/* https://sqlzoo.net/wiki/More_JOIN_operations */
/* 
movie(id	title	yr	director	budget	gross )
actor(id	name )
casting (movieid	actorid	ord)
*/

/*
1.
List the films where the yr is 1962 [Show id, title]
*/
SELECT id, title
 FROM movie
 WHERE yr=1962

/*
2.
Give year of 'Citizen Kane'.
*/
select yr
from movie
where title='Citizen Kane'

/*
3.
List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.
*/
select id, title, yr
from movie
where title like '%Star Trek%'
order by yr

/*
4.
What id number does the actor 'Glenn Close' have?
*/
select id
from actor
where name='Glenn Close'

/*
5.
What is the id of the film 'Casablanca'
*/
select id
from movie
where title='Casablanca'

/*
6.
Obtain the cast list for 'Casablanca'.

what is a cast list?
Use movieid=11768, (or whatever value you got from the previous question)
*/
select a.name
from actor a
join casting c
on a.id = c.actorid
where c.movieid =
(select id
from movie
where title='Casablanca'
)

/*
7.
Obtain the cast list for the film 'Alien'
*/
select a.name
from actor a
join casting c
on a.id = c.actorid
where c.movieid = 
(
select id
from movie
where title='Alien'
)

/*
8.
List the films in which 'Harrison Ford' has appeared
*/
select m.title
from movie m
join casting c
on m.id = c.movieid
join actor a
on c.actorid=a.id
where a.name='Harrison Ford'

/*
9.
List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]
*/
select m.title
from movie m
join casting c
on m.id=c.movieid
join actor a
on a.id=c.actorid
where a.name='Harrison Ford' and c.ord!=1


/*
10.
List the films together with the leading star for all 1962 films.
*/
select m.title, a.name
from movie m
join casting c
on m.id = c.movieid
join actor a
on c.actorid=a.id
where m.yr=1962 and c.ord=1

/*
11.
Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies.
*/
SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2

/*
12.
List the film title and the leading actor for all of the films 'Julie Andrews' played in.

Did you get "Little Miss Marker twice"?
*/

select m.title, a.name
from movie m
join casting c
on m.id = c.movieid and c.ord=1
join actor a
on a.id = c.actorid
where c.movieid in
  (SELECT movieid 
   FROM casting
   WHERE actorid IN 
    (
     SELECT id 
     FROM actor
     WHERE name='Julie Andrews'
    )
  )
  

/*
13.
Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles.
*/
select a.name
from actor a
join casting c
on a.id = c.actorid
where c.ord = 1
group by a.name
having count(*) >= 15
order by a.name

/*
14.
List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
*/
select m.title, count(*) as num_actors
from movie m
join casting c
on m.id = c.movieid
where m.yr=1978
group by m.title
order by num_actors desc, m.title

/*
15.
List all the people who have worked with 'Art Garfunkel'.
*/
select a.name
from movie m
join casting c
on m.id = c.movieid
join actor a
on a.id = c.actorid
where c.movieid in
  (SELECT movieid 
   FROM casting
   WHERE actorid IN 
    (
     SELECT id 
     FROM actor
     WHERE name='Art Garfunkel'
    )
  ) and a.name<>'Art Garfunkel'


