clear all;

f = 1:1:300;
G = 10.*((sin(pi*f*10.^(-2)))./(pi*f*10.^(-2))).^(2);

f1 = figure;
set(gcf,'position', [0,0,800, 600]);
plot(f,G);
title("G(f) frequency spectrum");
xlabel("Frequency [Hz]");
ylabel("Power [V^2]");

G_dB = 10.*log10(G);

f2 = figure;
set(gcf,'position', [0,0,800, 600]);
plot(f,G_dB);
title("G(f) frequency spectrum");
xlabel("Frequency [Hz]");
ylabel("Power [dB]");

maxPower = max(G_dB);
halfPower = maxPower - 3;
quarterPower = maxPower - 6;
halfPower_F = find(G_dB > halfPower);
halfPower_F = halfPower_F(end);
quarterPower_F = find(G_dB > quarterPower);
quarterPower_F = quarterPower_F(end);

hold on;
plot(halfPower_F, halfPower, 'o');
text(halfPower_F, halfPower+10, ['-3dB, ',num2str(halfPower_F),'Hz'], 'HorizontalAlignment', 'right');
plot(quarterPower_F, quarterPower, 'o');
text(quarterPower_F, quarterPower+10, ['-6dB, ',num2str(quarterPower_F),'Hz'], 'HorizontalAlignment', 'left');
hold off;