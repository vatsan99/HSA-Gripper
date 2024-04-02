close all
clc

data_files = [".\0to35mm_0to130deg_NRGLandscape_1.csv", ".\HSAFingerSeperateParts.csv"];
titles = {'Single HSA', 'Double HSA'};

% Loop over the data files
for i = 1:length(data_files)
    % Load the data
    data = table2array(readtable(data_files{i}));

    % Extract the variables
    theta = data(:, 4).*(-1); % x
    disp = data(:, 2); % y
    force_response = data(:, 3).*0.001; % z - convert to N (from mN)
    torque_response = data(:, 5); % z

    % Create a grid
    X_range = linspace(min(theta), max(theta));
    Y_range = linspace(min(disp), max(disp));
    [X_grid, Y_grid] = meshgrid(X_range, Y_range);

    % Interpolate Z onto the grid
    Z_grid = griddata(theta, disp, force_response, X_grid, Y_grid);
    Z1_grid = griddata(theta, disp, torque_response, X_grid, Y_grid);

    % Create the surface plot: Force Heat Map
    subplot(2, 3, i)
    contourf(X_grid, Y_grid, Z_grid, 'EdgeColor', 'none');
    colormap('turbo')
    colorbar;
    box on
    title({titles{i};'Force, F as a function of y and \theta'});
    xlabel('Rotation, \theta [degrees]');
    ylabel('Extension, y [mm]');
    zlabel('Force [N]');
    grid off
    view(0, 90)

    % Heat Map: Torque
    subplot(2, 3, i+3)
    contourf(X_grid, Y_grid, Z1_grid, 'EdgeColor', 'none');
    colormap('turbo')
    colorbar;
    box on
    title({titles{i};'Torque, \tau as a function of y and \theta'});
    xlabel('Rotation, \theta [degrees]');
    ylabel('Extension, y [mm]');
    zlabel('Torque [Nmm]');
    grid off
    view(0, 90)
end




% figure size

x0 = 950;
y0 = 410;
width = 1500;
height = 750;
set(gcf, 'position', [x0, y0, width, height])
fullFilePath = fullfile('D:\Srivatsan\HSA-gripper-files\Plot Images', 'PerformanceContour.png');
saveas(gcf, fullFilePath);