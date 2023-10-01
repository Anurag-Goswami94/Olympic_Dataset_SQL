# How many Olympic games have been held?
SELECT COUNT(DISTINCT(Games)) FROM athlete_events;

# List down all the Olympic games held so far?
SELECT distinct(Games), City FROM athlete_events ORDER BY Games ASC;

# Mention the total no. of nations who participated in each Olympic Games?
SELECT COUNT(DISTINCT(NOC)), Games FROM athlete_events GROUP BY Games ORDER BY Games;

# Which year saw the highest and lowest no. of countries participating in Olympic ?

SELECT Year, COUNT(DISTINCT(NOC)) As Total_Countries, Games FROM athlete_events GROUP BY Year, Games ORDER BY Games ASC LIMIT 1; 
SELECT Year, COUNT(DISTINCT(NOC)) As Total_Countries, Games FROM athlete_events GROUP BY Year, Games ORDER BY Games DESC LIMIT 1 ;

# Which nation has participated in all the olympic games?
SELECT DISTINCT(NOC) As Countries, COUNT(DISTINCT(Games)) AS Total_Games FROM athlete_events GROUP BY Countries ORDER BY Total_Games DESC LIMIT 5;

# Identify the sport which was played in all summer olympics ?

with t1 as 
	(SELECT COUNT(DISTINCT(Games)) AS Total_Summer_Games FROM athlete_events WHERE Season='Summer'),
t2 as
	(SELECT DISTINCT Sport, Games FROM athlete_events WHERE Season='Summer' ORDER By Games),
t3 as
	(SELECT sport, count(games) as no_of_games FROM t2 GROUP BY sport)
SELECT * FROM t3 JOIN t1 on t1.Total_Summer_Games= t3.no_of_games;

# Which sports were just played only once in Olympic?
 
select Sport, count(distinct Games) as No_Of_Sports
from athlete_events
group by Sport
Having count(distinct Games)<=1;

# Fetch the total number of sports played in each olympic games?

SELECT COUNT(DISTINCT SPORT), Games FROM athlete_events GROUP BY Games;

# Fetch details of the oldest athletes to win a gold medal?

SELECT Name, MAX(Age), City, Games FROM athlete_events WHERE Medal='Gold' GROUP BY Name, Age, City, Games ORDER BY Age DESC LIMIT 3;

# Find the ratio of Male and Female athletes participated in all olympic games?

with s1 as
	(SELECT COUNT(Sex) AS total_male, Sex, Games FROM athlete_events WHERE Sex= 'M' GROUP BY Sex, Games),
s2 as
	(SELECT COUNT(Sex) AS total_female, Sex, Games FROM athlete_events WHERE Sex= 'F' GROUP BY Sex, Games),
s3 as
	(SELECT concat('1:',SUM(s1.total_male) / SUM(s2.total_female)) AS Ratio FROM s1, s2)
SELECT * FROM s3;

# Fetch the top 5 athletes who won the most gold medals?
SELECT Name, COUNT(Medal) AS most_gold_medal, Team FROM athlete_events WHERE Medal='Gold' GROUP BY Name, Team ORDER BY most_gold_medal DESC LIMIT 5;

# Fetch the top 5 athletes who won the most medals(gold/silver/bronze)?
SELECT Name, Count(Medal) As most_madels,Team FROM athlete_events WHERE Medal != 'NA' GROUP BY Name, Team ORDER BY most_madels DESC LIMIT 5;

# Fetch the top 5 most successful countries in olympics. Success is defined by number of medals won?
SELECT team, COUNT(Medal) as total_medal_won FROM athlete_events WHERE Medal!= 'NA' GROUP BY team ORDER BY total_medal_won DESC LIMIT 5;

# List down total gold, silver and bronze medals won by each country. 
SELECT team, COUNT(Medal) as Total_medals, Medal FROM athlete_events WHERE Medal!= 'Na' GROUP BY team, Medal ORDER BY Total_medals DESC;

# List down total gold, silver and bronze medals won by each country corresponding to each olympic games?

SELECT DISTINCT (athlete_events.NOC),noc_regions.region FROM athlete_events JOIN noc_regions on athlete_events.NOC=noc_regions.NOC;

SELECT  noc_regions.region as country, COUNT(medal) Total_Medal, Medal, games FROM athlete_events JOIN noc_regions on athlete_events.NOC=noc_regions.NOC WHERE Medal!= 'NA' GROUP BY country, games, medal ORDER BY games ASC;

# Breakdown all the olympic games where India won medal for Hockey and how many medals in each olympic game?

SELECT Games, team, sport, COUNT(Medal) AS Total_medals, Medal FROM athlete_events WHERE Team='INDIA' and Sport='Hockey' and Medal!= 'NA' GROUP BY Games, team, sport, Medal ORDER BY Games ASC;

SELECT Games, team, sport, COUNT(Medal) AS Total_medals, Medal FROM athlete_events WHERE Team='INDIA' and Medal!= 'NA' GROUP BY Games, team, sport, Medal ORDER BY Games ASC;
