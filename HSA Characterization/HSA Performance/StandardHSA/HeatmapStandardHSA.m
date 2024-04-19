close all
clc

run('SpringConstantMatrixGripper.m')

%{
    Run SpringConstantMatrixGripper.m to process raw Instron test data. This script utilizes processed data to plot
    surface plots to generate a heatmap for force, torque, and spring constant (average) for the standard HSA.
%}

ticklabels = {'0', '30', '60', '90', '120'};
tl = [0 30 60 90 120];

% Reshape the vectors into matrices - Double HSA

dispMat = reshape(disp(indMat(:,1)), [length(dispSteps), length(rotSteps)]);
thetaMat = reshape(theta(indMat(:,1)), [length(dispSteps), length(rotSteps)]);
fMeanMat = reshape(fMean, [length(dispSteps), length(rotSteps)]);
tauMeanMat = reshape(tauMean, [length(dispSteps), length(rotSteps)]);

% Reshape the data - Spring Constant

kFitMatrix = reshape(kFit, length(dispSteps), length(rotSteps));
dispMatrix = reshape(disp(indMat(:,1)), length(dispSteps), length(rotSteps));
rotMatrix = reshape(theta(indMat(:,1)), length(dispSteps), length(rotSteps));

% Plot contour for Mean Force

figure()
subplot(1, 3, 1)
surfc(thetaMat, dispMat, fMeanMat, 'EdgeAlpha', 0)
colorbar;
hcb = colorbar;
% hcb.Position = hcb.Position + [0.075 0 0 0];
title_handle = get(hcb, 'Title');
title_string = {'F [N]'};
set(title_handle ,'String', title_string);
clim([-15 30]);
title({'Standard HSA';'Mean Force (F)'}, 'FontSize', 10)
view(0, 90)
xticks(tl)
xticklabels(ticklabels)
ylabel('Extension [mm]')
xlabel('Rotation, \theta [\circ]')
box on

% Plot contour for Mean Torque

subplot(1, 3, 2)
surfc(thetaMat, dispMat, tauMeanMat, 'EdgeAlpha', 0)
colorbar;
hcb = colorbar;
% hcb.Position = hcb.Position + [0.075 0 0 0];
title_handle = get(hcb, 'Title');
title_string = {'\tau [Nmm]'};
set(title_handle ,'String', title_string);
clim([-60 75]);
title({'Standard HSA';'Mean Torque (\tau)'}, 'FontSize', 10)
view(0, 90)
xticks(tl)
xticklabels(ticklabels)
ylabel('Extension [mm]')
xlabel('Rotation, \theta [\circ]')
box on

% Plot Spring Constant as a function of rotation and displacement

subplot(1, 3, 3)
surfc(rotMatrix, dispMat, kFitMatrix, 'EdgeAlpha', 0);
colorbar;
hcb = colorbar;
% hcb.Position = hcb.Position + [0.075 0 0 0];
title_handle = get(hcb, 'Title');
title_string = {'k [N/mm]'};
set(title_handle ,'String', title_string);
clim([0 5]);
title({'Standard HSA';'Mean Spring Constant (k)'}, 'FontSize', 10);
view(0, 90)
xticks(tl)
xticklabels(ticklabels)
ylabel('Extension [mm]')
xlabel('Rotation, \theta [\circ]')
box on

colormap("jet")

% figure size

x0 = 900;
y0 = 410;
width = 1250;
height = 300;
set(gcf, 'position', [x0, y0, width, height])
exportgraphics(gcf, 'D:\Srivatsan\HSA-gripper-files\Plot Images\HeatmapStandard.png', 'Resolution', 800)