%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               TP2 de Traitement Numérique du Signal
%                   SCIENCES DU NUMERIQUE 1A
%                       Fevrier 2025 
%                        Prune Mamalet
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
close all

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PARAMETRES GENERAUX
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
A=1;           %amplitude du cosinus (en V)
f1=1000;       %fréquence du cosinus 1 en Hz
f2=3000;       %fréquence du cosinus 2 en Hz
T1=1/f1;       %période du cosinus 1 en secondes
T2=1/f2;       %période du cosinus 2 en secondes
N=100;          %nombre d'échantillons souhaités pour le cosinus
Nfft = 256;     %nombre d'échantillon pour zéro padding
Fe=10000;      %fréquence d'échantillonnage en Hz
Te=1/Fe;       %période d'échantillonnage en secondes;

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%GENERATION DU SIGNAL A FILTRER
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Définition de l'échelle temporelle
temps=[0:Te:(N-1)*Te];
%Génération de N échantillons d'une somme de cosinus de fréquence f1 et f2
x=A*cos(2*pi*f1*temps) + A*cos(2*pi*f2*temps);

%Tracer le signal
figure
plot(temps,x);
xlabel('Temps (s)')
ylabel('signal')
title(['Tracé d''une somme de cosinus numérique de fréquences f1 et f2 Hz']);

%Tracé de la représentation fréquentielle
X=fft(x,Nfft);

figure
echelle_frequentielle=[0:Fe/(Nfft-1):Fe];
semilogy(echelle_frequentielle,abs(X));
grid
title(['Tracé de la représentation fréquentielle de le somme des deux cosinus']);
xlabel('Fréquence (Hz)')
ylabel('|TFD|')

% si pics vers le bas (autour 2500Hz ici) juste pb de calcul ne s'interresser qu'à la partie de
% base

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%SYNTHESE D'UN FILTRE PASSE-BAS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fc = 1500 ; %fréquence de coupure des filtres

% calcul du filtre 1
ordre1 = 11;
temps1 = [-(ordre1 -1)*Te/2:Te:(ordre1-1)*Te/2];
%h1 = 2*fc*sinc(2*fc*temps).*(0.54+0.46*cos((2*pi*temps)/ordre1)); là on
%multiplie par une fenetre - pas nécessaire ici
h1 = 2*fc/Fe*sinc(2*fc*temps1);
x_filtre1 = filter(h1,1,x);

%calcul du filtre 2
ordre2 = 61;
temps2 = [-(ordre2-1)*Te/2:Te:(ordre2-1)*Te/2];
h2 = 2*fc/Fe*sinc(2*fc*temps2);      
x_filtre2 = filter(h2,1,x);

%tracé de la sortie du filtre en temporel
figure
plot(temps,x_filtre1);
hold on
plot(temps,x_filtre2);
grid
title(['Tracé de la sortie du filtre']);
legend('ordre 11', 'ordre 61')
xlabel('temps (en s)')
ylabel('signal filtré')
%tracé de la réponse impulsionnelle des filtres : 

figure
H1=fft(h1,Nfft);
H2 = fft(h2,Nfft);
semilogy([0:Fe/(Nfft-1):Fe],abs(H1));
hold on 
semilogy([0:Fe/(Nfft-1):Fe],abs(H2));
grid
title(['Tracé réponse impulsionnelle du filtre']);
legend('ordre 11', 'ordre 61')
xlabel('fréquence en Hz')
ylabel('|TFD|')


%calcul de la réponse fréquentielle du filtre
X1 = fft(x_filtre1,Nfft);
X2 = fft(x_filtre2,Nfft);
echelle_freq1 = [0:Fe/(Nfft-1):Fe];
echelle_freq2 = [0:Fe/(Nfft-1):Fe];

%tracé de la réponse en fréquence du filtre
figure
semilogy(echelle_freq1,abs(X1));
hold on
semilogy(echelle_freq2,abs(X2));
grid
title(['Tracé réponse en fréquence du filtre']);
legend('ordre 11', 'ordre 61')
xlabel('fréquence en Hz')
ylabel('|TFD|')

%sur le signal temporel : peut observer le reatrd (plus important quand
%l'odre augmente) qui est du au fait que la réponse impulsionnelle n'est
%pas centrée autour de zéro pour rendre le filtre causale
%on voit bien qu'on a filtré une des fréquence et qu'on a plus qu'un seul
%cos
%sur la réponse temporel : f=3000Hz est bien atténué (plus avec le filtre
%d'odre plus élevé , tandis que f=1000Hz est bien conservé

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%REALISATION DU FILTRAGE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%tracé de la représentation fréquentielle du signal, et des réponses pour
%les 2 filtres
figure
semilogy(echelle_freq1,abs(X1));
hold on
semilogy(echelle_freq2,abs(X2));
hold on
semilogy(echelle_frequentielle,abs(X));
grid
title(['Représentation fréquentielle']);
legend('ordre 11', 'ordre 61','signal d''origine')
xlabel('fréquence en Hz')
ylabel('|TFD|')

%on a bien une atténuation des fréquences supérieures à 1000Hs (f2)
