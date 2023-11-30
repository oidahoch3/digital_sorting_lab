%% create function for plotting
spec = Spectra(1,:)
myPlot(spec)

function myPlot(spec)
    x = linspace(900, 1600, size(spec,2));
    
    hold on
    plot(x, spec);
    xlabel('wavelength');
    ylabel('intensity');
    title('spectrum');

end
