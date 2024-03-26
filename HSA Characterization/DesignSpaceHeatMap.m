close all
clc

points = [0, 150; 180, 0];


figure;

p1 = plot(points(:,1), points(:,2), 'ko', 'MarkerFaceColor', 'r', 'DisplayName', 'Max. values');

x = 0:300;

y = 0.2512 * x;

hold on

p2 = plot(x, y, 'k-', 'LineWidth', 1.5, 'DisplayName', 'Auxetic Trajectory');
legend([p1, p2], {'Points', 'Line'}, 'TextColor', 'auto');

xlabel('Rotation [\theta]')
ylabel('Extension [mm]')

xlim([0 250]);
ylim([0 250]);