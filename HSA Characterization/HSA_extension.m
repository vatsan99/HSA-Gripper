clc
close all

% data = readtable('HSA-Tensile-Torsion_1.csv');
% data1 = table2array(data);
% data2 = table2array(readtable('HSA-Tensile-Torsion_2.csv'));

HSA_FEA = table2array(readtable('HSA-FEA-Extension.csv'));
HSA_exp = table2array(readtable('HSA-FEA-Extension.csv'));

HSA_exp_disp = HSA_exp(:, 1);
HSA_exp_force = HSA_exp(:, 2);

HSA_FEA_disp = HSA_FEA(:, 2);
HSA_FEA_force = HSA_FEA(:, 3);

figure()
plot(HSA_exp_disp, HSA_exp_force, "LineWidth", 1.5)
hold on
plot(HSA_FEA_disp, HSA_FEA_force, "LineWidth", 1.5)

xlabel('Displacement [mm]')
ylabel('Force [N]')
% xlim([0 6])
% ylim([0 35])
grid on
grid minor




% figure size

x0 = 1000;
y0 = 650;
width = 800;
height = 400;
set(gcf, 'position', [x0, y0, width, height])