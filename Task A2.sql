select count(*) as "RowCount"-- counts the number of rows in this table
from Seattle_cycles_station

select count(distinct(station_id)) as "DistinctIDs" -- counts the number of unique station IDs (all are unique)
from Seattle_cycles_station

select name, decommission_date
from Seattle_cycles_station
where decommission_date is not null -- this shows the stations which have been decomission

select count(*) as "NoOfDecomStats" -- this counts the number of stations which have a decommisioned date
from Seattle_cycles_station
where decommission_date is not null

select min(install_date) as "earliest install date", max(install_date) as "latest install date"
from Seattle_cycles_station -- we get the earliest and latest install date

select count(distinct(trip_id)) as "UniqueTrips", count(*) as "RowCount"
from Seattle_cycles_trip -- returns unique trips and the total row count

select tripduration / 60 as "TripDurationMins"
from Seattle_cycles_trip -- converts the tripduration column to minutes

select count(distinct(trip_id)) as "TripCount", from_station_name -- counts the number of unique trips per station
from Seattle_cycles_trip
group by from_station_name -- this allows us to get the count for each station
order by TripCount desc -- order from largest to smallest

select
