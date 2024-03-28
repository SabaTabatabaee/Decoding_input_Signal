%% ENEE 630 Project
% Saba Tabatabaee - Maryam Maghsoudi Shaghaghi
% Fall 2022

clear; 
clc;
close all;

%% 3.1.1

g_Gain = 2050;

syms w 
H0 = 2*exp(-1i*15*w)*(-cos(15*w)+3*cos(13*w)-8*cos(11*w)+21*cos(9*w)-45*cos(7*w)...
+91*(cos(5*w))-191*cos(3*w)+643*cos(w)+512)/g_Gain;

H1 = 2*exp(1i*(pi-15*w))*(cos(15*w)-3*cos(13*w)+8*cos(11*w)-21*cos(9*w)+45*cos(7*w)...
-91*(cos(5*w))+191*cos(3*w)-643*cos(w)+512)/g_Gain;

w_values = 0:0.01:2*pi;
H0_values = double(subs(H0, w, w_values)); 
H1_values = double(subs(H1, w, w_values));

H0_phase = mod(15*w_values, 2*pi);
H1_phase = pi - H0_phase;

figure; plot(w_values/pi, 10*log(abs(H0_values)/max(abs(H0_values))), '*', 'LineWidth', 1.8, 'color', 'b');
xlabel('Pi'); ylabel('db'); title('Amplitude Plot');
hold on;
plot(w_values/pi, 10*log(abs(H1_values)/max(abs(H1_values))), '*', 'LineWidth', 1.8, 'color', 'r');
legend('H_0 (LPF)', 'H_1 (HPF)');

figure; plot(w_values, H0_phase, 'LineWidth', 1.8, 'color', 'b');
xlabel('Pi'); ylabel('Pi'); title('Phase Plot');
hold on;
plot(w_values, H1_phase, 'LineWidth', 1.8, 'color', 'r');
legend('H_0 (LPF)', 'H_1 (HPF)');

%% 3.1.2

% creating filters H(z) and H(-z)
g = [-1 0 3 0 -8 0 21 0 -45 0 91 0 -191 0 643 1024 643 0 -191 0 91 0 ...
    -45 0 21 0 -8 0 3 0 -1];    % g[n] as given

% normalize by gain
g = g / g_Gain;

% H0(z) = G(z),    H1(z) = G(-z)
h0 = g;
h1 = ( (-1).^(1:length(g)) ).*g;

% plotting filters g[n], h0[n], and h1[n] across time
% figure;
% plot(g, '*', 'Color', 'black', 'linewidth',2); 
% hold on; plot(h0, '.', 'Color', 'cyan', 'linewidth', 1.7);
% plot(h1, 'o', 'Color', 'r', 'linewidth', 1.7); legend('g', 'h0', 'h1');
% xlabel('n'); ylabel('Filters'); title('Filters across time');

N = 1024;   % signal length
N_burst = 1000;     % Number of bursts
for n = 1: N_burst
    X_rnd = createRandomInput(N);
    [Xhat_rnd_op1, MSE_rnd_op1(n)] = simplePolyphase(X_rnd, h0, h1, h0, -h1);
    [Xhat_rnd_op2, MSE_rnd_op2(n)] = simplePolyphase(X_rnd, h0, h1, h0, h1);
    X_bp = createBandpassInput(N);
    [Xhat_bp_op1, MSE_bp_op1(n)] = simplePolyphase(X_bp, h0, h1, h0, -h1);
    [Xhat_bp_op2, MSE_bp_op2(n)] = simplePolyphase(X_bp, h0, h1, h0, h1);
end

MSE_random_input_option_1 = mean(MSE_rnd_op1)
MSE_bandpass_input_option_2  = mean(MSE_rnd_op2)
MSE_random_input_option_1  = mean(MSE_bp_op1)
MSE_bandpass_input_option_2  = mean(MSE_bp_op2)

syms w

% option 1
F0 = H0;
F1 = -1 * H1;

T1 = 0.5 * (H0*F0 + H1*F1);
A1 = zeros(length(T1));

w_values = linspace(0, 2*pi, N);
T1_values = double(subs(T1, w, w_values)); 
A1_values = double(subs(A1, w, w_values));
T1_phase = mod(30*w, 2*pi);
T1_phase = double(subs(T1_phase, w, w_values));

% option 2
F0 = H0;
F1 = H1;

T2 = 0.5 * (H0*F0 + H1*F1);
A2 = 0.5 * (H1*F0 + H0*F1);

w_values = linspace(0, 2*pi, N);
T2_values = double(subs(T2, w, w_values)); 
A2_values = double(subs(A2, w, w_values));
T2_phase = mod(30*w, 2*pi);
T2_phase = double(subs(T2_phase, w, w_values));

figure; 
plot(w_values/pi, T1_phase, 'LineWidth', 1.8, 'color', 'b'); hold on;
plot(w_values/pi, T2_phase, 'LineWidth', 1.8, 'color', 'r');
xlabel('Pi'); ylabel('Pi'); title('Phase Plot');
legend('T1 phase', 'T2 phase');

figure; plot(w_values/pi, 10*log(abs(T1_values)/max(abs(T1_values))), '*', 'LineWidth', 1.8, 'color', 'm');
xlabel('Pi'); ylabel('db'); title('Two Different Systems ');
hold on;
plot(w_values/pi, 10*log(abs(T2_values)/max(abs(T2_values))), '*', 'LineWidth', 1.8, 'color', 'b');
plot(w_values/pi, 10*log(abs(A1_values)/max(abs(H1_values))), '*', 'LineWidth', 1.8, 'color', 'r');
plot(w_values/pi, 10*log(abs(A2_values)/max(abs(A2_values))), '*', 'LineWidth', 1.8, 'color', 'g');
legend('T1', 'T2', 'A1', 'A2');

