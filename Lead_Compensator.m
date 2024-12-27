% System Parameters (Numeric Substitution)
A = 1;              % Cross-sectional area of the tank (m^2)
k_out = 2;          % Outflow constant (m/s)

% Transfer Function of the Open-Loop System
s = tf('s');
G = 1 / (A * s + k_out); % Open-loop transfer function

% Desired Performance Specifications
zeta = 0.69;        % Damping ratio for 5% overshoot
omega_n = 6.45;     % Natural frequency from settling time

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
    set(h(i), 'LineWidth', 3);  % Bold the root locus lines
end

% Title and labels
title('Root Locus of the System with Lead Compensator');

% Bolden axes and grid
ax = gca;
ax.GridLineStyle = '--';   % Dashed grid lines
ax.GridAlpha = 0.6;        % Slightly transparent grid lines
ax.XGrid = 'on';
ax.YGrid = 'on';
ax.LineWidth = 1.5;        % Bold grid lines
ax.XAxis.LineWidth = 2;    % Bold the X-axis (XY-plane)
ax.YAxis.LineWidth = 2;    % Bold the Y-axis (XY-plane)
ax.Box = 'on';             % Ensure that the box is drawn around the plot
ax.XAxisLocation = 'origin'; % Place the X-axis at the origin
ax.YAxisLocation = 'origin'; % Place the Y-axis at the origin
grid on;

% Second Figure Example (e.g., Step Response or another plot)
figure;
step(G_c); % Example: step response of the compensated system

% Bolden step response lines
h = findobj(gcf, 'Type', 'line');
for i = 1:length(h)
    set(h(i), 'LineWidth', 3);  % Bold the step response lines
end

% Title and labels
title('Step Response of the System with Lead Compensator');

% Bolden axes and grid for the second figure
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.6;
ax.XGrid = 'on';
ax.YGrid = 'on';
ax.LineWidth = 1.5;
ax.XAxis.LineWidth = 2;
ax.YAxis.LineWidth = 2;
ax.Box = 'on';
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
grid on;