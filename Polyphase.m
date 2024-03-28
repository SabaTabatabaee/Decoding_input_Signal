function [Xhat, v1, v2, v3, v4, MSE] = Polyphase(X,h0,h1,f0,f1)
%% TX
%% part 1
u0 = conv(X,h0,'same');
u1 = conv(X,h1,'same');
w0 = u0(1:2:end);
v4 = u1(1:2:end);
%% part 2
p0 = conv(w0,h0,'same');
p1 = conv(w0,h1,'same');
t0 = p0(1:2:end);
v3 = p1(1:2:end);
%% part 3
l0 = conv(t0,h0,'same');
l1 = conv(t0,h1,'same');
v1 = l0(1:2:end);
v2 = l1(1:2:end);
%% RX 
%% part 1
u0prime = upsample(v1, 2);
u1prime = upsample(v2, 2);
w0prime = conv(u0prime, f0,'same') + conv(u1prime, f1,'same');
%% part 2
p0prime = upsample(w0prime, 2);
p1prime = upsample(v3, 2);
w1prime = conv(p0prime, f0,'same') + conv(p1prime, f1,'same');

%% part 3
t0prime = upsample(w1prime, 2);
t1prime = upsample(v4, 2);
Xhat = conv(t0prime, f0,'same') + conv(t1prime, f1,'same');

%% calculate MSE
sum = 0;
for k = 1: length(X)
    sum = sum + ((norm(X(k) - Xhat(k))^2) / (norm(X(k))^2));
end
MSE = sqrt(sum) / length(X);

end
