close all
clc

% Single HSA Heat Map

data = readtable(".\0to35mm_0to130deg_NRGLandscape_1.csv"); % processed raw data: Single HSA
data = table2array(data);

theta = data(:, 4).*(-1); % x
disp = data(:, 2); % y

force_response = data(:, 3).*0.001; % z - convert to N (from mN)
torque_response = data(:, 5); % z

force_sectional_HSA = data(:, 3).*0.001; % z - convert to N (from mN)
torque_sectional_HSA = data(:, 5); % z

X = theta;
Y = disp;

Z = force_response;
Z1 = torque_response;

% Create a grid
X_range = linspace(min(X), max(X));
Y_range = linspace(min(Y), max(Y));
[X_grid, Y_grid] = meshgrid(X_range, Y_range);

% Interpolate Z onto the grid
Z_grid = griddata(X, Y, Z, X_grid, Y_grid);

% Create the surface plot: Force Heat Map (Single HSA)
subplot(2, 3, 1)
surfc(X_grid, Y_grid, Z_grid, 'EdgeColor', 'none');
colormap('turbo')
colorbar;
box on
title({'Single HSA';'Force, F as a function of y and \theta'});
xlabel('Rotation, \theta [degrees]');
ylabel('Extension, y [mm]');
zlabel('Force [N]');
grid off
view(0, 90)

% Heat Map: Torque (Single HSA)

Z1_grid = griddata(X, Y, Z1, X_grid, Y_grid); % Interpolated torque data

subplot(2, 3, 4)
surfc(X_grid, Y_grid, Z1_grid, 'EdgeColor', 'none');
colormap('turbo')
colorbar;
box on
title({'Single HSA';'Torque, \tau as a function of y and \theta'});
xlabel('Rotation, \theta [degrees]');
ylabel('Extension, y [mm]');
zlabel('Torque [Nmm]');
grid off
view(0, 90)