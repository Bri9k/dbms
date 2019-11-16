ALTER TABLE trainhalts ADD CHECK (timein <= timeout);

ALTER TABLE trainhalts DROP FOREIGN KEY `trainhalts_ibfk_1`;
ALTER TABLE trainhalts ADD FOREIGN KEY id REFERENCES train(id) ON DELETE CASCADE;

INSERT INTO trainhalts VALUES ("T129", 0, "CST", NULL, "22.00") 
INSERT INTO trainhalts VALUES ("T129", 1, "GPR", "22.10", "22.15")
INSERT INTO trainhalts VALUES ("T129", 2, "TNA", "22.30", NULL)
