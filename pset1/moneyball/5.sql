-- find all teams that Satchel Paige played for.
select t.name
from teams "t"
where t.id in (
        select distinct pf.team_id
        from performances "pf"
        where pf.player_id = (
                select p.id
                from players "p"
                where p.first_name = 'Satchel'
                    and p.last_name = 'Paige'
            )
    );