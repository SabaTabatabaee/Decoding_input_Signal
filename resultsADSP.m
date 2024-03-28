clear; clc; close all;

figure; 
SNR = [-20 -15 -10 -8 -5 -2 -1 1 2 3 5 8 10 15 20 50 80 100];
MSE_R = [0.2347 0.1394 0.0802 0.0651 0.0487 0.0379 0.0353 0.0313 0.0298 0.0285 0.0266 0.0249 0.0243 0.0243 0.0236 0.0234 0.0234 0.0234];
plot(SNR, MSE_R, '-o', 'color', 'black', 'linewidth', 2);
hold on
SNR = [-20 -15 -10 -8 -5 -2 -1 1 2 3 5 8 10 15 20 50 80 100];
MSE_B = [0.7483 0.4212 0.2376 0.1893 0.1350 0.0970 0.0871 0.0706 0.0638 0.0579 0.0481 0.0379 0.0333 0.0270 0.0247 0.0236 0.0236 0.0236];
plot(SNR, MSE_B, '-*', 'color', 'blue', 'linewidth', 1.2);
xlabel('SNR'); ylabel('MSE'); title('MSE vs. SNR, Foff = 234.375');
legend('Random Input', 'Bandpass Input');

Foff = [-234.375 -156.250 -78.125 78.125 156.250 234.375];
R50 = [0.0236 0.0234 0.0234 0.0233 0.0233 0.0234];
R10 = [0.0246 0.0247 0.0250 0.0243 0.0245 0.0243];
B50 = [0.0236 0.0235 0.0234 0.0234 0.0235 0.0236];
B10 = [0.0331 0.0342 0.0341 0.0334 0.0331 0.0333];

figure; subplot(1, 2, 1)
plot(Foff, R50, '-o', 'color', [0 0 0], 'linewidth', 2); hold on;
plot(Foff, R10, '-o', 'color', [0 0 1], 'linewidth', 2);
legend('SNR = 50', 'SNR = 10'); title('Random Input'); xlabel('Freq offset (Hz)'); ylabel('MSE');
subplot(1, 2, 2); 
plot(Foff, B50, '-o', 'color', [0 0 0], 'linewidth', 2); hold on
plot(Foff, B10, '-o', 'color', [0 0 1], 'linewidth', 2);
legend('SNR = 50', 'SNR = 10'); title('Bandpass Input'); xlabel('Freq offset (Hz)'); ylabel('MSE');




