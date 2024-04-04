close all
clc

data_files = ["HSA-Peformance_Test-3Apr-SingleHSA.csv", "HSA-Peformance_Test-3Apr-DoubleHSA.csv", "HSA-Peformance_Test-3Apr-8RowHSA.csv"];
titles = {'Monolithic HSA', 'Stacked HSA', 'Standard 8-Row HSA'};

specified_points = [40 2; 20 30; 40 15];

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
    cm = 'gray'; % assign color map
    subplot(2, 3, i)
    surfc(X_grid, Y_grid, Z_grid, 'EdgeColor', 'none');
    colormap(cm)

    % Probes
    % for j = 1:size(specified_points, 1)
    %     specified_X = specified_points(j, 1);
    %     specified_Y = specified_points(j, 2);

    % % Find the closest grid point
    % [~, idx] = min(abs(X_grid(:) - specified_X) + abs(Y_grid(:) - specified_Y));
    % [x_idx, y_idx] = ind2sub(size(X_grid), idx);

    % % Add the Z value at the specified point to the plot
    % text(X_grid(x_idx, y_idx), Y_grid(x_idx, y_idx), num2str(Z_grid(x_idx, y_idx)), 'HorizontalAlignment', 'center', 'Color', 'black');
    % end

    hcb = colorbar;
    colorTitleHandle = get(hcb, 'Title');
    set(colorTitleHandle, 'String', 'Force [N]');
    caxis([-14.0782 23.5390]);

    box on
    title({titles{i} ; 'Force (F)'});
    xlabel('Rotation, \theta [degrees]');
    ylabel('Extension, y [mm]');
    zlabel('Force [N]');
    axis tight
    grid off
    view(0, 90)

    % Heat Map: Torque
    subplot(2, 3, i+3)
    surfc(X_grid, Y_grid, Z1_grid, 'EdgeColor', 'none');
    colormap(cm)

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
 
    hcb = colorbar;
    colorTitleHandle = get(hcb, 'Title');
    set(colorTitleHandle, 'String', 'Force [N]');
    caxis([-27.2578 69.7828]);

    box on
    title({titles{i} ; 'Torque (\tau)'});
    xlabel('Rotation, \theta [degrees]');
    ylabel('Extension, y [mm]');
    zlabel('Torque [Nmm]');
    axis tight
    grid off
    view(0, 90)
end



% figure size

x0 = 900;
y0 = 410;
width = 1550;
height = 750;
set(gcf, 'position', [x0, y0, width, height])
fullFilePath = fullfile('D:\Srivatsan\HSA-gripper-files\Plot Images', 'HeatMap-Comparison.png');
saveas(gcf, fullFilePath);