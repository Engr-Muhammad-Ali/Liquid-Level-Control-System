% System Parameters (Numeric Substitution)
A = 1;              % Cross-sectional area of the tank (m^2)
k_out = 2;          % Outflow constant (m/s)

% Transfer Function of the Open-Loop System
s = tf('s');
G = 1 / (A * s + k_out); % Open-loop transfer function

% Desired Performance Specifications
zeta = 0.69;        % Damping ratio for 5% overshoot
Ts = 0.90;          % Settling time (seconds)
omega_n = 4 / (zeta * Ts); % Natural frequency
disp(['Natural Frequency (omega_n): ', num2str(omega_n), ' rad/s']);

% Desired Pole Location
sigma = -zeta * omega_n; % Real part
omega_d = omega_n * sqrt(1 - zeta^2); % Imaginary part
desired_poles = [sigma + 1i * omega_d, sigma - 1i * omega_d];
disp(['Desired Poles: ', num2str(real(desired_poles)), ' ± j', num2str(imag(desired_poles))]);

% Lead Compensator Parameters
alpha = 2;          % Lead compensator alpha (greater than 1)
tau = 1 / omega_n;  % Time constant (approx.)

% Lead Compensator Transfer Function
C = (tau * s + 1) / (alpha * tau * s + 1);

% Open-Loop Transfer Function with Compensator
G_c = C * G;

% Root Locus Analysis
figure;
rlocus(G_c);   % Root locus plot of the open-loop transfer function with compensator

% Bolden root locus lines
h = findobj(gcf, 'Type', 'line');
for i = 1:length(h)
    set(h(i), 'LineWidth', 2); % Bolden root locus lines
end

% Title and labels
title('Root Locus of the System with Lead Compensator');
xlabel('Real Axis (seconds^{-1})');
ylabel('Imaginary Axis (seconds^{-1})');
grid on;

% Adjust grid and axes
ax = gca;
ax.GridLineStyle = '--';   % Dashed grid lines
ax.GridAlpha = 0.6;        % Slightly transparent grid lines
ax.XGrid = 'on';
ax.YGrid = 'on';
ax.LineWidth = 1.5;        % Bold grid lines
ax.XAxis.LineWidth = 2;    % Bold X-axis
ax.YAxis.LineWidth = 2;    % Bold Y-axis
ax.Box = 'on';
ax.XAxisLocation = 'origin'; % Place the X-axis at the origin
ax.YAxisLocation = 'origin'; % Place the Y-axis at the origin
grid on;

% Adjust K to place poles at desired locations
K = 7; % Adjust this value based on the root locus
T = feedback(K * G_c, 1); % Closed-loop transfer function

% Step Response Analysis
figure;
step(T);

% Bolden step response lines
h = findobj(gcf, 'Type', 'line');
for i = 1:length(h)
    set(h(i), 'LineWidth', 3); % Bolden step response lines
end

% Title and labels
title('Step Response of the Closed-Loop System');
xlabel('Time');
ylabel('Amplitude');
grid on;

% Adjust grid and axes for step response
ax = gca;
ax.GridLineStyle = '--';   % Dashed grid lines
ax.GridAlpha = 0.6;        % Slightly transparent grid lines
ax.XGrid = 'on';
ax.YGrid = 'on';
ax.LineWidth = 1.5;        % Bold grid lines
ax.XAxis.LineWidth = 2;    % Bold X-axis
ax.YAxis.LineWidth = 2;    % Bold Y-axis
ax.Box = 'on';
grid on;

% Performance Metrics
step_info = stepinfo(T);
disp('Step Response Performance:');
disp(['K = ', num2str(K)]);
disp(step_info);