function [v1_deint, v2_deint, v3_deint, v4_deint]= Deinterleaver(s_interleaver)

v1_deint = s_interleaver(1:8:end);

v2_deint = s_interleaver(3:8:end);

v3_deint_p1 = s_interleaver(5:8:end);
v3_deint_p2 = s_interleaver(7:8:end);

for i = 1: length(v3_deint_p1)
    v3_deint(2 * i) = v3_deint_p2(i);
    v3_deint(2 * i - 1) = v3_deint_p1(i);
end

v4_deint_p1 = s_interleaver(2:8:end);
v4_deint_p2 = s_interleaver(4:8:end);
v4_deint_p3 = s_interleaver(6:8:end);
v4_deint_p4 = s_interleaver(8:8:end);

for i = 1: length(v4_deint_p1)
    v4_deint(4 * i - 3) = v4_deint_p1(i);
    v4_deint(4 * i - 2) = v4_deint_p2(i);
    v4_deint(4 * i - 1) = v4_deint_p3(i);
    v4_deint(4 * i) = v4_deint_p4(i);
end

end