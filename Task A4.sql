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
select w.date, count(distinct(t.trip_id)) as NoOfTrips
from Seattle_weather_conditions as w
join Seattle_cycles_trip as t
on w.date = convert(date,t.starttime)
where Events like '%Snow%' -- it snowed on 5 days 2014-11-29, 2015-11-28, 2015-12-14, 2016-01-03, 2016-01-15
group by w.date
order by NoOfTrips desc

select count(distinct(t.trip_id)) as NoOfTrips, datepart(hour,starttime) as Hour
from Seattle_weather_conditions as w
join Seattle_cycles_trip as t
on w.date = convert(date,t.starttime)
where Events like '%Snow%' and w.date = '2015-12-14'
group by datepart(hour,starttime)
order by Hour -- the most trips were taken during commuting times

select count(distinct(t.trip_id)) as NoOfTrips, usertype
from Seattle_weather_conditions as w
join Seattle_cycles_trip as t
on w.date = convert(date,t.starttime)
where Events like '%Snow%' and w.date = '2015-12-14'
group by usertype -- of those trips 236 were taken by members and 24 by short-term pass holders

--3)
select name, current_dockcount
from Seattle_cycles_station
where current_dockcount < 15 and current_dockcount <> 0 -- Less than 15 docks: 2nd Ave & Blanchard St, Bellevue Ave & E Pine St, 
-- Burke Museum / E Stevens Way NE & Memorial Way NE, UW Engineering Library / E Stevens Way NE & Jefferson Rd, UW Intramural Activities Building

select count(distinct(tr.trip_id))
from Seattle_cycles_station as sta
join Seattle_cycles_trip as tr
on  sta.station_id = tr.to_station_id
where sta.current_dockcount < 15 and current_dockcount <> 0 -- returns all trips that ended at stations with less than 15 docks
--where tr.to_station_id = 'BT-05' or tr.to_station_id = 'CH-12' or tr.to_station_id = 'UW-02' or tr.to_station_id = 'UW-06' or tr.to_station_id = 'UW-07'

select
from 




