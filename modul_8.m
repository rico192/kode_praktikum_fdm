% modul 8
% variabel
% Data 1
L = [0.15 0.12 0.09 0.08];
n = [541 672 764 974];
% Data 2
n_motor_d2 = 850; % rpm
L_d2 = [0.160 0.140 0.110 0.090]; % m
m = 0.15; % kg
f_motor_d2 = 14.17; % Hz

% konstanta
E_baja = 2.1e11; % N/m2
I = 0.012 * 0.001^3 / 12; % m4

% kalkulasi data 1
f_absorber_d1 = (1/(2*pi)) * sqrt((3 * E_baja * I) ./ (m * L.^3));
f_motor_d1 = n ./ 60; % Hz

fprintf('\nData 1\n');
fprintf('================================================================\n');
fprintf(' Jarak, L (m) | f_absorber_d1 (Hz) | n (rpm) | f_motor_d1 (Hz)\n');
fprintf('================================================================\n');
for i = 1:length(L)
  fprintf(' %12.4f | %18.4f | %7.2f | %15.4f\n', L(i), f_absorber_d1(i), n(i), f_motor_d1(i));
end
fprintf('================================================================\n\n');

% kalkulasi data 2
f_absorber_d2 = (1/(2*pi)) * sqrt((3 * E_baja * I) ./ (m * L_d2.^3));
K = (3 * E_baja * I) ./ (L_d2.^3);
omega_motor_d2 = 2 * pi * f_motor_d2; % rad/s
omega_absorber_d2 = 2 * pi * f_absorber_d2; % rad/s
omega_s = omega_motor_d2 - omega_absorber_d2;
f_s = omega_s ./ 2 * pi; % Hz
A = f_s ./ abs(K - m .* omega_s.^2);

fprintf('\nData 2\n');
fprintf('===================================================================================================\n');
fprintf(' n_motor_d2 (rpm) | f_motor_d2 (Hz) | L_d2 (mm) | f_absorber_d2 (Hz) | Amplitudo (A)\n');
fprintf('===================================================================================================\n');
for i = 1:length(L_d2)
  fprintf(' %16.2f | %15.2f | %9.2f | %18.4f | %13.6f\n', n_motor_d2, f_motor_d2, L_d2(i), f_absorber_d2(i), A(i));
end
fprintf('===================================================================================================\n\n');


