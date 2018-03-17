clear all; close all;


m = 0.3;
fm = 2;
wm = fm*2*pi;
fc = 100;
wc = fc*2*pi;
Ac = 1; %unknown, lets leave it normalized
t = [0:0.0001:10];
n = length(t);
fs = length(t)/t(end);

sigma_squared = [0.05, 0.1, 0.5, 1];
sigma = sqrt(sigma_squared);

figure("Name", "Effect of noise");
for i = 1:length(sigma)
    vm = Ac.*(1+m.*cos(wm.*t)).*cos(wc.*t);
    v_orig = Ac*m.*cos(wm.*t);
    noise = sigma(i)*randn([1, length(t)]);
    
    signal = vm + noise;
    
    [b,a] = butter(4, [50, 150]/(fs/2), 'bandpass');
    signal = filter(b, a, signal);
    
    [yupper, ylower] = envelope(vm);
    
    subplot(length(sigma), 3, (i-1)*3+1);
    plot (t, vm, t, yupper, t, ylower);
    
    [yupper, ylower] = envelope(signal);
    
    subplot(length(sigma), 3, (i-1)*3+2);
    plot (t, signal, t, yupper, t, ylower);
    
    yupper = yupper - mean(yupper);
    RMSE = sqrt(mean((yupper - v_orig).^2));
    
    subplot(length(sigma), 3, (i-1)*3+3);
    stem (sigma_squared(i), RMSE);
end