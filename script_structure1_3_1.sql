CREATE TABLE Pays(
   Id_Pays INT AUTO_INCREMENT,
   nom VARCHAR(50) ,
   PRIMARY KEY(Id_Pays)
);

CREATE TABLE Ville(
   Id_Ville INT AUTO_INCREMENT,
   nom VARCHAR(50) ,
   Id_Pays INT NOT NULL,
   PRIMARY KEY(Id_Ville),
   FOREIGN KEY(Id_Pays) REFERENCES Pays(Id_Pays)
);

CREATE TABLE Circuit(
   Id_Circuit INT AUTO_INCREMENT,
   descriptif VARCHAR(50) ,
   villeDepart VARCHAR(50) ,
   dateDepart VARCHAR(50) ,
   nbrplacesDisponible VARCHAR(50) ,
   duree VARCHAR(50) ,
   villeArrivee VARCHAR(50) ,
   dateArrivee VARCHAR(50) ,
   prixInscription VARCHAR(50) ,
   nombre_place INT,
   PRIMARY KEY(Id_Circuit)
);

CREATE TABLE Etape(
   Id_Etape INT AUTO_INCREMENT,
   ordre VARCHAR(50) ,
   label VARCHAR(50) ,
   pays VARCHAR(50) ,
   ville VARCHAR(50) ,
   descriptif VARCHAR(50) ,
   prixVisite VARCHAR(50) ,
   Id_Ville INT NOT NULL,
   Id_Circuit INT,
   PRIMARY KEY(Id_Etape),
   FOREIGN KEY(Id_Ville) REFERENCES Ville(Id_Ville),
   FOREIGN KEY(Id_Circuit) REFERENCES Circuit(Id_Circuit)
);

CREATE TABLE Utilisatreur(
   Id_Utilisatreur INT AUTO_INCREMENT,
   nom VARCHAR(50) ,
   prenom VARCHAR(50) ,
   isadmin BOOLEAN,
   mail VARCHAR(50) ,
   date_naissance VARCHAR(50) ,
   PRIMARY KEY(Id_Utilisatreur)
);

CREATE TABLE Reservation(
   Id_Reservation INT AUTO_INCREMENT,
   Statut VARCHAR(50) ,
   Date_ VARCHAR(50) ,
   nombre_place_reserve INT,
   Id_Utilisatreur INT,
   Id_Circuit INT NOT NULL,
   PRIMARY KEY(Id_Reservation),
   UNIQUE(Id_Circuit),
   FOREIGN KEY(Id_Utilisatreur) REFERENCES Utilisatreur(Id_Utilisatreur),
   FOREIGN KEY(Id_Circuit) REFERENCES Circuit(Id_Circuit)
);

CREATE TABLE clan(
   Id_clan INT AUTO_INCREMENT,
   nom VARCHAR(50) ,
   Id_Ville INT,
   PRIMARY KEY(Id_clan),
   FOREIGN KEY(Id_Ville) REFERENCES Ville(Id_Ville)
);

CREATE TABLE circuit_in_pays(
   Id_Pays INT,
   Id_Circuit INT,
   PRIMARY KEY(Id_Pays, Id_Circuit),
   FOREIGN KEY(Id_Pays) REFERENCES Pays(Id_Pays),
   FOREIGN KEY(Id_Circuit) REFERENCES Circuit(Id_Circuit)
);
