clc
close all


data = readtable('TRL-Deformation-FEAData');
stress_data = readtable("TRL-Stress-FEAData");

t_n = table2array(data(2:80, 1)); % number of triangles
disp = table2array(data(2:80, 3)); % in-plane deformation

disp_08mm = table2array(data(2:80, 4));

ms = 15; % marker size

p = polyfit(t_n, disp, 7);
x2 = linspace(2, 30);

y_fit1 = polyval(p, x2);

figure
subplot(1, 3, 1)
% plot(t_n, (0.01)./disp,'ro','MarkerSize', ms,'LineWidth', 1.5, "MarkerFaceColor", 'r', 'DisplayName', '0.4 mm Base') % (0.01)./
% hold on
plot(t_n, (0.01)./disp_08mm,'k.', 'MarkerSize', ms, 'LineWidth', 1.5, "MarkerFaceColor", 'k', 'DisplayName', '0.8 mm Base') % (0.01)./
legend('Location', 'southeast')
% axis tight
box on

% polyfit - displacement vs t_n

xlabel('Number of Triangles [-]')
ylabel('Stiffness, k [N/mm]')
title({'In-Plane Stiffness: TR-SLL (F = 0.01 N)';'Simulated Data'}) 

% Torsion Test - Modified SLL ---------------------------------------

data1 = readtable('Torsional-Stiffness-Test.xlsx');

t_n1 = table2array(data1(3:81, 4)); % number of triangles
angle = table2array(data1(3:81, 10)); % angular deformation
angle_8 = table2array(data1(3:81, 11)); % 0.8 mm Base

ang_deg = angle.*(57.2957);
ang_deg_8 = angle_8.*(57.2957);
p1 = polyfit(t_n1, angle.*(57.2957), 7);
x1 = linspace(2,30);

y_fit = polyval(p1, x1);

subplot(1, 3, 2)
% plot(x1,y_fit,'r-','LineWidth',1.5)

% plot(t_n1, (5./angle),'ko','MarkerSize', ms,'LineWidth', 1.5, "MarkerFaceColor", 'r') % torsional stiffness
% hold on
plot(t_n1, (5./angle_8),'k.','MarkerSize', ms,'LineWidth', 1.5, "MarkerFaceColor", 'k', 'DisplayName', '0.8 mm Base')
legend()
xlim([0 80])

xlabel('Number of Triangles [-]')
ylabel('Torsional Stiffness, K [Nmm/rad]')
title({'Torsional Stiffness: TR-SLL (M = 5 N mm)';'Simulated Data'})
% ylim([0 0.03])

% Stress Data Analysis

t_n = table2array(stress_data((1:79), 1));

stress_in_plane = table2array(stress_data((1:79), 4)); % average stress - 0.8 mm base
stress_twist = table2array(stress_data((1:79), 5)); % average stress during twist

% box on
subplot(1, 3, 3)
yyaxis left
p1 = plot(t_n,stress_in_plane,'r.','MarkerSize', ms, 'LineWidth', 1.5, "MarkerFaceColor", 'r', 'DisplayName', 'Average Stress: In-Plane');
ylabel("Average Stress: In-Plane, \sigma_a [MPa]")
set(gca, 'YColor', p1.Color)

hold on
yyaxis right
p2 = plot(t_n,stress_twist,'b.','MarkerSize', ms, 'LineWidth', 1.5, "MarkerFaceColor", 'b', 'DisplayName', 'Average Stress: Twist');
ylabel("Average Stress: Twist, \sigma_a [MPa]")
set(gca, 'YColor', p2.Color)

% plot format
xlabel("Number of Triangles [-]")
xlim([0 80])

title({'Average Stress: TR-SLL';'F = 0.01 N; M = 5 Nmm';'Simulated Data'})
legend('Location', 'northeast')
box on


% figure size

x0 = 900;
y0 = 410;
width = 1300;
height = 400;
set(gcf, 'position', [x0, y0, width, height])
exportgraphics(gcf, 'D:\Srivatsan\HSA-gripper-files\Plot Images\TR-SLL-FEA.png', 'Resolution', 800)