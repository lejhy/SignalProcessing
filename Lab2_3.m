clear all; close all;

Ac = 2;
fc = 600;
wc = fc*2*pi;
fm = 30;
wm = fm*2*pi;
Am = [0.4, 0.8, 1.2, 1.6, 2];
t = [0:0.00001:1];

figure;
set(gcf,'position', [0,0,800, 600]);
    
hold on;
for i = 1:length(Am) 
    m = Am(i)/Ac;
    n = length(t);
    f = (0:n-1)*(100000/n);
    vm = Ac.*(1+m.*cos(wm.*t)).*cos(wc.*t);
    x = fft(vm);
    peak = abs(max(x(1:n/2)));
    temp = sort(x(1:n/2), 'descend');
    sidebandsAmp = abs(mean(temp(2:3)));
    stem(m, sidebandsAmp/peak);
    if i < length(Am)
        text(m+0.01, sidebandsAmp/peak+0.02, [num2str(sidebandsAmp/peak,1), ' V']);
    else
        text(m-0.01, sidebandsAmp/peak+0.02, [num2str(sidebandsAmp/peak,1), ' V'], 'HorizontalAlignment', 'right');
    end
end

title("Sidebands amplitude over modulation index m");
xlabel("Modulation index m");
ylabel("Sidebands amplitude [V]");