assignment4.pdf:  assignment4.md
	pandoc -o assignment4.pdf assignment4.md

assignment4.html: assignment4.md
	markdown assignment4.md > assignment4.html

dist: assignment4.html assignment4_a.sql assignment4_b.sql assignment4.pdf
	zip  111703013_assignment_4_dbms.zip assignment4.html assignment4_*.sql A_*.png assignment4.pdf

clean: 
	rm assignment4.pdf assignment4.html
