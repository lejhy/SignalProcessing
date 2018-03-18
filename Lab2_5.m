clear all; close all;

load handel.mat;

sound(y, Fs);
pause(length(y)/Fs);

t = [0:1/Fs:(length(y)-1)/Fs];
t_interp = linspace(min(t), max(t), 5*length(t));
y = interp1(t, y, t_interp, 'linear');

Fs = Fs * 5;

Ac = 1;
m = max(y)/Ac;
fc = 6000;
wc = fc*2*pi;
n = length(y);

t = [0:1/Fs:(n-1)/Fs];
fs = [0:1/t(end):(length(t)-1)/t(end)];
y_fs = abs(fft(y)/n).*2;

figure;
set(gcf,'position', [0,0,800, 600]);
plot (t, y);
title("Input signal");
xlabel("time [s]");
ylabel("Magnitude [V]");

figure;
set(gcf,'position', [0,0,800, 600]);
plot (fs(1:60000), y_fs(1:60000));
title("Frequency spectrum of input signal");
xlabel("Frequency [Hz]");
ylabel("Magnitude [V]");

[b, a] = butter(20, (4000)/(Fs/2));
vm = (Ac + y).*cos(wc.*t);
vm_fs = abs(fft(vm)/n).*2;

[yupper, ylower] = envelope(vm);

figure;
set(gcf,'position', [0,0,800, 600]);
plot (t, vm);
title("Modulated signal");
xlabel("Time [s]");
ylabel("Magnitude [V]");


figure;
set(gcf,'position', [0,0,800, 600]);
plot (fs(1:60000), vm_fs(1:60000));
title("Frequency spectrum of modulated signal");
xlabel("Frequency [Hz]");
ylabel("Magnitude [V]");


vl0 = Ac*cos(wc*t);

vo = vm .* vl0;

vo = filter(b, a, vo);
vo = (vo - mean(vo))*2;
vo_fs = abs(fft(vo)/n).*2;

figure;
set(gcf,'position', [0,0,800, 600]);
plot (t, vo);
title("Demodulated signal with \theta=0^{\circ}");
xlabel("Time [s]");
ylabel("Magnitude [V]");


figure;
set(gcf,'position', [0,0,800, 600]);
plot (fs(1:60000), vo_fs(1:60000));
title("Frequency spectrum of demodulated signal with \theta=0^{\circ}");
xlabel("Frequency [Hz]");
ylabel("Magnitude [V]");

sound(vo, Fs);
pause(length(y)/Fs);

vl85 = Ac*cos(wc*t+degtorad(85));

vo = vm .* vl85;

vo = filter(b, a, vo);
vo = (vo - mean(vo))*2;
vo_fs = abs(fft(vo)/n).*2;

figure;
set(gcf,'position', [0,0,800, 600]);
plot (t, vo);
title("Demodulated signal with \theta=85^{\circ}");
xlabel("Time [s]");
ylabel("Magnitude [V]");


figure;
set(gcf,'position', [0,0,800, 600]);
plot (fs(1:60000), vo_fs(1:60000));
title("Frequency spectrum of demodulated signal with \theta=85^{\circ}");
xlabel("Frequency [Hz]");
ylabel("Magnitude [V]");

sound(vo, Fs);
pause(length(y)/Fs);


    
