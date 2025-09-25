%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% IMPLANTATION DU BLOC MODULATEUR DEMODULATEUR SANS CANAL
% Mamalet Prune, Avril 2025
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
close all

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PARAMETRES GENERAUX 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Fe=24000;       %Fréquence d'échantillonnage
Te=1/Fe;        %Période d'échantillonnage
Rb=3000;        %Débit binaire souhaité
N=1000;         %Nombre de bits générés

M= 2;         %Ordre de la modulation :           A COMPLETER
Rs= Rb/log2(M);         %Débit symbole :                    A COMPLETER
Ns=Fe/Rs;         %Facteur de suréchantillonnage :    A COMPLETER

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%GENERATION DE L'INFORMATION BINAIRE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bits=randi([0,1],1,N);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%MAPPING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
symboles= 2*bits - 1 ;     % A COMPLETER

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%SURECHANTILLONNAGE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
somme_Diracs_ponderes=kron(symboles,[1 zeros(1,Ns-1)]);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%FILTRAGE DE MISE EN FORME
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Génération de la réponse impulsionnelle du filtre de mise en forme
h= ones(1,Ns);             % A COMPLETER 
%Filtrage de mise en forme
Signal_emis=filter(h,1,somme_Diracs_ponderes);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PAS DE CANAL DE PROPAGATION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Signal_recu=Signal_emis;

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%FILTRAGE DE RECEPTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Réponse impulsionnelle du filtre de réception
hr= h;             % identique au filtre de mise en forme   
%Filtrage de réception
Signal_recu_filtre=filter(hr,1,Signal_recu);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DIAGRAMME DE L'OEIL EN SORTIE DU FILTRE DE RECEPTION SANS BRUIT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
oeil=reshape(Signal_recu_filtre,Ns,length(Signal_recu_filtre)/Ns);
figure
plot(oeil)
title('Tracé du diagramme de l"oeil sans bruit en sortie du filtre de réception')

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%TRACE DE LA REPONSE IMPULSIONNELLE GLOBALE DE LA CHAINE DE TRANSMISSION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
g=conv(h,hr);     % g = h*hr
figure
plot(g)
ylabel('g')
xlabel('Numéros d"échantillons')
grid
title('Tracé de la réponse impulsionnelle globale de la chaine de transmission')

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ECHANTILLONNAGE AU RYTHME SYMBOLE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Choix de n0
n0=input('Choix de n0 pour échantillonnage à n0+mNs ? \n');     
%Echantillonnage à n0+mNs
Signal_echantillonne=Signal_recu_filtre(n0:Ns:end);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DECISIONS SUR LES SYMBOLES 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
symboles_recus=sign(Signal_echantillonne);
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%CALCUL DU TAUX D'ERREUR SYMBOLE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
long_TES = min(length(symboles_recus), length(symboles));
TES=sum(symboles_recus(1:long_TES) ~= symboles(1:long_TES)) / long_TES14 %nb de symboles      

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DEMAPPING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bits_recus=(symboles_recus==-1)*0+ (symboles_recus == 1)*1;     

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%CALCUL DU TAUX D'ERREUR BINAIRE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
long_TEB = min(length(bits_recus), min(length(bits))); 
TEB = sum(bits_recus(1:long_TEB) ~= bits(1:long_TEB))/long_TEB %nb de bits erronés sur nb de bits transmis