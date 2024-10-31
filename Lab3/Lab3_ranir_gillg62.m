%% Function for RMS
function rms_val = compute_rms(x)
    N = length(x);
    sum_sq = 0;
    for i = 1:N
        sum_sq = sum_sq + x(i)^2;
    end
    rms_val = sqrt(sum_sq / N);
end
%% 1a .) functions 
n = 0:50;
xa = 5 * cos(0*n);
xb = 5 * cos((pi/5)*n);
xc = 5 * cos((2*pi/5)*n);
xd = 5 * cos((3*pi/5)*n);
xe = 5 * cos((4*pi/5)*n);
xf = 5 * cos(pi*n);

h1 = [1/4 1/2 1/4];
h2 = [-1/4 1/2 -1/4];

signals = {xa xb xc xd xe xf};
%% 1b.) RMS of xa to xf
%create array to store RMS values for each signal
RMS_in = [0 0 0 0 0 0];
%find RMS for each signal
for i= 1:length(RMS_in)
    RMS_in(i) = compute_rms(signals{i});
end
%% 1c RMS of convolution h1
%create array to store RMS vals
RMS_out_h1 = [0 0 0 0 0 0];
%find RMS for each signal
for i= 1:length(RMS_out_h1)
    RMS_out_h1(i) = compute_rms(conv(h1,signals{i}));
end
%find the gain
gain_h1 = [0 0 0 0 0 0];
for j = 1:length(gain_h1)
    gain_h1(j) = 20 * log10(RMS_out_h1(j) / RMS_in(j));
end
%plot vs frequencies 
%array of the frequencies
frequencies = [0 pi/5 2*pi/5 3*pi/5 4*pi/5 pi];
plot(frequencies, gain_h1);
%% 1d.) repeat for h2
RMS_out_h2 = [0 0 0 0 0 0];
%find RMS for each signal
for k = 1:length(RMS_out_h2)
    RMS_out_h2(k) = compute_rms(conv(h2,signals{k}));
end
gain_h2 = [0 0 0 0 0 0];
for l = 1:length(gain_h2)
    gain_h2(l) = 20 * log10(RMS_out_h2(l) / RMS_in(l));
end

%plot
plot(frequencies, gain_h2);

%% 2a.) 
%dtft formula is sum of x[n]*e^(-jw) from 0 to N-1. 
function output_dtft = calculate_dtft(x,w)
    %output array init
    output_dtft =zeros(length(w));
    temp1 = 0;
    temp2 = 0;
    temp3 = 0;
    %cant do starting 0. so start from 0 and go to length 
    %%for n  = 1:length(x)
    for i = 1:length(w)
         temp1 = x(1) * exp(-1j * w(i)*0);
         temp2 = x(2) * exp(-1j * w(i)*1);
         temp3 = x(3) * exp(-1j * w(i)*2);
         output_dtft(i) = temp1+temp2+temp3;
        %output_dtft(n) = output_dtft(n) + x(n) * exp(-1j * w(i));
    end
    %%end
end

%% 2b.) 
%create input w for -3pi to 3pi
freq = [-3*pi : 0.001: 3*pi];
freq_length = length(freq);
freq2 = [-3*pi, 0, 3*pi];
%apply func
dtft_h1 = calculate_dtft(h1, freq);
dtft_h1 = dtft_h1(:,1);
%dtft_h1 = tranpose(dtft_h1);
dtft_h2 = calculate_dtft(h2, freq);
dtft_h2 = dtft_h2(:,1);
%dtft_h2 = tranpose(dtft_h2);

%% 2c.) magnitude vs frequencies
plot(freq, abs(dtft_h1));
%plot(freq, abs(dtft_h2));

%% 3a. )
%Gaussian white noise would be random with a standard deviation of 1. Ask
%the TA what the deviation should be, if this right
guass = randn(1,1000);
guass_h1 = conv(h1, guass);
guass_h2 = conv(h2, guass);

dtft_h1_guass = calculate_dtft(guass_h1, freq);
dtft_h1_guass = dtft_h1_guass(:,1);
dtft_h2_guass = calculate_dtft(guass_h2, freq);
dtft_h2_guass = dtft_h2_guass(:,1);
%% 3b.)
figure;
subplot(2, 1, 1);
plot(freq,abs(dtft_h1_guass));  % Magnitude of DTFT for h1 convolution
grid on;
subplot(2, 1, 2);
plot(freq, abs(dtft_h2_guass));  % Magnitude of DTFT for h2 convolution
grid on;