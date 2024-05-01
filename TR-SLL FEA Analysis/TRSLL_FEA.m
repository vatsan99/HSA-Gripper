clc
close all

FEA_data = readtable('FEA Data - 0.8mm;25mm.xlsx', 'VariableNamingRule', 'preserve');

ticklabels = string(0:10:80);
tl = 0:10:80;
ms = 15; % marker size

t_n = table2array(FEA_data(:, 2)); % number of triangles

disp = table2array(FEA_data(:, 3)); % in-plane deformation
K = 0.01./disp; % Bending Stiffness = Force applied / deflection

ang_disp = table2array(FEA_data(:, 6));
kappa = 5./ang_disp; % Torsional stiffness = Moment / angle of rotation


figure()

subplot(1, 3, 1)
plot(t_n, K, 'k.', 'MarkerSize', ms, 'LineWidth', 1.5, "MarkerFaceColor", 'k', 'DisplayName', 'TR-SLL: F = 0.01 N') % (0.01)./
legend('Location', 'southeast')
xlim([0 82])
ylim([min(K)-0.1e-3 max(K)+0.1e-3])
box on
xlabel('Number of Triangles [-]')
ylabel('Bending Stiffness, K [N/mm]')
title({'Bending Stiffness: TR-SLL';'Simulated Data'})
xticks(tl)
xticklabels(ticklabels)

subplot(1, 3, 2)
plot(t_n, kappa, 'k.', 'MarkerSize', ms, 'LineWidth', 1.5, "MarkerFaceColor", 'k', 'DisplayName', 'TR-SLL: M = 5 Nmm') % (0.01)./
legend('Location', 'northeast')
xlim([0 82])
ylim([min(kappa)-10 max(kappa)+10])
box on
xlabel('Number of Triangles [-]')
ylabel('Torsional Stiffness, \kappa [N/mm]')
title({'Torsional Stiffness: TR-SLL';'Simulated Data'})
xticks(tl)
xticklabels(ticklabels)

% Stress Data

stress_in_plane = table2array(FEA_data(:, 4)); % average stress during in-plane bending
stress_twist = table2array(FEA_data(:, 8)); % average stress during twist

subplot(1, 3, 3)
yyaxis left
p1 = plot(t_n, stress_in_plane, 'r.','MarkerSize', ms, 'LineWidth', 1.5, "MarkerFaceColor", 'r', 'DisplayName', 'Average Stress: In-Plane');
ylabel("Average Stress: Bending [MPa]")
ylim([0.01 0.20])
set(gca, 'YColor', p1.Color)

hold on
yyaxis right
p2 = plot(t_n, stress_twist, 'k.','MarkerSize', ms, 'LineWidth', 1.5, "MarkerFaceColor", 'b', 'DisplayName', 'Average Stress: Twist');
ylabel("Average Stress: Twisting [MPa]")
ylim([0.01 0.20])
set(gca, 'YColor', p2.Color)
xticks(tl)
xticklabels(ticklabels)
% plot format
xlabel("Number of Triangles [-]")
xlim([0 82])
% grid on
title({'Average Stresses: TR-SLL';'Simulated Data'})
legend('Location', 'northeast')
box on 






% figure size

x0 = 900;
y0 = 500;
width = 1200;
height = 300;
set(gcf, 'position', [x0, y0, width, height])
exportgraphics(gcf, 'D:\Srivatsan\HSA-gripper-files\Plot Images\TR-SLL-FEA.png', 'Resolution', 800)