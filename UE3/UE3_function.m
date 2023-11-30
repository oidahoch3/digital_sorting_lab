[files, path] = uigetfile('.mat', 'MultiSelect', 'on');
addpath(path); % so matlab knows where my files are

% without the if statement, the code only works if more than one file is
% selected. If only one file is selected, i have a string. if more than one
% file is selected i have a string array. so if only one file is selected i
% turn it into an array with itself as the only content.

if ischar(files) 
    files = {files};

end

% loop through all the files that i selected in the first step

for i = 1:numel(files)

    file = files{i};
    load(file)

    processed_image = process_image(imnData); %
    imshow(processed_image); % displaying the image so i can select a roi
    spectra = export_area(processed_image);
    
    [~, filename, ~] = fileparts(file); % getting rid of the extension to properly name the new images
    save(append(filename, '.processed.mat'), "spectra"); % exporting the processed data
    
end

close all % closing the displayed pictures after processing them

function processed_image = process_image(image)
    
    processed_image = mean(image, 2); % Mittelwert von PP
    processed_image = squeeze(processed_image); % gets rid of dim 1
    processed_image = rot90(processed_image); % Bild rotieren
    processed_image = rescale(processed_image); % Skalierung

end


function roi = export_area(image)    

    h = drawrectangle('Color', 'green');

    % Wait for the user to finish drawing the rectangle
    wait(h);

    % Create a binary mask for the selected region. The mask is an array of
    % 0 and 1 where 1 is the selected area.
    roi_mask = createMask(h);

    % the bounding box converts the mask into a rectangle which i can then
    % use to tell the crop function which specific rectangle i want to have
    % cropped
    roi_boundingbox = regionprops(roi_mask, 'BoundingBox');
    
    % the regionprops returns different values (e.g. area, centroid, and bounding box)
    % so i need to specifiy which value i want.
    roi = imcrop(image, roi_boundingbox.BoundingBox);
        
end
