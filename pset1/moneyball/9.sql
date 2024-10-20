-- find the 5 lowest paying teams (by average salary) in 2001
-- round average salary to 2 decimals
-- sort by least to gratest

select t.name, round(avg(s.salary), 2) "average salary"
from teams t join salaries s
on t.id = s.team_id
where s.year = 2001
group by t.id
order by "average salary"
limit 5;