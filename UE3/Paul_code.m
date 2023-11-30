
addpath 'G:\Meine Ablage\UNI_MASTER\00_MATLAB\Digital Sorting Lab\UE_3'

[filename,path] = uigetfile('.mat'); %Datenimport
addpath(path); % Fügt Pfad hinzu 
PP = load(filename).imnData; %PP laden, 

PP_grey = mean(PP,2); %Mittelwert aus Dimension 2
PP_grey = squeeze(PP_grey); %Squeeze um Größen der Dimension 1 zu entfernen
PP_grey = imrotate(PP_grey,90); %Bild um 90° drehen
PP_grey = rescale(PP_grey); %Maximalwertskalierung


I = imshow(PP_grey); %Ruft Bild auf

zeichne = drawrectangle("Color",'g'); %Rechteck kann mit Maus gezeichnet werden
points = zeichne.Position; %Gibt die Positionen des Rechtecks in Array zurück

%Zugriff auf die Punkte des gezeichneten Rechtecks
x = points(1,1); 
y = points(1,2);
weite = points(1,3);
hoehe = points(1,4);

rectangle('Position', [x, y, weite, hoehe], 'EdgeColor', 'g'); %Lässt Rechteck auf Bild


imshow(PP_grey)
spectra = PP(x:x+weite, : ,y:y+hoehe ); %3 Dimensionales Array in der Größe des Rechtecks wird aus PP Darstellung herausgenommen 
%Nicht aus Grauwertbild nehmen, da dieses nur ein Double Array ist

%% Daten in 2D Array abspeichern
SaveArray=[];
for rows=1:size(spectra,1)
    for cols=1:size(spectra,3)
    SaveArray=[SaveArray; spectra(rows,:,cols)];
    end
end

%% Ansicht der Rohdaten
data=squeeze(PP(144,:,18));
data=gradient(data);
plot(data)