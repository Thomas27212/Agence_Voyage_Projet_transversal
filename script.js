
/* =========================
   CARROUSEL DES VILLAGES
========================= */

const piste = document.querySelector("#carousel-piste");
const suivant = document.querySelector(".suivant");
const precedent = document.querySelector(".precedent");
const compteur = document.querySelector("#numero-village");

if (piste && suivant && precedent) {

    const cartes = piste.querySelectorAll(".carte-village");

    let position = 0;
    let animation = false;

    function afficherVillage() {

        const largeur = piste.parentElement.clientWidth;

        piste.style.transform = "translateX(-" + position * largeur + "px)";

        compteur.textContent =
            String(position + 1).padStart(2, "0") + " / " +
            String(cartes.length).padStart(2, "0");
    }

    suivant.addEventListener("click", function() {

        if (animation) return;

        animation = true;

        position++;

        if (position >= cartes.length) {
            position = 0;
        }

        afficherVillage();
    });

    precedent.addEventListener("click", function() {

        if (animation) return;

        animation = true;

        position--;

        if (position < 0) {
            position = cartes.length - 1;
        }

        afficherVillage();
    });

    piste.addEventListener("transitionend", function() {
        animation = false;
    });

    window.addEventListener("resize", afficherVillage);

    afficherVillage();
}
