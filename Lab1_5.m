clear all; close all;

load handel.mat;


figure;
set(gcf,'position', [0,0,800, 600]);
hold on;
box on;
bits = [2, 4, 6];
for i = 1:length(bits)
    [partition, codebook] = lloyds(y, 2^bits(i));
    [index, quantized, distor] = quantiz(y, partition, codebook);
    noise = quantized' - y;
    r = snr(y, noise);
    stem(bits(i), r);
    if i < length(bits) 
        text(bits(i)+0.1, r, [num2str(r), ' dB']);
        text(bits(i)+0.1, r-1, [num2str(bits(i)), ' bits']);
    else 
        text(bits(i)-0.03, r, [num2str(r), ' dB'], 'HorizontalAlignment', 'right');
        text(bits(i)-0.1, r-1, [num2str(bits(i)), ' bits'], 'HorizontalAlignment', 'right');
    end
%     sound(quantized, Fs);
%     pause(length(quantized)/Fs);
end
hold off;
title("SNqR over number of bits");
xlabel("Bits");
ylabel("SNqR [dB]");