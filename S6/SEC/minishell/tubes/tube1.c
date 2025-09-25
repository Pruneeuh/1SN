#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>

int main () {
    int p[2];
    pid_t pid; 

    
    pid = fork();

    if (pid ==-1) { /*erreur*/
        perror("fork");
        exit(3);
    }
    if (pid==0) { /*fils*/
        close(p[1]);
        int val;
        read(p[0],&val,sizeof(val));
        close(p[0]);
        printf("valeur = %d\n",val);
    }
    else { /*père*/
        if (pipe(p)==-1) {
        perror("erreur pipe");
        exit(2);
        }
        close(p[0]);
        int val = 1;
        write(p[1],&val,sizeof(val));
        close(p[1]);
    }
}