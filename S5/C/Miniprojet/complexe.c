#include "complexe.h"
#include <math.h>   
#include <stdio.h>        // Pour certaines fonctions trigo notamment

// Implantations de reelle et imaginaire
double reelle(complexe_t c) {
    return c.reel;
}

double imaginaire(complexe_t c){
    return c.imm;
}

// Implantations de set_reelle et set_imaginaire
void set_reelle(complexe_t* c, double r){
    c->reel = r;
}

void set_imaginaire(complexe_t* c, double i){
    c->imm = i;
}

void init(complexe_t* c, double r, double i){
    c->reel = r;
    c->imm = i; 
}

// Implantation de copie
void copie(complexe_t* resultat, complexe_t autre){
    *resultat = autre;
}

// Implantations des fonctions algébriques sur les complexes
void conjugue(complexe_t* resultat, complexe_t op) {
      init(resultat,op.reel,-op.imm);
}

void ajouter(complexe_t* resultat, complexe_t gauche, complexe_t droite){
    complexe_t somme; 

    somme.reel = gauche.reel + droite.reel; 
    somme.imm = gauche.imm + droite.imm; 
    copie(resultat, somme);
}

void soustraire(complexe_t* resultat, complexe_t gauche, complexe_t droite){
    init(&droite, -droite.reel, -droite.imm);
    ajouter(resultat, gauche, droite);
}


void multiplier(complexe_t* resultat, complexe_t gauche, complexe_t droite){
    complexe_t mult; 
    mult.reel = (gauche.reel * droite.reel) - (gauche.imm * droite.imm);
    mult.imm = (gauche.imm * droite.reel) + (gauche.reel * droite.imm);
    copie(resultat,mult);
}


void echelle(complexe_t* resultat, complexe_t op, float facteur){
    op.reel = facteur*op.reel;
    op.imm = facteur*op.imm; 
    copie(resultat,op);
}
void puissance(complexe_t* resultat, complexe_t op, int exposant){
    if (exposant==0){
        init(resultat,1,0);
    }
    else{
        complexe_t calcul; 
        calcul = op; 

        for (int i=0; i< exposant-1; i++){
             multiplier(&calcul, op, calcul); 
        }
        copie(resultat, calcul);
    }
   
}

// Implantations du module et de l'argument
double module_carre(complexe_t c){
    return c.reel*c.reel + c.imm*c.imm;
}

double module(complexe_t c){
    return sqrt(module_carre(c));
}

double argument(complexe_t c){
    return atan2(c.imm, c.reel);
}

