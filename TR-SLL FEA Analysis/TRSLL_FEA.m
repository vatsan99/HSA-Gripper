clc
close all

data = readtable('TRL-Deformation-FEAData.xlsx', 'sheet', 2);
% data = readtable('TRL-Deformation-FEAData');
stress_data = readtable("TRL-Stress-FEAData");

t_n = table2array(data(:, 1)); % number of triangles
% disp = table2array(data(2:80, 4)); % in-plane deformation
delta_08mm = table2array(data(:, 2)); % 0.8 mm base
ms = 15; % marker size

K = 0.01./delta_08mm; % Bending Stiffness = Force applied / deflection

figure()
subplot(3, 1, 1)
plot(t_n, K,'k.', 'MarkerSize', ms, 'LineWidth', 1.5, "MarkerFaceColor", 'k', 'DisplayName', 'TR-SLL: F = 0.01 N') % (0.01)./

legend('Location', 'southeast')
xlim([0 82])
% ylim([2.8e-3 3.6e-3])
box on
xlabel('Number of Triangles [-]')
ylabel('Bending Stiffness, K [N/mm]')
title({'Bending Stiffness: TR-SLL (F = 0.01 N)';'Simulated Data'}) 

% Torsion Stiffness (kappa)

data1 = readtable('Torsional-Stiffness-Test.xlsx');
angle_8 = table2array(data1(:, 15)); % 0.8 mm Base, 25 mm Wide

kappa = 5./angle_8; % Torsional stiffness = Moment / angle of rotation

subplot(3, 1, 2)
plot(t_n, kappa, 'k.', 'MarkerSize', ms, 'LineWidth', 1.5, "MarkerFaceColor", 'k', 'DisplayName', 'TR-SLL: M = 5 Nmm')

legend()
xlim([0 82])
xlabel('Number of Triangles [-]')
ylabel('Torsional Stiffness, \kappa [Nmm/rad]')
title({'Torsional Stiffness: TR-SLL (M = 5 N mm)';'Simulated Data'})
% ylim([0 0.03])

% Stress Data Analysis

t_n = table2array(stress_data((1:79), 1));

stress_in_plane = table2array(stress_data((1:79), 4)); % average stress during in-plane bending
stress_twist = table2array(stress_data((1:79), 5)); % average stress during twist


subplot(3, 1, 3)
yyaxis left
p1 = plot(t_n, stress_in_plane,'r.','MarkerSize', ms, 'LineWidth', 1.5, "MarkerFaceColor", 'r', 'DisplayName', 'Average Stress: In-Plane');
ylabel("Average Stress: Bending [MPa]")
ylim([0.01 0.240])
set(gca, 'YColor', p1.Color)

hold on
yyaxis right
p2 = plot(t_n, stress_twist, 'b.','MarkerSize', ms, 'LineWidth', 1.5, "MarkerFaceColor", 'b', 'DisplayName', 'Average Stress: Twist');
ylabel("Average Stress: Twisting [MPa]")
ylim([0.01 0.240])
set(gca, 'YColor', p2.Color)

% plot format
xlabel("Number of Triangles [-]")
xlim([0 82])

title({'Average Stresses: TR-SLL';'Simulated Data'})
legend('Location', 'northeast')
box on


% figure size

x0 = 900;
y0 = 100;
width = 450;
height = 1200;
set(gcf, 'position', [x0, y0, width, height])
exportgraphics(gcf, 'D:\Srivatsan\HSA-gripper-files\Plot Images\TR-SLL-FEA.png', 'Resolution', 800)