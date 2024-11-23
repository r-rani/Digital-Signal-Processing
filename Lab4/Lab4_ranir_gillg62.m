%%1a DFT Function 
function output_dtft = calculate_dtft(x,w)
    output_dtft =zeros(1,length(w));
    for i = 1:length(w)
        temp1=0;
        freq = w(i);
        for n = 1:length(x)
            temp1 = temp1 + x(n) * exp(-1j * freq*(n-1));
        end 
        output_dtft(i) = temp1;
    end
end
%DFT function: updated last labs dtft function as shown above 
function output_dft = calculate_dft(x)
    output_dft =zeros(1,length(x));
    for k = 0:length(x)-1
        for n = 0:length(x)-1
            output_dft(k+1)=output_dft(k+1) + x(n+1) * exp((-1j * 2 * pi * k * n )/ length(x));
        end
    end
end
%%
%1b COmpute the DFT of a rectangular signal
%DFT is stem because it is a discrete signal 
N = [16,32,64,128,256];
DFT = zeros(1:length(N));
%make signal using piecewise func 
%zero padding 
x_n1 = [ones(1,16),zeros(1,N(1)-16)];
x_n2 = [ones(1,16),zeros(1,N(2)-16)];
x_n3 = [ones(1,16),zeros(1,N(3)-16)];
x_n4 = [ones(1,16),zeros(1,N(4)-16)];
x_n5 = [ones(1,16),zeros(1,N(5)-16)];
%looks weird with plot func keep as plot
tiledlayout(2,3)
nexttile;
stem(abs(calculate_dft(x_n1)));
title("Magnitude of DFT for N=16");
xlabel("Frequency");
ylabel("Magntude");
nexttile;
stem(abs(calculate_dft(x_n2)));
title("Magnitude of DFT for N=32");
xlabel("Frequency");
ylabel("Magntude");
nexttile;
stem(abs(calculate_dft(x_n3)));
title("Magnitude of DFT for N=64");
xlabel("Frequency");
ylabel("Magntude");
nexttile;
stem(abs(calculate_dft(x_n4)));
title("Magnitude of DFT for N=128");
xlabel("Frequency");
ylabel("Magntude");
nexttile;
stem(abs(calculate_dft(x_n5)));
title("Magnitude of DFT for N=256");
xlabel("Frequency");
ylabel("Magntude");
%Adding zero padding improves frequency resolution because it adds points 

%%
%1c DTFT of the same input set
%make freq for dftf
w1 = linspace(0, 2*pi, N(1));
w2 = linspace(0, 2*pi, N(2));
w3 = linspace(0, 2*pi, N(3));
w4 = linspace(0, 2*pi, N(4));
w5 = linspace(0, 2*pi, N(5));

tiledlayout(2,3)
nexttile;
plot(abs(calculate_dtft(x_n1, w1)));
title("Magnitude of DTFT for N=16");
xlabel("Frequency");
ylabel("Magntude");
nexttile;
plot(abs(calculate_dtft(x_n2, w2)));
title("Magnitude of DTFT for N=32");
xlabel("Frequency");
ylabel("Magntude");
nexttile;
plot(abs(calculate_dtft(x_n3, w3)));
title("Magnitude of DTFT for N=64");
xlabel("Frequency");
ylabel("Magntude");
nexttile;
plot(abs(calculate_dtft(x_n4, w4)));
title("Magnitude of DTFT for N=128");
xlabel("Frequency");
ylabel("Magntude");
nexttile;
plot(abs(calculate_dtft(x_n5, w5)));
title("Magnitude of DTFT for N=256");
xlabel("Frequency");
ylabel("Magntude");

%%
%1d.) FFT
tiledlayout(2,3)
nexttile;
plot(abs(fft(x_n1)));
title("Magnitude of FFT for N=16");
xlabel("Frequency");
ylabel("Magntude");
nexttile;
plot(abs(fft(x_n2)));
title("Magnitude of FFT for N=32");
xlabel("Frequency");
ylabel("Magntude");
nexttile;
plot(abs(fft(x_n3)));
title("Magnitude of FFT for N=64");
xlabel("Frequency");
ylabel("Magntude");
nexttile;
plot(abs(fft(x_n4)));
title("Magnitude of FFT for N=128");
xlabel("Frequency");
ylabel("Magntude");
nexttile;
plot(abs(fft(x_n5)));
title("Magnitude of FFT for N=256");
xlabel("Frequency");
ylabel("Magntude");

%%
%1d Comparisons
tiledlayout(5,3)
nexttile;
stem(abs(calculate_dft(x_n1)));
title("Magnitude of DFT for N=16");
xlabel("Frequency");
ylabel("Magntude");
nexttile;
plot(abs(calculate_dtft(x_n1, w1)));
title("Magnitude of DTFT for N=16");
xlabel("Frequency");
ylabel("Magntude");
nexttile;
stem(abs(fft(x_n1)));
title("Magnitude of FFT for N=16");
xlabel("Frequency");
ylabel("Magntude");

nexttile;
stem(abs(calculate_dft(x_n2)));
title("Magnitude of DFT for N=32");
xlabel("Frequency");
ylabel("Magntude");
nexttile;
plot(abs(calculate_dtft(x_n2, w2)));
title("Magnitude of DTFT for N=32");
xlabel("Frequency");
ylabel("Magntude");
nexttile;
stem(abs(fft(x_n2)));
title("Magnitude of FFT for N=32");
xlabel("Frequency");
ylabel("Magntude");

nexttile;
stem(abs(calculate_dft(x_n3)));
title("Magnitude of DFT for N=64");
xlabel("Frequency");
ylabel("Magntude");
nexttile;
plot(abs(calculate_dtft(x_n3, w3)));
title("Magnitude of DTFT for N=64");
xlabel("Frequency");
ylabel("Magntude");
nexttile;
stem(abs(fft(x_n3)));
title("Magnitude of FFT for N=64");
xlabel("Frequency");
ylabel("Magntude");

nexttile;
stem(abs(calculate_dft(x_n4)));
title("Magnitude of DFT for N=128");
xlabel("Frequency");
ylabel("Magntude");
nexttile;
plot(abs(calculate_dtft(x_n4, w4)));
title("Magnitude of DTFT for N=128");
xlabel("Frequency");
ylabel("Magntude");
nexttile;
stem(abs(fft(x_n4)));
title("Magnitude of FFT for N=128");
xlabel("Frequency");
ylabel("Magntude");

nexttile;
stem(abs(calculate_dft(x_n5)));
title("Magnitude of DFT for N=256");
xlabel("Frequency");
ylabel("Magntude");
nexttile;
plot(abs(calculate_dtft(x_n5, w5)));
title("Magnitude of DTFT for N=256");
xlabel("Frequency");
ylabel("Magntude");
nexttile;
stem(abs(fft(x_n5)));
title("Magnitude of FFT for N=256");
xlabel("Frequency");
ylabel("Magntude");
%%
%
