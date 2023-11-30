clc
close all
clear all

[filenames, path] = uigetfile('.mat', 'MultiSelect', 'on');
addpath(path); % so matlab knows where my files are

%% load files
for i = 1:size(filenames, 2)
    files{i,1} = extractBefore(filenames{i},".mat"); % erstellt eine cell array bei dem alle files abgespeichert werden. In spaltte 1 wird der name eingetragen.
    files{i,2} = load(filenames{i}).imnData; % in spalte zwei werden die daten eingeladen.

end

%% processing the image

for i = 1:size(files, 1)

    cube = files{} % what does this cube do??


end


cube = files{1,2}; 

processed_image = process_image(cube, 2);
imshow(processed_image);



function processed_image = process_image(image, dim)
    
    processed_image = mean(image, dim); % Mittelwert von PP
    processed_image = squeeze(processed_image); % gets rid of dim 1
    processed_image = rot90(processed_image); % Bild rotieren
    processed_image = rescale(processed_image); % Skalierung

end
 
