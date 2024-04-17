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

subplot(1, 3, 1)
surfc(thetaMat, dispMat, fMeanMat, 'EdgeAlpha', 0)
colorbar;
clim([-2e4 2e4]);
title({'Stacked HSA';'Mean Force'}, 'FontSize', 10)
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
clim([-50 65]);
title({'Stacked HSA';'Mean Torque'}, 'FontSize', 10)
view(0, 90)
xticks(tl)
xticklabels(ticklabels)
ylabel('Extension [mm]')
xlabel('Rotation, \theta [\circ]')
box on
% Plot Spring Constant as a funtcion of rotation and displacement

subplot(1, 3, 3)
surfc(rotMatrix, dispMat, kFitMatrix, 'EdgeAlpha', 0);
view(0, 90)
colorbar; % Adds a colorbar to indicate the values
clim([0 4500]);
xticks(tl)
xticklabels(ticklabels)
title({'Stacked HSA';'Spring Constant'}, 'FontSize', 10);
ylabel('Extension [mm]')
xlabel('Rotation, \theta [\circ]')
box on

colormap("jet")


% figure size

x0 = 900;
y0 = 410;
width = 1200;
height = 300;
set(gcf, 'position', [x0, y0, width, height])
exportgraphics(gcf, 'D:\Srivatsan\HSA-gripper-files\Plot Images\HeatmapStacked.png', 'Resolution', 800)