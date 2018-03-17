clear all; close all;

load handel.mat;

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

figure("Name", "Effect of noise");

subplot(3, 2, 1);
plot (t, y);
subplot(3, 2, 2);
plot (fs, abs(fft(y)));

sound(y, Fs);
pause(length(y)/Fs);

[b, a] = butter(20, (4000)/(Fs/2));
vm = (Ac + y).*cos(wc.*t);

[yupper, ylower] = envelope(vm);

subplot(3, 2, 3);
plot (t, vm);
subplot(3, 2, 4);
plot (fs, abs(fft(vm)));

vl0 = Ac*cos(wc*t);

vo = vm .* vl0;

vo = filter(b, a, vo);
vo = (vo - mean(vo))*2;

subplot(3, 2, 5);
plot (t, vo);
subplot(3, 2, 6);
plot (fs, abs(fft(vo)));

sound(vo, Fs);
pause(length(y)/Fs);

vl85 = Ac*cos(wc*t+degtorad(85));

vo = vm .* vl85;

vo = filter(b, a, vo);
vo = (vo - mean(vo))*2;

subplot(3, 2, 5);
plot (t, vo);
subplot(3, 2, 6);
plot (fs, abs(fft(vo)));

sound(vo, Fs);
pause(length(y)/Fs);


    
