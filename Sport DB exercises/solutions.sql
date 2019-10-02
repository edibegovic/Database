	-- Query 1
select name, record 
from Sports
order by name;

-- Query 2
select distinct name 
from Sports S join Results R on S.ID = R. sportID; 

-- Query 3
select count(distinct R.peopleID)
from Results R; 

-- Query 4
select P.ID, P.name
from People P join Results R on P.ID = R.peopleID
group by P.ID
having count(*) >= 20;

-- Query 5
select distinct P.ID, P.name, G.description
from People P 
	join Gender G on P.gender = G.gender
	join Results R on P.ID = R.peopleID 
	join Sports S on S.ID = R.sportID
where R.result = S.record;

-- Query 6
select S.name, count(distinct R.peopleID) as numathletes
from Results R join Sports S on S.ID = R.sportID
where R.result = S.record
group by S.ID;

-- Query 7
select P.ID, P.name, max(R.result) as best, S.record-max(R.result) as difference
from People P 
	join Results R on P.ID = R.peopleID 
	join Sports S on S.ID = R.sportID
where S.name = 'Triple Jump'
group by P.ID, P.name, S.record
having count(*) >= 20;

select P.ID, P.name, max(R.result) as best, 
	to_char(S.record-max(R.result), '0D99') as difference
from People P 
	join Results R on P.ID = R.peopleID 
	join Sports S on S.ID = R.sportID
where S.name = 'Triple Jump'
group by P.ID, P.name, S.record
having count(*) >= 20;

-- Query 8
select distinct P.ID, P.name, G.description
from People P
	join Gender G on P.gender = G.gender
	join Results R on P.ID = R.peopleID
	join Competitions C on C.ID = R.competitionID
where C.place = 'Hvide Sande' and extract(year from C.held) = 2009;

-- Query 9
select P.name, G.description
from People P
	join Gender G on P.gender = G.gender
where P.name like '% J%sen';
	
-- Query 10
select P.name, S.name, 
	case when R.result is not null 
	then to_char(100*R.result/S.record, '990D99%') 
	else null 
	end as percentage
from People P 
	join Results R on P.ID = R.peopleID 
	join Sports S on S.ID = R.sportID;
