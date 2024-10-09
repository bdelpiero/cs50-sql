-- find the 2001 salary of the player who hit the most home runs in 2001
select s.salary
from salaries "s"
where year = 2001
    and s.player_id = (
        select pf.player_id
        from performances "pf"
        where pf.year = 2001
            and pf.HR = (
                select max(HR)
                from performances
            )
    );