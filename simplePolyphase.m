function [Xhat, MSE] = simplePolyphase(X, h0, h1, f0, f1)
    % simple polyphase implementation
    % filtering on the TX side
    u0 = conv(X, h0, 'same');
    u1 = conv(X, h1, 'same');
    % downsampling
    v0 = u0(1: 2: end);
    v1 = u1(1: 2: end);
    % upsampling
    u0prime = upsample(v0, 2);
    u1prime = upsample(v1, 2);
    % filtering on the RX side (F0 = H0, F1 = -H1)
    Xhat = conv(u0prime, f0, 'same') + conv(u1prime, f1, 'same');
    
    % Comparing X and Xhat
    % figure; subplot(1, 2, 1)
    % plot(real(X), 'o', 'Color', 'black'); hold on;
    % plot(real(Xhat), '*', 'Color', 'blue');
    % legend('X', 'Xhat'); 
    % subplot(1, 2, 2)
    % plot(imag(X), 'o', 'Color', 'black'); hold on;
    % plot(imag(Xhat), '*', 'Color', 'blue');
    % legend('X', 'Xhat');
    
    % Comparing X and Xhat by calculating MSE
    sum = 0;
    for k = 1: length(X)
        sum = sum + ((norm(X(k) - Xhat(k))^2) / (norm(X(k))^2));
    end
    sum = sqrt(sum) / length(X);
    MSE = sum;
end