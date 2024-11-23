%% A)
signal = audioread("aaa.wav");
info = audioinfo("aaa.wav"); %sampling freq is 8000

%% B)
N = 1:300;

plot(N,signal(N)); %period looks to be every 80th sample

%% C)

length1 = 1:80;
length2 = 1:160;

temp1 = calculate_dft(signal(length1)); %find dfts
temp2 = calculate_dft(signal(length2));

dft_oneperiod = zeros(80);
dft_twoperiod = zeros(160);

for i = 1:80

    dft_oneperiod(i) = sqrt((real(temp1(i))^2) + (imag(temp1(i))^2)); %find magnitudes

end

for i = 1:160

    dft_twoperiod(i) = sqrt((real(temp2(i))^2) + (imag(temp2(i))^2));

end

dft_oneperiod = dft_oneperiod(:,1);
dft_twoperiod = dft_twoperiod(:,1);

subplot(2,1,1);
plot(length1,dft_oneperiod(length1)); %plot
subtitle("DFT of One Period")

subplot(2,1,2);
plot(length2,dft_twoperiod(length2));
subtitle("DFT of Two Periods")

%% D)

dft_oneperiod_zeropad = zeros(1024);
dft_twoperiod_zeropad = zeros(1024);

temp3 = floor(1024/80); %where to put the zero padding
temp4 = floor(1024/160);

length3 = 1:1024;
%{
for i = 2:80

    dft_oneperiod_zeropad(1) = dft_oneperiod(1);
    dft_oneperiod_zeropad(((i-1)*temp3)+2) = dft_oneperiod(i); %zeropads by adding 12 zeros between

end

for i = 2:160

    dft_twoperiod_zeropad(1) = dft_twoperiod(1);
    dft_twoperiod_zeropad(((i-1)*temp4)+2) = dft_twoperiod(i); 

end
%}

dft_oneperiod_zeropad(1:80) = dft_oneperiod(1:80);
dft_twoperiod_zeropad(1:160) = dft_twoperiod(1:160);

temp5 = calculate_dft(dft_oneperiod_zeropad); %find dft
temp6 = calculate_dft(dft_twoperiod_zeropad);

dft_oneperiod_zeropad = dft_oneperiod_zeropad(:,1);
dft_twoperiod_zeropad = dft_twoperiod_zeropad(:,1);

for i = length3

    dft_oneperiod_zeropad(i) = sqrt((real(temp5(i))^2) + (imag(temp5(i))^2)); %find magnitude
    dft_twoperiod_zeropad(i) = sqrt((real(temp6(i))^2) + (imag(temp6(i))^2));

end

subplot(2,1,1);
plot(dft_oneperiod_zeropad);
subtitle("DFT of One Period");

subplot(2,1,2);
plot(dft_twoperiod_zeropad);
subtitle("DFT of Two Periods");

%% E)

win1 = 80;
win2 = 80*2;
win3 = 80*3;
win4 = 80*4;
win5 = 80*5;

tempwin1 = signal(1:win1);
tempwin2 = signal(1:win2);
tempwin3 = signal(1:win3);
tempwin4 = signal(1:win4);
tempwin5 = signal(1:win5);

temp7 = calculate_dft(tempwin1);
temp8 = calculate_dft(tempwin2);
temp9 = calculate_dft(tempwin3);
temp10 = calculate_dft(tempwin4);
temp11 = calculate_dft(tempwin5);

dft_win1 = zeros(win1);
dft_win2 = zeros(win2);
dft_win3 = zeros(win3);
dft_win4 = zeros(win4);
dft_win5 = zeros(win5);


for i = 1:80

    dft_win1(i) = sqrt((real(temp7(i))^2) + (imag(temp7(i))^2)); %find magnitudes

end
for i = 1:160

    dft_win2(i) = sqrt((real(temp8(i))^2) + (imag(temp8(i))^2)); %find magnitudes

end
for i = 1:240

    dft_win3(i) = sqrt((real(temp9(i))^2) + (imag(temp9(i))^2)); %find magnitudes

end
for i = 1:320

    dft_win4(i) = sqrt((real(temp10(i))^2) + (imag(temp10(i))^2)); %find magnitudes

end
for i = 1:400

    dft_win5(i) = sqrt((real(temp11(i))^2) + (imag(temp11(i))^2)); %find magnitudes

end

dft_win1 = dft_win1(:,1);
dft_win2 = dft_win2(:,1);
dft_win3 = dft_win3(:,1);
dft_win4 = dft_win4(:,1);
dft_win5 = dft_win5(:,1);

subplot(5,1,1);
plot(1:win1,dft_win1);
subtitle("DFT Window 1")

subplot(5,1,2);
plot(1:win2,dft_win2);
subtitle("DFT Window 2")

subplot(5,1,3);
plot(1:win3,dft_win3);
subtitle("DFT Window 3")

subplot(5,1,4);
plot(1:win4,dft_win4);
subtitle("DFT Window 4")

subplot(5,1,5);
plot(1:win5,dft_win5);
subtitle("DFT Window 5")


%% 1a DFT Function 
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