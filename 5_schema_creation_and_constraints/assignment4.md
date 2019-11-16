
# Assignment 4: Schema creation and constraints

## A: Constraints

#### 1 The value of timein is always less than or equal to timeout 

Before:

![A_1](A_1.png)
\

        ALTER TABLE trainhalts ADD CHECK (timein <= timeout);

Result:

![A 1](A_after_check.png)
\ 

#### 2  When a train is removed from service, all its halts should be deleted.

        ALTER TABLE trainhalts DROP FOREIGN KEY `trainhalts_ibfk_1`;
        ALTER TABLE trainhalts ADD FOREIGN KEY id REFERENCES train(id) ON DELETE CASCADE;

![A 2](A_addedcascade.png)
\ 

![A_2](A_schemaaftercascade.png)
\ 

#### 3 Insert inconsistent data and verify constraints

* Trying to insert invalid halt

 
        INSERT INTO trainhalts VALUES ("T129", 1, "GPR", "22.19", "22.15");

![A_2](A_failedinsert.png)
\ 




* Inserting valid halts to test cascade

  
        INSERT INTO trainhalts VALUES ("T129", 0, "CST", NULL, "22.00");
        INSERT INTO trainhalts VALUES ("T129", 1, "GPR", "22.10", "22.15");
        INSERT INTO trainhalts VALUES ("T129", 2, "TNA", "22.30", NULL);

![A_2](A_correctinsert.png)
\

![A_2](A_newhalts.png)
\

* Deleting train causes cascade delete of halts

 
        DELETE FROM train WHERE id = "T129";

![A_2](A_cascadedelete.png)
\


## B Schema Creation

Assumptions

1. All 3 IDs are 9 character strings
2. Email is of form (*@*)
3. name, email, college, state are strings having an upper bound on length

The create statements are as follows:


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

Screenshot of schema created

![B_1](schema_created.png)
\

