package allumettes;
import java.util.Arrays;
import java.util.Scanner;


/** Lance une partie des 13 allumettes en fonction des arguments fournis
 * sur la ligne de commande.
 * @author	Xavier Crégut
 * @version	$Revision: 1.5 $
 */
public class Jouer {

	private static final int NBARGUMENTOPTION = 3;

	/** Nombre maximal d'allumettes pouvant être prises. */
	private static final int NBINITIAL = 13;

	/** Lancer une partie. En argument sont donnés les deux joueurs sous
	 * la forme nom@stratégie.
	 * @param args la description des deux joueurs
	 */
	public static void main(String[] args) {
		Arbitre arbitre = null;
		Partie jeu = null;
		Scanner scanner = new Scanner(System.in);

		try {
			verifierNombreArguments(args);
			try {
				Boolean confiant = estConfiant(args);
				String[] decoupage1 = recupererDecoupage(args, 0);
				String[] decoupage2 = recupererDecoupage(args, 1);
				if (decoupage1.length != 2 | decoupage2.length != 2) {
					throw new ConfigurationException("une seule stratégie par joueur");
				}
				String nom1 = recupererNom(decoupage1);
				String nom2 = recupererNom(decoupage2);
				Strategie strategie1 = recupererStrategie(decoupage1, scanner);
				Strategie strategie2 = recupererStrategie(decoupage2, scanner);
				Joueur j1 = new Joueur(nom1, strategie1);
				Joueur j2 = new Joueur(nom2, strategie2);
				if (confiant) {
					arbitre = new ArbitreConfiant(j1, j2);
				} else {
					arbitre = new Arbitre(j1, j2);
				}
				jeu = new Partie(NBINITIAL);
			} catch (ConfigurationException e) {
				System.out.println(e.getMessage());
				afficherUsage();
			}
		if (arbitre != null && jeu != null) {
			arbitre.arbitrer(jeu);
		}
		} catch (ConfigurationException | ArrayIndexOutOfBoundsException e) {
			System.out.println();
			System.out.println("Erreur : " + e.getMessage());
			afficherUsage();
			System.exit(1);
		}
		scanner.close();
	}
	/*Vérifier que le nombre d'arguments donné en ligne de commande est correct
	 * @param args les arguments donné
	 */
	private static void verifierNombreArguments(String[] args) {
		final int nbJoueurs = 2;
		if (args.length < nbJoueurs) {
			throw new ConfigurationException("Trop peu d'arguments : " + args.length);
		}
		if (args.length > nbJoueurs + 1) {
			throw new ConfigurationException("Trop d'arguments : " + args.length);
		}
	}

	/** Afficher des indications sur la manière d'exécuter cette classe. */
	public static void afficherUsage() {
		System.out.println("\n" + "Usage :"
				+ "\n\t" + "java allumettes.Jouer joueur1 joueur2"
				+ "\n\t\t" + "joueur est de la forme nom@stratégie"
				+ "\n\t\t" + "strategie = naif | rapide | expert | humain | tricheur"
				+ "\n"
				+ "\n\t" + "Exemple :"
				+ "\n\t" + "	java allumettes.Jouer Xavier@humain "
					   + "Ordinateur@naif"
				+ "\n"
				);
	}
	/*Déterminer si l'arbitre doit être confiant ou non
	 * @param args arguments de la ligne de commande
	 * @return si l'arbitre est confiant
	 * @throws ConfigurationException usage de la classe n'est pas respecter
	 */
	public static Boolean estConfiant(String[] args) throws ConfigurationException {
			if (args.length == NBARGUMENTOPTION) {
				if (args[0].equals("-confiant")) {
					return true;
				} else {
					System.out.println("option existe pas");
					throw new ConfigurationException("cette option n'existe pas");
				}
			} else {
				return false;
			}
	}

	/* Retourne le découpage d'un des deux joueurs [nomi, strati]
	 * @param args la description des deux joueurs
	 * @param i le numéro du joeur
	 * @return tableau 1er élément : le nom; 2nd élément : la stratégie
	*/
	public static String[] recupererDecoupage(String[] args, Integer i) {
		if (args.length == NBARGUMENTOPTION) {
			args = Arrays.copyOfRange(args, 1, args.length);
		}
		return args[i].split("@");

	}
	/*A partir du découpage de recupererDecoupage retourne le nom du joueur
	 * @param decomposition [nom,strategie]
	 * @return nom du joueur
	*/
	public static String recupererNom(String[] decomposition) {
		return decomposition[0];
	}
	/* A partir du découpage de recupererDecoupage retourne la stratégie
	 * @param decomposition [nom,strategie]
	 * @return strategie du joueur
	*/
	public static Strategie recupererStrategie(String[] decomposition, Scanner scanner) {
			return recupererStrategie(decomposition[1], scanner);
	}

	/*Récupérer la stratégie à partir du la chaine de caractère correspondante
	 * @param strategie chaine de caractère correspondante
	 * @param scanner	le scanner créeer pour cette partie
	 * @return la stratégie associée
	 * @throws ConfigurationException le nom de la stratégie n'est pas conforme
	*/
	private static Strategie recupererStrategie(String strategie, Scanner scanner)
	 throws ConfigurationException {
		switch (strategie) {
			case "naif":
				return new StrategieNaif();
			case "rapide" :
				return new StrategieRapide();
			case "humain" :
				return new StrategieHumain(scanner);
			case "expert" :
				return new StrategieExpert();
			case "tricheur" :
				return new StrategieTricheur();
			default :
				System.out.println("strat mal def");
				throw new ConfigurationException("Type de"
						+ "stratégie mal définie");
		}
	}

}
