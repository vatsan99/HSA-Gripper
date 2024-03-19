clc

close all

stress_data = readtable("TRL-stress-data");

t_n = stress_data((1:79),1);
t_nAr = table2array(t_n);

stress = stress_data((1:79),2);
stressAr = table2array(stress);

% average stress
stress_avg = stress_data((1:79),3);
stress_avgAr = table2array(stress_avg);

figure()
box on

plot(t_nAr,stress_avgAr,'r^','MarkerSize',4, 'MarkerFaceColor', 'r')
% figure()
% hold on
% plot(t_nAr,stress_avgAr,'ro-','MarkerSize',6)

% plot format
xlabel("Number of Triangles [-]")
ylabel("Average stress [MPa]")
xlim([1 80])
% ylim([1 2.2])
title("Average stress: TR-SLL (F = 0.01 N)")
% title("Average stress for F = 0.01 N")
% grid on
% grid minor

% figure size; save figure

x0 = 1000;
y0 = 800;
width = 500;
height = 350;
set(gcf, 'position', [x0, y0, width, height])

fullFilePath = fullfile('D:\Srivatsan\HSA-gripper-files\Figures', 'Avg-Stress.png');

saveas(gcf, fullFilePath)