close all
clc

%{
    Grip force test: Tests the normal force produced during HSA gripper grasping, using a 3D-printed test cylinder

    Antipodal Grasping: Using opposing forces to grasp the cylinder (opposite points on the surface of the test cylinder)
%}

imported_data = {'GripforceTestSample_4-NoEcoflexLayer.csv', 'GripforceTestSample_8-PinchGrasp2.csv', 'GripforceTestSample_7-CagingGrasp2'};
legend_labels = {'Pinch Grasp: No Ecoflex', 'Pinch Grasp', 'Caging Grasp'};


figure()

% plot zero line
x = 0:99;
y = zeros(100);
plot(x, y, 'k--', 'LineWidth', 0.3, 'HandleVisibility', 'off')
hold on

ticklabels = {'10', '20', '30', '40', '50', '60', '70', '80', '90', '100'};
tl = linspace(10, 100, 10);

for i = 1:3
    %{
        Reads and plots force and extension data from Instron's raw data (.csv)
    %}
    data = readtable(imported_data{i}, "VariableNamingRule", "preserve");
    e_data = data.('Displacement'); % extension in mm
    f_data = data.('Force'); % force in N

    plot(e_data, f_data, '-', 'LineWidth', 1.5, 'DisplayName', legend_labels{i})
    hold on
end

title({"Grip Force Test";'HSA Rotation = 90\circ'})
xlabel('Extension [mm]')
ylabel('Force [N]')
xlim([0 100])
ylim([-6 12])

xticks(tl)
xticklabels(ticklabels)

grid on
legend('Location', 'southwest')


% figure size

x0 = 900;
y0 = 410;
width = 450;
height = 400;
set(gcf, 'position', [x0, y0, width, height])
exportgraphics(gcf, 'D:\Srivatsan\HSA-gripper-files\Plot Images\GripForce.png', 'Resolution', 800)