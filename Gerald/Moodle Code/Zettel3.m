%% Header
% LV Name
% LV Nummer
% Übungsblatt #

% Autor:
%   Vorname Nachname
%   Institut/Universität
%   E-Mail-Adresse

%% The mantra
clc
close all
clear all

pts = zeros(13,1);

%% Aufgabe 1
% Lösung
[file, path] = uigetfile(".mat");
PP = load(file).imnData;

% Test
if exist("PP")
    if size(PP) == [312   220    42]
        disp("Aufgabe 1 korrekt")
        pts(1,1) = 1;
    end
end

%% Aufgabe 2
PP_grey = rot90(squeeze(mean(PP,2)));
% Test
if exist("PP_grey")
    if size(PP_grey) == [42 312]
        disp("Aufgabe 2 korrekt")
        pts(2,1) = 1;
    end
end

%% Aufgabe 3
grayIm = PP_grey/max(PP_grey,[],'all');
I = imshow(grayIm);

% Test
if exist("I")
    if size(PP_grey) == [42 312]
        disp("Aufgabe 3 korrekt")
        pts(3,1) = 1;
    end
end

%% Aufgabe 4
% Angabe
close all

% Lösung
I = imshow(grayIm);
hold on
locs = [];
locs = uint8(ginput(2));
pos(1) = locs(1);
pos(2) = locs(3);
pos(3) = max(locs(:,2)) - min(locs(:,2));
pos(4) = max(locs(:,1)) - min(locs(:,1));
r = rectangle('Position',pos,'EdgeColor','g')

xMin = min(locs(:,1));
xMax = max(locs(:,1));
yMin = min(locs(:,2));
yMax = max(locs(:,2));
spectra = PP(xMin:xMax,:,yMin:yMax);

% Test
if exist("I") && exist("r") && exist("spectra")
    if r.EdgeColor == [0 1 0]
        disp("Aufgabe 4 korrekt")
        locs(4,1) = 1;
    end
end

%% Aufgabe 5
% Angabe
specs = [];

% Lösung
line = 1;
for x = 1:size(spectra,1)
    for y = 1:size(spectra,3)
        specs(line,:) = spectra(x,:,y);
        line = line+1;
    end
end


% Test
line = 1;
breakflag = 0;
for x = 1:size(spectra,1)
    for y = 1:size(spectra,3)
        if specs(line,:) ~= spectra(x,:,y);
            disp("Fehler an Koordinaten: X = " +num2str(x)+" und Y = "+num2str(y));            
            breakflag = 1;
            break
        end
        line = line+1;
    end
    if breakflag
        break
    end
end
if x == size(spectra,1) && y == size(spectra,3)
    disp("Aufgabe 5 korrekt")
    pts(5,1) = 1;
end

%% Aufgabe 6
% Angabe
PET = [];
TPU = [];
PE = [];

% Lösung
if size(PET,1) > 0 && size(PE,1) > 0 && size(TPU,1) > 0
    disp("Aufgabe 6 korrekt")
    pts(6,1) = 1;
end


