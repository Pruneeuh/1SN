#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#define	EXIT_FAILURE	1	/* Failing exit status.  */
#define	EXIT_SUCCESS	0


// A FINIIIR

int main (int argc, char *argv[]){
    int fdsource, fddest;
    if (argc !=3) {
        perror("pas le bon nb d'agruments");
        exit(EXIT_FAILURE);
    }
    if ((fdsource=open(argv[1],O_RDONLY))==-1){
        /*erreur*/
        perror("probleme fdsource");
        exit(EXIT_FAILURE);
    }
    if ((fddest=open(argv[2],O_WRONLY | O_CREAT| O_TRUNC,0644))==-1){
        /*erreur*/
        perror("probleme fddest");
        exit(EXIT_FAILURE);
    }
    if (dup2(fdsource,0)==-1){
        perror("probleme dup2 fdsource");
        exit(EXIT_FAILURE);
    } 
    if (dup2(fddest,1)==-1){
        perror("probleme dup2 fddest");
        exit(EXIT_FAILURE);
    }
    close(fdsource);
    close(fddest);
    execlp("cat","cat",NULL);
    
    /*copier chaque élément du premier fichier dans le 2e */
    


}