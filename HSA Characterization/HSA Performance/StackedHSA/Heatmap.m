close all
clc

run('SpringConstantMatrixGripper.m')

run('D:\Srivatsan\HSA-gripper-files\HSA Characterization\HSA Performance\StandardHSA\Heatmap.m') % process standard HSA data and create subplots

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

subplot(2, 3, 4)
contourf(thetaMat, dispMat, fMeanMat, 'EdgeColor', 'none')
colorbar
title('Mean Force: Stacked HSA', 'FontSize', 10)
ylabel('Extension [mm]')
xlabel('Rotation, \theta [\circ]')

% Plot contour for Mean Torque

subplot(2, 3, 5)
contourf(thetaMat, dispMat, tauMeanMat, 'EdgeColor', 'none')
colorbar
title('Mean Torque: Stacked HSA', 'FontSize', 10)
ylabel('Extension [mm]')
xlabel('Rotation, \theta [\circ]')

% Plot Spring Constant as a funtcion of rotation and displacement

subplot(2, 3, 6)
contourf(rotMatrix, dispMat, kFitMatrix, 'EdgeColor', 'none');
colorbar; % Adds a colorbar to indicate the values
title('Stacked HSA: Spring Constant', 'FontSize', 10);
ylabel('Extension [mm]')
xlabel('Rotation, \theta [\circ]')




% figure size

x0 = 900;
y0 = 410;
width = 1200;
height = 600;
set(gcf, 'position', [x0, y0, width, height])
exportgraphics(gcf, 'D:\Srivatsan\HSA-gripper-files\Plot Images\ContourWAuxTraj.png', 'Resolution', 800)