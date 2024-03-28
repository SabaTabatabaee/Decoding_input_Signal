clear; clc; close all;

%%%%%%%%%% YOU NEED TO CHAGE THESE EVERY TIME YOU RUN %%%%%%%%%%%

% Add the folder path that includes the simulation outputs
addpath('C:\Users\Maryam Maghsoudi\Desktop\projectcodes\Fstart0_Nsim1_SNR100_Foffset0_input0');

% Enter the SNR, Foff, NFrame, and NStart as strings so that the code can
% generate the file name path to read the files.
SNR = '70.000000';
Foff = '234.375000';
NFrame = '1';
NStart = '1';

data = importdata(createPath('Input', SNR, Foff, NFrame, NStart));
data = transpose(data(:, 1) + 1i * data(:, 2));

FN = 1;
freqID = 40;
w0 = 2 * pi * freqID / 128;

g_Gain = 2050;
g = [-1 0 3 0 -8 0 21 0 -45 0 91 0 -191 0 643 1024 643 0 -191 0 91 0 ...
    -45 0 21 0 -8 0 3 0 -1];    % g[n] as given
g = g / g_Gain;
h0 = g;
h1 = ( (-1).^(1:length(g)) ).*g * (-1);

[~, v0, v1, v2, v3, ~] = Polyphase(data, h0, h1, h0, h1);

v0_test = myReadV(0, createPath('V0', SNR, Foff, NFrame, NStart));
v1_test = myReadV(1, createPath('V1', SNR, Foff, NFrame, NStart));
v2_test = myReadV(2, createPath('V2', SNR, Foff, NFrame, NStart));
v3_test = myReadV(3, createPath('V3', SNR, Foff, NFrame, NStart));

figure; sgtitle('Checking Polyphase');
subplot(4, 2, 1); plot(real(v0), 'o'); hold on; plot(real(v0_test), '*'); title('V0 - real'); legend('Our system', 'Simulator''s output');
subplot(4, 2, 2); plot(imag(v0), 'o'); hold on; plot(imag(v0_test), '*'); title('V0 - imag'); %legend('Our system', 'Simulator''s output');
subplot(4, 2, 3); plot(real(v1), 'o'); hold on; plot(real(v1_test), '*'); title('V1 - real');%legend('Our system', 'Simulator''s output');
subplot(4, 2, 4); plot(imag(v1), 'o'); hold on; plot(imag(v1_test), '*'); title('V1 - imag');%legend('Our system', 'Simulator''s output');
subplot(4, 2, 5); plot(real(v2), 'o'); hold on; plot(real(v2_test), '*'); title('V2 - real');%legend('Our system', 'Simulator''s output');
subplot(4, 2, 6); plot(imag(v2), 'o'); hold on; plot(imag(v2_test), '*'); title('V2 - imag');%legend('Our system', 'Simulator''s output');
subplot(4, 2, 7); plot(real(v3), 'o'); hold on; plot(real(v3_test), '*'); title('V3 - real');%legend('Our system', 'Simulator''s output');
subplot(4, 2, 8); plot(imag(v3), 'o'); hold on; plot(imag(v3_test), '*'); title('V3 - imag');%legend('Our system', 'Simulator''s output');

[v0_scrm, scrm_pattern0] = myScrambler(v0, 1, FN);
[v1_scrm, scrm_pattern1] = myScrambler(v1, 2, FN);
[v2_scrm, scrm_pattern2] = myScrambler(v2, 3, FN);
[v3_scrm, scrm_pattern3] = myScrambler(v3, 4, FN);

v0_scrm_test = myReadV(0, createPath('ScrambledV0', SNR, Foff, NFrame, NStart));
v1_scrm_test = myReadV(1, createPath('ScrambledV1', SNR, Foff, NFrame, NStart));
v2_scrm_test = myReadV(2, createPath('ScrambledV2', SNR, Foff, NFrame, NStart));
v3_scrm_test = myReadV(3, createPath('ScrambledV3', SNR, Foff, NFrame, NStart));

figure; sgtitle('Checking Scrambler');
subplot(4, 2, 1); plot(real(v0_scrm), 'o'); hold on; plot(real(v0_scrm_test), '*'); title('V0 - real'); legend('Our system', 'Simulator''s output');
subplot(4, 2, 2); plot(imag(v0_scrm), 'o'); hold on; plot(imag(v0_scrm_test), '*'); title('V0 - imag'); %legend('Our system', 'Simulator''s output');
subplot(4, 2, 3); plot(real(v1_scrm), 'o'); hold on; plot(real(v1_scrm_test), '*'); title('V1 - real'); %legend('Our system', 'Simulator''s output');
subplot(4, 2, 4); plot(imag(v1_scrm), 'o'); hold on; plot(imag(v1_scrm_test), '*'); title('V1 - imag'); %legend('Our system', 'Simulator''s output');
subplot(4, 2, 5); plot(real(v2_scrm), 'o'); hold on; plot(real(v2_scrm_test), '*'); title('V2 - real'); %legend('Our system', 'Simulator''s output');
subplot(4, 2, 6); plot(imag(v2_scrm), 'o'); hold on; plot(imag(v2_scrm_test), '*'); title('V2 - imag'); %legend('Our system', 'Simulator''s output');
subplot(4, 2, 7); plot(real(v3_scrm), 'o'); hold on; plot(real(v3_scrm_test), '*'); title('V3 - real'); 
subplot(4, 2, 8); plot(imag(v3_scrm), 'o'); hold on; plot(imag(v3_scrm_test), '*'); title('V3 - imag'); 

s_int = interleaver(v0_scrm, v1_scrm, v2_scrm, v3_scrm);

n = 1: 128;
Tn = [32770 * (cos(w0 * n) + 1i * sin(w0 * n)), s_int];

Tn_test = myReadV(2, createPath('Tn', SNR, Foff, NFrame, NStart));

figure; sgtitle('Checking interleaver and burst formatter');
subplot(1, 2, 1); plot(real(Tn), 'o'); hold on; plot(real(Tn_test), '*'); title('Real part'); legend('Our system', 'Simulator''s output');
subplot(1, 2, 2); plot(imag(Tn), 'o'); hold on; plot(imag(Tn_test), '*'); title('Imag part'); legend('Our system', 'Simulator''s output');

Rn = myReadV(2, createPath('Rn', SNR, Foff, NFrame, NStart)); 

Rn_corr = freqCorrection(Rn);

[v0p_deint, v1p_deint, v2p_deint, v3p_deint] = Deinterleaver(Rn_corr);

v0p_descrm = myScrambler(v0p_deint, 1, FN);
v1p_descrm = myScrambler(v1p_deint, 2, FN);
v2p_descrm = myScrambler(v2p_deint, 3, FN);
v3p_descrm = myScrambler(v3p_deint, 4, FN);

Xhat = PolyphaseRec(v0p_descrm, v1p_descrm, v2p_descrm, v3p_descrm ,h0, h1);

figure;sgtitle('Checking interleaver and burst formatter');
subplot(1, 2, 1); plot(real(Xhat), 'o'); hold on; plot(real(data), '*'); title('Real part'); legend('System''s Output', 'Input');
subplot(1, 2, 2); plot(imag(Xhat), 'o'); hold on; plot(imag(data), '*'); title('Imag part'); legend('System''s Output', 'Input');

sum = 0;
for k = 1: length(data)
    sum = sum + ((norm(data(k) - Xhat(k))^2) / (norm(data(k))^2));
end
MSE = sqrt(sum) / length(data)


