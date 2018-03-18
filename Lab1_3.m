clear all; close all;

N = 10000;
k = [5, 10, 15];
sigma_squared = [0.001, 0.1, 1, 10, 100];
sigma = sqrt(sigma_squared);

for i = 1:length(sigma)
    x = sigma(i).*randn([N, 1]);
    for j = 1:length(k)
        [r, lags] = xcorr(x, k(j));
        plot(x);
        figure;
        set(gcf,'position', [0,0,800, 600]);
        stem(lags, r);
        title(['Gaussian random noise auto-correlation for \sigma^2=',num2str(sigma_squared(i))]);
        xlabel("Lagg");
        ylabel("Auto-correlation value");
    end
end

x = wgn(N, 1, 0);
[r, lags] = xcorr(x, 15);
plot(x);
figure;
set(gcf,'position', [0,0,800, 600]);
stem(lags, r);
title("White Gaussian noise auto-correlation");
xlabel("Lagg");
ylabel("Auto-correlation value");
