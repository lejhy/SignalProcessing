clear all; close all;

load handel.mat

n = length(y);
f = 0:Fs/n:Fs/2;
x = abs(fft(y)/n).*2;
x = x(0:n/2);
psd_dB = 20*log10(x);

sound(y, Fs);
pause (length(y)/Fs);

%part 1
psd_dB_maxPower = max(psd_dB);
psd_dB_quarterPower = psd_dB_maxPower - 6;
psd_dB_quarterPower_F = f(psd_dB > psd_dB_quarterPower);
psd_dB_quarterPower_F_low = psd_dB_quarterPower_F(1);
psd_dB_quarterPower_F_high = psd_dB_quarterPower_F(end);
bandwidth = psd_dB_quarterPower_F_high - psd_dB_quarterPower_F_low;

%plotting
figure;
set(gcf,'position', [0,0,800, 600]);
plot((0:length(y)-1)/Fs, y);
title("Audio signal handel.mat");
xlabel("Time [s]");
ylabel("Amplitude [V]");

figure;
set(gcf,'position', [0,0,800, 600]);
plot(f, psd_dB);
title("Frequency spectrum");
xlabel("Frequency [Hz]");
ylabel("Power [dB]");
hold on;
plot(psd_dB_quarterPower_F_low, psd_dB(f == psd_dB_quarterPower_F_low), 'o');
text(psd_dB_quarterPower_F_low, psd_dB(f == psd_dB_quarterPower_F_low)+7, [num2str(psd_dB_quarterPower_F_low), 'Hz']);
plot(psd_dB_quarterPower_F_high, psd_dB(f == psd_dB_quarterPower_F_high), 'o');
text(psd_dB_quarterPower_F_high, psd_dB(f == psd_dB_quarterPower_F_high)+7, [num2str(psd_dB_quarterPower_F_high), 'Hz']);
hold off;
%/plotting

% %/part 1

%part 2

[b,a] = butter(4, [psd_dB_quarterPower_F_low, psd_dB_quarterPower_F_high]/(Fs/2), 'bandpass');
y_filtered = filter(b, a, y);
[psd_y_filtered, w_y_filtered] = periodogram(y_filtered,[],[],Fs);
psd_y_filtered_dB = 10*log10(psd_y_filtered);
sound (y_filtered, Fs);
pause (length(y_filtered)/Fs);

%plotting
figure;
set(gcf,'position', [0,0,800, 600]);
plot((0:length(y_filtered)-1)/Fs, y_filtered);
title("Audio signal handel.mat (filtered)");
xlabel("Time [s]");
ylabel("Amplitude [V]");

figure;
set(gcf,'position', [0,0,800, 600]);
plot(w_y_filtered, psd_y_filtered_dB);
title("Frequency spectrum (filtered)");
xlabel("Frequency [Hz]");
ylabel("Power [dB]");
%/plotting

%/part 2