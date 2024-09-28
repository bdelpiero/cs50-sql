--find the names of schools (public or charter!) that reported a 100% graduation rate.
select name
from schools
where id in (
        select school_id
        from graduation_rates
        where graduated = 100
    );

-- alternative using joins
select s.name from schools "s" join graduation_rates "gr" on gr.school_id = s.id where gr.graduated = 100;
