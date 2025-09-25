#ifndef COMPLEX_H
#define COMPLEX_H

// Type utilisateur complexe_t
struct complexe_t {
    double reel;
    double imm; 
}; 
typedef struct complexe_t complexe_t; 


// Fonctions reelle et imaginaire
/**
 * reelle
 * Cette fonction qui à un nombre complexe donné retour sa partie réelle
 *
 * Paramètres : 
     * c     le complexe dont on veut la partie réelle. 
 */
double reelle(complexe_t c);
/**
 * imaginaire
 * Cette fonction qui à un nombre complexe donné retourne sa partie immaginaire
 * 
 * Paramètres : 
 *      c :  le complexe dont on veut la partie immaginaire
 *      
 */
double imaginaire(complexe_t c);

// Procédures set_reelle, set_imaginaire et init
/**
 * set_reelle
 * Cette prodédure modifie la partie réelle du nombre complexe donné avec le nombre réel
donné
 * 
 * Paramètres : 
 *      c :     [in out] le complexe (dont on veut changer la partie réelle)
 *      r :     [in] la nombre réel (qui va correspondre à la partie réelle)
 */
void set_reelle(complexe_t* c, double r);

/**
 * set_imaginaire
 * Cette prodédure modifie la partie immaginaire du nombre complexe donné avec le nombre réel
donné
 * 
 * Paramètres : 
 *      c :     [in out] le complexe (dont on veut changer la partie immaginaire)
 *      i :     [in] la nombre réel (qui va correspondre à la partie immaginaire)
 */
void set_imaginaire(complexe_t* c, double i); 
/**
 * init
 * Cette procédure modifie la partie réelle et la partie immaginaire du nombre complexe donnée avec les deux réels donnés 
 * 
 * Paramètres : 
 *      c :     [in out] le complexe a modifié
 *      r :     [in] la nouvelle partie réelle
 *      i :     [in] la nouvelle partie immaginaire 
 * 
 */
void init(complexe_t* c, double r, double i);

// Procédure copie
/**
 * copie
 * Copie les composasntes du complexe donné en second argument dans celles du premier
 * argument
 *
 * Paramètres :
 *   resultat       [out] Complexe dans lequel copier les composantes
 *   autre          [in]  Complexe à copier
 *
 * Pré-conditions : resultat non null
 * Post-conditions : resultat et autre ont les mêmes composantes
 */
void copie(complexe_t* resultat, complexe_t autre);

// Algèbre des nombres complexes
/**
 * conjugue
 * Calcule le conjugué du nombre complexe op et le sotocke dans resultat.
 *
 * Paramètres :
 *   resultat       [out] Résultat de l'opération
 *   op             [in]  Complexe dont on veut le conjugué
 *
 * Pré-conditions : resultat non-null
 * Post-conditions : reelle(*resultat) = reelle(op), complexe(*resultat) = - complexe(op)
 */
void conjugue(complexe_t* resultat, complexe_t op);

/**
 * ajouter
 * Réalise l'addition des deux nombres complexes gauche et droite et stocke le résultat
 * dans resultat.
 *
 * Paramètres :
 *   resultat       [out] Résultat de l'opération
 *   gauche         [in]  Opérande gauche
 *   droite         [in]  Opérande droite
 *
 * Pré-conditions : resultat non-null
 * Post-conditions : *resultat = gauche + droite
 */
void ajouter(complexe_t* resultat, complexe_t gauche, complexe_t droite);

/**
 * soustraire
 * Réalise la soustraction des deux nombres complexes gauche et droite et stocke le résultat
 * dans resultat.
 *
 * Paramètres :
 *   resultat       [out] Résultat de l'opération
 *   gauche         [in]  Opérande gauche
 *   droite         [in]  Opérande droite
 *
 * Pré-conditions : resultat non-null
 * Post-conditions : *resultat = gauche - droite
 */
void soustraire(complexe_t* resultat, complexe_t gauche, complexe_t droite);

/**
 * multiplier
 * Réalise le produit des deux nombres complexes gauche et droite et stocke le résultat
 * dans resultat.
 *
 * Paramètres :
 *   resultat       [out] Résultat de l'opération
 *   gauche         [in]  Opérande gauche
 *   droite         [in]  Opérande droite
 *
 * Pré-conditions : resultat non-null
 * Post-conditions : *resultat = gauche * droite
 */
void multiplier(complexe_t* resultat, complexe_t gauche, complexe_t droite);

/**
 * echelle
 * Calcule la mise à l'échelle d'un nombre complexe avec le nombre réel donné (multiplication
 * de op par le facteur réel facteur).
 *
 * Paramètres :
 *   resultat       [out] Résultat de l'opération
 *   op             [in]  Complexe à mettre à l'échelle
 *   facteur        [in]  Nombre réel à multiplier
 *
 * Pré-conditions : resultat non-null
 * Post-conditions : *resultat = op * facteur
 */
void echelle(complexe_t* resultat, complexe_t op, float facteur);

/**
 * puissance
 * Calcule la puissance entière du complexe donné et stocke le résultat dans resultat.
 *
 * Paramètres :
 *   resultat       [out] Résultat de l'opération
 *   op             [in]  Complexe dont on veut la puissance
 *   exposant       [in]  Exposant de la puissance
 *
 * Pré-conditions : resultat non-null, exposant >= 0
 * Post-conditions : *resultat = op * op * ... * op
 *                                 { n fois }
 */
void puissance(complexe_t* resultat, complexe_t op, int exposant);

// Module et argument
/**
 * module_carre
 * Fonction qui retourne le carré du module du complexe donné 
 * 
 * Paramètres : 
 *      c : complexe dont on cherche le module au carré
 * 
 */
double module_carre(complexe_t c);

/**
 * module
 * Fonction qui retourne le module du complexe donné 
 * 
 * Paramètres : 
 *      c : complexe dont on cherche le module 
 */
double module(complexe_t c); 
/**
 * argument
 * Fonction qui retourne l'argument du complexe donnée 
 * 
 * Paramètres : 
 *      c : complexe dont on cherche le module 
 */
double argument(complexe_t c);

#endif // COMPLEXE_H



