clear all; close all;

Ec = 2;
fc = 600;
wc = fc*2*pi;
fm = 30;
wm = fm*2*pi;
Em = [0.1, 0.2, 0.3, 0.4, 0.6, 0.8, 1, 1.5, 2];
KFM = 140;
t = 0:0.0001:0.1;
fs = 0:1/t(end):length(t)/t(end)-1;

figure("Name", "Modulated FM Signals");
for i = 1:length(Em)
    B = (KFM*Em(i))/wm;
    eFM = Ec*cos(wc*t+B*sin(wm*t));
    subplot(length(Em), 3, (i-1)*3+1);
    plot(t, eFM);
    subplot(length(Em), 3, (i-1)*3+2);
    stem(fs, abs(fft(eFM)));
    subplot(length(Em), 3, (i-1)*3+3);
    stem(B);
end
