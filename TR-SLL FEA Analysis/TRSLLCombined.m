clc
close all

run('TRSLLStiffness.m')

stress_data = readtable("TRL-Stress-FEAData");

t_n = stress_data((1:79),1);
t_nAr = table2array(t_n);

stress = stress_data((1:79),2);
stressAr = table2array(stress);

% average stress
stress_avg = stress_data((1:79),3);
stress_avgAr = table2array(stress_avg);

% average stress 2
stress_avg2 = stress_data((1:79),4);
stress_avgAr2 = table2array(stress_avg2);

% box on
subplot(1, 3, 3)
plot(t_nAr,stress_avgAr,'ro','MarkerSize', 3, 'LineWidth', 1.5, "MarkerFaceColor", 'r', 'DisplayName', '0.4 mm Base')
hold on
plot(t_nAr,stress_avgAr2,'ko','MarkerSize', 3, 'LineWidth', 1.5, "MarkerFaceColor", 'k', 'DisplayName', '0.8 mm Base')
% figure()
% hold on
% plot(t_nAr,stress_avgAr,'ro-','MarkerSize',6)

% plot format
xlabel("Number of Triangles [-]")
ylabel("Average Stress, \sigma_a [MPa]")
xlim([0 80])
% ylim([0 0.15])
title({'Average Stress: TR-SLL (F = 0.01 N)';'Simulated Data'})
legend('Location', 'Southwest')
box on
% title("Average stress for F = 0.01 N")
% grid on
% grid minor

% figure size; save figure

x0 = 1000;
y0 = 800;
width = 1200;
height = 350;
set(gcf, 'position', [x0, y0, width, height])

exportgraphics(gcf, 'D:\Srivatsan\HSA-gripper-files\Plot Images\TR-SLL-FEA.png', 'Resolution', 600)