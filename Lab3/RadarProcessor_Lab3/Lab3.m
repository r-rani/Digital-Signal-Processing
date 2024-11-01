%%LAb 3

x = readtable('Lab_3.csv');
x = table2array(x);


real = x(:,1);
imag = x(:,2);

abs = zeros(500);
fs = 1.5e8;

for i = 1:500

    abs(i) = sqrt((real(i)*real(i))+((imag(i)*imag(i))));

end

abs = abs(:,1);

N = 1:500;
r = (N*c)/(2*fs)
% R = 1:r;
plot(r,abs);
title("Plot of Signal");
ylabel("Magnitude");
xlabel("Distance (m)");

%{
subplot(2,1,1);
subtitle("Real");
plot(N,real);
subplot(2,1,2);
subtitle("Imag");
plot(N,imag);
%}

peak = max(abs);
c = physconst('LightSpeed');
Ts = 500;
r = (peak * c)/(2*Ts);