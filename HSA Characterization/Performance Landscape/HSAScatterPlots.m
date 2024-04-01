clc
close all

data = readtable('.\HSAFingerSeperateParts.csv');

extension = table2array(data(:, 2));
force = table2array(data(:, 3)).*0.001;
torque = table2array(data(:, 5));
theta = table2array(data(:, 4));


data2 = readtable('.\0to35mm_0to130deg_NRGLandscape_1.csv');

extension2 = table2array(data2(:, 2));
force2 = table2array(data2(:, 3)).*0.001;
torque2 = table2array(data2(:, 5));
theta2 = table2array(data2(:, 4));

figure()
subplot(1, 2, 1)
scatter3(theta, extension, force, 'r', 'DisplayName', 'Double HSA')
hold on
scatter3(theta2, extension2, force2, 'b', 'DisplayName', 'Single HSA')
box on
xlabel('Rotation, \theta [degrees]')
ylabel('Extension [mm]')
zlabel('Force [N]')

view(-90, 0)
legend('Location', 'best')

subplot(1, 2, 2)
scatter3(theta, extension, torque, 'r', 'DisplayName', 'Double HSA')
hold on
scatter3(theta2, extension2, torque2, 'b', 'DisplayName', 'Single HSA')
box on
xlabel('Rotation, \theta [degrees]')
ylabel('Extension [mm]')
zlabel('Torque [Nmm]')

view(180, 0)
legend('Location', 'best')



x0 = 950;
y0 = 410;
width = 1400;
height = 500;
set(gcf, 'position', [x0, y0, width, height])