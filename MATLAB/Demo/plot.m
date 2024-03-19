clc
close all

data = csvread('sample_temperature.csv'); % Replace with your actual file path
X = data(:, 1); % x values
Y = data(:, 3); % y values
T = data(:, 4); % Temperature values

F = scatteredInterpolant(X, Y, T);
[XI, YI] = meshgrid(linspace(min(X), max(X), 100), linspace(min(Y), max(Y), 100));
ZI = F(XI, YI);

contourf(XI, YI, ZI, 'LineStyle', 'none');
colormap("turbo")
colorbar; % Add a color scale
title('Temperature Contour');
xlabel('X');
ylabel('Y');

x0 = 900;
y0 = 600;
width = 500;
height = 350;
set(gcf, 'position', [x0, y0, width, height])

figure

surf(XI, YI, ZI, 'EdgeColor', "none")
xlim([min(X) max(X)])
xlabel('x*')
ylabel('y*')
zlabel('Temperature [K]')
colorbar;
colormap("turbo")
hold on
plot3(X, Y, T, '.', "MarkerSize", 10)


x0 = 1500;
y0 = 600;
width = 500;
height = 350;
set(gcf, 'position', [x0, y0, width, height])