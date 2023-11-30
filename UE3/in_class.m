[files, path] = uigetfile('.mat', 'MultiSelect', 'on');
addpath(path); % so matlab knows where my files are


lower_thresh = 600;
upper_thresh = 2000;
good_spectra = [];

if ischar(files) 
    files = {files};

end



file = files{i};
load(file)

processed_image = process_image(imnData); %
imshow(processed_image); % displaying the image so i can select a roi
    

bin_im = imbinarize(processed_image);

imshow(bin_im);










   % [~, filename, ~] = fileparts(file); % getting rid of the extension to properly name the new images
   % save(append(filename, '.grey.mat'), 'processed_image'); % exporting the processed data
    











function processed_image = process_image(image)
    
    processed_image = mean(image, 2); % Mittelwert von PP
    processed_image = squeeze(processed_image); % gets rid of dim 1
    processed_image = rot90(processed_image); % Bild rotieren
    processed_image = rescale(processed_image); % Skalierung

end
