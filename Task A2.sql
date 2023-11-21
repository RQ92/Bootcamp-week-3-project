--1)
select count(*) as "RowCount"-- counts the number of rows in this table
from Seattle_cycles_station

--2)
select count(distinct(station_id)) as "DistinctIDs" -- counts the number of unique station IDs (all are unique)
from Seattle_cycles_station

--3)
select name, decommission_date
from Seattle_cycles_station
where decommission_date is not null -- this shows the stations which have been decomission

--4)
select count(*) as "NoOfDecomStats", sum(install_dockcount) as "NoOfDecomDocks" -- this counts the number of stations which have a decommisioned date
from Seattle_cycles_station
where decommission_date is not null

--5)
select min(install_date) as "earliest install date", max(install_date) as "latest install date"
from Seattle_cycles_station -- we get the earliest and latest install date

--6)
select count(distinct(trip_id)) as "UniqueTrips", count(trip_id) as "RowCount"
from Seattle_cycles_trip -- returns unique trips and the total row count

--7)
select AVG(tripduration / 60) as "TripDurationMins"
from Seattle_cycles_trip -- converts the tripduration column to minutes

--8)
select top 1 count(distinct(trip_id)) as "TripCount", from_station_name -- counts the number of unique trips per station
from Seattle_cycles_trip
group by from_station_name -- this allows us to get the count for each station
order by TripCount desc -- order from largest to smallest

--9)
select count(*)
from Seattle_cycles_trip
where gender = 'Male'
and usertype = 'Member'
and year(starttime) = 2015

--10)
select count(*) -- returns the number of rows which contain a birth year
from Seattle_cycles_trip
where birthyear is not null

--11)
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
select count(distinct(bikeid)) as NoOfBikes, usertype, YEAR(starttime)
from Seattle_cycles_trip -- returns the number of unique bikes rented by Short Terms
where usertype = 'Short-Term Pass Holder'
group by usertype, year(starttime)

--14)
select Min(date) as EarliestDate, Max(date) as LatestDate
from Seattle_weather_daily

--15)
select date, Max_Temperature_F - Min_TemperatureF as TempDiff, Max_Temperature_F, Min_TemperatureF
from Seattle_weather_daily -- returns the daily temp diff and orders by largest to smallest
order by TempDiff desc

--16)
select avg(Mean_Humidity) as AvgHumidity, format(date, 'yyyy MM')
from Seattle_weather_daily
group by format(date, 'yyyy MM') -- returns the average humidity of each month
order by format(date, 'yyyy MM')

--17) 
select max(Max_Wind_Speed_MPH) as MaxWindSpeed, month(date) as Month
from Seattle_weather_daily
where year(date) = 2015
group by month(date) -- returns max wind speed of each month in 2015
order by max(Max_Wind_Speed_MPH) desc

--18) 
select count(Events) -- returns how many days had a weather event other than just rain
from Seattle_weather_daily
where events is not null
and events <> 'Rain'

--19)
select sum(Precipitation_In) as TotalRainfall, year(date) as Year -- total rainfall in first 3 months of 2016
from Seattle_weather_daily
where month(date) In(1,2,3) and year(date)= 2016
group by year(date) -- group by year so the sum is showed as one figure for all 3 months

--20)
select count(Events) as FogCount
from Seattle_weather_daily
where events like '%fog%'

