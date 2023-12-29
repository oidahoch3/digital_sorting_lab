clc
close all
clear all

[filenames, path] = uigetfile('.mat', 'MultiSelect', 'on');
addpath(path); % so matlab knows where my files are

if ischar(filenames)

    filenames = {filenames};

end

%% load files
for i = 1:size(filenames, 2)
    
    file = filenames{i};
    load(file)

    processed_image = process_image(imnData, 2);
    imshow(processed_image); % displaying the image so i can select a roi

    points = select_points(imnData);
    close;
     
    x = linspace(900, 1600, numel(points{1})); % es muss für jeden y wert einen x wert geben

    tiledlayout(2, 2);

    nexttile
    plot(x, points{1});
    title ('Raw Data');
    xlabel('Wavelength [nm]');
    ylabel('Intensity');
    
    nexttile
    for j = 1:numel(points)

        fpoints = gradient(points{j});
        plot(x, fpoints);
        title ('Gradient od the data');
        xlabel('Wavelength [nm]');
        ylabel('Intensity');

        hold on

    end

    hold off

    nexttile
    title ('Mean value of the data');
    xlabel('Wavelength [nm]');
    ylabel('Intensity');

    nexttile
    title ('Normalisation of the mean value');
    xlabel('Wavelength [nm]');
    ylabel('Intensity');
    
end

%% processing the image
function processed_image = process_image(image, dim)
    
    processed_image = mean(image, dim); % Mittelwert von PP
    processed_image = squeeze(processed_image); % gets rid of dim 1
    processed_image = rescale(processed_image); % Skalierung

end

function selected = select_points(data)    

    [x, y] = ginput;
    x = round(x);
    y = round(y);

    selected = {};

    for i = 1:numel(x)
        selected = [selected, data(y(i), :, x(i))];
    end

end
