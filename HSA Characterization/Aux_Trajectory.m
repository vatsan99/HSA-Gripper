close all
clc

max_disp = 45.34; % in mm
max_theta = 70.42; % in degress

points = [0, max_disp; max_theta, 0]; % maximum extension and rotation

figure;

x = 0:500;

y = 0.2512 * x;

z = zeros(501, 1);

p2 = plot(x, y, 'k-', 'LineWidth', 1.5, 'DisplayName', 'Auxetic Trajectory');

% Defining parallel lines

y1 = 0.2512.*x + points(1, 2);
y2 = 0.2512.*(x - points(2, 1));

hold on
plot(x, y1, '-', 'LineWidth', 1.5, 'DisplayName', 'Parallel Line 1')
hold on
plot(x, y2, '-', 'LineWidth', 1.5, 'DisplayName', 'Parallel Line 2')
hold on
p1 = plot(points(:,1), points(:,2), 'ro', 'MarkerFaceColor', 'r', 'DisplayName', 'Maximum Value');
hold on
plot(x, z, 'k--', 'LineWidth', 0.1, 'HandleVisibility', 'off'); % Zero line


legend('Location','Northwest')

xlabel('Rotation [\theta]')
ylabel('Extension [mm]')

xlim([min(x) max(x)]);
ylim([min(y2) 300]);

% figure size

x0 = 1000;
y0 = 650;
width = 750;
height = 500;
set(gcf, 'position', [x0, y0, width, height])