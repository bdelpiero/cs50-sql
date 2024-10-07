-- find the average player slary by year.
select year,
    round(avg(salary), 2) "average salary"
from salaries
group by year
order by year desc;