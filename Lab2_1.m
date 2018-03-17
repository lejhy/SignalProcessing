clear all; close all;

Ac = 2;
fc = 600;
wc = fc*2*pi;
fm = 30;
wm = fm*2*pi;
Am = [0.4, 0.8, 1.2, 1.6, 2];
t = [0:0.0001:0.1];

for i = 1:length(Am) 
    m = Am(i)/Ac;
    g = Am(i).*cos(wm.*t);
    vm = Ac.*(1+m.*cos(wm.*t)).*cos(wc.*t);
    figure;
    hold on;
    box on;
    set(gcf,'position', [0,0,800, 600]);
    plot(t, vm);
    plot(t, g);
    legend('v_m(t)', 'g(t)');
    title(['v_m(t) AM modulated by g(t) with m = ',num2str(m)]);
    xlabel("Time [s]");
    ylabel("Amplitude [V]");
    hold off;
end