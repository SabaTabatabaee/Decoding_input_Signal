function [X] = createRandomInput(N)

rndSgn = double(rand(1,N)>0.5);
rndSgn(find(rndSgn == 0)) = -1;

X_Re = rndSgn .* rand(1, N) * 2 ^ 15;
X_Im = rndSgn .* rand(1, N) * 2 ^ 15;
X = X_Re + 1i .* X_Im;

end