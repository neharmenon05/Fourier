% Read the audio file
[input_signal, Fs] = audioread("original_audio.wav");

% Display the original audio signal
figure;
subplot(2,1,1);
plot(input_signal);
title('Original Audio Signal');
xlabel('Sample');
ylabel('Amplitude');

% Perform Fourier transform
N = length(input_signal);
transformed_signal = fft(input_signal);

% Display the magnitude spectrum
subplot(2,1,2);
frequencies = linspace(0, Fs, N);
plot(frequencies, abs(transformed_signal));
title('Magnitude Spectrum');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

% Perform compression (Example: keep only first half of frequencies)
compressed_signal = transformed_signal(1:N/2);

% Reconstruct the compressed signal using inverse Fourier transform
reconstructed_signal = ifft(compressed_signal);

% Display the reconstructed signal
figure;
subplot(2,1,1);
plot(real(reconstructed_signal));
title('Reconstructed Audio Signal');
xlabel('Sample');
ylabel('Amplitude');

% Play the original and reconstructed audio signals
sound(input_signal, Fs); % Play original signal
pause(length(input_signal)/Fs); % Pause to wait for completion of original sound
sound(real(reconstructed_signal), Fs); % Play reconstructed signal
