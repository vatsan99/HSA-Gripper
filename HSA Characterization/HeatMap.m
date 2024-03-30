close all
clc


data = readtable("HSA_ARM_SpringConstantData_Layer3.csv");
data = table2array(data);

theta = data(:, 1);
disp = data(:, 2);
variable = data(:, 3);

figure()
scatter3(theta, disp, variable, [], variable, 'filled')
colorbar % Adds a colorbar to the figure
title('Performance')

xlabel('Theta')
ylabel('Displacement')
zlabel('Variable')


data1 = readtable("HSA_ARM_SpringConstantData_Layer3.csv");
data1 = table2array(data1);

X = data1(:, 1);
Y = data1(:, 2);
Z = data1(:, 3);

% Create a grid
X_range = linspace(min(X), max(X));
Y_range = linspace(min(Y), max(Y));
[X_grid, Y_grid] = meshgrid(X_range, Y_range);

% Interpolate Z onto the grid
Z_grid = griddata(X, Y, Z, X_grid, Y_grid);

% Create the surface plot
figure()
surfc(X_grid, Y_grid, Z_grid, 'EdgeColor', "none");
box on
title('Surface Plot');
xlabel('Displacement [mm]');
ylabel('Rotation [\theta]');
zlabel('Force');
colorbar
grid off

% Create the contour plot
figure()
contourf(X_grid, Y_grid, Z_grid, 'EdgeColor', 'none');
title('Contour Plot');
xlabel('X');
ylabel('Y');