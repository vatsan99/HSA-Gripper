close all
clc

data = readtable(".\0to35mm_0to130deg_NRGLandscape_1.csv"); % processed raw data: Single HSA
data = table2array(data);

theta = data(:, 4).*(-1); % x
disp = data(:, 2); % y

force_response = data(:, 3); % z
torque_response = data(:, 5); % z

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
surfc(X_grid, Y_grid, Z_grid, 'EdgeColor', 'none');
colormap('jet')
colorbar;
box on
title({'Performance Heat Map';'F = f(y, \theta)'});
xlabel('Rotation, \theta [degrees]');
ylabel('Extension, y [mm]');
zlabel('Force [mN]');
grid on
view(0, 90)

x0 = 950;
y0 = 350;
width = 500;
height = 380;
set(gcf, 'position', [x0, y0, width, height])

% fullFilePath = fullfile('D:\Srivatsan\HSA-gripper-files\Plot Images', 'HeatMap_Force.png');

% saveas(gcf, fullFilePath)


% Create the contour plot
figure()
contourf(X_grid, Y_grid, Z_grid, 'EdgeColor', 'none');
colormap('jet')
colorbar;
title('Contour Plot');
xlabel('X');
ylabel('Y');

x0 = 450;
y0 = 350;
width = 510;
height = 380;
set(gcf, 'position', [x0, y0, width, height])

% Double / Sectional HSA