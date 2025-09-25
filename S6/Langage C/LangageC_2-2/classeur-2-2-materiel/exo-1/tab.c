#include "tab.h"
#include <stdlib.h>

// Constante pour la taille initiale
int TAILLE_INIT = 4; 

// Implantation de tab_t
struct tab_t {
    int* tab;
    int taille_allouee;
    int taille_utilisee;
};

// creer
tab_t* creer() {
    tab_t* retour = malloc(sizeof(tab_t));
    retour->taille_allouee = 4;
    retour->taille_utilisee=0;
    int* tab = malloc(retour->taille_allouee* sizeof(int));
    retour->tab = tab;
    return retour;
};

//detruire
void detruire(tab_t* tab) {
    free(tab->tab);
};

//ajouter
void ajouter(tab_t* tab, int elt) {
    if (tab->taille_allouee == tab->taille_utilisee){
        //changer taille alouee
        tab->taille_allouee *=2;
        //reallouer tab
        int* new_tab = (int*)realloc(tab->tab,tab->taille_allouee*sizeof(int));
        if (new_tab != NULL) {
            tab->tab= new_tab;
        }
    }
    tab->tab[tab->taille_utilisee]=elt;
    tab->taille_utilisee++;
};

//supprimer
void supprimer(tab_t* tab, int elt) {
    int estTrouve = 0;
    for (int i=0; i<tab->taille_utilisee; i++){
        if (estTrouve ==1) {
            if (i+1!=tab->taille_utilisee){
                tab->tab[i]=tab->tab[i+1]; 
            }            
        } else if (tab->tab[i]== elt) {
            estTrouve=1;
            tab->tab[i]=tab->tab[i+1]; 
        }
    }
    if (estTrouve == 1) {
        tab->taille_utilisee --;
    }
    
};

//element
int element(tab_t* tab, int id) {
    return tab->tab[id];
};

//taille
int taille(tab_t* tab) {
    return tab->taille_utilisee;
};

//espace
int espace(tab_t* tab) {
    return tab->taille_allouee;
};

//serrer
void serrer(tab_t* tab) {
    if (tab->taille_utilisee > 0){
        
        int* newtab = (int*)realloc(tab->tab,tab->taille_utilisee*sizeof(int));
        if (newtab != NULL) {
            tab->tab = newtab;
        
        }
        tab->taille_allouee=tab->taille_utilisee;
    }
    
};


