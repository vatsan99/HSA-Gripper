close all
clc

%{
    Grip force test: Tests the normal force produced during HSA gripper grasping, using a 3D-printed test cylinder

    Antipodal Grasping: Using opposing forces to grasp the cylinder (opposite points on the surface of the test cylinder)
%}

figure()

gripForce_plot('GripperExtensionTest.csv') %! Replace with actual file name


% figure size

x0 = 900;
y0 = 410;
width = 700;
height = 400;
set(gcf, 'position', [x0, y0, width, height])
exportgraphics(gcf, 'D:\Srivatsan\HSA-gripper-files\Plot Images\GripForce.png', 'Resolution', 800)

function gripForce_plot(csv_file_path)
    data = readtable(csv_file_path, "VariableNamingRule", "preserve");
    e_data = data.('Displacement [mm]'); % extension in mm
    f_data = data.('Force [N]'); % force in N

    plot(e_data, f_data, '-', 'LineWidth', 2, 'DisplayName', 'Antipodal Grasp')
    title({"Grip Force Test";'HSA Rotation = 90\circ'})
    xlabel('Extension [mm]')
    ylabel('Force [N]')
    legend("Location", "northwest")
    axis tight
end