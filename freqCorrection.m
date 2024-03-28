function [Rn_corr, deltaW] = freqCorrection(Rn)
    freqID = 40;
    Rn_wave = Rn(1: 128);

    Rn_fft = abs(fft(Rn_wave));
    freq_vec = 0: 127;
    [~, maxIdx] = max(Rn_fft);
    ourW = freq_vec(maxIdx);
    deltaW = (ourW - freqID);
    deltaWRad = 2 * pi * (ourW - freqID) / 128;

    n = 1: length(Rn);
    Rn_corr = (cos(deltaWRad * n) - 1i * sin(deltaWRad * n)) .* Rn;
    Rn_corr = Rn_corr(129: end);
    
    figure; plot(freq_vec, Rn_fft, 'linewidth', 2); hold on; 
    xline(ourW, '--', 'color', 'black', 'linewidth', 2);
    xline(freqID, '--', 'color', 'red', 'linewidth', 2);
    legend('DFT', 'Detected Freq', 'Freq ID'); xlabel('Frequency'); title('DFT of R_n');
end

