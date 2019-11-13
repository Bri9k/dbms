assignment3.pdf:  assignment3.md
	pandoc -o assignment3.pdf assignment3.md

assignment3.html: assignment3.md
	markdown assignment3.md > assignment3.html

dist: assignment3.pdf assignment3.html assignment3.sql note.md
	tar -czvf 111703013_assignment_3_dbms.tar.gz assignment3.pdf assignment3.html assignment3.sql 3*.png note.md

clean: 
	rm assignment3.pdf assignment3.html
