close all
clc

data = readtable('TRL-Deformation-FEAData');

t_n = table2array(data(2:80,1)); % number of triangles
disp = table2array(data(2:80,3)); % in-plane deformation

disp_08mm = table2array(data(2:80,4));

p = polyfit(t_n,disp,7);
x2 = linspace(2,30);

y_fit1 = polyval(p,x2);

figure
% subplot(2,1,1)
% plot(x2,y_fit1,'r-','LineWidth',1.5)
% hold on
subplot(1, 3, 1)
plot(t_n, (0.01)./disp,'ro','MarkerSize', 3,'LineWidth', 1.5, "MarkerFaceColor", 'r', 'DisplayName', '0.4 mm Base') % (0.01)./
hold on
plot(t_n, (0.01)./disp_08mm,'ko','MarkerSize', 3,'LineWidth', 1.5, "MarkerFaceColor", 'k', 'DisplayName', '0.8 mm Base') % (0.01)./
% legend
% xlim([0 80])
% ylim([0.0030 0.0035])
% ylim([2.5 3.5])
legend('Location', 'southeast')
box on
% grid on

% polyfit - displacement vs t_n


xlabel('Number of Triangles [-]')
ylabel('Stiffness, k [N/mm]')
title({'In-Plane Stiffness: TR-SLL (F = 0.01 N)';'Simulated Data'}) 

x0 = 900;
y0 = 600;
width = 500;
height = 350;
set(gcf, 'position', [x0, y0, width, height])

% exportgraphics(gcf, 'D:\Srivatsan\HSA-gripper-files\Plot Images\TR-SLL-in_plane.png', 'Resolution', 600)

% Torsion Test - Modified SLL ---------------------------------------

data1 = readtable('Torsional-Stiffness-Test.xlsx');

t_n1 = table2array(data1(3:81,4)); % number of triangles
angle = table2array(data1(3:81,10)); % angular deformation
angle_8 = table2array(data1(3:81,11)); % 0.8 mm Base

ang_deg = angle.*(57.2957);
ang_deg_8 = angle_8.*(57.2957);
p1 = polyfit(t_n1, angle.*(57.2957), 7);
x1 = linspace(2,30);

y_fit = polyval(p1,x1);

subplot(1, 3, 2)
% plot(x1,y_fit,'r-','LineWidth',1.5)

plot(t_n1, (5./angle),'ro','MarkerSize', 3,'LineWidth', 1.5, "MarkerFaceColor", 'r') % torsional stiffness
hold on
plot(t_n1, (5./angle_8),'ko','MarkerSize', 3,'LineWidth', 1.5, "MarkerFaceColor", 'k')
legend('TR-SLL - (M = 5 Nmm)', '0.8 mm Base')
% ylim([0 1.6])
xlim([0 80])
% legend
% grid on


xlabel('Number of Triangles [-]')
ylabel('Torsional Stiffness, K [Nmm/rad]')
title({'Torsional Stiffness: TR-SLL (M = 5 N mm)';'Simulated Data'})
% ylim([0 0.03])

x0 = 1500;
y0 = 600;
width = 500;
height = 350;
set(gcf, 'position', [x0, y0, width, height])

% exportgraphics(gcf, 'D:\Srivatsan\HSA-gripper-files\Plot Images\TR-SLL-torsion.png', 'Resolution', 600)