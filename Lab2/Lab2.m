%% 1a
n = 0:9; 
x = ones(1, 10); % u[n] - u[n-10]
%greph
stem(n, x);
title('x[n] = u[n] - u[n-10]');
xlabel('n');
ylabel('x[n]');
xlim([-1, 11]);
ylim([0, ])
%% 1bc
a = conv(x, x); % a[n] = x[n]*x[n]
b = conv(a, x); % b[n] = a[n]*x[n]
c = conv(b, x); % c[n] = b[n]*x[n]
d = conv(c, x); % d[n] = c[n]*x[n]

% Plotting the results
subplot(4,1,1); stem(a); title('a[n] = x[n] * x[n]');
xlabel('n'); ylabel('a[n]');
subplot(4,1,2); stem(b); title('b[n] = a[n] * x[n]');
xlabel('n'); ylabel('b[n]');
subplot(4,1,3); stem(c); title('c[n] = b[n] * x[n]');
xlabel('n'); ylabel('c[n]');
subplot(4,1,4); stem(d); title('d[n] = c[n] * x[n]');
xlabel('n'); ylabel('d[n]');
%% 2a
[impr, fs] = audioread('roomIR.wav'); 
%graph
plot(impr);
title('Room Impulse Response');
xlabel('Sample Number');
ylabel('Amplitude');
%% 2b
soundsc(impr, fs);
%Answer to what you observed 
%you can see the impulse response is loudest at the beginning and fades
%You can also see that the amplitude is highest at the beginning dclines
%% 2c
[y, fs] = audioread('convolution.wav'); % Load speech signal
plot(y); % Plot the original speech signal
title('Original Speech Signal');
xlabel('Sample Number');
ylabel('Amplitude');
%% 2d
% Convolve
convolved_signal = conv(y, impr);
% graph
figure; plot(convolved_signal);
title('Convolved Speech Signal');
xlabel('Sample Number');
ylabel('Amplitude');
%% Comparing Signals: OG Signal -Impulse Response 
soundsc(impr, fs);%Impulse
%% Comparing Signals: OG Signal - Convolution
soundsc(y, fs); %OG
%% Comparing Signals: Conv Signal
soundsc(convolved_signal, fs); %Convolved 



