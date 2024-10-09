-- find the 50 players paid the least in 2001
-- sort by salary (lo to h)
-- else alphabetically first name, last name
-- else id

select p.first_name, p.last_name, s.salary
from players "p" join salaries "s" on p.id = s.player_id
where s.year = 2001
order by s.salary , p.first_name, p.last_name, p.id
limit 50; 
