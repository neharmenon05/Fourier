% Import library
import matlab.io.*

% Main function
audio_file = 'c6.wav';
Detected_Note = note_detect(audio_file);
fprintf('\n\tDetected Note = %s\n', Detected_Note);

% Function to detect note
function note = note_detect(audio_file)

    % Read audio file
    [sound, f_s] = audioread(audio_file);
    sound = sound(:,1); % consider only one channel
    file_length = length(sound);

    % Plot sound
    figure;
    plot(sound);
    title('Sound');
    
    % Fourier transformation
    fourier = abs(fft(sound));
    imax = find(fourier == max(fourier(1:round(file_length/2))), 1);
    
    % Plot Fourier transform
    figure;
    plot(fourier);
    title('Fourier Transform');
    
    % Peak detection
    threshold = 0.3 * fourier(imax);
    i_begin = find(fourier >= threshold, 1);
    i_end = find(fourier(i_begin:end) < threshold, 1) + i_begin - 1;
    imax = find(fourier == max(fourier(1:i_end+100)), 1);
    
    % Convert index to sound frequency
    freq = (imax*f_s)/(file_length);
    
    % Frequency database
    note = 0;
    name = ["C0","C#0","D0","D#0","E0","F0","F#0","G0","G#0","A0","A#0","B0","C1","C#1","D1","D#1","E1","F1","F#1","G1","G#1","A1","A#1","B1","C2","C#2","D2","D#2","E2","F2","F#2","G2","G2#","A2","A2#","B2","C3","C3#","D3","D3#","E3","F3","F3#","G3","G3#","A3","A3#","B3","C4","C4#","D4","D4#","E4","F4","F4#","G4","G4#","A4","A4#","B4","C5","C5#","D5","D5#","E5","F5","F5#","G5","G5#","A5","A5#","B5","C6","C6#","D6","D6#","E6","F6","F6#","G6","G6#","A6","A6#","B6","C7","C7#","D7","D7#","E7","F7","F7#","G7","G7#","A7","A7#","B7","C8","C8#","D8","D8#","E8","F8","F8#","G8","G8#","A8","A8#","B8","Beyond B8"];
    frequencies = [16.35,17.32,18.35,19.45,20.60,21.83,23.12,24.50,25.96,27.50,29.14,30.87,32.70,34.65,36.71,38.89,41.20,43.65,46.25,49.00,51.91,55.00,58.27,61.74,65.41,69.30,73.42,77.78,82.41,87.31,92.50,98.00,103.83,110.00,116.54,123.47,130.81,138.59,146.83,155.56,164.81,174.61,185.00,196.00,207.65,220.00,233.08,246.94,261.63,277.18,293.66,311.13,329.63,349.23,369.99,392.00,415.30,440.00,466.16,493.88,523.25,554.37,587.33,622.25,659.26,698.46,739.99,783.99,830.61,880.00,932.33,987.77,1046.50,1108.73,1174.66,1244.51,1318.51,1396.91,1479.98,1567.98,1661.22,1760.00,1864.66,1975.53,2093.00,2217.46,2349.32,2489.02,2637.02,2793.83,2959.96,3135.96,3322.44,3520.00,3729.31,3951.07,4186.01,4434.92,4698.64,4978.03,5274.04,5587.65,5919.91,6271.93,6644.88,7040.00,7458.62,7902.13,8000];
    
    % Searching for matched frequencies
    for i = 1:length(frequencies)-1
        if freq < frequencies(1)
            note = name(1);
            break;
        elseif freq > frequencies(end)
            note = name(end);
            break;
        elseif freq >= frequencies(i) && frequencies(i+1) >= freq
            if freq-frequencies(i) < (frequencies(i+1)-frequencies(i))/2
                note = name(i);
            else
                note = name(i+1);
            end
            break;
        end
    end
end
