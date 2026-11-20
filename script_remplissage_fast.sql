INSERT INTO Pays (nom) VALUES
('Pays du Feu'),
('Pays du Vent'),
('Pays de l''Eau'),
('Pays de la Foudre'),
('Pays de la Terre'),
('Pays des Vagues');

INSERT INTO Ville (nom, Id_Pays) VALUES
('Konohagakure', 1),
('Sunagakure', 2),
('Kirigakure', 3),
('Kumogakure', 4),
('Iwagakure', 5),
('Port des Vagues', 6);

INSERT INTO Circuit (descriptif, villeDepart, dateDepart, nbrplacesDisponible, duree, villeArrivee, dateArrivee, prixInscription, nombre_place) VALUES
('Tour des 5 Grandes Nations Shinobi', 'Konohagakure', '2026-11-01', 19, 30, 'Iwagakure', '2026-12-01', 500000, 20),
('Pèlerinage au Pays du Feu', 'Konohagakure', '2026-10-20', 8, 7, 'Kumogakure', '2026-10-27', 150000, 10),
('Découverte du Pays du Vent', 'Sunagakure', '2026-12-05', 15, 10, 'Kirigakure', '2026-12-15', 200000, 15);

INSERT INTO Utilisatreur (nom, prenom, isadmin, mail, date_naissance) VALUES
('Uzumaki', 'Boruto', 1, 'boruto@konoha.mail', '2010-10-10'),
('Uchiha', 'Sarada', 0, 'sarada@konoha.mail', '2010-03-21'),
('Nara', 'Shikadai', 0, 'shikadai@konoha.mail', '2010-07-25');

INSERT INTO clan (nom, Id_Ville) VALUES
('Uchiha', 1),
('Hyuga', 1),
('Uzumaki', 1),
('Nara', 1),
('Sabaku', 2);

INSERT INTO Etape (ordre, label, pays, ville, descriptif, prixVisite, Id_Ville, Id_Circuit) VALUES
(1, 'Mont Hokage', 'Pays du Feu', 'Konoha', 'Visite des visages des Hokages', 500, 1, 1),
(2, 'Ramens Ichiraku', 'Pays du Feu', 'Konoha', 'Dégustation des meilleurs ramens du monde', 1000, 1, 1),
(3, 'Tour Kazekage', 'Pays du Vent', 'Suna', 'Rencontre avec le Kazekage et visite du village', 2000, 2, 1),
(1, 'Forêt de la Mort', 'Pays du Feu', 'Konoha', 'Visite guidée du terrain de l''examen Chunin', 3000, 1, 2),
(2, 'Sanctuaire du Feu', 'Pays du Feu', 'Konoha', 'Cérémonie avec les prêtres du Feu', 1500, 1, 2);

INSERT INTO Reservation (Statut, Date_, nombre_place_reserve, Id_Utilisatreur, Id_Circuit) VALUES
('Confirmée', '2026-10-14', 1, 1, 1),
('En attente', '2026-10-14', 2, 2, 2);

INSERT INTO circuit_in_pays (Id_Pays, Id_Circuit) VALUES
(1, 1), (2, 1), (3, 1), (4, 1), (5, 1),
(1, 2),
(2, 3);