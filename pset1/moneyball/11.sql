-- find the 10 least expensive players per hit in 2001
--calculate the “dollars per hit” column by dividing a player’s 2001 salary by the number of hits they made in 2001. Recall you can use AS to rename a column.
-- filter out players with 0 hits
select p."first_name",
    p."last_name"
from players p
where p.id in (
        select s.player_id
        from salaries s
            join performances pf on s.player_id = pf.player_id
            and s.year = pf.year
        where s.year = 2001
            and pf."H" != 0
        order by (s.salary / pf."H")
        limit 10
    )
    and p.id in (
        select s.player_id
        from salaries s
            join performances pf on s.player_id = pf.player_id
            and s.year = pf.year
        where s.year = 2001
            and pf."RBI" != 0
        order by (s.salary / pf."RBI")
        limit 10
    )
    order by "last_name";