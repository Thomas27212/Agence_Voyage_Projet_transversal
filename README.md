# Agence_Voyage_Projet_transversal
repo github du projet transversal debut : 14/10/2026 qui porte sur la creation d'une BDD et d'un site web en rapport avec une agence de voyage reellle ou fictive

1 Il faut redefinir tout les types des variable, ils sont presque tous en varchar 50

2 Il faut verif les cardinalité

3 Il faut finir les exo de requete sql

4 Importer tous les fichier concernant le site





exo sql deja fait : 

exo 6 :  insert into Reservation values (NULL,"Confirmée",now(),1,1)

exo 7 : select Utilisatreur.nom, Utilisatreur.prenom, count(*) from Utilisatreur join Reservation on Utilisatreur.Id_Utilisatreur = Reservation.Id_Reservation where Reservation.Statut = "Confirmée"

exo 8 : select Utilisatreur.nom, Utilisatreur.prenom from Utilisatreur join Reservation on Utilisatreur.Id_Utilisatreur = Reservation.Id_Reservation where Reservation.Date_ = '2025-%'

exo 9 :
