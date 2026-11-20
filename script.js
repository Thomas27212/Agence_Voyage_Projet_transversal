const piste = document.querySelector("#carousel-piste");
const suivant = document.querySelector(".suivant");
const precedent = document.querySelector(".precedent");
const compteur = document.querySelector("#numero-village");

if (piste && suivant && precedent && compteur) {

    const cartes = piste.querySelectorAll(".carte-village");
    let position = 0;

    function afficherVillage() {
        const largeur = piste.parentElement.clientWidth;
        piste.style.transform = "translateX(-" + position * largeur + "px)";
        compteur.textContent = String(position + 1).padStart(2, "0") + " / " + String(cartes.length).padStart(2, "0");
    }

    suivant.addEventListener("click", function() {
        position++;
        if (position >= cartes.length) {
            position = 0;
        }
        afficherVillage();
    });

    precedent.addEventListener("click", function() {
        position--;
        if (position < 0) {
            position = cartes.length - 1;
        }
        afficherVillage();
    });

    window.addEventListener("resize", afficherVillage);

    afficherVillage();
}

function imageIntrouvable(image) {
    image.hidden = true;
    const secours = image.parentElement.querySelector(".image-manquante");
    if (secours) {
        secours.hidden = false;
    }
}

const images = document.querySelectorAll(".carte-village img");

images.forEach(function(image) {
    image.addEventListener("error", function() {
        imageIntrouvable(image);
    });
    if (image.complete && image.naturalWidth === 0) {
        imageIntrouvable(image);
    }
});

const formulaire = document.querySelector("#formulaire-recherche");

if (formulaire) {

    const choixPays = document.querySelector("#pays");
    const choixVillage = document.querySelector("#village");
    const choixClan = document.querySelector("#clan");
    const resultats = document.querySelector("#resultats");
    const texte = document.querySelector("#texte-resultat");

    const villages = {
        feu: ["Konohagakure"],
        vent: ["Sunagakure"],
        eau: ["Kirigakure"],
        foudre: ["Kumogakure"],
        terre: ["Iwagakure"]
    };

    const clans = {
        Konohagakure: ["Uchiha", "Hyuga", "Uzumaki", "Nara"],
        Sunagakure: ["Sabaku"]
    };

    function remplirListe(select, valeurs, premierTexte) {
        select.innerHTML = "";
        const premiere = document.createElement("option");
        premiere.value = "";
        premiere.textContent = premierTexte;
        select.appendChild(premiere);
        valeurs.forEach(function(valeur) {
            const option = document.createElement("option");
            option.value = valeur;
            option.textContent = valeur;
            select.appendChild(option);
        });
    }

    choixPays.addEventListener("change", function() {
        const liste = villages[choixPays.value] || [];
        remplirListe(choixVillage, liste, "Tous les villages");
        remplirListe(choixClan, [], "Tous les clans");
    });

    choixVillage.addEventListener("change", function() {
        const liste = clans[choixVillage.value] || [];
        remplirListe(choixClan, liste, "Tous les clans");
    });

    formulaire.addEventListener("submit", function(event) {
        event.preventDefault();
        let message = "Votre aventure ninja : ";
        if (choixVillage.value) {
            message = message + choixVillage.value;
        } else if (choixPays.value) {
            message = message + choixPays.options[choixPays.selectedIndex].textContent;
        } else {
            message = message + "toutes les destinations";
        }
        if (choixClan.value) {
            message = message + ", clan " + choixClan.value;
        }
        texte.textContent = message + " !";
        resultats.hidden = false;
    });
}