#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>

int main () {
    int p[2];
    pid_t pid; 

    if (pipe(p)==-1) {
        perror("erreur pipe");
        exit(2);
    }
    
    
    pid = fork();

    if (pid ==-1) { /*erreur*/
        perror("fork");
        exit(3);
    }
    if (pid==0) { /*fils*/
        int val;
        close(p[1]);
        while ((read(p[0],&val,sizeof(val))) > 0 ) {
            prinf("valeur : %d\n",val);
        }
        close(p[0]);
        printf("sortie de boucle");
    }
    else { /*père*/
        close(p[0]);
        for (int i=1; i< 10; i++) {
            write(p[1],&i,sizeof(i));
        }
        sleep(20);
        close(p[1]);
    }
}