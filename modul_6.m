% Modul 6 - Humidifikasi

% variabel
% format = [25% 50% 75% 100%]
h2 =[85.383 85.339 85.387 90.107];
h3 =[90.107 90.107 82.048 82.065];
w2 =[0.0206 0.0202 0.0208 0.0226]; % kandungan uap air pada udara masuk (kg uap/kg udara kering)
w3 =[0.0226 0.0224 0.0185 0.0192]; % kandungan uap air pada udara keluar (kg uap/kg udara kering)
V = [2.71 5 7.43 9.8]; % m/s
delta_H = [0.018 0.045 0.101 0.159];
TDB2 = [32 32.3 32.3 32]; % suhu udara masuk (C)
TDB3 = [32.3 33 33 32.6]; % suhu udara keluar (C)
TWB2 = [27 28.3 27 28]; % suhu bola basah udara masuk (C)
TWB3 = [28 27.3 26.3 26.3]; % suhu bola basah udara keluar (C)

A = 0.045; % luas penampang (m2)
tetha = 15; % sudut
P1 = 101325; % tekanan udara (Pa)
rho_minyak = 1040.95; % (kg/m3)
g = 9.81; % (m/s2)

% Penurunan tekanan
delta_P = rho_minyak * g .* delta_H .* sind(tetha);

% Kenaikan entalphi udara spesifik
% delta_h = abs(h3 - h2);
delta_h = h3 - h2;

% Perubahan kadar uap air udara spesifik
% delta_w = abs(w3 - w2);
delta_w = w3 - w2;

% Laju aliran massa udara
rho_udara = 1.15; % (kg/m3)
rho = ((P1 - delta_P) / P1) .* (TDB3 ./ TDB2) .* rho_udara; % (kg/m3)
m_dot_udara = rho .* V .* A; % (kg/s)

% Kenaikan entalpi udara tetap
delta_H = m_dot_udara .* delta_h;

% Penambahan kadar uap air total
delta_W = m_dot_udara .* delta_w;

% Jumlah kalor tetap yang diserap udara
hw = 419.17; % @100C (kJ/kg)
Q = m_dot_udara .* delta_h + delta_W .* hw; % (kW)

% fprint hasil
k = [25 50 75 100];
% Header
fprintf('=======================================================================================================\n');
fprintf('Variasi(%%) \t delta_P \t delta_h \t delta_w \t rho \t\t m_dot_a \t delta_H \t delta_W \t Q\n');
fprintf('=======================================================================================================\n');

% Loop ini bekerja sama baiknya untuk vektor baris maupun kolom
for i = 1:length(k)
    fprintf('%-3d \t\t %-7.3f \t %-7.3f \t %-7.4f \t %-7.3f \t %-7.3f \t %-7.3f \t %-7.4f \t %-7.3f\n', ...
            k(i), delta_P(i), delta_h(i), delta_w(i), rho(i), m_dot_udara(i), delta_H(i), delta_W(i), Q(i));
end
fprintf('=======================================================================================================\n');

% Plotting Hasil
figure;

% Plot 1: (m_dot_udara, Q)
subplot(2, 2, 1);
plot(m_dot_udara, Q, 'o-');
title('Q vs Laju Aliran Massa Udara');
xlabel('Laju Aliran Massa Udara (kg/s)');
ylabel('Jumlah Kalor (kW)');
grid on;

% Plot 2: (k, delta_h)
subplot(2, 2, 2);
plot(k, delta_h, 'o-');
title('Kenaikan Entalpi vs Variasi');
xlabel('Variasi (%)');
ylabel('Kenaikan Entalpi Spesifik (kJ/kg)');
grid on;

% Plot 3: (k, delta_w)
subplot(2, 2, 3);
plot(k, delta_w, 'o-');
title('Perubahan Kadar Uap Air vs Variasi');
xlabel('Variasi (%)');
ylabel('Perubahan Kadar Uap Air (kg uap/kg udara)');
grid on;

% Plot 4: (m_dot_udara, delta_H)
subplot(2, 2, 4);
plot(m_dot_udara, delta_H, 'o-');
title('Kenaikan Entalpi Total vs Laju Aliran Massa Udara');
xlabel('Laju Aliran Massa Udara (kg/s)');
ylabel('Kenaikan Entalpi Total (kW)');
grid on;

% Memberikan judul keseluruhan untuk semua subplot
% sgtitle('Grafik Hasil Eksperimen Humidifikasi');