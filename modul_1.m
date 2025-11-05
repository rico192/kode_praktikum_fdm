% <<<<<<< HEAD
# Modul 1 - Venturi Meter
# define
g = 9.81;
nu = 896.6 * 10 ^-6;
k = 1:12;
rho = 1000;
Q_LPM = [8 9 10 12 13 14 15 16 17 18 19 20];
Q = Q_LPM .* 10^-3 ./ 60;
# Q2 = Q_LPM / 60;
h1_cm = [3.5 4 5 6.5 7.5 8.5 9 13.5 14 15 16 17];
h2_cm = [2.5 2 3 3.5 3.5 3.5 7 8 13.5 8.5 9 8];
beda_h_cm = h1_cm - h2_cm;
beda_h = beda_h_cm ./ 100;
Dt_mm = 12.5;
D0_mm = 19.1;
Dt = Dt_mm ./ 1000;
D0 = D0_mm ./ 1000;
At = (pi/4) * Dt ^2;
rasio_dt_d0 = Dt / D0;
Cd = (Q ./ (At .* sqrt(2 * g .* beda_h))) .* (sqrt(1 - rasio_dt_d0 .^4));
V = Q ./ At;
Re = rho .* V .* Dt ./ nu;
AtsqrtdeltaPperrho = At .* sqrt(2 .* (rho * g .* beda_h) ./ rho);

# Display tabel
# Header
fprintf('=======================================================================================================\n');
fprintf('No. \t Q (m³/s) \t Cd \t\t V (m/s) \t Re \t\t Δh (m) \t At*sqrt(..)\n');
fprintf('=======================================================================================================\n');

% Loop ini bekerja sama baiknya untuk vektor baris maupun kolom
for i = 1:length(k)
    fprintf('%-3d \t %-12.2e \t %-7.3f \t %-7.3f \t %-12.2f \t %-7.3f \t %-12.2e\n', ...
            k(i), Q(i), Cd(i), V(i), Re(i), beda_h(i), AtsqrtdeltaPperrho(i));
end
fprintf('=======================================================================================================\n');

# plotting
figure; % Membuat window figure baru
plot(Q, AtsqrtdeltaPperrho, 'o-'); % Plot dengan marker 'o' dan garis '-'
title('Grafik Hubungan Q vs At*sqrt(2*\DeltaP/\rho)');
xlabel('Q (m^3/s)');
ylabel('At * sqrt(2 * \DeltaP / \rho) (m^3/s)');
grid on; % Menampilkan grid
grid minor on; % Menampilkan grid kecil
legend('Data Eksperimen');

figure; % Membuat window figure baru
plot(Q, beda_h, 'o-'); % Plot dengan marker 'o' dan garis '-'
title('Grafik Hubungan Q vs Δh');
xlabel('Q (m^3/s)');
ylabel('\Delta h (m)');
grid on; % Menampilkan grid
grid minor on; % Menampilkan grid kecil
legend('Data Eksperimen');

figure; % Membuat window figure baru
plot(Q, Cd, 'o-'); % Plot dengan marker 'o' dan garis '-'
title('Grafik Hubungan Q vs Cd');
xlabel('Q (m^3/s)');
ylabel('Cd');
grid on; % Menampilkan grid
grid minor on; % Menampilkan grid kecil
legend('Data Eksperimen');


grid on; % Menampilkan grid
grid minor on; % Menampilkan grid kecil
legend('Data Eksperimen');

# Membuat tabel sebagai gambar
% 1. Siapkan data dalam bentuk cell array
kolom_header = {'No.', 'Q (m³/s)', 'Cd', 'V (m/s)', 'Re', 'Δh (m)', 'At*sqrt(..)'};
numeric_data = [k', Q', Cd', V', Re', beda_h', AtsqrtdeltaPperrho'];

% Ubah data menjadi cell array untuk format kustom
data_tabel_cell = num2cell(numeric_data);

% Format kolom 'Re' (kolom ke-5) secara manual menjadi string tanpa desimal
for i = 1:length(Re)
    data_tabel_cell{i, 5} = sprintf('%.0f', Re(i));
end

% 2. Buat figure baru untuk tabel
figure;
set(gcf, 'Position', [100, 100, 850, 350]); % Atur ukuran window figure [x, y, lebar, tinggi]
t = uitable('Data', data_tabel_cell,...
            'ColumnName', kolom_header,...
            'ColumnFormat', {'numeric', 'shortE', 'numeric', 'numeric', 'char', 'numeric', 'shortE'},... % Ubah format kolom Re menjadi 'char'
            'ColumnWidth', {30, 80, 50, 70, 100, 70, 80},...
            'RowName',[],...
            'Position',[20 20 810 310]); % Atur posisi tabel dalam figure