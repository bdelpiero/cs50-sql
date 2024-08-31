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