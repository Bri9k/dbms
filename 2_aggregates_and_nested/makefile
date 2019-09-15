assignment2.pdf:  assignment2.md
	pandoc -o assignment2.pdf assignment2.md

assignment2.html: assignment2.md
	markdown assignment2.md > assignment2.html

dist: assignment2.pdf assignment2.html assignment2.sql
	tar -czvf 111703013_assignment_2_dbms.tar.gz assignment2.pdf assignment2.html assignment2.sql 2_a_*.png

clean: 
	rm assignment2.pdf assignment2.html
