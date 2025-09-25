#define _GNU_SOURCE
#include "liste_noeud.h"
#include <stdlib.h>
#include <math.h>

struct _cellule {
    noeud_id_t noeud_actuel;
    double distance; 
    noeud_id_t noeud_precedent;
    struct _cellule* cellule_suivante;
};

typedef struct _cellule cellule_t; 

struct liste_noeud_t {
    cellule_t* premiere_cellule;
};

liste_noeud_t* creer_liste() {
    liste_noeud_t* liste= (liste_noeud_t*)malloc(sizeof(liste_noeud_t));
    liste->premiere_cellule = NULL;
    return liste;
}

void detruire_liste(liste_noeud_t** liste) {
    if (liste == NULL || *liste == NULL) {
    return; 
    }
    cellule_t* curseur;
    curseur = (*liste)->premiere_cellule;
    cellule_t* suivant;
    while(curseur != NULL){
        suivant = curseur->cellule_suivante;
        free(curseur);
        curseur = suivant;
    }
    (*liste)->premiere_cellule = NULL;
    free(*liste);
    *liste = NULL;
}

bool est_vide_liste(const liste_noeud_t* liste) {
    return liste->premiere_cellule == NULL; 
}

bool contient_noeud_liste(const liste_noeud_t* liste, noeud_id_t noeud) {
    bool contient = false; 
    cellule_t* curseur;
    curseur = liste->premiere_cellule;
    while (curseur != NULL && !contient) {
        if (curseur->noeud_actuel == noeud) {
            contient = true;
        }
        curseur = curseur->cellule_suivante;
    }
    return contient;
}


bool contient_arrete_liste(const liste_noeud_t* liste, noeud_id_t source, noeud_id_t destination){
    bool existe = false;
    cellule_t* curseur;
    curseur = liste->premiere_cellule;
    if (!est_vide_liste(liste)){
        if (contient_noeud_liste(liste, destination)){
            while (curseur->noeud_actuel != destination){
                curseur = curseur->cellule_suivante;
            } 
            if (curseur->noeud_precedent == source){
                existe = true;
            }    
        }
    } 
    return existe;
}

double distance_noeud_liste(const liste_noeud_t* liste, noeud_id_t noeud){
    cellule_t* curseur;
    curseur = liste->premiere_cellule;
    if (!contient_noeud_liste(liste, noeud)){
        return INFINITY;
    }else{
        while (curseur->noeud_actuel != noeud) {
            curseur = curseur->cellule_suivante;
        }
        return curseur->distance;
    }
}        

noeud_id_t precedent_noeud_liste(const liste_noeud_t* liste, noeud_id_t noeud){
    cellule_t* curseur ;
    curseur = liste->premiere_cellule;
    if (!contient_noeud_liste(liste, noeud)){
        return NO_ID; //idem
    }else{
        while (curseur->noeud_actuel != noeud) {
            curseur = curseur->cellule_suivante;
        }
        return curseur->noeud_precedent;
    }
}

noeud_id_t min_noeud_liste(const liste_noeud_t* liste){
    cellule_t* curseur;
    if (est_vide_liste(liste)) {
        return NO_ID;
    }else{
        curseur = liste->premiere_cellule;
        double min = curseur->distance;
        noeud_id_t noeud_min = curseur->noeud_actuel;
        while (curseur != NULL) {
            if (curseur->distance < min){
                noeud_min = curseur->noeud_actuel;
                min = curseur->distance;
            }
            curseur = curseur->cellule_suivante; 
        }
        return noeud_min;
    }
}

void inserer_noeud_liste(liste_noeud_t* liste, noeud_id_t noeud, noeud_id_t precedent, double distance){
    cellule_t* curseur;
    cellule_t* premiere;    
    if (est_vide_liste(liste)){
        premiere = (cellule_t*)malloc(sizeof(struct _cellule));
        premiere->noeud_actuel = noeud;
        premiere->distance = distance;
        premiere->noeud_precedent = precedent;
        premiere->cellule_suivante = NULL;
        liste->premiere_cellule = premiere;
    } 
    else if (!contient_noeud_liste(liste, noeud)){
        curseur = liste->premiere_cellule;
        while (curseur->cellule_suivante != NULL){
            curseur = curseur->cellule_suivante;
        } 
        cellule_t* nouvelle_cellule;
        nouvelle_cellule = (cellule_t*)malloc(sizeof(struct _cellule));
        if (nouvelle_cellule != NULL) {
            nouvelle_cellule->distance = distance;
            nouvelle_cellule->noeud_precedent = precedent; 
            nouvelle_cellule->noeud_actuel = noeud; 
            nouvelle_cellule->cellule_suivante = curseur->cellule_suivante;
            curseur->cellule_suivante = nouvelle_cellule;
        }   
    }
}

void changer_noeud_liste(liste_noeud_t* liste, noeud_id_t noeud, noeud_id_t precedent, double distance){
    cellule_t* curseur;
    curseur = liste->premiere_cellule;
    if (!contient_noeud_liste(liste, noeud)){
        inserer_noeud_liste(liste,noeud,precedent,distance);
    }else{
        while (curseur->noeud_actuel != noeud){
            curseur = curseur->cellule_suivante;
        }
        curseur->noeud_precedent = precedent;
        curseur->distance = distance; 
    } 
}
      

void supprimer_noeud_liste(liste_noeud_t* liste, noeud_id_t noeud){
    if (liste == NULL || liste->premiere_cellule == NULL) return;

    
    if (contient_noeud_liste(liste, noeud)){
        cellule_t* curseur;
        curseur = liste->premiere_cellule;
        cellule_t* cellule_precedente; 
        cellule_precedente = NULL;
        while (curseur->noeud_actuel != noeud){
            cellule_precedente = curseur;
            curseur = curseur->cellule_suivante;
        }
        if (cellule_precedente == NULL) { //le noeud à supprimer est le premier de la liste
            liste->premiere_cellule = curseur->cellule_suivante;
        }else{
            cellule_precedente->cellule_suivante = curseur->cellule_suivante; 
        }
        free(curseur);
    }
}