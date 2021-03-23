Create database Gestion_Notes

use Gestion_Notes

create table ETUDIANT(
NETUDIANT int primary key,
Nom varchar(20),
Prenom varchar(20));

create table MATIERE(
CodeMat varchar(10) primary key,
LibelleMat varchar(20),
CoeffMat int);

create table EVALUER(
NETUDIANT int,
CodeMat varchar(10),
Date_ Date,
Note float,
CONSTRAINT FK_NETUDIANT FOREIGN KEY (NETUDIANT)
    REFERENCES ETUDIANT(NETUDIANT),
CONSTRAINT FK_CodeMat FOREIGN KEY (CodeMat)
    REFERENCES MATIERE(CodeMat),	
Primary key(NETUDIANT,CodeMat)
);

insert into ETUDIANT values(1001,'mazzouz','chaimae')
insert into ETUDIANT values(2002,'alaoui','salma')
insert into ETUDIANT values(3003,'fatihi','laila')

insert into MATIERE values('1AA1','MATIERE1',3)
insert into MATIERE values('2BB2','MATIERE2',4)
insert into MATIERE values('3CC3','MATIERE3',1)

insert into EVALUER values(1001,'2BB2','2021-01-01',16)
insert into EVALUER values(2002,'1AA1','2021-02-02',15)
insert into EVALUER values(3003,'3CC3','2021-03-03',16)

--Q1
Select count(*) as 'Nombre Etudiants' from Etudiant 

--Q2
Select min(note) as 'basse Note', max(note) as 'Haute note' from evaluer

--Q3
Create View MGETU
as
Select etudiant.Netudiant, MATIERE.LibelleMat, AVG(evaluer.note) as 'MoyEtuMat'
from Evaluer, matiere, etudiant
where evaluer.codeMat= matiere.codeMat AND evaluer.Netudiant=Etudiant.Netudiant
Group by Etudiant.Netudiant, matiere.LibelleMat

--Q4
Select libelleMat, AVG(MoyEtuMat)
from MGETU
Group by LibelleMat

--Q5
Create View MGETUQ5
as 
Select Netudiant, SUM(MoyEtuMat*CoeffMat)/SUM(CoeffMat) As 'MoyGen'
From MGETU,Matiere
Where Matiere.libelleMat=MGETU.libelleMat
GROUP BY Netudiant
--Q6

Select AVG(MoyGen) as 'MoyGenPro' from MGETUQ5

--Q7
Select etudiant.NETUDIANT, nom, Prenom, MoyGen 
from MGETUQ5, etudiant
where etudiant.Netudiant= MGETUQ5.Netudiant 
		and MoyGen>=(Select AVG(MoyGen)from MGETUQ5)