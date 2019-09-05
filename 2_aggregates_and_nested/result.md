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

    SELECT DISTINCT building, (SELECT SUM(c2.count)
                               FROM classroom c2
                               WHERE c1.building = c2.building) AS total_capacity
    FROM classroom c1;


![A 2](/images/2_a_2.png)

3.

    SELECT t1.course_id, t1.sec_id, t1.semester, t1.year, (SELECT COUNT(DISTINCT t2.ID) 
                                                           FROM teaches t2 
                                                           WHERE t1.course_id = t2.course_id AND 
                                                                 t1.sec_id = t2.sec_id AND 
                                                                 t1.semester = t2.semester AND 
                                                                 t1.year = t2.year) AS total 
    FROM teaches t1;

OR
    SELECT MAX(SELECT COUNT(DISTINCT t2.ID) 
               FROM teaches t2 
               WHERE t1.course_id = t2.course_id AND 
               t1.sec_id = t2.sec_id AND 
               t1.semester = t2.semester AND 
               t1.year = t2.year)) AS max_instructors
    FROM teaches t1;

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
 

    

