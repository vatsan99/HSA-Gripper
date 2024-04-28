close all
clc

%{
    Grip force test: Tests the normal force produced during HSA gripper grasping, using a 3D-printed test cylinder

    Antipodal Grasping: Using opposing forces to grasp the cylinder (opposite points on the surface of the test cylinder)
%}

% imported_data = {'GripforceTestSample_4-NoEcoflexLayer.csv', 'GripforceTestSample_8-PinchGrasp2.csv', 'GripforceTestSample_7-CagingGrasp2'};
% legend_labels = {'Pinch Grasp: No Ecoflex', 'Pinch Grasp', 'Caging Grasp'};

imported_data = {'Grip Force Test (Apr 28)/GripforceTestSample-90degPinch.csv'
                'Grip Force Test (Apr 28)/GripforceTestSample-120degPinch.csv'
                'Grip Force Test (Apr 28)/GripforceTestSample-90degCaging.csv'
                'Grip Force Test (Apr 28)/GripforceTestSample-120Caging.csv'};
legend_labels = {'Pinch Grasp (90\circ)', 'Pinch Grasp (120\circ)', 'Caging Grasp (90\circ)', 'Caging Grasp (120\circ)'};

figure()

% plot zero line
x = 0:99;
y = zeros(100);
% plot(x, y, 'k--', 'LineWidth', 0.5, 'HandleVisibility', 'off')
% hold on

tl = 0:5:100;
ticklabels = cellstr(num2str(tl'));

for i = 1:4
    %{
        Reads and plots force and extension data from Instron's raw data (.csv)
    %}
    data = readtable(imported_data{i}, "VariableNamingRule", "preserve");
    e_data = data.('Displacement'); % extension in mm
    f_data = data.('Force'); % force in N

    plot(e_data, f_data, '-', 'LineWidth', 1.5, 'DisplayName', legend_labels{i})
    hold on

    fprintf('Maximum Force [in N] = %f\n', max(f_data))
end

title({"Grip Force Test";'For HSA Rotation of 90\circ and 120\circ'})
xlabel('Extension [mm]')
ylabel('Normal Force, F_g [N]')
xlim([0 50]) % extension scale
ylim([0 13]) % force scale

xticks(tl)
xticklabels(ticklabels)

grid on
legend('Location', 'south')


% figure size

x0 = 900;
y0 = 410;
width = 450;
height = 400;
set(gcf, 'position', [x0, y0, width, height])
exportgraphics(gcf, 'D:\Srivatsan\HSA-gripper-files\Plot Images\GripForce.png', 'Resolution', 800)