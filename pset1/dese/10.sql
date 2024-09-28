-- find the 10 public school districts with the highest per-pupil expenditures. 
-- Your query should return the names of the districts and the per-pupil expenditure for each.
select d."name",
    sum(e."per_pupil_expenditure") AS "Total Per-Pupil Expenditure"
from districts d
    join expenditures e ON d."id" = e."district_id"
group by d."id"
order by "Total Expenditures" desc
limit 10;