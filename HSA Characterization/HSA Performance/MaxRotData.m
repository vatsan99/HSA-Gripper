close all
clc

font = 'Times New Roman';

data_standard = readtable('.\StandardHSA\HSA_GRIPPER_SpringConstantData_StandardHSA', "VariableNamingRule", "preserve"); % Long HSA Data
data_sectional = readtable('.\StackedHSA\HSA_GRIPPER_SpringConstantData_SingleSectionalHSA', 'VariableNamingRule', 'preserve'); % Short HSA Data

long_color = [0.4660 0.6740 0.1880];
short_color = [0.6350 0.0780 0.1840];

% Long HSA Data
degHSA_l = table2array(data_standard(:,1)); % Rotation
dispHSA_l = table2array(data_standard(:,2)); % Displacement
fHSA_l =  table2array(data_standard(:,3)).*1000; % force (kN to N)
tauHSA_l = table2array(data_standard(:, 7)); % Torque

% Short HSA Data
degHSA_s = table2array(data_sectional(:,1));
dispHSA_s = table2array(data_sectional(:,2));
fHSA_s = table2array(data_sectional(:,3))./1000; % force (mN to N)
tauHSA_s = table2array(data_sectional(:, 7)); % Torque

% Force Plot
plot3(degHSA_s(92:end), dispHSA_s(92:end), fHSA_s(92:end), 'x-', 'DisplayName', 'Short HSA', 'MarkerSize', 8, 'LineWidth', 1.5, 'Color', short_color, 'MarkerFaceColor', short_color)
hold on
plot3(degHSA_l(85:end), dispHSA_l(85:end), fHSA_l(85:end), 's-', 'DisplayName', 'Long HSA', 'MarkerSize', 6, 'LineWidth', 1.5, 'Color', long_color, 'MarkerFaceColor', long_color) % , 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'k'
view(90, 0)

ylim([-1 max(dispHSA_l)+1])
ylabel('Extension [mm]');
title('Force at Maximum HSA Rotation (120\circ)')
zlabel('Force [N]');
legend('location', 'northwest')
box on
grid on

set(gca, 'ClippingStyle', 'rectangle', 'fontName', font)

x0 = 1500;
y0 = 500;
width = 460;
height = 220;
set(gcf, 'position', [x0, y0, width, height])

exportgraphics(gcf, 'D:\Srivatsan\HSA-gripper-files\Plot Images\MaxRotForce.png', 'Resolution', 300)

% Torque Plot

figure();

plot3(degHSA_s(92:end), dispHSA_s(92:end), tauHSA_s(92:end), 'x-', 'DisplayName', 'Short HSA', 'MarkerSize', 8, 'LineWidth', 1.5, 'Color', short_color, 'MarkerFaceColor', short_color)
hold on
plot3(degHSA_l(85:end), dispHSA_l(85:end), tauHSA_l(85:end), 's-', 'DisplayName', 'Long HSA', 'MarkerSize', 6, 'LineWidth', 1.5, 'Color', long_color, 'MarkerFaceColor', long_color) % , 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'k'
view(90, 0)

ylim([-1 max(dispHSA_l)+1])
ylabel('Extension [mm]');
title('Torque at Maximum HSA Rotation (120\circ)')
zlabel('Torque [Nmm]');
legend('location', 'northeast')
box on
grid on

set(gca, 'ClippingStyle', 'rectangle', 'fontName', font)

x0 = 700;
y0 = 500;
width = 460;
height = 220;
set(gcf, 'position', [x0, y0, width, height])

exportgraphics(gcf, 'D:\Srivatsan\HSA-gripper-files\Plot Images\MaxRotTau.png', 'Resolution', 330)