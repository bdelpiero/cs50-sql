-- find public school districts in Massachusets with above-average per-pupil expenditures and an above-average percentage of teachers rated “exemplary”. 
-- return the districts’ names, along with their per-pupil expenditures and percentage of teachers rated exemplary
-- Sort the results first by the percentage of teachers rated exemplary (high to low), then by the per-pupil expenditure (high to low).
select d.name,
    e.per_pupil_expenditure,
    se.exemplary
from districts d
    join expenditures e on d.id = e.district_id
    join staff_evaluations se on d.id = se.district_id
where 1 = 1
    -- only Massachusetts Public schools
    and d.state = 'MA'
    and d.type = 'Public School District'
    -- with above average per-pupil expenditure
    and e.per_pupil_expenditure > (
        select avg(per_pupil_expenditure)
        from expenditures
    )
    -- with above average examplary staff evaluations
    and se.exemplary > (
        select avg(exemplary)
        from staff_evaluations
    )
order by se.exemplary desc,
    e.per_pupil_expenditure desc;