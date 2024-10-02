%Lab 1 4TL4
%saad
%% Question 1 
amp = 5; 
f = [10 25 40 60 40 60];
phase = [0 0 0 0 pi/2 pi/2];
Fs = 100; 
%cont time seq
t = 0:0.0005:0.5; 
at = amp*cos(2*pi*f(1)*t+phase(1));
bt = amp*cos(2*pi*f(2)*t+phase(2));
ct = amp*cos(2*pi*f(3)*t+phase(3));
dt = amp*cos(2*pi*f(4)*t+phase(4));
et = amp*cos(2*pi*f(5)*t+phase(5));
ft = amp*cos(2*pi*f(6)*t+phase(6));

%disc time seq
n = 0:1/Fs:0.5; %number of samples is Sampling frequency (100Hz) * seconds (0.5)
an = amp*cos(2*pi*f(1)*n+phase(1));
bn = amp*cos(2*pi*f(2)*n+phase(2));
cn = amp*cos(2*pi*f(3)*n+phase(3));
dn = amp*cos(2*pi*f(4)*n+phase(4));
en = amp*cos(2*pi*f(5)*n+phase(5));
fn = amp*cos(2*pi*f(6)*n+phase(6));

tiledlayout(4,3);
nexttile
plot(t, at);
title('A(t)');
ylim([-6 6]);
xlabel('t');
ylabel('A(t)')
nexttile
plot(t, bt);
title('B(t)');
ylim([-6 6]);
xlabel('t');
ylabel('B(t)')
nexttile
plot(t, ct);
title('C(t)');
ylim([-6 6]);
xlabel('t');
ylabel('C(t)')
nexttile
stem(n, an);
title('A(n)');
ylim([-6 6]);
xlabel('n');
ylabel('A(n)');
nexttile
stem(n, bn);
title('B(n)');
ylim([-6 6]);
xlabel('n');
ylabel('B(n)');
nexttile
stem(n, cn);
title('C(n)');
ylim([-6 6]);
xlabel('n');
ylabel('C(n)');

nexttile
plot(t, dt);
title('D(t)');
ylim([-6 6]);
xlabel('t');
ylabel('D(t)')
nexttile
plot(t, et);
title('E(t)');
ylim([-6 6]);
xlabel('t');
ylabel('E(t)');
nexttile
plot(t, ft);
title('F(t)');
ylim([-6 6]);
xlabel('t');
ylabel('F(t)');
nexttile
stem(n, dn);
title('D(n)');
ylim([-6 6]);
xlabel('n');
ylabel('D(n)');
nexttile
stem(n, en);
title('E(n)');
ylim([-6 6]);
xlabel('n');
ylabel('E(n)');
nexttile
stem(n, fn);
title('F(n)');
ylim([-6 6]);
xlabel('n');
ylabel('F(n)');



%% Question 2a
n = 0:30;
impulse = 16;
step = 12; %step occurs at 12 for u[n-12]
deltat = (n == impulse); %array where impulse is 1 and otherwise 0
ut = (n >= step); %array where elements are 1 after 12 and 0 otherwise

tiledlayout(1,2);
nexttile
stem(n,deltat);
title('delta[n-16]')
ylim([-0.1 1.1]);
xlabel('n');
ylabel('delta(n)');
nexttile
stem(n,ut);
title('u[n-12]')
ylim([-0.1 1.1]);
xlabel('n');
ylabel('u(n)');

%% Question 2b
un1 = (n >= 14);
un2 = (n >= 15);
x1n = un1-un2;
stem(n,x1n);
title('Difference Signal x1[n]')
ylim([-0.1 1.1]);
xlabel('n');
ylabel('x1(n)');
%% Question 2c
un1 = (n >= 9);
un2 = (n >= 16);
x2n = un1-un2;
stem(n,x2n);
title('Difference Signal x2[n]')
xlabel('n');
ylabel('x2(n)');
ylim([-0.1 1.1]);
%% Question 3a
n = 1:40;
amp = 1;
w = pi/10;
xn = exp(1i*w*n);

