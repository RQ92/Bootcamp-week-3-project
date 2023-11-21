select count(*) -- counts the number of rows in this table
from Seattle_cycles_station

select count(distinct(station_id)) -- counts the number of unique station IDs (all are unique)
from Seattle_cycles_station

select name, decommission_date
from Seattle_cycles_station
where decommission_date is not null -- this shows the stations which have been decomission

select count(*) -- this counts the number of stations which have a decommisioned date
from Seattle_cycles_station
where decommission_date is not null

