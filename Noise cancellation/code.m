%% Load the 'audio_sample.wav' file in MATLAB
[sample_data, sample_rate] = audioread("noisy_audio.wav");

%% Plot the original signal in time domain
sample_period = 1 / sample_rate;
t = (0:sample_period:(length(sample_data) - 1) / sample_rate);
subplot(2, 2, 1)
plot(t, sample_data)
title('Time Domain Representation - Unfiltered Sound')
xlabel('Time (seconds)')
ylabel('Amplitude')
xlim([0, t(end)])

%% Transform the length to a power of 2 for faster computation
m = length(sample_data);
n = pow2(nextpow2(m));

%% Plot the original signal in frequency domain
y = fft(sample_data, n);
f = (0:n - 1) * (sample_rate / n);
amplitude = abs(y) / n;
subplot(2, 2, 2)
plot(f(1:floor(n / 2)), amplitude(1:floor(n / 2)))
title('Frequency Domain Representation - Unfiltered Sound')
xlabel('Frequency')
ylabel('Amplitude')

%% Filter the audio sample data to remove noise using a moving average filter
window_size = 21;
filtered_sound = movmean(sample_data, window_size); 
sound(filtered_sound, sample_rate)
%% Plot the filtered audio file in time domain
t1 = (0:sample_period:(length(filtered_sound) - 1) / sample_rate);
subplot(2, 2, 3)
plot(t1, filtered_sound)
title('Time Domain Representation - Filtered Sound')
xlabel('Time (seconds)')
ylabel('Amplitude')
xlim([0, t1(end)])

%% Plot the filtered audio file in frequency domain
y1 = fft(filtered_sound, n);
amplitude = abs(y1) / n;
subplot(2, 2, 4)
plot(f(1:floor(n / 2)), amplitude(1:floor(n / 2)))
title('Frequency Domain Representation - Filtered Sound')
xlabel('Frequency')
ylabel('Amplitude')
%% Save the filtered audio as a new file
output_filename = 'filtered_audio.wav';
audiowrite(output_filename, filtered_sound, sample_rate);

disp(['Filtered audio saved as "', output_filename, '"']);

