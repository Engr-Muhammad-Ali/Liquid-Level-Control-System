syms A k_out K s

% Open-Loop Transfer Function
G = 1 / (A * s + k_out);

% Closed-Loop Transfer Function
T = K * G / (1 + K * G);

% Characteristic Equation
[~, char_eq] = numden(T); % Extract the denominator of T(s)
char_eq = simplify(char_eq); % Simplify the denominator
disp('Characteristic Equation:');
disp(char_eq);

% Solve for Closed-Loop Poles
poles = solve(char_eq, s); % Solve the characteristic equation for poles
disp('Closed-Loop Poles:');
disp(poles);

% Parameters (Numeric Substitution)
A = 1;              % Cross-sectional area of the tank (m^2)
k_out = 2;          % Outflow constant (m/s)

% Define Transfer Function
s = tf('s');
G = 1 / (A * s + k_out); % Open-loop transfer function

% Plot Root Locus
figure;
rlocus(G); % Plot root locus

% Hold the plot to overlay additional graphics
hold on;

% Highlight the Poles (no poles in this case, but we emphasize the root locus)
% Root locus is plotted as a line on the real axis.
% Emphasize the root locus with a bold line
plot(real(pole(G)), imag(pole(G)), 'rx', 'MarkerSize', 10, 'LineWidth', 2); % Bold red crosses for poles

% Highlight the XY-Plane (bolden the X and Y axes)
xline(0, 'k-', 'LineWidth', 2); % Bold solid vertical line at x = 0 (y-axis)
yline(0, 'k-', 'LineWidth', 2); % Bold solid horizontal line at y = 0 (x-axis)

% Adjust Axis Limits to better view the root locus
xlim([-3, 1]); % Adjust x-axis range for better view of negative x-axis
ylim([-2, 2]); % Adjust y-axis range if necessary

% Formatting
title('Root Locus of the Liquid Level Control System', 'FontWeight', 'bold');
xlabel('Real Axis', 'FontWeight', 'bold');
ylabel('Imaginary Axis', 'FontWeight', 'bold');
grid on;

hold off;