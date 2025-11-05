% Modul 4
% Kelompok D1
% Nyolong gedik ndasse

clear; clc;

% --- Gunakan Struct untuk Mengorganisir Data Input ---
data(1).bukaan = '25%';
data(1).delta_H = [0.81 0.023 0.03];
data(1).V = [3.27 3.05 2.64];
data(1).DB5 = [32 33 35];
data(1).WB5 = [25 26 26];
data(1).DB7 = [33 33 51];
data(1).WB7 = [26 28 34];
data(1).W5 = [0.0131 0.0185 0.0177];
data(1).H5 = [76 80.64 80.55];
data(1).W7 = [0.0185 0.0222 0.0273];
data(1).H7 = [80.64 90.06 122.18];

data(2).bukaan = '50%';
data(2).delta_H = [0.033 0.044 0.041]; % Isi data di sini
data(2).V = [5.34 4.85 5.37];
data(2).DB5 = [31 33 34];
data(2).WB5 = [25 26 26];
data(2).DB7 = [33 37 45];
data(2).WB7 = [26 28 33];
data(2).W5 = [0.0175 0.0185 0.0181];
data(2).H5 = [76.05 80.64 80.39];
data(2).W7 = [0.0185 0.0205 0.0276];
data(2).H7 = [80.69 89.88 116.58];

data(3).bukaan = '75%';
data(3).delta_H = [0.125 0.128 0.123]; % Isi data di sini
data(3).V = [8.79 8.43 7.73];
data(3).DB5 = [31 32 33];
data(3).WB5 = [25 25 26];
data(3).DB7 = [33 35 41];
data(3).WB7 = [25 27 31];
data(3).W5 = [0.0175 0.0171 0.0185];
data(3).H5 = [76.04 76.008 80.64];
data(3).W7 = [0.0167 0.0195 0.0248];
data(3).H7 = [75.96 85.25 105.02];

data(4).bukaan = '100%';
data(4).delta_H = [0.161, 0.159, 0.158]; % Isi data di sini
data(4).V = [9.67, 9.54, 9.14];
data(4).DB5 = [31, 33, 33];
data(4).WB5 = [25, 25, 25];
data(4).DB7 = [33, 33, 36];
data(4).WB7 = [25, 26, 29];
data(4).W5 = [0.0175, 0.0167, 0.0167];
data(4).H5 = [76.05, 75.968, 75.968];
data(4).W7 = [0.0167, 0.0185, 0.0219];
data(4).H7 = [75.968, 80.691, 94.571];

% --- Konstanta ---
SG_minyak = 0.89;
rho_H2O = 999; % kg/m3
g = 9.81; % m/s2
rho_5 = 1.157; % kg/m3
A = 0.045; % m2
P_atm = 101325; % Pa

% --- Lakukan Perhitungan dalam Loop ---
for i = 1:length(data)
    % Cek jika data kosong untuk menghindari error
    if isempty(data(i).delta_H)
        % Inisialisasi hasil dengan NaN (Not a Number) jika input kosong
        num_variasi = 3; % Asumsi ada 3 variasi (Low, Medium, High)
        data(i).delta_P = nan(1, num_variasi);
        data(i).P7 = nan(1, num_variasi);
        data(i).rho7 = nan(1, num_variasi);
        data(i).m_dot = nan(1, num_variasi);
        data(i).delta_H_calc = nan(1, num_variasi);
        data(i).Q = nan(1, num_variasi);
        continue; % Lanjut ke iterasi berikutnya
    end
    
    data(i).delta_P = SG_minyak * rho_H2O * g .* data(i).delta_H .* sind(15);
    data(i).P7 = P_atm + data(i).delta_P;
    data(i).rho7 = (data(i).P7 .* data(i).DB5 .* rho_5) ./ (P_atm .* data(i).DB5);
    data(i).m_dot = data(i).rho7 .* data(i).V .* A;
    data(i).delta_H_calc = data(i).H7 - data(i).H5; % Ganti nama agar tidak menimpa delta_H input
    data(i).Q = data(i).m_dot .* data(i).delta_H_calc;
end

% --- Cetak Output ---
labels = {'Low', 'Medium', 'High'};

% Definisikan format untuk satu blok data. Ini memastikan konsistensi.
data_format = '%-10.2f %-10.0f %-10.2f %-10.2f %-10.2f %-10.2f ';
header_format = '%-10s %-10s %-10s %-10s %-10s %-10s ';

% --- Cetak Tabel 1 (25% dan 50%) ---
fprintf('\n--- Tabel untuk Bukaan 25%% dan 50%% ---\n');
fprintf('======================================================================================================================\n');
fprintf('%-15s', 'Variasi Bukaan');
for i = 1:2 % Loop hanya untuk data(1) dan data(2)
    fprintf('| %-66s', data(i).bukaan);
end
fprintf('|\n');

