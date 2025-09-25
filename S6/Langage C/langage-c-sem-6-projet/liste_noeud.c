#define _GNU_SOURCE
#include "liste_noeud.h"
#include <stdlib.h>
#include <math.h>

struct liste_noeud_t {
    cellule* premiere_cellule
}

typedef struct _cellule {
    noeud_id_t noeud_actuel;
    float distance; 
    noeud_id_t noeud_precedent;
    _cellule cellule_suivante;
}

liste_noeud creer_liste() {
    liste_noeud liste;
    liste.premiere_cellule = NULL;
}

void detruire_liste(*liste_noeud liste_ptr) {
    free(liste_ptr->premiere_cellule) // pas sûre du tout là 
}

bool est_vide_liste(liste_noeud liste) {
    return liste.premiere_cellule == NULL; 
}

bool contient_noeud_liste(const liste_noeud_t* liste, noeud_id_t noeud) {
    bool contient = false; 
    liste_noued curseur = liste_noeud;
    while (curseur.cellule != NULL | !curseur) {
        if (curseur.cellule.noeud_acteul == noeud) {
            contient = true;
        }
        curseur = curseur.cellule.cellule_suivante; 
    }
}


