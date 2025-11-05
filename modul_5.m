% Inisialisasi variabel untuk data pengukuran
% Ganti nilai placeholder (0) dengan data hasil pengukuran Anda.
% Setiap field berisi satu nilai pengukuran.

clear; clc;

% --- Gunakan Struct untuk Mengorganisir Data Input ---
data(1).bukaan = '25%';
data(1).TDB1 = 43; % Suhu Bola Kering sebelum pemanas (Celsius)
data(1).TDB2 = 46; % Suhu Bola Kering setelah pemanas (Celsius)
data(1).h1   = 151; 
data(1).h2   = 181; 
data(1).h3   = 138; 
data(1).w1   = 0.091;
data(1).w2   = 0.052;
data(1).w3   = 0.033;
data(1).V    = 1.37; 
data(1).h_manometer = 0.026; % Beda tinggi manometer orifice

data(2).bukaan = '50%';
data(2).TDB1 = 42.8;
data(2).TDB2 = 44.8;
data(2).h1   = 143;
data(2).h2   = 178;
data(2).h3   = 127;
data(2).w1   = 0.039;
data(2).w2   = 0.05;
data(2).w3   = 0.029;
data(2).V    = 3.64;
data(2).h_manometer = 0.03;

data(3).bukaan = '75%';
data(3).TDB1 = 42.3;
data(3).TDB2 = 43;
data(3).h1   = 136;
data(3).h2   = 158;
data(3).h3   = 129;
data(3).w1   = 0.036;
data(3).w2   = 0.045;
data(3).w3   = 0.031;
data(3).V    = 4.12;
data(3).h_manometer = 0.034;

data(4).bukaan = '100%';
data(4).TDB1 = 38.6;
data(4).TDB2 = 40;
data(4).h1   = 127;
data(4).h2   = 140;
data(4).h3   = 112;
data(4).w1   = 0.039;
data(4).w2   = 0.039;
data(4).w3   = 0.027;
data(4).V    = 4.39;
data(4).h_manometer = 0.037;

% --- Konstanta ---
h0 = 0.02; % H2O
SG_minyak = 0.89;
rho_H2O = 999; % kg/m3
rho_udara = 1.157; % kg/m3
g = 9.81; % m/s2
% rho_5 = 1.157; % kg/m3
A = 0.045; % m2
P_atm = 101325; % Pa

% --- Lakukan Perhitungan dalam Loop ---
for i = 1:length(data)
    % Cek jika data kosong untuk menghindari error
    if data(i).h_manometer == 0 && data(i).V == 0
        % Inisialisasi hasil dengan NaN (Not a Number) jika input kosong
        data(i).delta_P = NaN;
        data(i).P2 = NaN;
        data(i).rho_2 = NaN;
        data(i).m_dot1 = NaN;
        data(i).m_dot2 = NaN;
        data(i).m_dot3 = NaN;
        continue; % Lanjut ke iterasi berikutnya
    end

    data(i).delta_P = SG_minyak * rho_H2O * g * (data(i).h_manometer - h0) * sind(15); % Pa
    data(i).P2 = P_atm - data(i).delta_P; % Pa
    data(i).rho_2 = ((data(i).P2 * data(i).TDB1) / (P_atm * data(i).TDB2)) * rho_udara; % kg/m3
    data(i).m_dot1 = rho_udara * data(i).V * A; % kg/s
    
    % Hindari pembagian dengan nol jika h1 == h3
    if (data(i).h1 - data(i).h3) == 0
        data(i).m_dot2 = NaN;
    else
        data(i).m_dot2 = data(i).m_dot1 * ((data(i).h1 - data(i).h2) / (data(i).h3 - data(i).h2)); % kg/s
    end
    
    % Hindari pembagian dengan nol jika h3 == 0
    if data(i).h3 == 0
        data(i).m_dot3 = NaN;
    else
        data(i).m_dot3 = ((data(i).m_dot1 * data(i).h1) + (data(i).m_dot2 * data(i).h2)) / data(i).h3; % kg/s
    end
