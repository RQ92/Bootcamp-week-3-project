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

select *
from Seattle_cycles_trip
where gender = 'Male'
and usertype = 'Member'

select count(*) -- returns the number of rows which contain a birth year
from Seattle_cycles_trip
where birthyear is not null

select 2023 - max(birthyear) as "YoungestRider" -- this returns the current age of the youngest rider
from Seattle_cycles_trip

--12)
select count(trip_id) -- this counts the number of trips which start and end at the same station
from Seattle_cycles_trip
where from_station_id = to_station_id

select count(trip_id) -- this checks the previous query is correct
from Seattle_cycles_trip
where from_station_name = to_station_name

--13)
select count(distinct(bikeid)) as NoOfBikes, usertype 
from Seattle_cycles_trip -- returns the number of unique bikes rented by Short Terms
where usertype = 'Short-Term Pass Holder'
group by usertype

--14)
select
from Seattle_weather_conditions