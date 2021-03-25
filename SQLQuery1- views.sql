Create database ecole
on primary(
name=ecole_data,
filename='G:\DB\ecole.mdf',
size=10MB,
MAXSIZE = 50MB, 
FILEGROWTH = 1MB 
)
log on(
name=ecole_log,
filename='G:\DB\ecole.ldf',
size=5MB,
MAXSIZE = 10MB, 
FILEGROWTH = 1MB 
)
use ecole
create table ETUDIANT(
NEtudiant int PRiMARY KEY,
Nom varchar(25),
Prenom varchar(25)
)
create table MATIERE(
CodeMat int PRiMARY KEY,
LibelleMat varchar(25),
CoeffMat int
)

create table Evaluer(
NEtudiant int foreign key references ETudIANt(NEtudiant),
CodeMat int foreign key references matiere(CodeMat),
dateEva Date,
Note numeric,
primary key(NEtudiant,CodeMat)
)

insert into etudiant values(1,'ALAOUI', 'ALI'),(2,'FARIDI', 'MAJDA'),(3,'AMRAOUI', 'KHALID'),(4,'FATHI', 'AMINA'),(5,'RIDAOUI', 'FAHD'),(6,'MADIH', 'KHADIJA')
select * from etudiant
select * from matiere
insert into matiere values(101, 'POO', 2),(102, 'PS', 2),(103, 'Math', 1),(104, 'SQL', 5),(105, 'HTML', 3)
delete from evaluer
insert into evaluer values(1,101, '03/24/2021',15),(1,102, '03/24/2021',11),
(1,103, '03/24/2021',17),(1,104, '03/24/2021',10),(1,105, '03/24/2021',8)

insert into evaluer values(2,101, '03/24/2021',11),(2,102, '03/24/2021',14),
(2,103, '03/24/2021',14),(2,104, '03/24/2021',16),(2,105, '03/24/2021',13)

insert into evaluer values(3,101, '03/24/2021',16),(3,102, '03/24/2021',11),
(3,103, '03/24/2021',14),(3,104, '03/24/2021',14),(3,105, '03/24/2021',13)

insert into evaluer values(4,101, '03/24/2021',17),(4,102, '03/24/2021',9),
(4,103, '03/24/2021',15),(4,104, '03/24/2021',11),(4,105, '03/24/2021',18)

insert into evaluer values(5,101, '03/24/2021',15),(5,102, '03/24/2021',11),
(5,103, '03/24/2021',14),(5,104, '03/24/2021',10),(5,105, '03/24/2021',10)

insert into evaluer values(6,101, '03/24/2021',16),(6,102, '03/24/2021',18),
(6,103, '03/24/2021',16),(6,104, '03/24/2021',18),(6,105, '03/24/2021',12)

select * from evaluer

--Q1
Select count(*) as 'NBETU' from Etudiant 

--Q2
Select min(note) as 'NoteMIN', max(note) as 'noteMAX' from evaluer

--Q3
Create View MGETU
as
Select etudiant.Netudiant, matiere.LibelleMat, AVG(evaluer.note) as 'MoyEtuMat'
from Evaluer, matiere, etudiant
where evaluer.codeMat= matiere.codeMat AND evaluer.Netudiant=Etudiant.Netudiant
Group by Etudiant.Netudiant, matiere.LibelleMat

--Q4
Select libelleMat, AVG(MoyEtuMat) as 'MoyETUmat'
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
Select etudiant.NEtudiant, nom, Prenom, MoyGen 
from MGETUQ5, etudiant
where etudiant.Netudiant= MGETUQ5.Netudiant 
		and MoyGen>=(Select AVG(MoyGen)from MGETUQ5)

select * from MGETU

select * from MGETUQ5