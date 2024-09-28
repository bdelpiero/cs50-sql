--find the names of districts that are no longer operational. they have “(non-op)” at the end of their name.
select name
from districts
where name like '%(non-op)';