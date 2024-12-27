% System Parameters
A = 1;              % Cross-sectional area of the tank (m^2)
k_out = 2;          % Outflow constant (m/s)

% Transfer Function
s = tf('s');
G = 1 / (A * s + k_out);

% Display Poles and Zeros
[poles, zeros] = pzmap(G); % Poles and zeros of the system
disp('Poles of the system:');
disp(poles);
disp('Zeros of the system:');
disp(zeros);

% Plot Pole-Zero Map
figure;
pzmap(G); % Default pole-zero map
hold on;

% Highlight the Poles
plot(real(poles), imag(poles), 'rx', 'MarkerSize', 10, 'LineWidth', 2); % Bold red crosses for poles

% Shift Y-Axis (Add Right-Side Reference Line)
xline(0, 'k-', 'LineWidth', 2); % Bold solid vertical line at x = 0 (y-axis)
yline(0, 'k-', 'LineWidth', 2); % Bold solid horizontal line at y = 0 (x-axis)

% Adjust Axis Limits
xlim([-3, 1]); % Adjust x-axis range for better view of negative x-axis
ylim([-2, 2]); % Adjust y-axis range if necessary

% Formatting
title('Pole-Zero Map of the Liquid Level Control System', 'FontWeight', 'bold');
xlabel('Real Axis', 'FontWeight', 'bold');
ylabel('Imaginary Axis', 'FontWeight', 'bold');
grid on;

% Bold Axes and Labels
ax = gca; % Get current axes
ax.LineWidth = 1; % Keep axes borders thinner
ax.FontSize = 12; % Increase font size for labels and ticks
hold off;