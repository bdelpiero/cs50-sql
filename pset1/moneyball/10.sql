select
    p.first_name,
    p.last_name,
    s.salary,
    pf."HR",
    s.year
from players p
    join salaries s on p.id = s.player_id
    join performances pf on p.id = pf.player_id
-- is this where the same as joining by a second condition? like 
-- join performances pf on p.id = pf.player_id and pf.year = s.year
where s.year = pf.year
order by p.id,
    s.year desc,
    pf."HR" desc,
    s.salary desc;