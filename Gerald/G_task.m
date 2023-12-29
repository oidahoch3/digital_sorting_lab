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
     
    x = linspace(900, 1600, size(points, 2)); % es muss für jeden y wert einen x wert geben
   
    h = figure;
    tiledlayout(2, 2); % tilted layout - i will have a 2 by 2 graph layout

    %% presentation of raw data
    nexttile

    plot(x, points(1, :));
    title('Raw Data');
    xlabel('Wavelength [nm]');
    ylabel('Intensity');
    
    %% presentation of gradient data
    nexttile

    fpoint_matrix = [];

    for j = 1:size(points, 1)

        fpoints = gradient(points(j, :));
        fpoint_matrix = [fpoint_matrix; fpoints];

        plot(x, fpoints);

        hold on

    end

    title('Gradient of the data');
    xlabel('Wavelength [nm]');
    ylabel('Incline');
    hold off

    %% presentation of mean value
    nexttile

    mean_fpoints = mean(fpoint_matrix, 1);
    plot(x, mean_fpoints);
    title('Mean value of the data');
    xlabel('Wavelength [nm]');
    ylabel('Incline');

    %% presentation of normalisation
    nexttile

    plot(x, smoothdata(normalize(mean_fpoints)))
    title('Normalisation of the mean value');
    xlabel('Wavelength [nm]');
    ylabel('Incline');
    
    uiwait(h);
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
    
    selected = cell2mat(selected.');

end
