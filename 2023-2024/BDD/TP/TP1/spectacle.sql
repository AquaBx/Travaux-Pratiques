CREATE TABLE spectacle(numSpec INTEGER PRIMARY KEY, titreSpec TEXT, salle TEXT, metteurEnScene TEXT);
CREATE TABLE jouer(nomActeur TEXT, numSpec INTEGER, PRIMARY KEY(nomActeur,numSpec));
CREATE TABLE representations(date TEXT, heure TEXT, numSpec INTEGER, tarif  REAL, PRIMARY KEY(date,heure,numSpec));


INSERT INTO spectacle VALUES (1,'Becaup de bruit pour rien','Moliere','Andre Antoine');
INSERT INTO spectacle VALUES (2,'L ile des esclaves','Moliere','Charles Dullin');
INSERT INTO spectacle VALUES (3,'Exercices de style','Victor Hugo','Olivier Le Mans');
INSERT INTO spectacle VALUES (20,'Henry VI','Victor Hugo','Olivier Le Mans');
INSERT INTO spectacle VALUES (22,'Histoire de la Princesse','Victor Hugo','Olivier Le Mans');
INSERT INTO spectacle VALUES (50,'La Savetiere Prodigieuse','Anatole France','Alban Ivanov');
INSERT INTO spectacle VALUES (60,'La Tempete','Anatole France','Alban Ivanov');
INSERT INTO spectacle VALUES (65,'L Avare','Anatole France','David Guillon');
INSERT INTO spectacle VALUES (68,'Le Bougeois Gentilhomme','Anatole France','Jean-Marie Bigard');
INSERT INTO spectacle VALUES (75,'Le Malade Imaginaire','Anatole France','Jean-Marie Bigard');


INSERT INTO jouer VALUES ('Xavier Chavari',1);
INSERT INTO jouer VALUES ('Xavier Chavari',2);
INSERT INTO jouer VALUES ('Xavier Chavari',3);
INSERT INTO jouer VALUES ('Xavier Chavari',20);
INSERT INTO jouer VALUES ('Xavier Chavari',22);
INSERT INTO jouer VALUES ('Chantal Gallia',1);
INSERT INTO jouer VALUES ('Chantal Gallia',75);
INSERT INTO jouer VALUES ('Chantal Gallia',68);
INSERT INTO jouer VALUES ('Chantal Gallia',65);
INSERT INTO jouer VALUES ('Chantal Gallia',60);
INSERT INTO jouer VALUES ('René Cousinier',2);
INSERT INTO jouer VALUES ('René Cousinier',3);
INSERT INTO jouer VALUES ('René Cousinier',22);
INSERT INTO jouer VALUES ('René Cousinier',60);
INSERT INTO jouer VALUES ('René Cousinier',68);
INSERT INTO jouer VALUES ('Jean Trancene',2);
INSERT INTO jouer VALUES ('Jean Trancene',22);
INSERT INTO jouer VALUES ('Jean Trancene',65);
INSERT INTO jouer VALUES ('Didier Bourdon',65);
INSERT INTO jouer VALUES ('Didier Bourdon',75);




INSERT INTO representations VALUES ('12.2.2013','15h00',1,29.90);
INSERT INTO representations VALUES ('13.2.2013','20h00',2,49.90);
INSERT INTO representations VALUES ('25.2.2013','21h00',2,39.90);
INSERT INTO representations VALUES ('1.3.2013','21h00',2,39.90);
INSERT INTO representations VALUES ('13.3.2013','20h00',2,49.90);
INSERT INTO representations VALUES ('14.3.2013','16h00',2,69.90);
INSERT INTO representations VALUES ('16.3.2013','17h00',2,39.90);
INSERT INTO representations VALUES ('19.3.2013','19h00',2,19.90);
INSERT INTO representations VALUES ('13.2.2013','20h00',3,89.90);
INSERT INTO representations VALUES ('15.2.2013','20h00',2,39.90);
INSERT INTO representations VALUES ('19.2.2013','20h00',2,49.90);
INSERT INTO representations VALUES ('1.2.2013','15h00',20,29.90);
INSERT INTO representations VALUES ('1.2.2013','20h30',20,59.90);
INSERT INTO representations VALUES ('11.2.2013','20h30',20,39.90);
INSERT INTO representations VALUES ('17.2.2013','20h30',20,69.90);
INSERT INTO representations VALUES ('19.2.2013','20h30',20,69.90);
INSERT INTO representations VALUES ('22.2.2013','21h00',20,69.90);
INSERT INTO representations VALUES ('13.3.2013','21h00',22,49.90);
INSERT INTO representations VALUES ('15.3.2013','21h00',22,69.90);
INSERT INTO representations VALUES ('16.3.2013','21h00',50,59.90);
INSERT INTO representations VALUES ('22.3.2013','19h00',50,29.90);
INSERT INTO representations VALUES ('13.4.2013','19h00',50,39.90);
INSERT INTO representations VALUES ('19.4.2013','19h00',50,29.90);
INSERT INTO representations VALUES ('21.4.2013','19h00',60,49.90);
INSERT INTO representations VALUES ('27.4.2013','20h00',60,59.90);
INSERT INTO representations VALUES ('29.4.2013','20h00',60,49.90);
INSERT INTO representations VALUES ('1.5.2013','20h00',60,49.90);
INSERT INTO representations VALUES ('7.5.2013','21h00',60,39.90);
INSERT INTO representations VALUES ('17.5.2013','20h00',60,19.90);
INSERT INTO representations VALUES ('18.5.2013','21h00',60,19.90);
INSERT INTO representations VALUES ('20.5.2013','20h00',60,99.90);
INSERT INTO representations VALUES ('21.5.2013','20h00',60,59.90);
INSERT INTO representations VALUES ('29.5.2013','20h00',60,39.90);
INSERT INTO representations VALUES ('1.6.2013','15h00',60,29.90);
INSERT INTO representations VALUES ('13.6.2013','16h00',60,49.90);
INSERT INTO representations VALUES ('23.6.2013','15h00',65,49.90);
INSERT INTO representations VALUES ('13.7.2013','21h00',65,39.90);
INSERT INTO representations VALUES ('31.8.2013','19h00',68,79.90);
INSERT INTO representations VALUES ('13.9.2013','20h00',68,49.90);
INSERT INTO representations VALUES ('14.9.2013','19h00',68,19.90);
INSERT INTO representations VALUES ('15.9.2013','19h30',75,49.90);
INSERT INTO representations VALUES ('16.9.2013','16h00',75,59.90);
INSERT INTO representations VALUES ('1.10.2013','21h00',75,49.90);
INSERT INTO representations VALUES ('12.10.2013','20h00',75,39.90);