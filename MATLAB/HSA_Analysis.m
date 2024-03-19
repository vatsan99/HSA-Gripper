close all
clc

hsa_force_fea = readtable('force-reaction-full-HSA.xls.csv');

time1 = table2array(hsa_force_fea(:, 3));

force_reaction1 = table2array(hsa_force_fea(:, 4));

figure
plot(time1, force_reaction1, '-', 'LineWidth', 1.5)

xlabel('Displacement [mm]')
ylabel('Force [N]')

x0 = 800;
y0 = 600;
width = 600;
height = 450;
set(gcf, 'position', [x0, y0, width, height])