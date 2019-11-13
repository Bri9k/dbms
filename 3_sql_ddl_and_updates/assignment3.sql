--- Assignment 3: SQL DDL and Updates


--- 1 Give a 10% hike to all instructors

	UPDATE instructor
	SET salary = salary * (110 / 100);


--- 2 For all instructors who are advisors of atleast 2 students increase salary by 5000

	UPDATE instructor AS ins, 
               (SELECT i_ID
		FROM advisor
		GROUP BY i_ID
		HAVING COUNT(s_ID) >= 2) AS idash)
	SET ins.salary = ins.salary
	WHERE ins.ID = idash.i_ID;


--- B: DDL and DML statements for the following

--- 1 Each offering of a course (i.e. a section) can have many Teaching assistants; each teaching assistant is a student. Extend the existing schema(Add/Alter tables) to accommodate this requirement. 

	CREATE TABLE teaching_assistant
	(ID VARCHAR(5),
	 course_id VARCHAR(8),
	 sec_id VARCHAR(8),
	 semester VARCHAR(6),
	 year DECIMAL(4, 0),
	 PRIMARY KEY (ID, course_id, sec_id, semester, year),
	 FOREIGN KEY (ID) REFERENCES student(ID) ON DELETE CASCADE,
	 FOREIGN KEY (course_id, sec_id, semester, year) REFERENCES section(course_id, sec_id, semester, year) ON DELETE CASCADE);


--- 2 According to the existing schema, one student can have only one advisor. Alter the schema to allow a student to have multiple advisors and make sure that you are able to insert multiple advisors for a student.	


	ALTER TABLE advisor
	DROP PRIMARY KEY,
	DROP FOREIGN KEY advisor_ibfk_1,
	DROP FOREIGN KEY advisor_ibfk_2,
	ADD PRIMARY KEY(s_id, i_id),
	ADD FOREIGN KEY(s_id) REFERENCES student(ID),
	ADD FOREIGN KEY(i_id) REFERENCES instructor(ID);


--- 3 Write SQL queries on the modified schema. You will need to insert data to ensure the query results are not empty.

--- Adding Data

	INSERT INTO instructor (ID, name, dept_name, salary) VALUES ('77777', 'Ashok', 'Physics', 50000);
	INSERT INTO advisor (s_ID, i_ID) VALUES ('12345', '77777');
	INSERT INTO advisor (s_ID, i_ID) VALUES ('12345', '45565');
	INSERT INTO advisor (s_ID, i_ID) VALUES ('12345', '83821');



--- Find all students who have more than 3 advisors

	
	SELECT s.name
	FROM student as s INNER JOIN advisor as a
	ON s.ID = a.s_ID
	GROUP BY s.ID
	HAVING COUNT(*) > 3;

--- Find all students who are co-advised by Prof. Srinivas and Prof. Ashok.


	SELECT s.name
	FROM instructor as i1 INNER JOIN advisor as a1 INNER JOIN student as s INNER JOIN advisor as a2 INNER JOIN instructor as i2
	ON i1.ID = a1.i_ID AND a1.s_ID = s.ID AND s.ID = a2.s_ID AND a2.i_ID = i2.ID
	WHERE i1.name = "Srinivasan" AND i2.name = "Ashok";

--- Find students advised by instructors from different departments. etc.


	SELECT DISTINCT s.name
	FROM instructor as i1 INNER JOIN advisor as a1 INNER JOIN student as s INNER JOIN advisor as a2 INNER JOIN instructor as i2
	ON i1.ID = a1.i_ID AND a1.s_ID = s.ID AND s.ID = a2.s_ID AND a2.i_ID = i2.ID
	WHERE NOT(i1.dept_name = i2.dept_name);

--- 3 Write SQL Queries for the following

--- Delete all information in the database which is more than 10 years old. Add data as necessary to verify your query.

--- Delete the course CS 101.  Any course which has CS 101 as a prereq should remove CS 101 from its prereq set.  Create a cascade constraint to enforce the above rule, and verify that it is working.


	SHOW CREATE TABLE prereq;

	ALTER TABLE prereq
	DROP FOREIGN KEY prereq_ibfk_2,
	ADD FOREIGN KEY (prereq_id) REFERENCES course(course_id) ON DELETE CASCADE;

	DELETE 
	FROM course
	WHERE course_id = "CS-101";


