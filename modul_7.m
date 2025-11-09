% Modul 7 - Dehumidifikasi

# variabel [I II III IV]
% Data untuk katup kapiler
data(1).v = [10 12 14 16];
data(1).DB1 = [33 34 36 34];
data(1).WB1 = [27 28 28 28];
data(1).DB2 = [32 32 33 33];
data(1).WB2 = [26 26 27 27];
data(1).h1 = [85 89 89 90];
data(1).h2 = [81 80.1 85.33 85.3];
data(1).w1 = [0.019 0.022 0.0209 0.0213];
data(1).w2 = [0.0202 0.019 0.0209 0.0209];

% Data untuk katup ekspansi
data(2).v = [10 12 14 16];
data(2).DB1 = [35 36 36 37];
data(2).WB1 = [28 29 29 29];
data(2).DB2 = [33 33 33 34];
data(2).WB2 = [27 28 27 28];
data(2).h1 = [95 89 99 99.6];
data(2).h2 = [90 85.2 85.8 90];
data(2).w1 = [0.0204 0.0228 0.0226 0.0223];
data(2).w2 = [0.0212 0.0222 0.0202 0.0218];

% konstanta
P_atm = 101325; % tekanan atmosfer dalam Pa
A = 0.005771; % luas penampang dalam m^2
rho = 1.225; % massa jenis udara dalam kg/m^3

% Perhitungan untuk kedua set data
for i = 1:2
    % penurunan entalpi
    data(i).delta_h = data(i).h1 - data(i).h2;
    % penurunan kadar uap air
    data(i).delta_w = data(i).w1 - data(i).w2;
    % aliran massa
    data(i).m_dot = rho * A .* data(i).v; % dalam kg/s
    % Jumlah Kalor dilepas
    data(i).Q = data(i).m_dot .* data(i).delta_h; % dalam Watt
end

% Menampilkan hasil dalam bentuk tabel
variasi = ['I   '; 'II  '; 'III '; 'IV  '];

% Tabel untuk Katup Kapiler
fprintf('\n\nTabel Hasil Perhitungan Katup Kapiler\n');
fprintf('=====================================================================================\n');
fprintf('Variasi | v (m/s) | delta_h (kJ/kg) | delta_w (kg/kg) | m_dot (kg/s) | Q (Watt)\n');
fprintf('-------------------------------------------------------------------------------------\n');
for j = 1:4
    fprintf('%s    | %-7.2f | %-15.2f | %-12.4f | %-12.4f | %-8.2f\n', ...
            variasi(j,:), data(1).v(j), data(1).delta_h(j), data(1).delta_w(j), data(1).m_dot(j), data(1).Q(j));
end
fprintf('=====================================================================================\n');

% Tabel untuk Katup Ekspansi
fprintf('\n\nTabel Hasil Perhitungan Katup Ekspansi\n');
fprintf('=====================================================================================\n');
fprintf('Variasi | v (m/s) | delta_h (kJ/kg) | delta_w (kg/kg) | m_dot (kg/s) | Q (Watt)\n');
fprintf('-------------------------------------------------------------------------------------\n');
for j = 1:4
    fprintf('%s    | %-7.2f | %-15.2f | %-15.4f | %-12.4f | %-8.2f\n', ...
            variasi(j,:), data(2).v(j), data(2).delta_h(j), data(2).delta_w(j), data(2).m_dot(j), data(2).Q(j));
end
fprintf('=====================================================================================\n');

% Membuat plot grafik
figure;

% Plot (m_dot, Q)
subplot(3,1,1);
plot(data(1).m_dot, data(1).Q, 'r-o', 'DisplayName', 'Katup Kapiler');
hold on;
plot(data(2).m_dot, data(2).Q, 'b-x', 'DisplayName', 'Katup Ekspansi');
hold off;
title('Grafik Laju Aliran Massa vs Kalor yang Dilepas');
xlabel('Laju Aliran Massa (kg/s)');
ylabel('Kalor yang Dilepas (Watt)');
legend('show');
grid on;

% Plot (m_dot, delta_w)
subplot(3,1,2);
plot(data(1).m_dot, data(1).delta_w, 'r-o', 'DisplayName', 'Katup Kapiler');
hold on;
plot(data(2).m_dot, data(2).delta_w, 'b-x', 'DisplayName', 'Katup Ekspansi');
hold off;
title('Grafik Laju Aliran Massa vs Penurunan Kadar Uap Air');
xlabel('Laju Aliran Massa (kg/s)');
ylabel('Penurunan Kadar Uap Air (kg/kg)');
legend('show');
grid on;

% Plot (m_dot, delta_h)
subplot(3,1,3);
plot(data(1).m_dot, data(1).delta_h, 'r-o', 'DisplayName', 'Katup Kapiler');
hold on;
plot(data(2).m_dot, data(2).delta_h, 'b-x', 'DisplayName', 'Katup Ekspansi');
hold off;
title('Grafik Laju Aliran Massa vs Penurunan Entalpi');
xlabel('Laju Aliran Massa (kg/s)');
ylabel('Penurunan Entalpi (kJ/kg)');
legend('show');
grid on;


