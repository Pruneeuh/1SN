package utilisateur;
import java.util.*;

public class Utilisateurs {
        /* */
        private Map<Integer, Utilisateur> utilisateurs; 

        public Utilisateurs() {
                this.utilisateurs = new HashMap<>();
        }

        public void ajouterUtilisateur(Utilisateur util) {
                int numCarte = util.getNumCarte();
                if (utilisateurs.containsKey(numCarte)) {
                        System.out.println("Utilisateur déjà inscrit !\n");
                } else {
                        utilisateurs.put(numCarte, util);
                }
        }

        public void supprimerUtilisatuer(Utilisateur util) {
                utilisateurs.remove(util.getNumCarte());
        }

        public Utilisateur getUtilisateurDansListe(int numeroCarte) {
                return this.utilisateurs.get(numeroCarte);
        }

        public int nbUtilisateurs() {
                return utilisateurs.size();                
        }
        public Utilisateur chercher(int numCarte, String mdp) {
                for (Utilisateur u : utilisateurs.values()) {
                    if (u.connexionValide(numCarte, mdp)) {
                        return u;
                    }
                }
                return null;
            }
}
