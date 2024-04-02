close all
clc

run('SingleHSAPerformance.m') % processes and plots data from Single HSA raw data


data_double_HSA = table2array(readtable(".\HSAFingerSeperateParts.csv")); % processed raw data: Double HSA

theta_double_HSA = data_double_HSA(:, 4).*(-1); % x
disp_double_HSA = data_double_HSA(:, 2); % y

force_double_HSA = data_double_HSA(:, 3).*0.001; % z - convert to N (from mN)
torque_double_HSA = data_double_HSA(:, 5); % z


x = theta_double_HSA;
y = disp_double_HSA;

z = force_double_HSA;
z1 = torque_double_HSA;

% Create a grid
x_range = linspace(min(x), max(x));
y_range = linspace(min(y), max(y));
[x_grid, y_grid] = meshgrid(x_range, y_range);

% Interpolate z onto the grid
z_grid = griddata(x, y, z, x_grid, y_grid);

% Create the surface plot: Force Heat Map (Double HSA)

subplot(2, 3, 2)
surfc(x_grid, y_grid, z_grid, 'EdgeColor', 'none');
colormap('autumn')
colorbar;
box on
title({'Double HSA';'Force, F as a function of y and \theta'});
xlabel('Rotation, \theta [degrees]');
ylabel('Extension, y [mm]');
zlabel('Force [N]');
grid off
view(0, 90)

% Create the surface plot: Force Heat Map (Double HSA)

z1_grid = griddata(x, y, z1, x_grid, y_grid);

subplot(2, 3, 5)
surfc(x_grid, y_grid, z1_grid, 'EdgeColor', 'none');
colormap('autumn')
colorbar;
box on
title({'Double HSA';'Torque, \tau as a function of y and \theta'});
xlabel('Rotation, \theta [degrees]');
ylabel('Extension, y [mm]');
zlabel('Torque [Nmm]');
grid off
view(0, 90)






% - Performance Difference - %

z2 = force_double_HSA - force_response(1:2725); % Double HSA - Single HSA

% Interpolate z onto the grid
z2_grid = griddata(x, y, z2, x_grid, y_grid);

% Create the surface plot: Force Heat Map (Double HSA)

subplot(2, 3, 3)
surfc(x_grid, y_grid, z2_grid, 'EdgeColor', 'none');
colormap('autumn')
colorbar;
box on
title({'Performance Difference';'Force, F as a function of y and \theta'});
xlabel('Rotation, \theta [degrees]');
ylabel('Extension, y [mm]');
zlabel('Force [N]');
grid off
view(0, 90)

z3 = torque_double_HSA - torque_response(1:2725); % Double HSA - Single HSA

% Interpolate z onto the grid
z3_grid = griddata(x, y, z3, x_grid, y_grid);

% Create the surface plot: Force Heat Map (Double HSA)

subplot(2, 3, 6)
surfc(x_grid, y_grid, z3_grid, 'EdgeColor', 'none');
colormap('autumn')
colorbar;
box on
title({'Performance Difference';'Torque, \tau as a function of y and \theta'});
xlabel('Rotation, \theta [degrees]');
ylabel('Extension, y [mm]');
zlabel('Torque [Nmm]');
grid off
view(0, 90)


% figure size

x0 = 300;
y0 = 150;
width = 1200;
height = 600;
set(gcf, 'position', [x0, y0, width, height])

% fullFilePath = fullfile('D:\Srivatsan\HSA-gripper-files\Plot Images', 'PerformanceHeatMap.png');
% saveas(gcf, fullFilePath)