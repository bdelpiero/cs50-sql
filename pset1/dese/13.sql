-- correlation between staff_evaluations and expenditure?
-- this is not the best way to answer this question, just a first approach
-- avg exemplary rates of schools with above avg expenditure
select avg(se.exemplary)
from districts d
    join expenditures e on d.id = e.district_id
    join staff_evaluations se on d.id = se.district_id
where 1 = 1
    and e.per_pupil_expenditure > (
        select avg(per_pupil_expenditure)
        from expenditures
    );
-- avg exemplary rates of schools with below avg expenditure
select avg(se.exemplary)
from districts d
    join expenditures e on d.id = e.district_id
    join staff_evaluations se on d.id = se.district_id
where 1 = 1
    and e.per_pupil_expenditure < (
        select avg(per_pupil_expenditure)
        from expenditures
    );
-- putting this two queties together with help of chatgpt
WITH above_avg_expenditure_exemplary_rate AS (
    SELECT AVG(se.exemplary) AS avg_exemplary
    FROM districts d
        JOIN expenditures e ON d.id = e.district_id
        JOIN staff_evaluations se ON d.id = se.district_id
    WHERE e.per_pupil_expenditure > (
            SELECT AVG(per_pupil_expenditure)
            FROM expenditures
        )
),
below_avg_expenditure_exemplary_rate AS (
    SELECT AVG(se.exemplary) AS avg_exemplary
    FROM districts d
        JOIN expenditures e ON d.id = e.district_id
        JOIN staff_evaluations se ON d.id = se.district_id
    WHERE e.per_pupil_expenditure < (
            SELECT AVG(per_pupil_expenditure)
            FROM expenditures
        )
)
SELECT CASE
        WHEN a.avg_exemplary > b.avg_exemplary THEN 'Above-average expenditure schools have higher exemplary staff evaluations rates'
        WHEN a.avg_exemplary < b.avg_exemplary THEN 'Below-average expenditure schools have higher exemplary staff evaluations rates'
        ELSE 'Both have similar exemplary rates'
    END AS comparison_result
FROM above_avg_expenditure_exemplary_rate a,
    below_avg_expenditure_exemplary_rate b;