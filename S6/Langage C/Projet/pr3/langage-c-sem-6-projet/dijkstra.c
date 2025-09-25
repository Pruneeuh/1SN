#include "dijkstra.h"
#include <stdlib.h>

/**
 * construire_chemin_vers - Construit le chemin depuis le noeud de départ donné vers le
 * noeud donné. On passe un chemin en entrée-sortie de la fonction, qui est mis à jour
 * par celle-ci.
 *
 * Le noeud de départ est caractérisé par un prédécesseur qui vaut `NO_ID`.
 *
 * Ce sous-programme fonctionne récursivement :
 *  1. Si le noeud a pour précédent `NO_ID`, on a fini (c'est le noeud de départ, le chemin de
 *     départ à départ se compose du simple noeud départ)
 *  2. Sinon, on construit le chemin du départ au noeud précédent (appel récursif)
 *  3. Dans tous les cas, on ajoute le noeud au chemin, avec les caractéristiques associées dans visites
 *
 * @param chemin [in/out] chemin dans lequel enregistrer les étapes depuis le départ vers noeud
 * @param visites [in] liste des noeuds visités créée par l'algorithme de Dijkstra
 * @param noeud noeud vers lequel on veut construire le chemin depuis le départ
 */

void construire_chemin_vers (liste_noeud_t* chemin, liste_noeud_t* visites, noeud_id_t noeud) {
    noeud_id_t np  = precedent_noeud_liste(visites, noeud);
    if (np != NO_ID) {
        construire_chemin_vers(chemin,visites, np);    
        inserer_noeud_liste(chemin, np, precedent_noeud_liste(visites,np),distance_noeud_liste(visites,np));
    }
}

float dijkstra(
    const struct graphe_t* graphe, 
    noeud_id_t source, noeud_id_t destination, 
    liste_noeud_t** chemin) {
    liste_noeud_t* AVisiter= creer_liste(); 
    liste_noeud_t* visites= creer_liste(); 

    inserer_noeud_liste(AVisiter,source,NO_ID,0);
    while (!est_vide_liste(AVisiter)) {
        // recherche du noeud de AVisiter à une distance minimale 
        noeud_id_t nc = min_noeud_liste(AVisiter); 

        // ajouter ce noeud dans Visites / supprimer de AVisiter
        double distance_nc = distance_noeud_liste(AVisiter,nc);
        noeud_id_t precedent_nc = precedent_noeud_liste(AVisiter,nc);
        inserer_noeud_liste(visites,nc,precedent_nc,distance_nc);
        supprimer_noeud_liste(AVisiter, nc);

        // parcours voisins de ce noeud 
        size_t nb_voisins = nombre_voisins(graphe, nc);
        if (nb_voisins>0) { 
            noeud_id_t* voisins = (noeud_id_t*)malloc(nb_voisins*sizeof(noeud_id_t));
            noeuds_voisins(graphe, nc, voisins);
            for (size_t i=0; i<nb_voisins; i++) {
                if (!contient_noeud_liste(visites,voisins[i])){
                    // calcul distance au noeud de départ en passant par ce noeud 
                    double delta_prim = distance_noeud_liste(visites,nc) + noeud_distance(graphe, nc, voisins[i]);
                    double delta = distance_noeud_liste(AVisiter,voisins[i]); // retourne INFINITY si pas dans la liste 
                    // tester si meilleur chemin que le précédent 

                    if (delta_prim < delta) {
                        changer_noeud_liste(AVisiter, voisins[i], nc, delta_prim);
                    }
                } 
            }
            free(voisins);
        } 
    }
    detruire_liste(&AVisiter);
    if (chemin != NULL) {
        *chemin = creer_liste();
        construire_chemin_vers(*chemin,visites,destination); 
        inserer_noeud_liste(*chemin, destination, precedent_noeud_liste(visites,destination),distance_noeud_liste(visites,destination));
        
    }
   
    float distance = distance_noeud_liste(visites, destination);
    detruire_liste(&visites);
    return distance;
}