plot(real(xn),imag(xn))
title('Complex Signal')
xlabel('Real');
ylabel('Img');
%% Question 3b
subplot(2,1,1)
stem(n, real(xn))
ylim([-1.5 1.5]);
title('Real');
xlabel('n');
ylabel('Real');
subplot(2,1,2)
stem(n,imag(xn))
ylim([-1.5 1.5]);
title('Img');
xlabel('n');
ylabel('Img');
%% Question 3c
mag= abs(xn);
phs = angle(xn);
subplot(2,1,1);
stem(n, mag);
ylim([-1.5 1.5]);
title('Magnitude Plot');
xlabel('n');
ylabel('Magnitude');
subplot(2,1,2);
stem(n,phs);
ylim([-5 5]);
title('Phase Plot');
xlabel('n');
ylabel('Phase');


%% Question 4b
[y,fs] = audioread('defineit.wav');
t = 0: length(y)-1;
tiledlayout(1,2);
nexttile
plot(t,y);
title('Audio Signal')
xlabel('t');
ylabel('Audio Signal');
nexttile
histogram(y,50)
title('Histogram of Amplitudes')
xlabel('Samples');
ylabel('Amplitudes');
%% Display the info

%number of bits used to quantize audio file
info = audioinfo('defineit.wav');
disp(info);

%% Question 4c
soundsc(y,fs)
%% Question 4d,e,f
levels = 8; %2^bits 
range_min = -1;
range_max = 1;
%change to the signal min and max 
bin = (range_max-range_min)/levels; % 1-(-1)/8 = 0.25

%scale by factor
clear max abs min;
alpha = max(abs(y));
y_scaled = (y)/alpha; 
%Clipping. if x_max is smalled than any value in y scaled, it is replaced by xmax
y_clipped = min(y_scaled, range_max);
%Quantize. Divide into bins and then round 
y3bit = (round(y_clipped/bin))*bin; 
%error
%plot results
tiledlayout(2,2);
nexttile
t_new = 1:length(y3bit);
plot(t_new, y3bit);
title('New Signal')
xlabel('Samples');
ylabel('Amplitudes');
nexttile
histogram(y3bit,50)
title('Histogram of Amplitudes')
xlabel('Samples');
ylabel('Amplitudes');
nexttile
plot(t,y);
title('Old Signal')
xlabel('Samples');
ylabel('Amplitudes');
nexttile
histogram(y,50)
title('Histogram of Amplitudes')
xlabel('Samples');
ylabel('Amplitudes');

%% Question 4f error
e = y_scaled - y3bit;

t_e = 0: length(e)-1;
tiledlayout(1,2);
nexttile
plot(t_e, e);
title('error')
xlabel('Samples');
ylabel('error');
nexttile
histogram(e,50)
title('Histogram of error')
xlabel('Samples');
ylabel('error');
%% Question 4g
alpha = 1000;
y_pscaled = y*alpha;


%Clipping. if x_max is smalled than any value in y scaled, it is replaced by xmax

%y_pclip = min(y,range_max);

for n =1 : length(y_pscaled)
    if y_pscaled(n)>1
        y_pscaled(n)=1;
    elseif y_pscaled(n)<-1
        y_pscaled(n)=-1;
    end
end
y_pscaled = y_pscaled*alpha;

%%
plot(t, y_pscaled);
%ylim([-5 5]);
%% 

%Quantize. Divide into bins and then round 
bin2 = (alpha - (-alpha))/8;
y3bit_pclip = (round(y_pscaled/bin2))*bin2;
ep = y_pscaled - y3bit_pclip;
t_e = 0: length(e)-1;


tiledlayout(4,2);
nexttile
t_new = 1:length(y3bit_pclip);
plot(t_new, y3bit_pclip);
%ylim([-1.5 1.5]);
title('P clip')
xlabel('Samples');
ylabel('Amplitudes');
nexttile
histogram(y3bit_pclip,50)

title('Histogram of Amplitudes')
xlabel('Samples');
ylabel('Amplitudes');
nexttile
plot(t_e, ep);
title('error')
xlabel('Samples');
ylabel('error');
nexttile
histogram(ep,50)
title('Histogram of error')
xlabel('Samples');
ylabel('error');
nexttile
plot(t,y3bit);
title('Old Signal')
xlabel('Samples');
ylabel('Amplitudes');
nexttile
histogram(y3bit,50)
title('Histogram of Amplitudes')
xlabel('Samples');
ylabel('Amplitudes');
nexttile
plot(t_e, e);
title('error')
xlabel('Samples');
ylabel('error');
nexttile
histogram(e,50)
title('Histogram of error')
xlabel('Samples');
ylabel('error');