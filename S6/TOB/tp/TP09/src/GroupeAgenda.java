import java.util.List; 

public class GroupeAgenda extends Agenda {
    private ArrayList<AgendaIndividuel> agendas; 

    
    public ajouter(AgendaIndividuel agenda){
        if (agenda != null){
            agendas.add(agenda);
        }
    }

    public enregistrer(int creneau, string rdv) throws OccupeException, CreneauInvalideException{
        boolean dispo = true; 
        for (AgendaIndividuel agenda : agendas){
            try{
                agenda.getRendezVous(creneau);
            }
            catch (LibreException e){
            }
        }
    }

    public String getRendezVous(int creneau) throws LibreException{
        boolean creneauLibre = true;
        boolean rdvDiff = false;
        String rdv;
        try{
            for (AgendaIndividuel agenda : agendas){
                if (rdv !=null){
                    String rdv2= agenda.getRendezVous(creneau); 
                    if (rdv != rdv2){
                        rdvDiff = true;
                    }
                else
                creneauLibre = false;
            }
        }
            catch(LibreException e){
                creneauLibre = true;
            }
        }
        if (rdvDiff = true) {
            return null;
        }
        elsif creneauLibre
    }

}
