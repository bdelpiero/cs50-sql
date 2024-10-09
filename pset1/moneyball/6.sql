-- top 5 teams, sorted by the total number of hits by players in 2001
-- sort by hits (hi to lo)
select t."name",
    sum(pf.H) "total hits"
from teams "t"
    join performances "pf" on t.id = pf.team_id
where pf.year = 2001
group by t.id
order by "total hits" desc
limit 5;