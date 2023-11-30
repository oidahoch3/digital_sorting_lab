%% Übungseinheit #2 DSL

%% Aufgaben


%% Kommentare und Sections in Matlab erstellen

% Kommentar %% Section

%% For Schleife in Matlab Erstellen
for i = 1:10
    disp(i)
end

%% IF Bedingung in Matlab erstellen
run = 1;
if run == 1
    disp("Läuft")
    run = 0;
end

%% While loop in Matlab erstellen
clc
close all
clear all

run = true;
laufvariable = 0;
while run
    laufvariable = laufvariable + 1;
    disp(laufvariable)
    if laufvariable == 10
        run = false;
        disp("Break")
    end
end


%% Switch in Matlab erstellen
clc
close all
clear all

i = 10;
switch i
    case 0
        disp("Falsch")
    case 1
        disp("Korrekt")
    otherwise
        disp("Nicht abgedeckt")
end

%% Eine Funktionen im Matlab Skript erstellen


%% Aufruf dieser Funktion in einem separaten Matlab Skript


%% Erstellen einer "myPlot" Funktion in Matlab


%% Aufrufen dieser Funktion in einem separaten Matlab Skript


%% Schreiben von Code, der eine beliebige Anzahl an .mat Spektralwürfel in ein Cell Array einläd
clc
close all
clear all
[filenames, path] = uigetfile("MultiSelect","on",".mat");
addpath(path);
for i = 1:size(filenames,2)
    files{i,1} = extractBefore(filenames{i},".mat");
    files{i,2} = load(filenames{i}).imnData;
end
 
%% Schreiben von Code dass einen Spektralwürfel in ein Schwarz Weiß Bild umformt und anzeigt
cube = files{1,2};
im = mean(cube,2);
im = squeeze(im);
im = mat2gray(im);
imshow(im)


%% Schreiben von Code, damit ein Pixel aus dem Spektralgraubild ausgewählt werden kann
imshow(im)
pts = ginput(1);
pts = round(pts);
close gcf

%% ginput öffnen und farbe des Fadenkreuzes auf WEISS umstellen
imshow(im)
pts = myGinput(1);
pts = round(pts);
x = pts(1);
y = pts(2);
close gcf

%% Mit eigener Plot Funktion das Ausgewählte Spektrum darstellen
spectrum = cube(y,:,x);
my_plot(spectrum);



%% Umstellen der Funktion damit Schritgröße, Art und Name geändert werden können
% Die Schritftart soll zufällig aus den installierten Schriften gewählt werden
uint8(rand(1,"single")*10)
d = listfonts;
fontNumber = uint8(rand(1,"single")*10);
font = d{fontNumber};
my_plot(spectrum,font,12,"MyPlot");


%% Schreiben einer Funktion der aus dem Spektralwürfel nur jene Pixel auswählt, die in einem gewählten Helligkeits Intervall sind
lowerThresh = 600;
upperThresh = 2000;

meanImage = mean(cube,2);
binary = meanImage > lowerThresh & meanImage < upperThresh;
imshow(squeeze(binary))
goodSpectra = [];
for x = 1:size(cube,1)
    for y = 1:size(cube,3)
        if binary(x,1,y) > 0
            goodSpectra = [goodSpectra; cube(x,:,y)];
        end
    end
end

%% Darstellen dieser "Guten Spektra" in einem Plot mit Min Max und Mean Spektrum
f = figure()
hold on
plot(max(goodSpectra))
plot(min(goodSpectra))
plot(mean(goodSpectra))

%% Normalisieren dieser Spektren und plotten
nSpectra = normalize(goodSpectra,2);
f = figure()
hold on
plot(max(nSpectra))
plot(min(nSpectra))
plot(mean(nSpectra))

%% Ableiten der normalisierten Spektren und plotten
ndSpectra = gradient(nSpectra,2);
f = figure()
hold on
plot(max(ndSpectra))
plot(min(ndSpectra))
plot(mean(ndSpectra))




%%
clc
clear extractedSpectra
currCube = files{1,2};
for i = 1:size(files,1)
    currCube = files{i,2};
    extractedSpectra{1,i} = extractBefore(filenames{i},".mat");
    extractedSpectra{2,i} = xtrackSpectra(currCube,600,2000);
    extractedSpectra{3,i} = max(extractedSpectra{2,i});
    extractedSpectra{4,i} = mean(extractedSpectra{2,i});
    extractedSpectra{5,i} = min(extractedSpectra{2,i});
end

%%
f = figure()
hold on
for i = 1:size(extractedSpectra,2)
    axes()
    plot(gradient(extractedSpectra{4,i}))
end





%% Hilfsfunktionen
function goodSpectra = xtrackSpectra(cube, lowerThresh, upperThresh)
    lowerThresh = 600;
    upperThresh = 2000;
    
    meanImage = mean(cube,2);
    binary = meanImage > lowerThresh & meanImage < upperThresh;
    goodSpectra = [];
    for x = 1:size(cube,1)
        for y = 1:size(cube,3)
            if binary(x,1,y) > 0
                goodSpectra = [goodSpectra; cube(x,:,y)];
            end
        end
    end
end

%%
function f = my_plot(spectrum, fontName, fontSize, name)
if nargin == 1
    fontName = "Arial";
    fontSize = 12;
    name = "MyPlot";
end
    f = figure("Position",[100 100 1200 800],"Name",name);
    n = linspace(900,1600,size(spectrum,2));
    plot(n, spectrum);
    hold on
    grid minor
    set(gca,"FontName",fontName);
    xlabel("Wavelength [nm]","FontSize",fontSize,"FontName", fontName);
    ylabel("Intensity [ALU]","FontSize",fontSize,"FontName", fontName);
    legend("Spektrum","FontName", fontName,"FontSize",	fontSize);
    title(name,"FontSize",fontSize*2,"FontName", fontName);
end