fprintf('%-15s', 'Heater Setting');
for i = 1:2 % Loop hanya untuk data(1) dan data(2)
    fprintf(['| ' header_format], 'delta_P', 'P7', 'rho_7', 'm_dot', 'delta_H', 'Q');
end
fprintf('|\n');
fprintf('======================================================================================================================\n');

% Cetak Data untuk Tabel 1
for j = 1:length(labels)
    fprintf('%-15s', labels{j});
    for i = 1:2 % Loop hanya untuk data(1) dan data(2)
        fprintf(['| ' data_format], ...
            data(i).delta_P(j), data(i).P7(j), data(i).rho7(j), ...
            data(i).m_dot(j), data(i).delta_H_calc(j), data(i).Q(j));
    end
    fprintf('|\n');
end
fprintf('======================================================================================================================\n');


% --- Cetak Tabel 2 (75% dan 100%) ---
fprintf('\n\n--- Tabel untuk Bukaan 75%% dan 100%% ---\n');
fprintf('======================================================================================================================\n');
fprintf('%-15s', 'Variasi Bukaan');
for i = 3:4 % Loop hanya untuk data(3) dan data(4)
    fprintf('| %-66s', data(i).bukaan);
end
fprintf('|\n');

fprintf('%-15s', 'Heater Setting');
for i = 3:4 % Loop hanya untuk data(3) dan data(4)
    fprintf(['| ' header_format], 'delta_P', 'P7', 'rho_7', 'm_dot', 'delta_H', 'Q');
end
fprintf('|\n');
fprintf('======================================================================================================================\n');

% Cetak Data untuk Tabel 2
for j = 1:length(labels)
    fprintf('%-15s', labels{j});
    for i = 3:4 % Loop hanya untuk data(3) dan data(4)
        fprintf(['| ' data_format], ...
            data(i).delta_P(j), data(i).P7(j), data(i).rho7(j), ...
            data(i).m_dot(j), data(i).delta_H_calc(j), data(i).Q(j));
    end
    fprintf('|\n');
end
fprintf('======================================================================================================================\n');


% --- Pengambilan Data untuk Plotting ---
% Siapkan sumbu-X (persentase bukaan)
bukaan_percent = [25, 50, 75, 100];

% Siapkan array kosong untuk menampung data yang sudah diurutkan
m_dot_low = [];
Q_low = [];
m_dot_medium = [];
Q_medium = [];
m_dot_high = [];
Q_high = [];

% Loop melalui setiap bukaan (25%, 50%, dst.) untuk mengambil data
for i = 1:length(data)
    % Ambil data 'Low' (elemen ke-1 dari setiap array)
    m_dot_low(end+1) = data(i).m_dot(1);
    Q_low(end+1) = data(i).Q(1);
    
    % Ambil data 'Medium' (elemen ke-2 dari setiap array)
    m_dot_medium(end+1) = data(i).m_dot(2);
    Q_medium(end+1) = data(i).Q(2);
    
    % Ambil data 'High' (elemen ke-3 dari setiap array)
    m_dot_high(end+1) = data(i).m_dot(3);
    Q_high(end+1) = data(i).Q(3);
end


% --- Membuat 3 Plot dalam Satu Figure (Subplot) ---
point_labels = {' A', ' B', ' C', ' D'}; % Label untuk titik A, B, C, D

figure; % Membuat SATU window plot baru
% sgtitle('Hubungan Laju Aliran Massa (m) dan Perpindahan Panas (Q)'); % Judul utama untuk seluruh figure

% --- Subplot 1: Heater Setting "Low" ---
subplot(3, 1, 1); % Grid 3 baris, 1 kolom, pilih plot ke-1
plot(m_dot_low, Q_low, '-o'); 
hold on;
for i = 1:length(m_dot_low)
    text(m_dot_low(i), Q_low(i), point_labels{i}, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left');
end
hold off;
title('Heater Setting: Low');
ylabel('Q (kJ/s)');
grid on;

% --- Subplot 2: Heater Setting "Medium" ---
subplot(3, 1, 2); % Grid 3 baris, 1 kolom, pilih plot ke-2
plot(m_dot_medium, Q_medium, '-s', 'Color', [0.8500 0.3250 0.0980]); % Warna oranye
hold on;
for i = 1:length(m_dot_medium)
    text(m_dot_medium(i), Q_medium(i), point_labels{i}, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left');
end
hold off;
title('Heater Setting: Medium');
ylabel('Q (kJ/s)');
grid on;

% --- Subplot 3: Heater Setting "High" ---
subplot(3, 1, 3); % Grid 3 baris, 1 kolom, pilih plot ke-3
plot(m_dot_high, Q_high, '-^', 'Color', [0.9290 0.6940 0.1250]); % Warna kuning
hold on;
for i = 1:length(m_dot_high)
    text(m_dot_high(i), Q_high(i), point_labels{i}, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left');
end
hold off;
title('Heater Setting: High');
xlabel('m (kg/s)'); % Label X cukup di plot paling bawah
ylabel('Q (kJ/s)');
grid on;