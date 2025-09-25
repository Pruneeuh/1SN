#include <stdio.h>
#include <stdlib.h>
#include "readcmd.h"
#include <stdbool.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <signal.h>

void traitement(int sig) {
    printf("signal reçu : %d \n",sig);
    pid_t pid = waitpid(-1, NULL, WNOHANG|WUNTRACED|WCONTINUED);
    printf("%d \n",pid);                                     
}

int main(void) {
    bool fini= false;
    struct sigaction action;
    action.sa_handler = traitement; 
    action.sa_flags = SA_RESTART;
    sigemptyset(&action.sa_mask);
    sigaction(SIGCHLD,&action,NULL);

    while (!fini) {
        printf("> ");
        struct cmdline *commande= readcmd();

        if (commande == NULL) {
            // commande == NULL -> erreur readcmd()
            perror("erreur lecture commande \n");
            exit(EXIT_FAILURE);
    
        } else {

            if (commande->err) {
                // commande->err != NULL -> commande->seq == NULL
                printf("erreur saisie de la commande : %s\n", commande->err);
        
            } else {

                /* Pour le moment le programme ne fait qu'afficher les commandes 
                   tapees et les affiche à l'écran. 
                   Cette partie est à modifier pour considérer l'exécution de ces
                   commandes 
                */
                int indexseq= 0;
                char **cmd;
                while ((cmd= commande->seq[indexseq])) {
                    if (cmd[0]) {
                        if (strcmp(cmd[0], "exit") == 0) {
                            fini= true;
                            printf("Au revoir ...\n");
                        }
                        else {
                            pid_t pid_fils = fork();
                           // pid_t waitpid(pid_t pid, int *status, int options);
                            //int status;

                            
                            switch (pid_fils) {
                                case -1 : /*erreur*/
                                    exit(EXIT_FAILURE);
                                    break;
                                case 0 : /*fils*/
                                    execvp(cmd[0],cmd);
                                    break;
                                default : 
                                    if (commande->backgrounded == NULL) {
                                        pause();
                                        //int status; 
                                        //waitpid(pid_fils, &status, 0);
                                    }
                                    break;
                            }

                            
                            /*
                            printf("commande : ");
                            int indexcmd= 0;
                            while (cmd[indexcmd]) {
                                printf("%s ", cmd[indexcmd]);
                                
                                indexcmd++;
                            }
                            printf("\n");*/
                        }

                        indexseq++;
                    }
                }
            }
        }
    }
    return EXIT_SUCCESS;
}
