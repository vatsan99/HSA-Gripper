close all
clc

% Identical, but for two different material configurations

dataHSA = {'.\StandardHSA\HSA_GRIPPER_SpringConstantData_StandardHSA', '.\StackedHSA\HSA_GRIPPER_SpringConstantData_SingleSectionalHSA'};

titles = {'Long HSA', 'Short HSA'};
plot_pos = [4, 1, 5, 2, 6, 3];

% Properties

x_tl = 0:30:125;
y_tl = 0:5:36;
x_ticklabels = cellstr(num2str(x_tl'));
y_ticklabels = cellstr(num2str(y_tl'));
cm = 'jet'; % colormap
font = 'Times New Roman';

x_grid = 0:120;
y_grid = 0:35;


% force plot

for i = 2
    data = readtable(dataHSA{i}, "VariableNamingRule", "preserve");

    degHSA = table2array(data(:,1)); % Rotation
    dispHSA = table2array(data(:,2)); % Displacement
    % fHSA = table2array(data(:,3)).*10e2; % Long HSA force
    fHSA = table2array(data(:,3)); % Short HSA force


    
    % generate heat maps

    [dispGrid, degGrid] = meshgrid(linspace(min(dispHSA), max(dispHSA), 50), linspace(min(degHSA), max(degHSA), 50));
    Ffit = fit([dispHSA, degHSA], fHSA, 'poly33');
    fGrid = Ffit(dispGrid, degGrid);

    subplot(2, 3, plot_pos(i))
    surf(degGrid, dispGrid, fGrid, 'EdgeColor', 'none', 'HandleVisibility', 'off');
    xlabel('Rotation, \theta [\circ]');
    ylabel('Extension [mm]');
    zlabel('Force');
    title({titles{i};'Force (F)'});
    xlim([min(degHSA) max(degHSA)])
    ylim([min(dispHSA) max(dispHSA)])
    box on
    view(0, 90)
    grid off
    colormap(cm)
    colorbar;
    hcb = colorbar;
    title_handle = get(hcb, 'Title');
    title_string = {'F [N]'};
    set(title_handle ,'String', title_string);
    % clim([-30.51 46.89]);
    xticks(x_tl)
    xticklabels(x_ticklabels)
    yticks(y_tl)
    yticklabels(y_ticklabels)
    set(gca, 'FontName', font, 'Layer', 'top')
    
    hold on
    plot3(noFRot, noFDisp, noFTau, 'k--', 'LineWidth', 1, 'DisplayName', 'F = 0')
    set(gca, 'FontName', font, 'Layer', 'top', 'ClippingStyle', 'rectangle')
    legend('Box','off', 'Location','northwest')
    % hold on
    % plot_gridX(x_grid)
    % plot_gridY(y_grid)
end

% torque plot

for i = 2
    data = readtable(dataHSA{i}, "VariableNamingRule", "preserve");
    degHSA = table2array(data(:,1)); % Rotation
    dispHSA = table2array(data(:,2)); % Displacement
    tauHSA = table2array(data(:,7)); % Force (in N-mm)
   

    % generate heat maps

    tauFit = fit([dispHSA, degHSA], tauHSA, 'poly33');
    [dispGrid, degGrid] = meshgrid(linspace(min(dispHSA), max(dispHSA), 50), linspace(min(degHSA), max(degHSA), 50));
    tauGrid = tauFit(dispGrid, degGrid);
    hold on

    subplot(2, 3, plot_pos((i) + 2))
    surf(degGrid, dispGrid, tauGrid, 'EdgeColor', 'none', 'HandleVisibility', 'off');
    xlabel('Rotation, \theta [\circ]');
    ylabel('Extension [mm]');
    zlabel('Torque');
    title({titles{i};'Torque (\tau)'});
    xlim([min(degHSA) max(degHSA)])
    ylim([min(dispHSA) max(dispHSA)])
    box on
    view(0, 90)
    grid off
    colormap(cm)
    colorbar;
    hcb = colorbar;
    title_handle = get(hcb, 'Title');
    title_string = {'\tau [Nmm]'};
    set(title_handle ,'String', title_string);
    clim([-56.03 145.75]);
    xticks(x_tl)
    xticklabels(x_ticklabels)
    yticks(y_tl)
    yticklabels(y_ticklabels)

    
    hold on
    plot3(noFRot, noFDisp, noFTau, 'k--', 'LineWidth', 1.0, 'DisplayName', 'F = 0')
    set(gca, 'FontName', font, 'Layer', 'top', 'ClippingStyle', 'rectangle')
    legend("Box", 'off', 'Location', 'southeast')

end

% spring constant plot

% for i = 1:2
%     data = readtable(dataHSA{i}, "VariableNamingRule", "preserve");
%     degHSA = table2array(data(:,1)); % Rotation
%     dispHSA = table2array(data(:,2)); % Displacement
%     kHSA = table2array(data(:,4)); % spring constant (in N/mm)
  

%     % generate heat maps

%     kFit = fit([dispHSA, degHSA], kHSA, 'poly33');
%     [dispGrid, degGrid] = meshgrid(linspace(min(dispHSA), max(dispHSA), 50), linspace(min(degHSA), max(degHSA), 50));
%     kGrid = kFit(dispGrid, degGrid);
%     hold on

%     subplot(2, 3, plot_pos((i) + 4))
%     surf(degGrid, dispGrid, kGrid, 'EdgeColor', 'none');
%     xlabel('Rotation, \theta [\circ]');
%     ylabel('Extension [mm]');
%     zlabel('Spring Constant');
%     title({titles{i};'Spring Constant (k)'});
%     xlim([min(degHSA) max(degHSA)])
%     ylim([min(dispHSA) max(dispHSA)])
%     box on
%     view(0, 90)
%     grid off
%     colormap(cm)
%     colorbar;
%     hcb = colorbar;
%     title_handle = get(hcb, 'Title');
%     title_string = {'k [N/mm]'};
%     set(title_handle ,'String', title_string);
%     clim([0 4.7358]);
%     xticks(x_tl)
%     xticklabels(x_ticklabels)
%     yticks(y_tl)
%     yticklabels(y_ticklabels)

%     set(gca, 'FontName', font, 'Layer', 'top')

%     % hold on
%     % plot_gridX(x_grid)
%     % plot_gridY(y_grid)

% end

% figure()
% scatter3(noFDisp,noFRot,noFTau)
% title('Torque Required Along the Minimum Energy Landscape')
% xlabel('Displacement [mm]')
% ylabel('Rotation [deg]')
% zlabel('Torque [Nmm]')



x0 = 900;
y0 = 500;
width = 1100;
height = 550;
set(gcf, 'position', [x0, y0, width, height])

exportgraphics(gcf, 'D:\Srivatsan\HSA-gripper-files\Plot Images\HeatMap.png', 'Resolution', 300)


% Optional lines to use as grid

%{
function plot_gridX(x)
    for j = 5:5:35
        y = j*ones(size(x));
        z = 100*ones(size(x)); 
        plot3(x, y, z, 'k-', 'LineWidth', 0.001, 'HandleVisibility', 'off')
        hold on  
    end

end

function plot_gridY(y1)
    for k = 20:20:120
        x1 = k*ones(size(y1));
        z1 = 100*ones(size(y1)); 
        plot3(x1, y1, z1, 'k-', 'LineWidth', 0.001, 'HandleVisibility', 'off')
        hold on  
    end

end
%}