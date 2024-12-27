% System Parameters (Numeric Substitution)
A = 1;              % Cross-sectional area of the tank (m^2)
k_out = 2;          % Outflow constant (m/s)

s = tf('s');
G = 1 / (A * s + k_out); % Open-loop transfer function

zeta = 0.69;        % Damping ratio for 5% overshoot
Ts = 0.90;          % Settling time (seconds)
omega_n = 4 / (zeta * Ts); % Natural frequency
disp(['Natural Frequency (omega_n): ', num2str(omega_n), ' rad/s']);

% Lead Compensator Parameters
alpha = 2;          % Lead compensator alpha (greater than 1)
tau = 1 / omega_n;  % Time constant (approx.)

% Lead Compensator Transfer Function
C = (tau * s + 1) / (alpha * tau * s + 1);

% Open-Loop Transfer Function with Compensator
G_c = C * G;

% Closed-Loop Transfer Function
K = 7; % Adjusted gain
T = feedback(K * G_c, 1); % Closed-loop transfer function (feedback)

% Sinusoidal Disturbance in Laplace Domain
f = 1; % Frequency of disturbance (Hz)
Disturbance = 0.01 * (2 * pi * f) / (s^2 + (2 * pi * f)^2); % Laplace domain representation

% Output response to disturbance
Disturbed_Output = T * Disturbance;

% Simulate the disturbance response
t = 0:0.01:10; % Time vector
[y_disturbance, t_disturbance] = lsim(Disturbed_Output, sin(2 * pi * f * t), t); % Response to disturbance

% Plot the disturbance response
figure;
plot(t_disturbance, y_disturbance, 'LineWidth', 2); % Plot disturbance response

% Formatting
title('System Response to Sinusoidal Disturbance');
xlabel('Time (seconds)');
ylabel('Output Amplitude');
grid on;

% Analyze Step Response with Disturbance
disp('Performance with Sinusoidal Disturbance:');
step_info_disturbed = stepinfo(Disturbed_Output);
disp(step_info_disturbed);