end

% --- Cetak Tabel Output ---
fprintf('\n--- Tabel Hasil Perhitungan ---\n');
fprintf('======================================================================================================\n');
fprintf('%-15s %-12s %-12s %-12s %-12s %-12s %-12s\n', ...
        'Bukaan Plat', 'delta_P', 'P2', 'rho_2', 'm_dot1', 'm_dot2', 'm_dot3');
fprintf('%-15s %-12s %-12s %-12s %-12s %-12s %-12s\n', ...
        '', '(Pa)', '(Pa)', '(kg/m3)', '(kg/s)', '(kg/s)', '(kg/s)');
fprintf('======================================================================================================\n');

% Loop untuk mencetak data dari setiap struct
for i = 1:length(data)
    fprintf('%-15s %-12.3f %-12.3f %-12.3f %-12.3f %-12.3f %-12.3f\n', ...
            data(i).bukaan, data(i).delta_P, data(i).P2, data(i).rho_2, ...
            data(i).m_dot1, data(i).m_dot2, data(i).m_dot3);
end
fprintf('======================================================================================================\n');

% --- Pengambilan Data untuk Plotting ---
bukaan_percent = zeros(1, length(data));
delta_P_vals = zeros(1, length(data));
m_dot1_vals = zeros(1, length(data));
m_dot2_vals = zeros(1, length(data));
m_dot3_vals = zeros(1, length(data));

for i = 1:length(data)
    bukaan_percent(i) = str2double(strrep(data(i).bukaan, '%', ''));
    delta_P_vals(i) = data(i).delta_P;
    m_dot1_vals(i) = data(i).m_dot1;
    m_dot2_vals(i) = data(i).m_dot2;
    m_dot3_vals(i) = data(i).m_dot3;
end

% --- Membuat Plot dalam Satu Figure ---
figure;
% sgtitle('Grafik Hubungan Bukaan Plat Terhadap Parameter Aliran');

% Plot 1: Bukaan Plat vs delta_P
subplot(2, 2, 1);
plot(bukaan_percent, delta_P_vals, '-o', 'LineWidth', 1.5);
title('Bukaan Plat vs \DeltaP');
xlabel('Bukaan Plat (%)');
ylabel('\DeltaP (Pa)');
grid on;
xticks([0 25 50 75 100]);
xlim([0 100]);

% Plot 2: Bukaan Plat vs m_dot1
subplot(2, 2, 2);
plot(bukaan_percent, m_dot1_vals, '-s', 'LineWidth', 1.5, 'Color', [0.8500 0.3250 0.0980]);
title('Bukaan Plat vs Laju Aliran Massa 1');
xlabel('Bukaan Plat (%)');
ylabel('m_{dot1} (kg/s)');
grid on;
xticks([0 25 50 75 100]);
xlim([0 100]);

% Plot 3: Bukaan Plat vs m_dot2
subplot(2, 2, 3);
plot(bukaan_percent, m_dot2_vals, '-^', 'LineWidth', 1.5, 'Color', [0.4660 0.6740 0.1880]);
title('Bukaan Plat vs Laju Aliran Massa 2');
xlabel('Bukaan Plat (%)');
ylabel('m_{dot2} (kg/s)');
grid on;
xticks([0 25 50 75 100]);
xlim([0 100]);

% Plot 4: Bukaan Plat vs m_dot3
subplot(2, 2, 4);
plot(bukaan_percent, m_dot3_vals, '-d', 'LineWidth', 1.5, 'Color', [0.4940 0.1840 0.5560]);
title('Bukaan Plat vs Laju Aliran Massa 3');
xlabel('Bukaan Plat (%)');
ylabel('m_{dot3} (kg/s)');
grid on;
xticks([0 25 50 75 100]);
xlim([0 100]);

