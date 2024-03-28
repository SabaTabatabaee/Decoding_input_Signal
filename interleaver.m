function  s_interleaver = interleaver(v1_scrm, v2_scrm, v3_scrm, v4_scrm)

    s_interleaver = [];
    for k = 1: 128
        s_interleaver = [s_interleaver, ...
            [v1_scrm(k) v4_scrm(4*(k-1)+1) v2_scrm(k) v4_scrm(4*(k-1)+2) v3_scrm(2*(k-1)+1)...
            v4_scrm(4*(k-1)+3) v3_scrm(2*(k-1)+2) v4_scrm(4*(k-1)+4)]];
    end   

end