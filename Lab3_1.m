clear all; close all;

Ec = 2;
fc = 600;
wc = fc*2*pi;
fm = 30;
wm = fm*2*pi;
Em = [0.1, 0.2, 0.3, 0.4, 0.6, 0.8, 1, 1.5, 2];
KFM = 140;
t = 0:0.0001:1;
n = length(t);
fs = n/t(end);
f = 0:fs/n:fs-(fs/n);

B_figure = figure;
set(gcf,'position', [0,0,800, 600]);
    
for i = 1:length(Em)
    B = (KFM*Em(i))/wm;
    eFM = Ec*cos(wc*t+B*sin(wm*t));
    eFM_fs = abs(fft(eFM)/n).*2;
    
    figure;
    set(gcf,'position', [0,0,800, 600]);
    plot(t, eFM);
    title(['Modulated signal for \beta=', num2str(B)]);
    xlabel("Time [s]");
    ylabel("Magnitude [V]");

    figure;
    set(gcf,'position', [0,0,800, 600]);
    stem(f(1:1200), eFM_fs(1:1200));
    title(['Frequency spectrum of modulated signal for \beta = ', num2str(B)]);
    xlabel("Frequency [Hz]");
    ylabel("Magnitude [V]");
    
    figure(B_figure);
    hold on;
    box on;
    set(gcf,'position', [0,0,800, 600]);
    stem(Em(i), B);
    if i < length(Em)
        text(Em(i)+0.02,B-0.01,num2str(B));
    else 
        text(Em(i)-0.02,B-0.01,num2str(B),'HorizontalAlignment', 'right');
    end
    hold off;
end

title("Frequency modulation index \beta over A_m");
xlabel("A_m [V]");
ylabel("Modulation index \beta");
