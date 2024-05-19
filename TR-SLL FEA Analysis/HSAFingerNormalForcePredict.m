clear all %#ok
close all
%% FEA DATA
dataFEA = readtable('FEA Data - 0.8mm;25mm.xlsx');

Colors = ['r'; 'k'];
ticklabels = string(0:10:80);
tl = 0:10:80;

t_n = table2array(dataFEA(:, 2)); % number of triangles
% angRot4 = table2array(dataFEA(:,10)); % angular twist in Rad for 0.4mm thick base
angRot8 = table2array(dataFEA(:,7)); % angular twist in Rad for 0.8mm thick base, 25 mm width
torApp = 5; %in Nmm
kappaRatio = 1.3./4.1; %G, in GPA. Taken from Engineering Toolbox and https://doi.org/10.1007/s11837-015-1367-y
% kappa4 = kappaRatio.* torApp ./angRot4; %in Nmm/Rad
kappa8 = kappaRatio.* torApp ./angRot8; %in Nmm/Rad

%Self Check Plot
% plot(t_n,kappa4,'ro','MarkerSize', 3,'LineWidth', 1.5, "MarkerFaceColor", 'r', 'DisplayName', '0.4 mm Base') % (0.01)./
% hold on
plot(t_n, kappa8,'ko','MarkerSize', 3,'LineWidth', 1.5, "MarkerFaceColor", 'k', 'DisplayName', '0.8 mm Base, 25 mm Wide') % (0.01)./
legend('Location', 'southeast')
xlabel('Number of Triangles [-]')
ylabel('Torsional Stiffness [Nmm/rad]')
title('Torsional Stiffness FEA Sweep')
box on

%% Calc Payload
theta = linspace(0, 8, 2); %degrees. Angle when object slips.
r = 3.2; %mm. Dist to Neutral Axis from contact surface. 2.8mm to COG of just triangles, 0.4mm for silicone layer
rHSA = 31; %mm. Dist to Neutral Axis from HSA Cent. From CAD
x = r * deg2rad(theta); %mm
tau_const = 1.74; %Nmm per degree. Calc in CalcTauHSA.m
phiMax = 90; %degrees
legends = strings(1, length(x));
fg = zeros(length(x), length(t_n));
figure()
hold on
for i = 1:length(x)
    fg(i,:) = slip_force(kappa8, r,rHSA, x(i), tau_const, phiMax);
    plot(t_n, fg(i,:), '-', 'LineWidth', 2, 'Color', Colors(i))
    legends(i) = "Allowable Twist: "+ num2str(theta(i))+ '°';
end
xlabel('Number of Triangles [-]')
ylabel('Slip Force [N]')
ylim([0 20])
xlim([0 80])
legend(legends)
xticks(tl)
xticklabels(ticklabels)
title({'Predicted Slip Force of Object'; ['HSA Rotation = ', num2str(phiMax), '°']})
box on

% figure size

x0 = 900;
y0 = 410;
width = 410;
height = 200;
set(gcf, 'position', [x0, y0, width, height])
exportgraphics(gcf, 'D:\Srivatsan\HSA-gripper-files\Plot Images\SlipForce-Plot.png', 'Resolution', 500)


function [fg] = slip_force(kappa, r,rHSA, x, tau_const, phi)
    % Calculate the slip force when an object will fall from the grasp.
    % inputs:
    %   kappa: the coefficient of torsional stiffness of the SLL
    %   r: distance to the neutral axis
    %   x: the displacement of the object
    %   tau_const: the coefficient of the HSA
    %   phi: the angle of the HSA
    % output:
    %   fg = slip force
    fg = kappa ./ r.^2 .* x + tau_const./rHSA .* phi;
end