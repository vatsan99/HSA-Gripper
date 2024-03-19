close all
% clear all
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
plot(t_n,disp,'r+','MarkerSize',6,'LineWidth', 1.5)
% legend
xlim([0 80])
ylim([0 30])
legend('TRL - (F = 0.01 N)')
% grid on

% polyfit - displacement vs t_n


xlabel('Number of Triangles [-]')
ylabel(' Displacement as a percentage of length [%]')
title({'In-Plane Deformation: Modified SLL (F = 0.01 N)';'Simulated Data'}) 



% figure size; save figure

x0 = 1000;
y0 = 800;
width = 550;
height = 350;
set(gcf, 'position', [x0, y0, width, height])

fullFilePath = fullfile('D:\Srivatsan\HSA-gripper-files\Figures', 'In-plane.png');

saveas(gcf, fullFilePath)

% Torsion Test - Modified SLL ---------------------------------------
% 
% data1 = readtable('Torsional-Stiffness-Test.xlsx');
% 
% t_n1 = table2array(data1(1:29,4)); % number of triangles
% angle = table2array(data1(1:29,10)); % angular deformation
% ang_deg = angle.*(57.2957);
% p1 = polyfit(t_n1,angle.*(57.2957),7);
% x1 = linspace(2,30);
% 
% y_fit = polyval(p1,x1);
% 
% subplot(2,1,2)
% plot(x1,y_fit,'r-','LineWidth',1.5)
% hold on
% plot(t_n1,angle.*(57.2957),'r+','MarkerSize',6,'LineWidth',1.5)
% legend('TRL - (M = 5 Nmm)')
% ylim([0 1.6])
% % legend
% % grid on
% % 
% % 
% xlabel('Number of Triangles [-]')
% ylabel('Angular Displacement [degrees]')
% title({'Angular Displacement: Modified SLL (M = 5 N mm)';'Simulated Data'})
% ylim([0 0.03])
% 
% 
% % expression: F_g = (kappa / r**2) * x, r (thickness of the base Ecoflex
% % layer), x (extension distance)

%%
% torsionRatio = disp./flip(ang_deg);
% SLLRatio = 27.38/15.36;
% SLLequiv = [SLLRatio.*.1 ];
% nSLL = [0.00001];
% figure()
% semilogy(t_n,torsionRatio,'ko','MarkerSize',6)
% ylim ([0.1 30])
% hold on 
% plot(nSLL,SLLequiv,'ro','MarkerSize',6)
% xlabel('Number of Triangles [-]')
% ylabel('In-Plane Performance Ratio [mm]/[degree]')
% title('Grippability Metric')
% 
% legend('TRL - (M = 5 N mm,F = 0.01 N)','SLL - (M ~= 5 N mm,F = 0.01 N)')