%% 3.1.3

N = 1024;   % signal length

X_rnd = createRandomInput(N);
X_bp = createBandpassInput(N);

[Xhat_rnd_op1, ~, ~, ~, ~, MSE_rnd_op1_plyphse] = Polyphase(X_rnd, h0, h1, h0, -h1);
[Xhat_rnd_op2, ~, ~, ~, ~, MSE_rnd_op2_plyphse] = Polyphase(X_rnd, h0, h1, h0, h1);
[Xhat_bp_op1, ~, ~, ~, ~, MSE_bp_op1_plyphse] = Polyphase(X_bp, h0, h1, h0, -h1);
[Xhat_bp_op2, ~, ~, ~, ~, MSE_bp_op2_plyphse] = Polyphase(X_bp, h0, h1, h0, h1);

MSE_Random_Input_Option_1_Polyphase = MSE_rnd_op1_plyphse
MSE_Random_Input_Option_2_Polyphase = MSE_rnd_op2_plyphse
MSE_Bandpass_Input_Option_1_Polyphase = MSE_bp_op1_plyphse
MSE_Bandpass_Input_Option_2_Polyphase = MSE_bp_op2_plyphse

% plot filters for polyphase after simplification
syms w 
G_2W= 2*exp(-1i*15*2*w)*(-cos(15*2*w)+3*cos(13*2*w)-8*cos(11*2*w)+21*cos(9*2*w)-45*cos(7*2*w)...
+91*(cos(5*2*w))-191*cos(3*2*w)+643*cos(2*w)+512);

G_minus2W= 2*exp(1i*(pi-15*2*w))*(cos(15*2*w)-3*cos(13*2*w)+8*cos(11*2*w)-21*cos(9*2*w)+45*cos(7*2*w)...
-91*(cos(5*2*w))+191*cos(3*2*w)-643*cos(2*w)+512);

G_4W= 2*exp(-1i*15*4*w)*(-cos(15*4*w)+3*cos(13*4*w)-8*cos(11*4*w)+21*cos(9*4*w)-45*cos(7*4*w)...
+91*(cos(5*4*w))-191*cos(3*4*w)+643*cos(4*w)+512);

G_minus4W= 2*exp(1i*(pi-15*4*w))*(cos(15*4*w)-3*cos(13*4*w)+8*cos(11*4*w)-21*cos(9*4*w)+45*cos(7*4*w)...
-91*(cos(5*4*w))+191*cos(3*4*w)-643*cos(4*w)+512);

w_values = 0:0.01:2*pi;
G_2W_values = double(subs(G_2W, w, w_values)); 
G_4W_values = double(subs(G_4W, w, w_values)); 
G_minus2W_values = double(subs(G_minus2W, w, w_values));
G_minus4W_values = double(subs(G_minus4W, w, w_values));

Normalized_low_pass=H0_values;
H3_filter=H1_values;
H2_filter=H0_values.*G_minus2W_values;
H1_filter=H0_values.*G_2W_values.*G_minus4W_values;
H0_filter=H0_values.*G_2W_values.*G_4W_values;

figure; plot(w_values/pi, 10*log(abs(Normalized_low_pass)/max(abs(Normalized_low_pass))), '*', 'LineWidth', 1.8, 'color', 'b');
xlabel('Pi'); ylabel('db'); title('Amplitude Plot');
hold on;
plot(w_values/pi, 10*log(abs(H3_filter)/max(abs(H3_filter))), '*', 'LineWidth', 1.8, 'color', [0.8500 0.3250 0.0980]);
hold on;
plot(w_values/pi, 10*log(abs(H2_filter)/max(abs(H2_filter))), '*', 'LineWidth', 1.8, 'color', [.7 .7 .7]);
hold on;
plot(w_values/pi, 10*log(abs(H1_filter)/max(abs(H1_filter))), '*', 'LineWidth', 1.8, 'color', 'g');
hold on;
plot(w_values/pi, 10*log(abs(H0_filter)/max(abs(H0_filter))), '*', 'LineWidth', 1.8, 'color', 'y');
legend('Normalized low pass', 'H3 filter for v3','H2 filter for v2','H1 filter for v1','H0 filter for v0');


%% 4.2.1 Scrambler
N = 1024;   % signal length

X_rnd = createRandomInput(N);

[Xhat, v1, v2, v3, v4, ~] = Polyphase(X_rnd, h0, h1, h0, -h1);

FN = 1;

v1_scrm = myScrambler(v1, 1, FN);
v2_scrm = myScrambler(v2, 2, FN);
v3_scrm = myScrambler(v3, 3, FN);
v4_scrm = myScrambler(v4, 4, FN);

%% 4.2.2 Descrambler
v1_descrm = myScrambler(v1_scrm, 1, FN);
v2_descrm = myScrambler(v2_scrm, 2, FN);
v3_descrm = myScrambler(v3_scrm, 3, FN);
v4_descrm = myScrambler(v4_scrm, 4, FN);

%% 5.1 Interleavering 
s_interleaver = interleaver(v1_scrm, v2_scrm, v3_scrm, v4_scrm);

%% 5.2 Deinterleavering 
[v1_deint, v2_deint, v3_deint, v4_deint] = Deinterleaver(s_interleaver);





