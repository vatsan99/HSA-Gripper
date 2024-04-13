close all
clc

%{
    running this file processes standard HSA data, and preps subplots to 
    integrate into the final subplot, which contains stacked HSA data and their 
    corresponding subplots. 

    Directly run the file located at (↓)

    Final heatmap location: D:\Srivatsan\HSA-gripper-files\HSA Characterization\HSA Performance\StackedHSA\Heatmap.m
%}

run('SpringConstantMatrixGripper.m')

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
subplot(2, 3, 1)
contourf(thetaMat, dispMat, fMeanMat, 'EdgeColor', 'none')
colorbar
title('Mean Force: Standard HSA', 'FontSize', 10)
ylabel('Extension [mm]')
xlabel('Rotation, \theta [\circ]')

% Plot contour for Mean Torque

subplot(2, 3, 2)
contourf(thetaMat, dispMat, tauMeanMat, 'EdgeColor', 'none')
colorbar
title('Mean Torque: Standard HSA', 'FontSize', 10)
ylabel('Extension [mm]')
xlabel('Rotation, \theta [\circ]')

% Plot Spring Constant as a funtcion of rotation and displacement

subplot(2, 3, 3)
contourf(rotMatrix, dispMat, kFitMatrix, 'EdgeColor', 'none');
colorbar; % Adds a colorbar to indicate the values
title('Standard HSA: Spring Constant', 'FontSize', 10);
ylabel('Extension [mm]')
xlabel('Rotation, \theta [\circ]')

