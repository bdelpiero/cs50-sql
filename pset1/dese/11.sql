-- display the names of schools, their per-pupil expenditure, 
-- and their graduation rate. 
-- Sort the schools from greatest per-pupil expenditure to least. 
-- If two schools have the same per-pupil expenditure, sort by school name.
--You should assume a school spends the same amount per-pupil their district as a whole spends
with district_total_expenditures AS (
    select d."name",
        d."id",
        sum(e."per_pupil_expenditure") AS "Per-pupil Expenditure"
    from districts d
        join expenditures e ON d."id" = e."district_id"
    group by d."id"
)
select s."name" "School Name",
    dts."Per-pupil Expenditure",
    gr."graduated" "Graduation Rates"
from district_total_expenditures "dts"
    join schools "s" on dts."id" = s."district_id"
    join graduation_rates "gr" on gr."school_id" = s."id"
order by dts."Per-pupil Expenditure" desc,
    s."name";
-- simpler version, assuming there is one expenditure per district
SELECT "name" "School Name",
    "per_pupil_expenditure" "Per-pupil Expenditure",
    "graduated" "Graduation Rates"
FROM "schools"
    JOIN "expenditures" ON "schools"."district_id" = "expenditures"."district_id"
    JOIN "graduation_rates" ON "schools"."id" = "graduation_rates"."school_id"
ORDER BY "per_pupil_expenditure" DESC,
    "name";