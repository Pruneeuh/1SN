#ifndef TAB_H
#define TAB_H

// Type abstrait tab_t
struct tab_t;
typedef struct tab_t tab_t;


/**
 * creer - crée un tab_t avec une taille allouée initiale de 4 et une taille utilisée de 0.
 * Le contenu du tab_t est un tableau alloué dans le tas (de taille 4 initialement)
 *
 * Post-condition : 
 *   - le champ contenu du tab_t est non-NULL et est dans le tas
 *   - taille(resultat) == 0
 *   - espace(resultat) == 4
 *
 * @return tab_t nouvellement créé
 */
tab_t* creer();

/**
 * detruire - détruit le tab_t, c'est-à-dire libère son contenu alloué dans le tas.
 *
 * Pré-conditions : tab != NULL, contenu de tab valide (non NULL et pas déjà libéré)
 * Post-conditions : contenu de tab == NULL, mémoire libérée
 *
 * @param tab [in,out] tab_t à détruire
 */
void detruire(tab_t* tab);

/**
 * ajouter - ajoute un élément à la fin du tab_t, en réallouant le contenu si besoin
 *
 * Pré-conditions : tab != NULL, tab non détruit
 * Post-conditions : 
 *   - element(tab, taille(tab) - 1) == elt
 *   - taille(tab) == \old(taille(tab)) + 1
 *   - si \old(taille(tab)) == \old(espace(tab)), alors espace(tab) == 2 * espace(tab)
 *
 * @param tab [in,out] tab_t dans lequel ajouter l'élément
 * @param elt élément à rajouter
 */
void ajouter(tab_t* tab, int elt); 

/**
 * supprimer - supprimer la première occurence d'un élément s'il existe, ou laisse le
 * tableau inchangé si l'élément n'existe pas.
 *
 * Pré-conditions : tab != NULL, tab non détruit
 * Post-conditions : 
 *   - si elt n'appartient pas à tab, taille(tab) == \old(taille(tab))
 *   - sinon, taille(tab) == \old(taille(tab)) - 1 et nombre d'occurrences de elt dans tab réduit de 1
 *   - espace(tab) == \old(espace(tab))
 *
 * @param tab [in,out] tab_t duquel supprimer l'élément
 * @param elt élément à supprimer
 */
void supprimer(tab_t* tab, int elt);


/**
 * element - récupère l'ième élément dans le tableau.
 *
 * Pré-conditions : tab non détruit, 0 <= id < tab.taille_utilisee
 *
 * @param tab [in] tab dans lequel chercher l'élément
 * @param id indice à récupérer
 */
int element(tab_t* tab, int id); 

/**
 * taille - récupère la taille (utilisée) du tableau.
 * 
 * Pré-conditions : tab non détruit
 * Post-conditions : resultat >= 0
 *
 * @return taille du tableau (nombre d'éléments)
 */
int taille(tab_t* tab); 

/**
 * espace - récupère la taille (en mémoire) du tableau.
 *
 * Pré-conditions : tab non détruit
 * Post-conditions : resultat > 0
 *
 * @return espace occupé par le tableau
 */
int espace(tab_t* tab); 

// serrer
/**
 * serrer - réalloue le tableau de façon à ce que la taille allouée soit égale à
 * la taille utilisée.
 *
 * Pré-conditions : tab != NULL, tab non-détruit
 *  => /!\ taille(tab) peut être égale à 0
 * Post-conditions :
 *   - si taille(tab) > 0 alors taille(tab) == espace(tab)
 *   - sinon, espace(tab) == \old(espace(tab))
 *
 * @param tab [in,out] tab_t à réallouer
 */
void serrer(tab_t* tab);

#endif


