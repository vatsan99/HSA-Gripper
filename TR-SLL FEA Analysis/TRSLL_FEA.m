clc
close all

FEA_data = readtable('TR-SLL_FEA Data - Updated.xlsx', 'VariableNamingRule', 'preserve');

ticklabels = string(0:10:80);
tl = 0:10:80;
y_tl = 3.5e-3:0.2e-3:4.5e-3; 
y_ticklabels = string(3.5e-3:0.2e-3:4.5e-3);

ms = 15; % marker size
font = 'Times New Roman';

t_n = table2array(FEA_data(:, 2)); % number of triangles
disp = table2array(FEA_data(:, 3)); % in-plane deformation
K = 0.01./disp; % Bending Stiffness = Force applied / deflection
ang_disp = table2array(FEA_data(:, 7));
kappa = 5./ang_disp; % Torsional stiffness = Moment / angle of rotation

figure()

subplot(1, 3, 2)
plot(t_n, K, 'x', 'MarkerSize', 6, 'LineWidth', 1.5, "MarkerFaceColor", [0.8500 0.3250 0.0980], 'DisplayName', 'TR-SLL: F = 0.01 N') % (0.01)./
legend('Location', 'southeast')
xlim([0 82])
ylim([min(K)-0.2e-3 max(K)+0.2e-3])
box on
xlabel('Number of Triangles [-]')
ylabel('Bending Stiffness, K [N/mm]')
title({'Bending Stiffness: TR-SLL';'Simulated Data'})
xticks(tl)
xticklabels(ticklabels)
yticks(y_tl)
yticklabels(y_ticklabels)
ytickformat('%.1f')
set(gca, 'FontName', font)
grid on

subplot(1, 3, 1)
plot(t_n, kappa, '.', 'MarkerSize', ms, 'LineWidth', 1.5, "MarkerFaceColor", [0.8500 0.3250 0.0980], 'Color', [0.8500 0.3250 0.0980],'DisplayName', 'TR-SLL: M = 5 Nmm') % (0.01)./
legend('Location', 'northeast')
xlim([0 82])
ylim([0 1050])
box on
xlabel('Number of Triangles [-]')
ylabel('Torsional Stiffness, \kappa [Nmm/rad]')
title({'Torsional Stiffness: TR-SLL';'Simulated Data'})
xticks(tl)
xticklabels(ticklabels)
set(gca, 'FontName', font)
grid on

% Stress Data

stress_in_plane = table2array(FEA_data(:, 4)); % average stress during in-plane bending
stress_twist = table2array(FEA_data(:, 8)); % average stress during twist

subplot(1, 3, 3)
% yyaxis left
plot(t_n, stress_in_plane, 'x', 'MarkerSize', 6, 'LineWidth', 1.5, "MarkerFaceColor", 'r', 'DisplayName', 'In-Plane Bending: F = 0.01 N');
% ylim([0.01 0.20])
% set(gca, 'YColor', p1.Color)

hold on
% yyaxis right
plot(t_n, stress_twist, '.','MarkerSize', ms, 'LineWidth', 1.5, 'DisplayName', 'Torsion: M = 5 Nmm');
% ylabel("Average Stress: Torsion [MPa]")
ylim([0 0.15])
% set(gca, 'YColor', p2.Color)
% xticks(tl)
% xticklabels(ticklabels)
% plot format
xlabel("Number of Triangles [-]")
ylabel("Average Stress [MPa]")
xlim([0 82])
% grid on
title({'Average Stress: TR-SLL';'Simulated Data'})
legend('Location', 'northeast')
box on
xticks(tl)
xticklabels(ticklabels)
set(gca, 'FontName', font)
grid on




% figure size

x0 = 900;
y0 = 500;
width = 1150;
height = 280;
set(gcf, 'position', [x0, y0, width, height])
exportgraphics(gcf, 'D:\Srivatsan\HSA-gripper-files\Plot Images\TR-SLL-FEA.png', 'Resolution', 330)