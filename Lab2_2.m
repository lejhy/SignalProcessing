clear all; close all;

Ac = 2;
fc = 600;
wc = fc*2*pi;
fm = [15, 20, 30];
Am = 0.8;
m = Am/Ac;
t = 0:0.00001:1;

figure("Name", "Modulated signals");
for i = 1:length(fm) 
    wm = fm(i)*2*pi;
    n = length(t);
    f = (0:n-1)*(100000/n);
    vm = Ac.*(1+m.*cos(wm.*t)).*cos(wc.*t);
    x = fft(vm);
    subplot(length(fm), 2, (i-1)*2+1);
    stem(f(550:650), x(550:650));
    title("Full-AM");
    axis([550 650 -20000 120000]);
    vm = Ac.*(m.*cos(wm.*t)).*cos(wc.*t);
    x = fft(vm);
    subplot(length(fm), 2, (i-1)*2+2);
    stem(f(550:650), x(550:650));
    title("DSB-SC");
    axis([550 650 -20000 120000]);
end