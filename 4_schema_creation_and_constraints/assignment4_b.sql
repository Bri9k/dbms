DROP DATABASE person;

CREATE DATABASE person;

USE person;

CREATE TABLE person (
	ID CHAR(9) PRIMARY KEY,
	name VARCHAR(20),
	email VARCHAR(20),
	CHECK (email LIKE "*@*")
);

CREATE TABLE remotecentre(
	centreID CHAR(9) PRIMARY KEY,
	college VARCHAR(20),
	town VARCHAR(20),
	state VARCHAR(10)
);

CREATE TABLE programme(
	progID CHAR(9) PRIMARY KEY,
	title VARCHAR(15),
	fromdate DATE,
	todate DATE,
	CHECK (fromdate <= todate)
);

CREATE TABLE coordinator(
	ID CHAR(9),
	FOREIGN KEY (ID) REFERENCES person(ID),
	progID CHAR(9),
	FOREIGN KEY (progID) REFERENCES programme(progID),
	centreID CHAR(9),
	FOREIGN KEY (centreID )REFERENCES remotecentre(centreID)
);

CREATE TABLE participant(
	ID CHAR(9),
	FOREIGN KEY (ID) REFERENCES person(ID),
	progID CHAR(9),
	FOREIGN KEY (progID )REFERENCES programme(progID),
	centreID CHAR(9),
	FOREIGN KEY (centreID) REFERENCES remotecentre(centreID)
);
