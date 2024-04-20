close all
clc

%{
    Grip force test: Tests the normal force produced during HSA gripper grasping, using a 3D-printed test cylinder

    Antipodal Grasping: Using opposing forces to grasp the cylinder (opposite points on the surface of the test cylinder)
%}

% data = readtable('GripperExtensionTest.csv');

e = data(:, 2); % extension in mm
F = data(:, 3); % force in N

figure()
plot(e, F, '-', 'LineWidth', 2, 'DisplayName', 'Antipodal Grasp', 'Color', [0 0.4470 0.7410])

title({"Grip Force Test";'HSA Rotation = 90\circ'})
xlabel('Extension [mm]')
ylabel('Force [N]')
legend("Location", "northwest")
axis tight




% figure size

x0 = 900;
y0 = 410;
width = 700;
height = 400;
set(gcf, 'position', [x0, y0, width, height])
exportgraphics(gcf, 'D:\Srivatsan\HSA-gripper-files\Plot Images\GripForce.png', 'Resolution', 800)