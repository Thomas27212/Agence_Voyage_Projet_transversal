<?php
session_start();

$connexion = mysqli_connect("localhost", "voyage", "voyage123", "naruto_trip");
if (!$connexion) {
    die("Connexion a la base impossible");
}
mysqli_set_charset($connexion, "utf8mb4");

if (isset($_GET["deconnexion"])) {
    session_destroy();
    header("Location: admin.php");
    exit;
}

$erreur = "";

if (isset($_POST["connexion"])) {
    $mail = mysqli_real_escape_string($connexion, $_POST["mail"]);
    $resultat = mysqli_query($connexion, "SELECT * FROM Utilisatreur WHERE mail = '$mail' AND isadmin = 1");
    if ($resultat && mysqli_num_rows($resultat) == 1) {
        $_SESSION["admin"] = true;
    } else {
        $erreur = "Ce mail ne correspond pas a un admin";
    }
}

if (!isset($_SESSION["admin"])) {
?>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion admin</title>
    <link rel="stylesheet" href="admin.css">
</head>
<body>
    <div class="boite-connexion">
        <h1>🍥 Naruto Travel</h1>
        <h2>Connexion admin</h2>
        <?php if ($erreur != "") { ?>
            <p class="message"><?php echo $erreur; ?></p>
        <?php } ?>
        <form method="post">
            <label for="mail">Mail admin</label>
            <input type="email" id="mail" name="mail" required>
            <button type="submit" name="connexion">Se connecter</button>
        </form>
        <a href="voyage.html">Retour au site</a>
    </div>
</body>
</html>
<?php
    exit;
}

$tables = array(
    "Pays" => array("nom"),
    "Ville" => array("nom", "Id_Pays"),
    "Circuit" => array("descriptif", "villeDepart", "dateDepart", "nbrplacesDisponible", "duree", "villeArrivee", "dateArrivee", "prixInscription", "nombre_place"),
    "Etape" => array("ordre", "label", "pays", "ville", "descriptif", "prixVisite", "Id_Ville", "Id_Circuit"),
    "Utilisatreur" => array("nom", "prenom", "isadmin", "mail", "date_naissance"),
    "Reservation" => array("Statut", "Date_", "nombre_place_reserve", "Id_Utilisatreur", "Id_Circuit"),
    "clan" => array("nom", "Id_Ville"),
    "circuit_in_pays" => array("Id_Pays", "Id_Circuit")
);

$cles = array(
    "Pays" => "Id_Pays",
    "Ville" => "Id_Ville",
    "Circuit" => "Id_Circuit",
    "Etape" => "Id_Etape",
    "Utilisatreur" => "Id_Utilisatreur",
    "Reservation" => "Id_Reservation",
    "clan" => "Id_clan"
);

$dates = array("dateDepart", "dateArrivee", "date_naissance", "Date_");
$nombres = array("nbrplacesDisponible", "duree", "nombre_place", "ordre", "nombre_place_reserve");
$prix = array("prixInscription", "prixVisite");
$liens = array("Id_Pays" => "Pays", "Id_Ville" => "Ville", "Id_Circuit" => "Circuit", "Id_Utilisatreur" => "Utilisatreur");

$table = "Pays";
if (isset($_GET["table"]) && array_key_exists($_GET["table"], $tables)) {
    $table = $_GET["table"];
}

$message = "";

if (isset($_POST["enregistrer"], $_POST["table"]) && array_key_exists($_POST["table"], $tables)) {
    $table = $_POST["table"];
    $id = isset($_POST["id"]) ? $_POST["id"] : "";
    $colonnes = array();
    $valeurs = array();
    foreach ($tables[$table] as $champ) {
        $valeur = isset($_POST[$champ]) ? trim($_POST[$champ]) : "";
        if ($valeur === "") {
            $valeurs[] = "NULL";
        } else {
            $valeurs[] = "'" . mysqli_real_escape_string($connexion, $valeur) . "'";
        }
        $colonnes[] = $champ;
    }
    if ($id == "" || !isset($cles[$table])) {
        $requete = "INSERT INTO $table (" . implode(", ", $colonnes) . ") VALUES (" . implode(", ", $valeurs) . ")";
    } else {
        $morceaux = array();
        foreach ($tables[$table] as $i => $champ) {
            $morceaux[] = $champ . " = " . $valeurs[$i];
        }
        $id = (int) $id;
        $requete = "UPDATE $table SET " . implode(", ", $morceaux) . " WHERE " . $cles[$table] . " = $id";
    }
    if (mysqli_query($connexion, $requete)) {
        header("Location: admin.php?table=" . $table);
        exit;
    }
    $message = "Enregistrement impossible, verifiez les valeurs";
}

