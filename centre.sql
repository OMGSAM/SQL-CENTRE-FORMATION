SELECT Formation.Titre, Session.Nom AS Nom_Session, Session.Date_Debut, Session.Date_Fin
FROM Formation
INNER JOIN Session ON Formation.ID_Formation = Session.ID_Formation;





Lister les étudiants inscrits dans chacune des formations. Ordonner la liste par titre de formation.
 

  
SELECT Formation.Titre, Etudiant.Nom, Etudiant.Prenom
FROM Formation
INNER JOIN Inscription ON Formation.ID_Formation = Inscription.ID_Formation
INNER JOIN Etudiant ON Inscription.ID_Etudiant = Etudiant.ID_Etudiant
ORDER BY Formation.Titre;





Pour la formation web développement, calculer le nombre d’inscriptions distancielles et présentielles.
 

  
SELECT SUM(CASE WHEN Inscription.Type_Inscription = 'Distancielle' THEN 1 ELSE 0 END) AS Inscriptions_Distancielles,
       SUM(CASE WHEN Inscription.Type_Inscription = 'Présentielle' THEN 1 ELSE 0 END) AS Inscriptions_Présentielles
FROM Formation
INNER JOIN Inscription ON Formation.ID_Formation = Inscription.ID_Formation
WHERE Formation.Titre = 'Web Développement';




Lister les formations dont le nombre d’inscriptions distancielles est supérieur ou égal à 3. Ordonner la liste par le nombre d’inscription.



  
SELECT Formation.Titre, COUNT(Inscription.ID_Inscription) AS Nombre_Inscriptions
FROM Formation
INNER JOIN Inscription ON Formation.ID_Formation = Inscription.ID_Formation
WHERE Inscription.Type_Inscription = 'Distancielle'
GROUP BY Formation.Titre
HAVING COUNT(Inscription.ID_Inscription) >= 3
ORDER BY Nombre_Inscriptions;





Lister pour chaque spécialité active, la liste des formations correspondantes: leurs titres, durée et prix. Ordonner la liste par l’ordre alphabétique descendant du nom de la spécialité.
 
SELECT Specialite.Nom, Formation.Titre, Formation.Duree, Formation.Prix
FROM Formation
INNER JOIN Specialite ON Formation.ID_Specialite = Specialite.ID_Specialite
WHERE Specialite.Active = 1
ORDER BY Specialite.Nom DESC;




Afficher l’union de la liste en N:4 avec la liste des formations dont le nombre d’inscriptions présentiellesest supérieur ou égal à 4.




  
SELECT Formation.Titre, COUNT(Inscription.ID_Inscription) AS Nombre_Inscriptions
FROM Formation
INNER JOIN Inscription ON Formation.ID_Formation = Inscription.ID_Formation
WHERE Inscription.Type_Inscription = 'Présentielle'
GROUP BY Formation.Titre
HAVING COUNT(Inscription.ID_Inscription) >= 4

UNION

SELECT Formation.Titre, COUNT(Inscription.ID_Inscription) AS Nombre_Inscriptions
FROM Formation
INNER JOIN Inscription ON Formation.ID_Formation = Inscription.ID_Formation
WHERE Inscription.Type_Inscription = 'Distancielle'
GROUP BY Formation.Titre
HAVING COUNT(Inscription.ID_Inscription) >= 4;



Calculer le total des prix payés par Année et mois de la date de début des sessions.
 


  
SELECT YEAR(Session.Date_Debut) AS Annee, MONTH(Session.Date_Debut) AS Mois, SUM(Formation.Prix) AS Total_Prix
FROM Formation
INNER JOIN Session ON Formation.ID_Formation = Session.ID_Formation
GROUP BY YEAR(Session.Date_Debut), MONTH(Session.Date_Debut);
