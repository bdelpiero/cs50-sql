-- *** The Lost Letter ***
-- when we get the address information for this id, we get smth strange. 
-- 2 Finnigan Street
-- There seems to be a typo or smth wrong with the data, as it does not match exactly the expected Varsha's directory: 2 Finnegan Street
select *
from "addresses"
where "id" = (
                -- get the address id where the package was dropped at
                select "address_id"
                from "scans"
                where "action" = 'Drop'
                        and "package_id" = (
                                -- get the id of the Congratulatory packaged picked from Anneke's address
                                select id
                                from packages
                                where "from_address_id" = (
                                                select id
                                                from "addresses"
                                                where "address" = '900 Somerville Avenue'
                                        )
                                        and contents = 'Congratulatory letter'
                        )
        );
-- *** The Devious Delivery ***
-- get the packages with no From address
select id
from packages
where "from_address_id" is null;
-- sinde the previous query returned a single element, we can assume it is our expected package. no we can look where it ended up at
select *
from addresses
where id = (
                select "address_id"
                from scans
                where "package_id" = (
                                select id
                                from packages
                                where "from_address_id" is null
                        )
                        and "action" = 'Drop'
        );
-- get the contents of the package
select contents
from packages
where "from_address_id" is null;
-- *** The Forgotten Gift ***
-- get the old man's address
select *
from addresses
where "address" = '109 Tileston Street';
-- check for packages sent from this address
-- this retieves only one result, the content of which is Flowers
select *
from packages
where "from_address_id" = (
                select id
                from addresses
                where "address" = '109 Tileston Street'
        );
-- who's got the package now?
-- lets check the scans for the package to see if smth is off
select *
from scans
where package_id = (
                select id
                from packages
                where "from_address_id" = (
                                select id
                                from addresses
                                where "address" = '109 Tileston Street'
                        )
        );
-- so, the packaged was dropped at a warehouse at 950 Brannon Harris Way an then picked again.. but has not been dropped anywhere since that
-- this means the package is in hands of the driver
-- lets get the latest scan and use that driver id to get the drivers data
select *
from drivers
where id = (
                select "driver_id"
                from scans
                where package_id = (
                                select id
                                from packages
                                where "from_address_id" = (
                                                select id
                                                from addresses
                                                where "address" = '109 Tileston Street'
                                        )
                        )
                order by timestamp desc
                limit 1
        );
-- we could maybe do the same subquery using max on timestamp instead of order by
select "driver_id",
        "timestamp"
from scans
where "timestamp" = (
                select max("timestamp")
                from scans
                where package_id in (
                                select id
                                from packages
                                where "from_address_id" = (
                                                select id
                                                from addresses
                                                where "address" = '109 Tileston Street'
                                        )
                        )
        );