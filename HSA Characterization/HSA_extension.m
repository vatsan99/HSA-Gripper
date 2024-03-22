clc
close all


HSA_FEA = table2array(readtable('.\HSA-FEA-Extension.csv')); % FEA data
HSA_exp = table2array(readtable('.\HSA-full-extension-test.is_tcyclic_tao_Exports\HSA-full-extension-test_1.csv')); % Instron data
HSA_exp2 = table2array(readtable('.\HSA-full-extension-test.is_tcyclic_tao_Exports\HSA-full-extension-test_2.csv')); % Instron data

HSA_exp_disp = HSA_exp(:, 2);
HSA_exp_force = HSA_exp(:, 3).*1000; % force data to N

HSA_exp_disp2 = HSA_exp2(:, 2);
HSA_exp_force2 = HSA_exp2(:, 3).*1000; % force data to N

HSA_FEA_disp = HSA_FEA(:, 1);
HSA_FEA_force = HSA_FEA(:, 2);

figure()
plot(HSA_exp_disp, HSA_exp_force, "LineWidth", 1.5) % instron extension
hold on
plot(HSA_exp_disp2, HSA_exp_force2, "LineWidth", 1.5)
hold on
plot(HSA_FEA_disp, HSA_FEA_force, "LineWidth", 1.5) % FEA

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