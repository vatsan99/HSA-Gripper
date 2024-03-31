close all
clc

data = readtable("HSA_ARM_SpringConstantData_Layer3.csv");
data = table2array(data);

theta = data(:, 1); % x
disp = data(:, 2); % y

force_response = data(:, 3); % z
torque_response = data(:, 4); % z

data1 = readtable("HSA_ARM_SpringConstantData_Layer3.csv");
data1 = table2array(data1);

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

% Create the surface plot
figure()
surfc(X_grid, Y_grid, Z_grid, 'EdgeColor', "none");
colormap('jet')
colorbar;
box on
title({'Performance Heat Map';'F = f(x, \theta)'});
xlabel('Rotation [\theta]');
ylabel('Displacement [mm]');
zlabel('Force');
grid off
view(0, 90)

x0 = 1000;
y0 = 650;
width = 550;
height = 380;
set(gcf, 'position', [x0, y0, width, height])

fullFilePath = fullfile('D:\Srivatsan\HSA-gripper-files\Plot Images', 'HeatMap_Force.png');

saveas(gcf, fullFilePath)


% Create the contour plot
% figure()
% contourf(X_grid, Y_grid, Z_grid, 'EdgeColor', 'none');
% colormap('jet')
% title('Contour Plot');
% xlabel('X');
% ylabel('Y');