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

z = {force_double_HSA, torque_double_HSA, force_double_HSA - force_response(1:2725), torque_double_HSA - torque_response(1:2725)};
titles = {{'Double HSA';'Force, F as a function of y and \theta'}
        {'Double HSA';'Torque, \tau as a function of y and \theta'}
        {'Performance Difference';'Force, F as a function of y and \theta'}
        {'Performance Difference';'Torque, \tau as a function of y and \theta'}};
zlabels = {'Force [N]', 'Torque [Nmm]', 'Force [N]', 'Torque [Nmm]'};

% Create a grid
x_range = linspace(min(x), max(x));
y_range = linspace(min(y), max(y));
[x_grid, y_grid] = meshgrid(x_range, y_range);
plot_order = [2, 5, 3, 6];

for i = 1:4
    % Interpolate z onto the grid
    z_grid = griddata(x, y, z{i}, x_grid, y_grid);

    % Create the surface plot
    subplot(2, 3, plot_order(i))
    surfc(x_grid, y_grid, z_grid, 'EdgeColor', 'none');
    colormap('jet')
    colorbar;
    box on
    title(titles{i});
    xlabel('Rotation, \theta [degrees]');
    ylabel('Extension, y [mm]');
    zlabel(zlabels{i});
    grid off
    % view(0, 90)
end

% figure size
x0 = 300;
y0 = 150;
width = 1200;
height = 600;
set(gcf, 'position', [x0, y0, width, height])