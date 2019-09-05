CREATE DATABASE railway;
USE railway;

DROP TABLE trainhalts;
DROP TABLE train;
DROP TABLE track;
DROP TABLE station;

-- This TABLE stores the distances between directly connected stations stcode1 and stcode2.
-- Assume that this represents a directed track. i.e, for two stations A and B, there will be 
-- an entry corresponding to (A, B, distance) and another for (B,A, distance).
CREATE TABLE track
	(stcode1 VARCHAR(5) ,
	stcode2 VARCHAR(5), 
	distance INTEGER ,
	PRIMARY KEY (stcode1,stcode2) );

CREATE TABLE station
	(stcode VARCHAR(5),
	name VARCHAR(20),
	PRIMARY KEY (stcode));

CREATE TABLE train
	(id VARCHAR(5) ,
	name VARCHAR(20),
	PRIMARY KEY (id) );

-- This TABLE contains one row for every halt of a train. 
-- id     : id of the train
-- seqno  : the halt number. Assume that the starting station has seqno as 0
-- stcode : station code of this halt 
-- timein : time at which the train arrives at this station. (will be null for the starting station of a train)
-- timeout: time at which the train departs this station. (will be null for the terminating station of a train)
-- If a train passes through a station without stopping, then there will be an entry with timein = timeout.
CREATE TABLE trainhalts
	(id VARCHAR(5) , 
	seqno INTEGER , 
	stcode VARCHAR(10), 
	timein  VARCHAR(5) ,
	timeout VARCHAR(5) , 
	PRIMARY KEY (id,seqno),
	FOREIGN KEY (id) REFERENCES train(id)); 


