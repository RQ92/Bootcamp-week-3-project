--A2 – solutions
use Seattle_cyclehire
go 
--1) how many rows are in the Seattle_cycles_station table?
select count(* )from Seattle_cycles_station
--2) how many unique station IDs are there?
select count( distinct station_id) from Seattle_cycles_station
---- 3) which cycle stations (names) have been decommissioned?
select name from Seattle_cycles_station where decommission_date is not null 
---- 4) in total, how many installed docks have been decommissioned? 
select sum( install_dockcount) from Seattle_cycles_station 
where decommission_date is not null 
-- nb typo in hint - suggested COUNT() should be SUM() 
----5) what was the earliest date and the latest date that cycle stations were installed?
select max(install_date) as latest, min(install_date) as earliest 
from Seattle_cycles_station
----6) how many unique trips are there overall?
--Does that number match the number of rows in the Seattle_cycles_trip table?
select count(*) from Seattle_cycles_trip
select count(distinct trip_id) from Seattle_cycles_trip
-- numbers do not match; there are 5k less trips than rows in the table 
----7) what is the average trip duration in minutes? 
select floor(AVG(tripduration)/60) from Seattle_cycles_trip
----8) from which station did the largest number of individual trips begin?
select count(distinct trip_id) as tottrips, from_station_id
from Seattle_cycles_trip
group by from_station_id 
order by tottrips DESC
----9) how many male members of the cycle hire scheme made trips in 2015? 
select count(distinct trip_id) from Seattle_cycles_trip
where usertype='Member' and gender = 'Male' 
-- we dont know how many unique men, we do know how many trips were made by men who were members
----10) how many rows do not have nulls for the column birthyear? 
select count(*) from Seattle_cycles_trip where birthyear is not null 
----11) how old was the youngest rider that we know about?  
select 2016-max(birthyear)  from Seattle_cycles_trip where birthyear is not null 
select * from Seattle_cycles_trip where  birthyear = 
(select max(birthyear) from seattle_cycles_trip) --shows that a 17 yo rode in 2016
--12) how many total trips started and ended at the same station? 
select count(distinct trip_id) from Seattle_cycles_trip 
where to_station_id = from_station_id
--13) how many unique bikes were rented per year by short term pass holders? 
select count(distinct bikeid) as noofbikes, 
year(starttime) from Seattle_cycles_trip 
where usertype = 'Short-Term Pass Holder'
group by year(starttime)
--14) what is the earliest and latest dates we have in the Seattle_weather_conditions table?
select min(date), max(date) from Seattle_weather_conditions
--15) calculate the difference in temperature on each day between 
--the maximum (F) and minimum (F), then sort your results to 
--discover on which date(s) this difference was largest
select Max_Temperature_F-Min_TemperatureF as diff,  
date from Seattle_weather_conditions
order by diff DESC
--16) summarise the average humidity per month (all years) 
select avg(mean_humidity) as avghumidity, month(date) as month 
from Seattle_weather_conditions
group by month(date) 
--17) which month(s) in 2015 saw the highest max windspeed (not gusts) recorded? 
select max(Max_Wind_Speed_MPH) as topwindspeed, month(date) as month 
from Seattle_weather_conditions
where year(date) = 2015
group by month(date) 
order by topwindspeed DESC
--18) on how many days were any weather events other than simply rain
--(storm, snow, fog etc.) recorded? 
select count(date) from Seattle_weather_conditions 
where events is not null and events <> 'Rain'
--19) what was the total rainfall accumulation (inches) during the first 3 months of 2016? 
select round(sum(Precipitation_In),2) as totalrain from Seattle_weather_conditions
where year(date) = 2016 and month(date) in(1,2,3)
--20) on how many individual dates was fog reported?  
select count(date) from Seattle_weather_conditions where events like '%fog%'

