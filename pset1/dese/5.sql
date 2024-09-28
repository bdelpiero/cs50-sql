--find cities with 3 or fewer public schools.
-- Your query should return the names of the cities and the number of public schools within them,
-- ordered from greatest number of public schools to least. If two cities have the same number of public schools, order them alphabetically.

select city as "City",
    count(id) as "Number of Schools"
from schools
where type = 'Public School'
group by city
having "Number of Schools" <= 3
order by "Number of Schools" desc, city;
