Select count(*) as 'Nombre Etudiants' from Etudiant 

Select min(note) as 'basse Note', max(note) as 'Haute note' from evaluer

Create View MGETU
as
Select etudiant.Netudiant, matiere.LiblleMat, AVG(evaluer.note) as 'MoyEtuMat'
from Evaluer, matiere, etudiant
where evaluer.codeMat= matiere.codeMat AND evaluer.Netudiant=Etudiant.Netudiant
Group by Etudiant.Netudiant, matiere.LibelleMat

MGETU(Netudiant,LiblleMat, MoyEtuMat)
Select libelleMat, AVG(MoyEtuMat)
from MGETU
Group by LibelleMat

MGETU(Netudiant,LiblleMat, MoyEtuMat)
Create View MGETUQ5
as 
Select Netudiant, SUM(MoyEtuMat*CoeffMat)/SUM(CoeffMat) As 'MoyGen'
From MGETU,Matiere
Where Matiere.libelleMat=MGETU.libelleMat
GROUP BY Netudiant

MGETUQ5(Netudiant,MoyGen)

Select AVG(MoyGen) as 'MoyGenPro' from MGETUQ5


Select Netudiant, nom, Prenom, MoyGen 
from MGETUQ5, etudiant
where etudiant.Netudiant= MGETUQ5.Netudiant 
		and MoyGen>=(Select AVG(MoyGen)from MGETUQ5)







