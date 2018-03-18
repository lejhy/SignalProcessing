clear all; close all;

load handel.mat;

sigma_squared = [0.001, 0.01, 0.1, 0.5, 1, 2];
sigma = sqrt(sigma_squared);

figure;
set(gcf,'position', [0,0,800, 600]);
hold on;
box on;
for i = 1:length(sigma) 
    noise = sigma(i)*randn([length(y), 1]);
    x = y + noise;
    r = snr(y, noise);
    
    stem(sigma_squared(i), r);
    if i < length(sigma) 
        text(sigma_squared(i)+0.03, r, [num2str(r), ' dB']);
        text(sigma_squared(i)+0.03, r-1.5, ['\sigma^2 = ', num2str(sigma_squared(i))]);
    else 
        text(sigma_squared(i)-0.03, r, [num2str(r), ' dB'], 'HorizontalAlignment', 'right');
        text(sigma_squared(i)-0.03, r-1.5, ['\sigma^2 = ', num2str(sigma_squared(i))], 'HorizontalAlignment', 'right');
    end
    sound(x, Fs);
    pause(length(x)/Fs);
end
hold off;
title("SNR over \sigma^2");
xlabel("\sigma^2");
ylabel("SNR [dB]");