clc
close all
clear all

[filenames, path] = uigetfile('.mat', 'MultiSelect', 'on');
addpath(path); % so matlab knows where my files are

if ischar(filenames)

    filenames = {filenames};

end

pca_matrix = []; 
pca_groups = [];
name_list = {};

%% load files
for i = 1:size(filenames, 2)

    file = filenames{i};
    load(file) % loading the data

    processed_image = process_image(imnData, 2); % using my own function to proccess the data
    imshow(processed_image); % displaying the image so i can select a roi

    points = select_points(imnData); % select points from the image. the points get further processed
    close;
     
    x = linspace(900, 1600, size(points, 2)); % es muss für jeden y wert einen x wert geben
   
    h = figure;
    tiledlayout(2, 2); % tilted layout - i will have a 2 by 2 graph layout

    %% presentation of raw data
    nexttile;

    plot(x, points(1, :));
    title('Raw Data');
    xlabel('Wavelength [nm]');
    ylabel('Intensity');
    
    %% presentation of gradient data
    nexttile;

    fpoint_matrix = []; % creating an empty list to store the gradient point information

    for j = 1:size(points, 1) % this for loop iterates through all points aka clicks and takes the gradient of the points

        fpoints = gradient(points(j, :)); % taking the gradient
        fpoint_matrix = [fpoint_matrix; fpoints]; % storing data

        plot(x, fpoints); % plotting the gradient points

        hold on;

    end

    title('Gradient of the data'); % adding the labels after the for loop because they are only needed once
    xlabel('Wavelength [nm]');
    ylabel('Incline');
    hold off;

    %% presentation of mean value
    nexttile;

    mean_fpoints = mean(fpoint_matrix, 1);
    plot(x, mean_fpoints);
    title('Mean value of the data');
    xlabel('Wavelength [nm]');
    ylabel('Incline');

    %% presentation of normalisation
    nexttile;

    plot(x, smoothdata(normalize(mean_fpoints)));
    title('Normalisation of the mean value');
    xlabel('Wavelength [nm]');
    ylabel('Incline');

    [~, filename, ~] = fileparts(file); % getting rid of the extension to properly name the new images
    writematrix(fpoint_matrix, append(filename, '.processed.xls'));
    
    uiwait(h);

    % filling the empty lists with information
    pca_matrix = [pca_matrix; fpoint_matrix];
    pca_groups = [pca_groups; i * ones(size(fpoint_matrix, 1), 1)];
    name_list = [name_list, filename];

end

%% PCA analysis
tiledlayout(2, 2);

[coeff, score, ~, ~, explained] = pca(pca_matrix);

nexttile;

scatter3(score(:, 1), score(:, 2), score(:, 3), 30, pca_groups, 'filled');
title('PCA Plot');
xlabel('Principal Component 1');
ylabel('Principal Component 2');
zlabel('Principal Component 3'); % the pca plot does not have a legend because i tried for 3 hours to add a legend to the pca plot and i failed. i ll gladly take less point for this but i only have so much patience for one legend.

%% pareto analysis
nexttile;

pareto(explained(:,1));
title('Pareto-Analysis');
ylabel('Cumulative Probability');

%% comparison of the materials
nexttile;

x = linspace(900, 1600, size(fpoint_matrix, 2));
plot(x, fpoint_matrix);
title('Gradient of the data');
xlabel('Wavelength [nm]');
ylabel('Incline');
legend(name_list);

%% processing the image
function processed_image = process_image(image, dim)
    
    processed_image = mean(image, dim); % mean value
    processed_image = squeeze(processed_image); % gets rid of dim 1
    processed_image = rescale(processed_image); % Skalierung

end

function selected = select_points(data)    

    [x, y] = ginput; % this allows me to know the coordinates of the points that i choose. 
    x = round(x);
    y = round(y);

    selected = {};

    for i = 1:numel(x)
        selected = [selected, data(y(i), :, x(i))]; % storing the information of the selected points
    end
    
    selected = cell2mat(selected.');

end
