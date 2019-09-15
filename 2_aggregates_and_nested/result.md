# Assignment 2: Aggregates and Nested Subqueries

## A: Aggregates and Grouping and Ordering:

1. Find the number of instructors who have never taught any course. If the result of your query is empty, add the appropriate data (and include corresponding insert statements) to ensure the result is not empty.

    SELECT COUNT(DISTINCT instructor.ID)
    FROM instructor LEFT JOIN teaches
    ON instructor.ID = teaches.ID
    WHERE teaches.ID IS NULL

Result:

![A 1](/images/2_a_1.png)

2. Find the total capacity of every building in the university.

    SELECT DISTINCT building, (SELECT SUM(c2.capacity)
                               FROM classroom c2
                               WHERE c1.building = c2.building) AS total_capacity
    FROM classroom c1;

    SELECT building, SUM(capacity)
    FROM classroom
    GROUP BY building;


![A 2](/images/2_a_2.png)

3. Find the maximum number of teachers for any single course section.  Your output should be a single number.  For example, if CS-101 section 1 in Spring 2012 had 3 instructors teaching the course, and no other section had more instructors teaching the section, your answer would be 3.

    SELECT t1.course_id, t1.sec_id, t1.semester, t1.year, (SELECT COUNT(DISTINCT t2.ID) 
                                                           FROM teaches t2 
                                                           WHERE t1.course_id = t2.course_id AND 
                                                                 t1.sec_id = t2.sec_id AND 
                                                                 t1.semester = t2.semester AND 
                                                                 t1.year = t2.year) AS total 
    FROM teaches t1;

OR
    SELECT  (SELECT COUNT(DISTINCT t2.ID) 
                                                           FROM teaches t2 
                                                           WHERE t1.course_id = t2.course_id AND 
                                                                 t1.sec_id = t2.sec_id AND 
                                                                 t1.semester = t2.semester AND 
                                                                 t1.year = t2.year) AS total 
    FROM teaches t1;

    SELECT COUNT(DISTINCT ID)
    FROM teaches
    GROUP BY course_id, sec_id, semester, year;

![A 3](/images/2_a_3.png)

4. 


    SELECT d.dept_name, (SELECT COUNT(*) 
                         FROM instructor i  
                         WHERE d.dept_name = i.dept_name) AS noi 
    FROM department d 
    WHERE (SELECT COUNT(*) FROM instructor i WHERE d.dept_name = i.dept_name) > 0 
    ORDER BY -noi;

5. 

    SELECT s.name, (SELECT SUM(c.credits) 
                    FROM takes t INNER JOIN course as c 
                    ON t.course_id = c.course_id 
                    WHERE NOT(t.grade = 'F') AND NOT(t.grade IS NULL) AND s.ID = t.ID) as total_credits 
    FROM student s;


![A 4](/images/2_a_4.png)
 

6. 

    SELECT (SELECT COUNT(DISTINCT s.ID)
            FROM takes as s INNER JOIN teaches as t
            ON (s.course_id, s.sec_id, s.year, s.semester) = (t.course_id, t.sec_id, t.year, t.semester)
            WHERE t.ID = i.ID) as count
    FROM instructor i
    WHERE i.name = "Srinivasan";

7.
    SELECT i.name
    FROM instructor i
    WHERE i.salary = (SELECT MAX(t.salary)
                      FROM instructor t
                      WHERE t.dept_name = i.dept_name);

8.
Number of courses Srini takes

    SELECT COUNT(DISTINCT t.course_id)
    FROM teaches t
    WHERE t.ID = (SELECT ID FROM instructor WHERE name = "Srinivasan")
    
Number of courses student 's' takes taught by srini
    
    SELECT COUNT(*)
    FROM takes AS t INNER JOIN teaches ch
    ON (t.course_id, t.sec_id, t.semester, t.year) = (ch.course_id, ch.sec_id, ch.semester, ch.year)
    WHERE (SELECT ID FROM instructor WHERE name = "Srinivasan") = ch.ID AND t.ID = s.ID

Final Query

    SELECT s.name
    FROM student s
    WHERE (SELECT COUNT(*)
           FROM takes AS t INNER JOIN teaches ch
           ON (t.course_id, t.sec_id, t.semester, t.year) = (ch.course_id, ch.sec_id, ch.semester, ch.year)
           WHERE (SELECT ID FROM instructor WHERE name = "Srinivasan") = ch.ID AND t.ID = s.ID) = 
           (SELECT COUNT(DISTINCT tc.course_id)
            FROM teaches tc
            WHERE tc.ID = (SELECT ID FROM instructor WHERE name = "Srinivasan"));



9.

    SELECT d.dept_name, 
           (SELECT SUM(salary) 
            FROM instructor
            WHERE dept_name = d.dept_name) as amount_spent
    FROM department d;

10.

The maximum number of courses

    WITH instructor_workload AS
    (SELECT i.ID, (SELECT COUNT(DISTINCT course_id)
                   FROM teaches
                   WHERE i.ID = ID) as no_of_courses
     FROM instructor i)
     SELECT DISTINCT s.name 
     FROM student as s INNER JOIN advisor as a
     ON s.ID = a.s_ID
     WHERE a.i_ID = (SELECT ID FROM instructor_workload WHERE no_of_courses = (SELECT MAX(no_of_courses) FROM instructor_workload));


