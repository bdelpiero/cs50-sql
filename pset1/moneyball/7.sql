-- find the name of the player who’s been paid the highest salary, of all time, in Major League Baseball
select p.first_name,
    p.last_name
from players "p"
where p.id = (
        select s.player_id
        from salaries "s"
        order by s.salary desc
        limit 1
    );
-- alternative
SELECT "first_name",
    "last_name"
FROM "players"
WHERE "id" = (
        SELECT "player_id"
        FROM "salaries"
        WHERE "salary" = (
                SELECT MAX("salary")
                FROM "salaries"
            )
    );