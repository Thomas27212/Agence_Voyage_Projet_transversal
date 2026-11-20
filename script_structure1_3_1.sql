CREATE DATABASE IF NOT EXISTS naruto_trip;
USE naruto_trip;

CREATE TABLE Pays(
   Id_Pays INT AUTO_INCREMENT,
   nom VARCHAR(50) NOT NULL,
   PRIMARY KEY(Id_Pays)
);

CREATE TABLE Ville(
   Id_Ville INT AUTO_INCREMENT,
   nom VARCHAR(50) NOT NULL,
   Id_Pays INT NOT NULL,
   PRIMARY KEY(Id_Ville),
   FOREIGN KEY(Id_Pays) REFERENCES Pays(Id_Pays)
);

CREATE TABLE Circuit(
   Id_Circuit INT AUTO_INCREMENT,
   descriptif VARCHAR(255),
   villeDepart VARCHAR(50),
   dateDepart DATE,
   nbrplacesDisponible INT,
   duree INT,
   villeArrivee VARCHAR(50),
   dateArrivee DATE,
   prixInscription DECIMAL(10,2),
   nombre_place INT,
   PRIMARY KEY(Id_Circuit)
);

CREATE TABLE Etape(
   Id_Etape INT AUTO_INCREMENT,
   ordre INT,
   label VARCHAR(100),
   pays VARCHAR(50),
   ville VARCHAR(50),
   descriptif VARCHAR(255),
   prixVisite DECIMAL(10,2),
   Id_Ville INT NOT NULL,
   Id_Circuit INT NOT NULL,
   PRIMARY KEY(Id_Etape),
   FOREIGN KEY(Id_Ville) REFERENCES Ville(Id_Ville),
   FOREIGN KEY(Id_Circuit) REFERENCES Circuit(Id_Circuit)
);

CREATE TABLE Utilisatreur(
   Id_Utilisatreur INT AUTO_INCREMENT,
   nom VARCHAR(50) NOT NULL,
   prenom VARCHAR(50) NOT NULL,
   isadmin BOOLEAN DEFAULT FALSE,
   mail VARCHAR(100) NOT NULL,
   date_naissance DATE,
   PRIMARY KEY(Id_Utilisatreur),
   UNIQUE(mail)
);

CREATE TABLE Reservation(
   Id_Reservation INT AUTO_INCREMENT,
   Statut VARCHAR(20) DEFAULT 'En attente',
   Date_ DATE,
   nombre_place_reserve INT DEFAULT 1,
   Id_Utilisatreur INT NOT NULL,
   Id_Circuit INT NOT NULL,
   PRIMARY KEY(Id_Reservation),
   FOREIGN KEY(Id_Utilisatreur) REFERENCES Utilisatreur(Id_Utilisatreur),
   FOREIGN KEY(Id_Circuit) REFERENCES Circuit(Id_Circuit)
);

CREATE TABLE clan(
   Id_clan INT AUTO_INCREMENT,
   nom VARCHAR(50) NOT NULL,
   Id_Ville INT NOT NULL,
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