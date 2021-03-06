/* https://sqlzoo.net/wiki/Using_Null */

/*
1.
List the teachers who have NULL for their department.

Why we cannot use =
You might think that the phrase dept=NULL would work here but it doesn't - you can use the phrase dept IS NULL
*/
select name
from teacher
where dept is NULL

/*
2.
Note the INNER JOIN misses the teachers with no department and the departments with no teacher.
*/
SELECT teacher.name, dept.name
 FROM teacher INNER JOIN dept
           ON (teacher.dept=dept.id)
           
/*
3.
Use a different JOIN so that all teachers are listed.
*/
select teacher.name, dept.name
from teacher left join
dept
on teacher.dept=dept.id


/*
4.
Use a different JOIN so that all departments are listed.
*/
select teacher.name, dept.name
from teacher right join dept
on teacher.dept=dept.id

select teacher.name, dept.name
from dept left join teacher
on teacher.dept=dept.id

/*
5.
Use COALESCE to print the mobile number. Use the number '07986 444 2266' if there is no number given. Show teacher name and mobile number or '07986 444 2266'
*/
select name, COALESCE(mobile,'07986 444 2266') as mobile
from teacher

/*
6.
Use the COALESCE function and a LEFT JOIN to print the teacher name and department name. Use the string 'None' where there is no department.
*/
select t.name, coalesce(d.name,'None')as dept
from teacher t
left join dept d
on t.dept=d.id

/*
7.
Use COUNT to show the number of teachers and the number of mobile phones.
*/

/*
8.
Use COUNT and GROUP BY dept.name to show each department and the number of staff. Use a RIGHT JOIN to ensure that the Engineering department is listed.
*/

/*
9.
Use CASE to show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2 and 'Art' otherwise.
*/

/*
10.
Use CASE to show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2, show 'Art' if the teacher's dept is 3 and 'None' otherwise.
*/

