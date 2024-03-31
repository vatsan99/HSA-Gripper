close all
clc

data = readtable('TRL-new-old');

t_n = table2array(data(2:80,1)); % number of triangles
disp = table2array(data(2:80,3)); % in-plane deformation

p = polyfit(t_n,disp,7);
x2 = linspace(2,30);

y_fit1 = polyval(p,x2);

figure
% subplot(2,1,1)
% plot(x2,y_fit1,'r-','LineWidth',1.5)
% hold on
% subplot(2,1,1)
plot(t_n, (0.01)./disp,'r^','MarkerSize', 3,'LineWidth', 1.5, "MarkerFaceColor", 'r')
% legend
% xlim([0 80])
% ylim([0 30])
legend('TR-SLL - (F = 0.01 N)')
% grid on

% polyfit - displacement vs t_n


xlabel('Number of Triangles [-]')
ylabel('Stiffness [N/mm]')
title({'In-Plane Stiffness: TR-SLL (F = 0.01 N)';'Simulated Data'}) 

x0 = 900;
y0 = 600;
width = 500;
height = 350;
set(gcf, 'position', [x0, y0, width, height])

fullFilePath = fullfile('D:\Srivatsan\HSA-gripper-files\Plot Images', 'TR-SLL-in_plane.png');

saveas(gcf, fullFilePath)

% Torsion Test - Modified SLL ---------------------------------------

data1 = readtable('Torsional-Stiffness-Test.xlsx');

t_n1 = table2array(data1(3:81,4)); % number of triangles
angle = table2array(data1(3:81,10)); % angular deformation
ang_deg = angle.*(57.2957);
p1 = polyfit(t_n1,angle.*(57.2957),7);
x1 = linspace(2,30);

y_fit = polyval(p1,x1);

% subplot(2,1,2)
% plot(x1,y_fit,'r-','LineWidth',1.5)
% hold on
figure()
plot(t_n1, (5./angle),'r^','MarkerSize', 3,'LineWidth', 1.5, "MarkerFaceColor", 'r') % torsional stiffness
legend('TR-SLL - (M = 5 Nmm)')
% ylim([0 1.6])
xlim([0 80])
% legend
% grid on


xlabel('Number of Triangles [-]')
ylabel('Torsional Stiffness [Nmm/rad]')
title({'Torsional Stiffness: TR-SLL (M = 5 N mm)';'Simulated Data'})
% ylim([0 0.03])

x0 = 1500;
y0 = 600;
width = 500;
height = 350;
set(gcf, 'position', [x0, y0, width, height])

shg

fullFilePath = fullfile('D:\Srivatsan\HSA-gripper-files\Plot Images', 'TR-SLL-out_of_plane.png');

saveas(gcf, fullFilePath)