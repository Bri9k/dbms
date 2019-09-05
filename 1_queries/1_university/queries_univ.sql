-- Students whose credits are greater than 100
SELECT name
FROM student
WHERE tot_cred > 100;

-- Course id and grades of Tanaka
SELECT t.course_id, t.grade
FROM student as s INNER JOIN takes as t
ON s.ID = t.ID
WHERE s.name = 'Tanaka';

-- Instructors who teach a course in the CS building
SELECT i.id, i.name
FROM instructor as i INNER JOIN teaches as ch INNER JOIN section as s INNER JOIN department as d
ON i.ID = ch.ID AND ch.sec_id = s.sec_id AND s.building = d.building
WHERE d.dept_name = "Comp. Sci."
GROUP BY i.id;

-- Courses which have taken place in both spring and fall
SELECT c.title
FROM section as s1 INNER JOIN course as c INNER JOIN section as s2
ON c.course_id = s1.course_id AND c.course_id = s2.course_id AND s1.semester = "Spring" AND s2.semester = "Fall"
GROUP BY c.title;

-- Optional

-- Instructors from Comp Sci
SELECT name
FROM instructor
WHERE dept_name = 'Comp. Sci.';

-- Courses taught by Srinivasan
SELECT c.course_id, c.title
FROM course as c INNER JOIN teaches as t INNER JOIN instructor as i
ON c.course_id = t.course_id AND t.ID = i.ID
WHERE i.name = 'Srinivasan';

-- Instructors who taught atleast one course in Spring 2009
SELECT i.name 
FROM instructor as i INNER JOIN section as s INNER JOIN teaches as t
ON i.ID = t.ID AND t.course_id = s.course_id AND t.sec_id = s.sec_id AND t.semester = s.semester AND t.year = s.year
WHERE s.semester = 'Spring' AND s.year = 2009
GROUP BY i.ID;
