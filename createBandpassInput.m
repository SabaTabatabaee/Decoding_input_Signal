function [X] = createBandpassInput(N)
    for m = 1: N
        X_Re(m) = 1344 * cos(0.06*pi*m)+ 864 * cos(0.18*pi*m) + ...
            8543 * cos(0.38*pi*m) - 43 * cos(0.8*pi*m);
        X_Im(m) = 1344 * sin(0.06*pi*m)+ 864 * sin(0.18*pi*m) + ...
            8543 * sin(0.38*pi*m) - 43 * sin(0.8*pi*m);
    end
    
    X = X_Re + 1i .* X_Im;
end