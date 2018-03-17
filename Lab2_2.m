clear all; close all;

Ac = 2;
fc = 600;
wc = fc*2*pi;
fm = [15, 20, 30];
Am = 0.8;
m = Am/Ac;
t = 0:0.00001:1;
n = length(t);
fs = n/t(end);
f = 0:fs/n:fs-(fs/n);

for i = 1:length(fm) 
    wm = fm(i)*2*pi;
    
    figure;
    set(gcf,'position', [0,0,800, 600]);
    vm = Ac.*(1+m.*cos(wm.*t)).*cos(wc.*t);
    x = abs(fft(vm)/n).*2;
    stem(f(550:650), x(550:650));
    title(['DSB-AM for fm = ', num2str(fm(i))]);
    xlabel('Frequency [Hz]');
    ylabel('Magnitude [V]');
    axis([550 650 0 2]);
    
    figure;
    set(gcf,'position', [0,0,800, 600]);
    vm = Ac.*(m.*cos(wm.*t)).*cos(wc.*t);
    x = abs(fft(vm)/n).*2;
    stem(f(550:650), x(550:650));
    title(['DSB-SC for fm = ', num2str(fm(i)), 'Hz']);
    xlabel('Frequency [Hz]');
    ylabel('Magnitude [V]');
    axis([550 650 0 2]);
end