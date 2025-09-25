#include <stdlib.h>
#define	EXIT_FAILURE	1	/* Failing exit status.  */
#define	EXIT_SUCCESS	0




int main (int argc, char *argv[]){
    int fdsource, fddest;
    if (argc !=3) {
        perror("pas le bon nb d'agruments");
        exit(EXIT_FAILURE);
    }
    if (fdsource=open(argv[1],O_RDONLY)==-1){
        /*erreur*/
        perror("probleme fdsource");
        exit(EXIT_FAILURE);
    }
    if (fddest=open(argv[2],O_WRONLY | O_CREAT| O_TRUNC,0644)==-1){
        /*erreur*/
        perror("probleme fddest");
        exit(EXIT_FAILURE);
    }
    
    /*copier chaque élément du premier fichier dans le 2e */
    


}