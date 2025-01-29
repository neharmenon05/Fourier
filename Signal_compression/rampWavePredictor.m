function rampWavePredictor
    % Create figure window
    hFig = figure('Position', [100, 100, 800, 600], 'Name', 'Ramp Wave Predictor');
    
    % Create slider
    hSlider = uicontrol('Style', 'slider', ...
                        'Min', 1, 'Max', 50, 'Value', 1, ...
                        'Position', [150, 50, 500, 20], ...
                        'Callback', @updatePlot);
    
    % Add a label for the slider
    uicontrol('Style', 'text', 'Position', [150, 30, 500, 20], ...
              'String', 'Number of Harmonics');
    
    % Create axes for plotting
    hAxes = axes('Parent', hFig, 'Position', [0.1, 0.3, 0.8, 0.6]);
    
    % Initial plot
    updatePlot();
    
    function updatePlot(~, ~)
        % Get slider value
        nHarmonics = round(get(hSlider, 'Value'));
        
        % Generate ramp wave approximation using Fourier series
        t = linspace(0, 2*pi, 1000);
        rampWave = zeros(size(t));
        
        for k = 1:nHarmonics
            rampWave = rampWave + (-1)^(k+1) * (2/(k*pi)) * sin(k*t);
        end
        
        % Clear previous plot
        cla(hAxes);
        
        % Plot the ramp wave approximation
        plot(hAxes, t, rampWave, 'LineWidth', 2);
        title(hAxes, ['Ramp Wave Approximation with ', num2str(nHarmonics), ' Harmonics']);
        xlabel(hAxes, 'Time');
        ylabel(hAxes, 'Amplitude');
        grid(hAxes, 'on');
    end
end