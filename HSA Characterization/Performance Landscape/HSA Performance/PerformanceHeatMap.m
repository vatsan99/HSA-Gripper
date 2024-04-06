close all
clc

data_files = ["HSA-Peformance_Test-3Apr-SingleHSA.csv", "HSA-Peformance_Test-3Apr-DoubleHSA.csv", "HSAGripper-TestSet2-4Apr-8RowHSA.csv"];
titles = {'Monolithic HSA', 'Stacked HSA', 'Standard 8-Row HSA'};

specified_points = [40 2; 20 30; 40 15];

cm = 'summer';
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

    % Define the matrices in a cell array
    grids = {X_grid, Y_grid, Z_grid, Z1_grid};

    % Loop over the cell array
    for k = 1:length(grids)
        % Remove the first and last rows
        grids{k} = grids{k}(2:end-1, :);
    end

    % Extract the matrices from the cell array
    X_grid = grids{1};
    Y_grid = grids{2};
    Z_grid = grids{3};
    Z1_grid = grids{4};

    % Create the surface plot: Force Heat Map
    colormap(cm)
    subplot(2, 3, i)
    surfc(X_grid, Y_grid, Z_grid, 'EdgeColor', 'none');
    

    % Probes: comment lines 51 - 61 to suppress
    % for j = 1:size(specified_points, 1)
    %     specified_X = specified_points(j, 1);
    %     specified_Y = specified_points(j, 2);

    % % Find the closest grid point
    % [~, idx] = min(abs(X_grid(:) - specified_X) + abs(Y_grid(:) - specified_Y));
    % [x_idx, y_idx] = ind2sub(size(X_grid), idx);

    % % Add the Z value at the specified point to the plot
    % text(X_grid(x_idx, y_idx), Y_grid(x_idx, y_idx), num2str(Z_grid(x_idx, y_idx)), 'HorizontalAlignment', 'center', 'Color', 'black');
    % end

    box on
    title({titles{i};'Force (F)'});
    xlabel('Rotation, \theta [degrees]');
    ylabel('Extension, y [mm]');
    zlabel('Force [N]');
    axis tight
    grid off
    view(0, 90)
end

% Colorbar 1
hcb = colorbar;
hcb.Position = hcb.Position + [0.12 0 0 0];
title_handle = get(hcb, 'Title');
title_string = {'F [N]'};
set(title_handle ,'String', title_string);

% Heat Map: Torque

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

    Z1_grid = griddata(theta, disp, torque_response, X_grid, Y_grid);

    % Define the matrices in a cell array
    grids = {X_grid, Y_grid, Z_grid, Z1_grid};

    % Loop over the cell array
    for k = 1:length(grids)
        % Remove the first and last rows
        grids{k} = grids{k}(2:end-1, :);
    end

    % Extract the matrices from the cell array
    X_grid = grids{1};
    Y_grid = grids{2};
    Z_grid = grids{3};
    Z1_grid = grids{4};

    % Create the surface plot: Force Heat Map

    colormap(cm)
    subplot(2, 3, i+3)
    surfc(X_grid, Y_grid, Z1_grid, 'EdgeColor', 'none');

    % Probes
    % for j = 1:size(specified_points, 1)
    %     specified_X = specified_points(j, 1);
    %     specified_Y = specified_points(j, 2);

    % % Find the closest grid point
    % [~, idx] = min(abs(X_grid(:) - specified_X) + abs(Y_grid(:) - specified_Y));
    % [x_idx, y_idx] = ind2sub(size(X_grid), idx);

    % % Add the Z value at the specified point to the plot
    % text(X_grid(x_idx, y_idx), Y_grid(x_idx, y_idx), num2str(Z1_grid(x_idx, y_idx)), 'HorizontalAlignment', 'center', 'Color', 'black');
    % end

    box on
    title({titles{i};'Torque (\tau)'});
    xlabel('Rotation, \theta [degrees]');
    ylabel('Extension, y [mm]');
    zlabel('Torque [Nmm]');
    axis tight
    grid off
    view(0, 90)
end

% Colorbar 2
hcb = colorbar;
hcb.Position = hcb.Position + [0.12 0 0 0];
title_handle = get(hcb, 'Title');
title_string = {'\tau [Nmm]'};
set(title_handle ,'String', title_string);
% figure size


x0 = 900;
y0 = 410;
width = 800;
height = 550;
set(gcf, 'position', [x0, y0, width, height])
exportgraphics(gcf, 'D:\Srivatsan\HSA-gripper-files\Plot Images\PerformanceHeatMap.png', 'Resolution', 800)

% max_disp = max(disp); % in mm
% max_theta = max(theta); % in degress

% points = [0, max_disp; max_theta, 0]; % maximum extension and rotation

% hold on

% x = 0:500;

% y = 0.2512 * x;

% z = zeros(501, 1);

% p2 = plot(x, y, 'k-', 'LineWidth', 1.5, 'DisplayName', 'Auxetic Trajectory');

% % Defining parallel lines

% y1 = 0.2512.*x + points(1, 2);
% y2 = 0.2512.*(x - points(2, 1));

% hold on
% plot(x, y1, '-', 'LineWidth', 1.5, 'HandleVisibility', 'off')
% hold on
% plot(x, y2, '-', 'LineWidth', 1.5, 'HandleVisibility', 'off')
% hold on
% p1 = plot(points(:,1), points(:,2), 'ro', 'MarkerFaceColor', 'r', 'DisplayName', 'Maximum Value');
% hold on
% plot(x, z, 'k--', 'LineWidth', 0.1, 'HandleVisibility', 'off'); % Zero line


% legend('Location', 'best')

% xlabel('Rotation [\theta]')
% ylabel('Extension [mm]')

% xlim([min(x) max(x)]);
% ylim([min(y2) 300]);