-- display the names of all school districts and the number of pupils enrolled in each
select d."name",
    sum(e."pupils") as "Total Pupils"
from districts "d"
    join expenditures "e" on d."id" = e."district_id"
group by d."id";