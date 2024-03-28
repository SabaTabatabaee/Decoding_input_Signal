function [v_hat, scrm_pattern] = myScrambler(v, number, FN)

    v_real = real(v);
    v_imag = imag(v);
    
    LFSR = zeros(1, 26);

    switch number
        case 1
            nfn = 9;
            GID = [1 1 1 0 1];
        case 2
            nfn = 10;
            GID = [1 0 1 0 1 1 1];
        case 3
            nfn = 11;
            GID = [1 0 0 1 0 0 0 1];
        case 4
            nfn = 12;
            GID = [1 1 0 0 1 0 1 1];
    end
    
    nfn = nfn + 1;
    
    LFSR(end - nfn - length(FN) + 1: end - nfn) = FN;
    LFSR(26 - length(GID) + 1: end) = GID;
    
    LFSR_real = LFSR;
    LFSR_imag = LFSR;
    
    for idx = 1: length(v)
        PN_real = xor(xor(LFSR_real(1), LFSR_real(23)), LFSR_real(26));
        PN_imag = xor(xor(xor(LFSR_imag(1), LFSR_imag(23)), xor(LFSR_imag(24), LFSR_imag(25))), LFSR_imag(26));
        
        mul_real = 1 - 2 * PN_real;
        mul_imag = 1 - 2 * PN_imag;
        
        scrm_pattern(idx, 1) = mul_real;
        scrm_pattern(idx, 2) = mul_imag;
        
        v_real_hat(idx) = v_real(idx) * mul_real;
        v_imag_hat(idx) = v_imag(idx) * mul_imag;
        
        LFSR_real = [LFSR_real(2: end), PN_real];
        LFSR_imag = [LFSR_imag(2: end), PN_imag];
    end

    v_hat = v_real_hat + 1i * v_imag_hat;

end