if (isset($_GET["supprimer"])) {
    if ($table == "circuit_in_pays") {
        $pays = (int) $_GET["pays"];
        $circuit = (int) $_GET["circuit"];
        $requete = "DELETE FROM circuit_in_pays WHERE Id_Pays = $pays AND Id_Circuit = $circuit";
    } else {
        $id = (int) $_GET["supprimer"];
        $requete = "DELETE FROM $table WHERE " . $cles[$table] . " = $id";
    }
    if (mysqli_query($connexion, $requete)) {
        header("Location: admin.php?table=" . $table);
        exit;
    }
    $message = "Suppression impossible, cette ligne est utilisee dans une autre table";
}

$ligne = null;
if (isset($_GET["modifier"]) && isset($cles[$table])) {
    $id = (int) $_GET["modifier"];
    $resultat = mysqli_query($connexion, "SELECT * FROM $table WHERE " . $cles[$table] . " = $id");
    $ligne = mysqli_fetch_assoc($resultat);
}

function optionsLiees($connexion, $champ, $selection) {
    global $liens;
    $tableLiee = $liens[$champ];
    $resultat = mysqli_query($connexion, "SELECT * FROM $tableLiee");
    $html = "";
    while ($ligneLiee = mysqli_fetch_assoc($resultat)) {
        $id = $ligneLiee[$champ];
        if ($tableLiee == "Utilisatreur") {
            $nom = $ligneLiee["nom"] . " " . $ligneLiee["prenom"];
        } elseif ($tableLiee == "Circuit") {
            $nom = $ligneLiee["descriptif"];
        } else {
            $nom = $ligneLiee["nom"];
        }
        $choisi = "";
        if ($id == $selection) {
            $choisi = " selected";
        }
        $html .= "<option value=\"" . $id . "\"" . $choisi . ">" . htmlspecialchars($nom) . "</option>";
    }
    return $html;
}

$resultat = mysqli_query($connexion, "SELECT * FROM $table");
if (!$resultat) {
    die("Importez d'abord les scripts SQL");
}
$lignes = array();
while ($entree = mysqli_fetch_assoc($resultat)) {
    $lignes[] = $entree;
}
?>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Naruto Travel</title>
    <link rel="stylesheet" href="admin.css">
