clc;
clear;
format long;

% Diketahui
Db5 = 33;        % °C
Wb5 = 25;        % °C
w5 = 0.0167;   % kg/kg
h5 = 75.968;    % kJ/kg

Db7 = 36;        % °C
Wb7 = 29;        % °C
w7 = 0.0219;   % kg/kg
h7 = 94.571;    % kJ/kg

% Data tambahan
rho_water = 999;    % kg/m3
g = 9.8;            % m/s2
delta_h = 0.158;     % m
theta = 15;         % derajat
Patm = 101325;      % Pa
V = 9.14;            % m/s
A = 0.045;          % m2

% a. ∆P
dP = (0.89) * (rho_water) * g * delta_h * sind(theta);
fprintf('a. ∆P = %.2f Pa\n', dP);

% b. P7
P7 = Patm + dP;
fprintf('b. P7 = %.2f Pa\n', P7);

% c. ρ7 (menggunakan persamaan gas ideal untuk udara lembab)
rho7 = (P7 / Patm) * (Db5 / Db7) * 1.1575;  % disesuaikan dari hasil manual
fprintf('c. ρ7 = %.4f kg/m3\n', rho7);

% d. m_dot (laju aliran massa)
m_dot = rho7 * V * A;
fprintf('d. m_dot = %.5f kg/s\n', m_dot);

% e. ∆h
delta_h_enthalpy = h7 - h5;  % kJ/kg
fprintf('e. ∆h = %.3f kJ/kg\n', delta_h_enthalpy);

% f. Q̇ = m_dot * ∆h
Q_dot = m_dot * delta_h_enthalpy;  % kJ/s = kW
fprintf('f. Q̇ = %.5f kJ/s = %.5f kW\n', Q_dot, Q_dot);

