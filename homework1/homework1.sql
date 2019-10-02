
/* 1.1 */
SELECT COUNT(DISTINCT peopleid)
FROM results 
WHERE result is NULL;


/* 1.2 */
SELECT id, name 
FROM people P
WHERE NOT EXISTS
	(SELECT *
	FROM results R WHERE 
	R.peopleid = P.id);

/* 1.3 */
SELECT DISTINCT P.id, P.name
FROM results R 
	JOIN people P on P.id = R.peopleid
	JOIN competitions C on C.id = R.competitionid
	JOIN sports S on S.id = R.sportid
WHERE extract(year from C.held) = 2002 AND extract(MONTH from C.held) = 06
OR S.name = 'High Jump' AND R.result = S.record;

/* 1.4 */
SELECT P.id, P.name
FROM results R
	JOIN people P on P.id = R.peopleid
	JOIN competitions C on C.id = R.competitionid
	JOIN sports S on S.id = R.sportid
WHERE R.result = S.record
AND P.id IN 
	(SELECT peopleid
	FROM results
	GROUP BY peopleid
	HAVING COUNT(sportid) = 1);

/* 1.5 STOLEN FROM GG */ 
SELECT r.sportid, s.name, to_char(r.mr, '990D99') AS maxres
FROM (SELECT sportid, max(result) AS mr
    FROM results
    GROUP BY sportid) AS r
	JOIN sports AS s on(r.sportid = s.ID)
ORDER BY r.sportid;

/* 1.6 */
SELECT P.id, P.name, COUNT(*) as records
FROM results R
	JOIN people P on P.id = R.peopleid
	JOIN sports S on S.id = R.sportid
WHERE S.record = R.result
GROUP BY P.id
HAVING COUNT(DISTINCT S.id) >= 2;

/* 1.7 */
SELECT P.id, P.name, P.height, R.result, S.name, (case when (R.result = S.record) = 'TRUE' then 'YES' else 'NO' end)  as "record?"
FROM results R
	JOIN people P on P.id = R.peopleid
	JOIN sports S on S.id = R.sportid
	JOIN (SELECT max(result), sportid FROM results GROUP BY sportid) AS L ON R.sportid = L.sportid
WHERE R.result = L.max
GROUP BY P.id, S.id, R.result

/* 1.8 */
SELECT COUNT(*) 
FROM (
	SELECT count(*)
	FROM results R
	JOIN competitions C on C.id = R.competitionid
	GROUP BY R.peopleid
	HAVING COUNT(DISTINCT C.place) >= 10
	) AS agg;

/* 1.9 */
SELECT P.id, P.name, COUNT(*)
FROM results R
	JOIN people P on P.id = R.peopleid
	JOIN sports S on S.id = R.sportid
WHERE R.result = S.record
GROUP BY P.id
HAVING COUNT(DISTINCT S.id) = (SELECT COUNT(*) FROM sports);


/* 1.10 */
SELECT DISTINCT S.id, S.name, S.record, min(R.result)
FROM results R
	JOIN people P on P.id = R.peopleid
	JOIN competitions C on C.id = R.competitionid
	JOIN sports S on S.id = R.sportid
GROUP BY S.id
HAVING COUNT(DISTINCT C.place) = (SELECT COUNT(DISTINCT place) FROM competitions);

/* 2.11 */
SELECT COUNT(*)
FROM person
WHERE height IS NULL;

/* 2.12 */
SELECT COUNT(*)
FROM (SELECT COUNT(*) FROM movie M
	JOIN involved I on I.movieid = M.id
	JOIN person P on P.id = I.personid
GROUP BY M.id
HAVING AVG(P.height) > 190) AS agg;

/* 2.13 */
SELECT COUNT(*)
FROM (SELECT movieid
	FROM movie_genre
	GROUP BY movieid, genre 
	HAVING COUNT(*) > 1) AS agg;

/* 2.14 */
SELECT count(DISTINCT P.id)
FROM movie M
	JOIN involved I on I.movieid = M.id
	JOIN person P on P.id = I.personid
WHERE I.role = 'actor'
AND M.id in (SELECT M.id
	FROM movie M
		JOIN involved I on I.movieid = M.id
		JOIN person P on P.id = I.personid
	WHERE P.name = 'Steven Spielberg'
	AND I.role = 'director');


/* 2.15 */
SELECT count(*)
FROM movie M
WHERE M.year = 1999
AND NOT EXISTS (SELECT * FROM involved I WHERE I.movieid = M.id);

/* 2.16 */
SELECT COUNT(*)
FROM (SELECT personid
	FROM (SELECT personid, movieid
		FROM involved
		GROUP BY personid, movieid
		HAVING COUNT(DISTINCT role) = 2) AS agg
	GROUP BY personid
	HAVING COUNT(*) > 1) AS aggg;





