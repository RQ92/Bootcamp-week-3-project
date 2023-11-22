-- 1) 
select top 1 count(*), from_station_name, from_station_id
from Seattle_cycles_trip
group by from_station_name, from_station_id
order by count(*) desc -- the most trips were taken from Pier 69/ Alaskan Way & Clay St ID WF-01
-- 13054 trips were taken from this station

select count(distinct(bikeid))
from Seattle_cycles_trip
where from_station_id = 'WF-01' -- 485 unique bikes were taken from this station

select ROUND(AVG(tripduration / 60),0) as 'AvgTripDur', from_station_id
from Seattle_cycles_trip
where from_station_id = 'WF-01'
group by from_station_id -- average trip duration was 35 minutes

-- 2)
select w.date, count(distinct(t.trip_id)) as NoOfTrip
from Seattle_weather_conditions as w
join Seattle_cycles_trip as t
on w.date = convert(date,t.starttime)
where Events like '%Snow%' -- it snowed on 5 days 2014-11-29, 2015-11-28, 2015-12-14, 2016-01-03, 2016-01-15
group by w.date
order by NoOfTrips desc

select w.date, count(distinct(t.trip_id)) as NoOfTrip, datepart(hour,starttime)
from Seattle_weather_conditions as w
join Seattle_cycles_trip as t
on w.date = convert(date,t.starttime)
where Events like '%Snow%' -- it snowed on 5 days 2014-11-29, 2015-11-28, 2015-12-14, 2016-01-03, 2016-01-15
group by w.date
order by NoOfTrips desc

select datepart(hour,starttime)
from Seattle_cycles_trip