</head>
<body>

    <header>
        <h1>🍥 Admin Naruto Travel</h1>
        <nav>
            <a href="voyage.html">Retour au site</a>
            <a href="admin.php?deconnexion=1">Deconnexion</a>
        </nav>
    </header>

    <main>

        <div class="onglets">
            <?php foreach ($tables as $nomTable => $champs) { ?>
                <a href="admin.php?table=<?php echo $nomTable; ?>" class="<?php if ($nomTable == $table) { echo "actif"; } ?>"><?php echo $nomTable; ?></a>
            <?php } ?>
        </div>

        <?php if ($message != "") { ?>
            <p class="message"><?php echo $message; ?></p>
        <?php } ?>

        <h2><?php echo $table; ?></h2>

        <div class="zone-table">
            <table>
                <?php if (count($lignes) > 0) { ?>
                    <tr>
                        <?php foreach (array_keys($lignes[0]) as $colonne) { ?>
                            <th><?php echo $colonne; ?></th>
                        <?php } ?>
                        <th>Actions</th>
                    </tr>
                    <?php foreach ($lignes as $entree) { ?>
                        <tr>
                            <?php foreach ($entree as $valeur) { ?>
                                <td><?php echo htmlspecialchars($valeur ?? ""); ?></td>
                            <?php } ?>
                            <td class="actions">
                                <?php if (isset($cles[$table])) { ?>
                                    <a href="admin.php?table=<?php echo $table; ?>&modifier=<?php echo $entree[$cles[$table]]; ?>">Modifier</a>
                                    <a href="admin.php?table=<?php echo $table; ?>&supprimer=<?php echo $entree[$cles[$table]]; ?>" class="supprimer">Supprimer</a>
                                <?php } else { ?>
                                    <a href="admin.php?table=circuit_in_pays&pays=<?php echo $entree["Id_Pays"]; ?>&circuit=<?php echo $entree["Id_Circuit"]; ?>" class="supprimer">Supprimer</a>
                                <?php } ?>
                            </td>
                        </tr>
                    <?php } ?>
                <?php } else { ?>
                    <tr>
                        <td>Aucune ligne</td>
                    </tr>
                <?php } ?>
            </table>
        </div>

        <h2><?php if ($ligne) { echo "Modifier"; } else { echo "Ajouter"; } ?></h2>

        <form method="post" class="formulaire-admin">
            <input type="hidden" name="table" value="<?php echo $table; ?>">
            <input type="hidden" name="id" value="<?php if ($ligne) { echo $ligne[$cles[$table]]; } ?>">
            <?php foreach ($tables[$table] as $champ) { ?>
                <div class="champ-admin">
                    <label for="<?php echo $champ; ?>"><?php echo $champ; ?></label>
                    <?php
                    $valeur = "";
                    if ($ligne) {
                        $valeur = $ligne[$champ];
                    }
                    if (isset($liens[$champ])) {
                    ?>
                        <select id="<?php echo $champ; ?>" name="<?php echo $champ; ?>">
                            <?php echo optionsLiees($connexion, $champ, $valeur); ?>
                        </select>
                    <?php } elseif ($champ == "isadmin") { ?>
                        <select id="isadmin" name="isadmin">
                            <option value="0"<?php if ($valeur == 0) { echo " selected"; } ?>>Non</option>
                            <option value="1"<?php if ($valeur == 1) { echo " selected"; } ?>>Oui</option>
                        </select>
                    <?php } elseif ($champ == "Statut") { ?>
                        <select id="Statut" name="Statut">
                            <?php
                            $statuts = array("En attente", "Confirmée", "Annulée");
                            foreach ($statuts as $statut) {
                                $choisi = "";
                                if ($valeur == $statut) {
                                    $choisi = " selected";
                                }
                                echo "<option value=\"" . $statut . "\"" . $choisi . ">" . $statut . "</option>";
                            }
                            ?>
                        </select>
                    <?php } elseif (in_array($champ, $dates)) { ?>
                        <input type="date" id="<?php echo $champ; ?>" name="<?php echo $champ; ?>" value="<?php echo htmlspecialchars($valeur ?? ""); ?>">
                    <?php } elseif (in_array($champ, $prix)) { ?>
                        <input type="number" step="0.01" id="<?php echo $champ; ?>" name="<?php echo $champ; ?>" value="<?php echo htmlspecialchars($valeur ?? ""); ?>">
                    <?php } elseif (in_array($champ, $nombres)) { ?>
                        <input type="number" id="<?php echo $champ; ?>" name="<?php echo $champ; ?>" value="<?php echo htmlspecialchars($valeur ?? ""); ?>">
                    <?php } else { ?>
                        <input type="text" id="<?php echo $champ; ?>" name="<?php echo $champ; ?>" value="<?php echo htmlspecialchars($valeur ?? ""); ?>">
                    <?php } ?>
                </div>
            <?php } ?>
            <button type="submit" name="enregistrer">Enregistrer</button>
            <?php if ($ligne) { ?>
                <a href="admin.php?table=<?php echo $table; ?>">Annuler</a>
            <?php } ?>
        </form>

    </main>

</body>
</html>