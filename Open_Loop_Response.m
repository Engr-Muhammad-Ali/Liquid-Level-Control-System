% System Parameters (Numeric Substitution)
A = 1;              % Cross-sectional area of the tank (m^2)
k_out = 2;          % Outflow constant (m/s)

% Transfer Function of the Open-Loop System
s = tf('s');
G = 1 / (A * s + k_out);

% Step Response (without any controller)
figure;
[response, time] = step(G); % Get response data
plot(time, response, 'LineWidth', 2); % Plot with bold line
title('Open-Loop Step Response of the Liquid Level Control System');
xlabel('Time');
ylabel('Liquid Level (h)');
grid on;