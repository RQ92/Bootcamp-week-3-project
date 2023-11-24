-- Task A4 solutions  
--1) Which station saw the highest trip volume?
--a)	from which station (ID and name) were most cycle hire trips taken overall? 
--b)	How many trips were taken from this station? 
--c)	How many unique bikes were borrowed from this station? 
--d)	What was the average trip duration (rounded to the nearest number of minutes) 
--from this station?
--Guidance to answer the questions:
--- join table Seattle_cycles_station to table Seattle_cycles_trip using 
--the [from_station_id] column 
--- select and appropriately aggregate the columns [trip_id], [bikeid], [tripduration]
--- convert [tripduration] into minutes and round it to 0 decimal places
--- select the [station_id] and [name] in the query 
--- use GROUP BY on all the non-aggregated columns 
--- order the results by the number of trips
--- refine your query to choose the  top one row to answer a),b),c),d) 

select top 1 
count( t.trip_id) as nooftrips,
count(distinct t.bikeid) as noofuniquebikes, 
floor(avg(t.tripduration)/60) as avg_duration_min,
s.name, s.station_id
from Seattle_cycles_trip t
inner join Seattle_cycles_station s on 
t.from_station_id = s.station_id
group by s.name, s.station_id
order by nooftrips DESC


--2) Are people in Seattle mad enough to cycle when it snows? 
--a)	On which dates did it snow in Seattle? 
--b)	On those snowy days, what was the highest number of cycle trips which took place? 
--c)	Did those trips take place during the whole day or only at certain hours of the day?
--d)	How many of those plucky snow-hardy cyclists were members of the scheme and 
-- how many were short term pass holders?
--Guidance to answer the questions:
--- filter the Seattle_weather_conditions table for those dates where the [events] column contained the word ‘snow’ to answer a)
--- inner join to the table Seattle_cycles_trip to using date fields 
--(hint: you will need to extract the date from the [starttime] of the trip, 
--to match the formatting of the date in the weather table, for the join to work. 
--This is a useful method: 
--cast([date column] as Date) 
--- select and aggregate the [trip_id] appropriately 
--- group the results by the date the cycle trip started
--- order the results by number of trips so that the highest number of trips is at the top
--- select the top row to answer b) 
--- remove the top row condition and introduce the hour of the [starttime] of the trip 
--to your query, for which you can use Hour() 
--- group the results by the hour (instead of the dates) that the cycle trip started and review the results table to spot any trends in unpopular hours of the day to answer c)
--- select the [usertype] as a new column and add it to the group by to answer d)

--b) 
select top 1 
w.date, count(t.trip_id) as nooftrips
from Seattle_weather_conditions w 
inner join Seattle_cycles_trip t
on w.Date = cast(t.starttime as Date)
where w.events like '%snow%'
group by w.Date
order by nooftrips DESC

--c)
select datepart(hh,t.starttime) as hourofday, 
count(t.trip_id) as nooftrips
from Seattle_weather_conditions w 
inner join Seattle_cycles_trip t
on w.Date = cast(t.starttime as Date)
where w.events like '%snow%'
group by datepart(hh,t.starttime) 
order by hourofday

--d) 
select datepart(hh,t.starttime) as hourofday, 
t.usertype,
count(t.trip_id) as nooftrips
from Seattle_weather_conditions w 
inner join Seattle_cycles_trip t
on w.Date = cast(t.starttime as Date)
where w.events like '%snow%'
group by datepart(hh,t.starttime) , t.usertype
order by hourofday


--3) there are five cycle stations with less than 15 cycle docks 
--but ONLY one of these stations can expanded, i.e., adding more cycle docks). 
--Which cycle station would you recommend should have more docks added? 
--a)	Which stations currently have less than 15 cycle docks 
--(disregarding decommissioned stations)? 
--b)	How many total trips ended at each of those stations?
--c)	In the months of May, June, July, August each year, 
--how many total bikes were docked at these stations? 
--d)	Which of these stations often has the most monthly bike returns?
--Guidance to answer the questions:
--- Filter the Seattle_cycles_station table to collect the IDs and names of all stations with [current_dockcount]<15, that also have no value in the [decommission_date] to answer a)
--- join to table Seattle_cycles_trip using the [to_station_id] column 
--- select and aggregate the [bikeid] to answer b) 
--- extract the month and year from the stoptime to see which month the bike was returned to the stations
--- filter to trips with a [stoptime] in month numbers 5,6,7,8 
--- group the results by the non-aggregated columns to answer c)
--- sort the results to see which station ID appears most often in the top 10 to answer d) 

--a) 
select s.station_id , s.name
from Seattle_cycles_station s
where current_dockcount < 15
and decommission_date is NULL

--b) mistake in hint, trip id not bike id
select s.station_id , s.name, 
count(t.trip_id) as notrips_to
from Seattle_cycles_station s
join Seattle_cycles_trip t
on s.station_id = t.to_station_id
where current_dockcount < 15
and decommission_date is NULL
group by s.station_id , s.name

--c)
select 
year(t.stoptime) as yearoftrip,
s.station_id , s.name, 
count(t.trip_id) as notrips_to, 
count(t.bikeid) as noofbikes
from Seattle_cycles_station s
join Seattle_cycles_trip t
on s.station_id = t.to_station_id
where current_dockcount < 15
and decommission_date is NULL
and month(t.stoptime) in (5,6,7,8)
group by s.station_id , s.name, 
year(t.stoptime)
order by station_id

--d) 
select month(t.stoptime) as monthoftrip, 
year(t.stoptime) as yearoftrip,
s.station_id , s.name, 
count(t.trip_id) as notrips_to, 
count(t.bikeid) as noofbikes
from Seattle_cycles_station s
join Seattle_cycles_trip t
on s.station_id = t.to_station_id
where current_dockcount < 15
and decommission_date is NULL
and month(t.stoptime) in (5,6,7,8)
group by s.station_id , s.name, 
month(t.stoptime),year(t.stoptime)
order by noofbikes DESC