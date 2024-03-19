clc
close all

data = readtable('HSA-Tensile-Torsion_1.csv');
data1 = table2array(data);
data2 = table2array(readtable('HSA-Tensile-Torsion_2.csv'));


disp_data = data1(:, 2);
force_data = data1(:, 3);

disp_data1 = data2(:, 2);
force_data1 = data2(:, 3);

figure()
plot(disp_data, force_data*(-1), "LineWidth", 1.5)
hold on
plot(disp_data1, force_data1*(-1), "LineWidth", 1.5)

xlabel('Displacement [mm]')
ylabel('Force [N]')
xlim([0 6])
ylim([0 35])
grid on
grid minor




% figure size

x0 = 1000;
y0 = 650;
width = 800;
height = 400;
set(gcf, 'position', [x0, y0, width, height])