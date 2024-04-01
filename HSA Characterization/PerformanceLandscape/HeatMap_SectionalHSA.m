close all
clc

% Double/Sectional HSA Heat Map

data_sectional_HSA = readtable(".\HSAFingerSeperateParts.csv");

disp_sectional_HSA = table2array(data_sectional_HSA(:, 2));
theta_sectional_HSA = table2array(data_sectional_HSA(:, 4).*(-1)); % x

force_sectional_HSA = table2array(data_sectional_HSA(:, 3)); % z
torque_sectional_HSA = table2array(data_sectional_HSA(:, 5)); % z