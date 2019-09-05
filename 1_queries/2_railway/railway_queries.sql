-- 1. All pairs of stations at a distance of less than 20km

SELECT stcode1, stcode2 
FROM track
WHERE distance < 20;


-- 2. ids of all trains that have a stop at thane
-- Note: if a train starts at Thane, not considered
-- Order by is to ensure uniqueness, but is not needed in this
-- particular case, where train goes only one way

SELECT t.id 
FROM station as s INNER JOIN trainhalts as t
ON s.stcode = t.stcode
WHERE NOT(t.seqno = 0) AND s.name = "THANE"
ORDER BY s.name;


-- 3. Names of all trains that start from Mumbai

SELECT t.name 
FROM station as st INNER JOIN train as t INNER JOIN trainhalts as h 
ON st.stcode = h.stcode AND h.id = t.id 
WHERE st.name = "MUMBAI" AND h.seqno = 0;

-- Stations in order of visit by train CSR-AMR-LOCAL

SELECT st.name 
FROM station as st INNER JOIN train as t INNER JOIN trainhalts as h
ON st.stcode = h.stcode and h.id = t.id
WHERE t.name = "CST-AMR_LOCAL"
ORDER BY h.seqno;
