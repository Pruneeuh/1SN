#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>

int main (int N) {
    /*créer le tableau*/
    int tab[N];
    for (int i=0; i<N; i++) {
        tab[i]=i;
    }

    /*créer un tube*/
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
    /*!!il attend un signal (qu’il devra ignorer, et qui pourra ˆetre envoy´e via le terminal
    FAIRE AVEC WAIT */
        int tab2[N];
        close(p[1]);
        for (int i=0;i<10;i++) {
            read(p[0],&tab2,sizeof(tab2));
        }
        close(p[0]);
        printf("fin de la lecture du tableau");
    }
    else { /*père*/
        close(p[0]);
        while (1) {
            int retour;
            for (int i=1; i< 10; i++) {
                retour = write(p[1],&tab,sizeof(tab));
            }
            sleep(1);
            printf("valeur retournée par le write %d\n",retour);
        }
        close(p[1]);

    }
}