clear all; close all;

Ac = 2;
fc = 600;
wc = fc*2*pi;
fm = 30;
wm = fm*2*pi;
Am = [0.4, 0.8, 1.2, 1.6, 2];
t = [0:0.00001:1];

hold on;
for i = 1:length(Am) 
    m = Am(i)/Ac;
    n = length(t);
    f = (0:n-1)*(100000/n);
    vm = Ac.*(1+m.*cos(wm.*t)).*cos(wc.*t);
    x = fft(vm);
    peak = max(x(1:n/2));
    temp = sort(x(1:n/2), 'descend');
    sidebandsAmp = mean(temp(2:3));
    plot(m, sidebandsAmp/peak, 'o');
end