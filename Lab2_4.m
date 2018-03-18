clear all; close all;


m = 0.3;
fm = 2;
wm = fm*2*pi;
fc = 100;
wc = fc*2*pi;
Ac = 1; %unknown, lets leave it normalized
t = [0:0.001:10];
n = length(t);
fs = length(t)/t(end);

sigma_squared = [0, 0.05, 0.1, 0.5, 1];
sigma = sqrt(sigma_squared);

rmse_figure = figure;
set(gcf,'position', [0,0,800, 600]);

for i = 1:length(sigma)
    vm = Ac.*(1+m.*cos(wm.*t)).*cos(wc.*t);
    v_orig = Ac*m.*cos(wm.*t);
    noise = sigma(i)*randn([1, length(t)]);
    
    signal = vm + noise;
    
    [b,a] = butter(4, [50, 150]/(fs/2), 'bandpass');
    signal = filter(b, a, signal);
    
    [yupper, ylower] = envelope(vm);
    
    figure;
    set(gcf,'position', [0,0,800, 600]);
    plot (t, vm, t, yupper, t, ylower);
    title(['Input signal for \sigma^2=', num2str(sigma_squared(i))]);
    xlabel("Time [s]");
    ylabel("Magnitude [V]");
    
    [yupper, ylower] = envelope(signal);
    
    figure;
    set(gcf,'position', [0,0,800, 600]);
    plot (t, signal, t, yupper, t, ylower);
    title(['Output signal for \sigma^2=', num2str(sigma_squared(i))]);
    xlabel("Time [s]");
    ylabel("Magnitude [V]");
    
    yupper = yupper - mean(yupper);
    RMSE = sqrt(mean((yupper - v_orig).^2));
    
    figure(rmse_figure);
    hold on;
    box on;
    stem (sigma_squared(i), RMSE);
    if i < length(sigma)
        text(sigma_squared(i)+0.01, RMSE-0.001, num2str(RMSE));
    else
        text(sigma_squared(i)-0.01, RMSE-0.001, num2str(RMSE), 'HorizontalAlignment', 'right');
    end
    hold off;
end

title(['RMSE over \sigma^2']);
xlabel("Variance \sigma^2");
ylabel("RMSE");