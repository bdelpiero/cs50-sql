--find the name (or names) of the school district(s) with the single least number of pupils.
-- Report only the name(s).
select d."name"
from districts "d"
    join expenditures "e" on d."id" = e."district_id"
where e."pupils" = (
        select min(e."pupils")
        from expenditures "e"
    );
-- assuming a case where there are many expenditures per district
-- (with help of chatgpt)
with district_totals AS (
    select d."name",
        sum(e."pupils") AS "Total Pupils"
    from districts d
        join expenditures e ON d."id" = e."district_id"
    group by d."id"
)
select "name"
from district_totals
where "Total Pupils" = (
        select min("Total Pupils")
        from district_totals
    );