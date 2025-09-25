%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMPARAISON DE MODULATEURS BANDE DE BASE
% MAMALET Prune, Avril 2025
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


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%GENERATION DE L'INFORMATION BINAIRE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bits=randi([0,1],1,N);


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%MAPPING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Modulateur 1
M_mod1 = 2;                %Ordre de la modulation         : A COMPLETER
Rs_mod1 = Rb/log2(M_mod1);   %Débit symbole       = Rb           : A COMPLETER
Ns_mod1 = 1/(Rs_mod1*Te);                %Facteur de suréchantillonnage  : = Ts/Te
symboles_mod1= 2*bits -1 ;     %Génération des symboles        : A COMPLETER 

%Modulateur 2
M_mod2= 4;                %Ordre de la modulation         : A COMPLETER
Rs_mod2=Rb/log2(M_mod2);                %Débit symbole                  : A COMPLETER
Ns_mod2=1/(Rs_mod2*Te);                %Facteur de suréchantillonnage  : A COMPLETER
symboles_mod2=bit_a_symbole(bits);     %Génération des symboles        : A COMPLETER 

%Modulateur 3
M_mod3= 2;                %Ordre de la modulation         : A COMPLETER
Rs_mod3 = Rb/log2(M_mod3);                %Débit symbole                  : A COMPLETER
Ns_mod3=1/(Rs_mod3*Te);                %Facteur de suréchantillonnage  : A COMPLETER
symboles_mod3=2*bits -1;          %Génération des symboles        : A COMPLETER 


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%SURECHANTILLONNAGE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Modulateur 1
somme_Diracs_ponderes_mod1=kron(symboles_mod1,[1 zeros(1,Ns_mod1-1)]);

%Modulateur 2
somme_Diracs_ponderes_mod2=kron(symboles_mod2,[1 zeros(1,Ns_mod2-1)]);

%Modulateur 3
somme_Diracs_ponderes_mod3=kron(symboles_mod3,[1 zeros(1,Ns_mod3-1)]);


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%FILTRAGE DE MISE EN FORME (filtres RIF)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Modulateur 1
%Génération de la réponse impulsionnelle du filtre de mise en forme
h_mod1= ones(1,Ns_mod1); % A COMPLETER
%Filtrage de mise en forme
Signal_mod1=filter(h_mod1,1,somme_Diracs_ponderes_mod1);

%Modulateur 2
%Génération de la réponse impulsionnelle du filtre de mise en forme
h_mod2=ones(1,Ns_mod2); % A COMPLETER
%Filtrage de mise en forme
Signal_mod2=filter(h_mod2,1,somme_Diracs_ponderes_mod2);

%Modulator 3
%Génération de la réponse impulsionnelle du filtre de mise en forme
alpha=0.5;
h_mod3= rcosdesign(0.5,9,Ns_mod3); % A COMPLETER
%Filtrage de mise en forme
Signal_mod3=filter(h_mod3,1,somme_Diracs_ponderes_mod3);


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%TRACES DES SIGNAUX
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Modulateur 1
figure
echelle_temporelle=[0:length(Signal_mod1)-1]*Te; % A COMPLETER
plot(echelle_temporelle,Signal_mod1)
xlabel('Temps (s)')
ylabel('Signal transmis, Modulateur 1')

%Modulateur 2
figure
plot(echelle_temporelle,Signal_mod2)
xlabel('Temps (s)')
ylabel('Signal transmis, Modulateur 2')

%Modulateur 3
figure
plot(echelle_temporelle,Signal_mod3)
xlabel('Temps (s)')
ylabel('Signal transmis, Modulateur 3')


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ESTIMATION DES DENSITES SPECTRALES DE PUISSANCE DES SIGNAUX GENERES
%(Estimation par périodogramme de Welch)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Modulateur 1
DSP_mod1=pwelch(Signal_mod1,[],[],[],Fe,'twosided');

%Modulator 2
DSP_mod2=pwelch(Signal_mod2,[],[],[],Fe,'twosided');

%Modulator 3
DSP_mod3=pwelch(Signal_mod3,[],[],[],Fe,'twosided');


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%TRACES DES DSPs POUR COMPARAISON ENTRE ELLES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
echelle_frequentielle=[-Fe/2:Fe/(length(DSP_mod1)-1):Fe/2]; % A COMPLETER
semilogy(echelle_frequentielle,fftshift(DSP_mod1),'b')
hold on
semilogy(echelle_frequentielle,fftshift(DSP_mod2),'r')
semilogy(echelle_frequentielle,fftshift(DSP_mod3),'k')
grid
xlabel('Frequence (Hz)')
ylabel('DSP du signal transmis')
legend('Modulateur 1','Modulateur 2','Modulateur 3')

%% calcul de la bande passante 

%modulateur 1 : 
DSP_dB_1 = 10*log10(fftshift(DSP_mod1)); % calcul de la DSP en db
max_1 = max(DSP_dB_1); %max de la DSP en db 
i_seuil_1 = find(DSP_dB_1 >= (max_1 - 3)); % récupère tous les indices où DSP > max - 3dB
B_1 = echelle_frequentielle(i_seuil_1(end)) - echelle_frequentielle(i_seuil_1(1));
% la bande passante correspond à la palge de fréquence où la DSP est
% supérieur au max -3dB 

%modulateur 2 : 
DSP_dB_2 = 10*log10(fftshift(DSP_mod2)); % calcul de la DSP en db
max_2 = max(DSP_dB_2); %max de la DSP en db 
i_seuil_2 = find(DSP_dB_2 >= (max_2 - 3)); % récupère tous les indices où DSP > max - 3dB
B_2 = echelle_frequentielle(i_seuil_2(end)) - echelle_frequentielle(i_seuil_2(1));

%modulateur 2 : 
DSP_dB_3= 10*log10(fftshift(DSP_mod3)); % calcul de la DSP en db
max_3 = max(DSP_dB_3); %max de la DSP en db 
i_seuil_3 = find(DSP_dB_3>= (max_3 - 3)); % récupère tous les indices où DSP > max - 3dB
B_3 = echelle_frequentielle(i_seuil_3(end)) - echelle_frequentielle(i_seuil_3(1));

%calcul efficacité spectrale 
efficacite_1 = Rb/B_1 
efficacite_2 = Rb/B_2
efficacite_3 = Rb/B_3