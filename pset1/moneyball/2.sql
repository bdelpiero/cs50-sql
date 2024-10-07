--write a SQL query to find Cal Ripken Jr.’s salary history.
-- sort by year desc
select s.year,
    s.salary
from salaries "s"
where s.player_id = (
        select id
        from players
        where first_name = 'Cal'
            and last_name like 'Ripken%'
    )
order by year desc;