-- ==========================================
-- 1. Insertion des Pays (Les 5 grandes nations + Pays des Vagues)
-- ==========================================
INSERT INTO Pays (nom) VALUES
('Pays du Feu'),
('Pays du Vent'),
('Pays de l''Eau'),
('Pays de la Foudre'),
('Pays de la Terre'),
('Pays des Vagues');

-- ==========================================
-- 2. Insertion des Villes (Les villages cachés)
-- Id_Pays : 1=Feu, 2=Vent, 3=Eau, 4=Foudre, 5=Terre, 6=Vagues
-- ==========================================
INSERT INTO Ville (nom, Id_Pays) VALUES
('Konohagakure', 1),
('Sunagakure', 2),
('Kirigakure', 3),
('Kumogakure', 4),
('Iwagakure', 5),
('Port des Vagues', 6);

-- ==========================================
-- 3. Insertion des Circuits touristiques
-- ==========================================
INSERT INTO Circuit (descriptif, villeDepart, dateDepart, nbrplacesDisponible, duree,villeArrivee, dateArrivee, prixInscription) VALUES
('Tour des 5 Grandes Nations Shinobi', 'Konohagakure', '2026-11-01', '20', '30 jours','Iwagakure','2026-11-31', '500000 Ryos'),
('Pèlerinage au Pays du Feu', 'Konohagakure', '2026-10-20', '10', '7 jours','Kumogakure','2026-11-31', '150000 Ryos'),
('Découverte du Pays du Vent', 'Sunagakure', '2026-12-05', '15', '10 jours','Kirigakure','2026-11-31', '200000 Ryos');

-- ==========================================
-- 4. Insertion des Utilisateurs (Génération suivante)
-- ==========================================
INSERT INTO Utilisatreur (nom, prenom, isadmin, mail, date_naissance) VALUES
('Uzumaki', 'Boruto', True, 'boruto@konoha.mail', '2010-10-10'),
('Uchiha', 'Sarada', False, 'sarada@konoha.mail', '2010-03-21'),
('Nara', 'Shikadai', False, 'shikadai@konoha.mail', '2010-07-25');



-- ==========================================
-- 6. Insertion des Clans
-- Id_Ville : 1=Konoha, 2=Suna
-- ==========================================
INSERT INTO clan (nom, Id_Ville) VALUES
('Uchiha', 1),
('Hyuga', 1),
('Uzumaki', 1),
('Nara', 1),
('Sabaku', 2);

-- ==========================================
-- 7. Insertion des Étapes des circuits
-- ==========================================
INSERT INTO Etape (ordre, label, pays, ville, descriptif, prixVisite, Id_Ville, Id_Circuit) VALUES
-- Étapes pour le Circuit 1 (Tour des 5 nations)
('1', 'Mont Hokage', 'Pays du Feu', 'Konoha', 'Visite des visages des Hokages', '500 Ryos', 1, 1),
('2', 'Ramens Ichiraku', 'Pays du Feu', 'Konoha', 'Dégustation des meilleurs ramens du monde', '1000 Ryos', 1, 1),
('3', 'Tour Kazekage', 'Pays du Vent', 'Suna', 'Rencontre avec le Kazekage et visite du village', '2000 Ryos', 2, 1),

-- Étapes pour le Circuit 2 (Pays du Feu)
('1', 'Forêt de la Mort', 'Pays du Feu', 'Konoha', 'Visite guidée du terrain de l''examen Chunin', '3000 Ryos', 1, 2),
('2', 'Sanctuaire du Feu', 'Pays du Feu', 'Konoha', 'Cérémonie avec les prêtres du Feu', '1500 Ryos', 1, 2);

-- ==========================================
-- 8. Insertion des Réservations
-- ATTENTION : La contrainte UNIQUE(Id_Circuit) empêche de réserver 2 fois le même circuit.
-- ==========================================
INSERT INTO Reservation (Statut, Date_, Id_Utilisatreur, Id_Circuit) VALUES
('Confirmée', '2026-10-14', 1, 1), -- Boruto réserve le Circuit 1
('En attente', '2026-10-14', 2, 2); -- Sarada réserve le Circuit 2

-- ==========================================
-- 9. Insertion des relations Circuit <-> Pays
-- ==========================================
INSERT INTO circuit_in_pays (Id_Pays, Id_Circuit) VALUES
-- Le Circuit 1 traverse les 5 grandes nations (Pays 1 à 5)
(1, 1), (2, 1), (3, 1), (4, 1), (5, 1),
-- Le Circuit 2 se déroule au Pays du Feu (Pays 1)
(1, 2),
-- Le Circuit 3 se déroule au Pays du Vent (Pays 2)
(2, 3);
