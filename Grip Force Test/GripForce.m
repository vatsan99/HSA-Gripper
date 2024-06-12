close all
clc

imported_data = {'.\Updated Test - May 23\InstronTestData-23May_Pinch1.csv'
                '.\Updated Test - May 23\InstronTestData-23May_Pinch2.csv'
                '.\Updated Test - May 23\InstronTestData-23May_Caging1.csv'
                '.\Updated Test - May 23\InstronTestData-23May_Caging2.csv'};
legend_labels = {'Pinch Grasp 1', 'Pinch Grasp', 'Planar Caging Grasp', 'Planar Caging Grasp 2'};

figure()
hold on
tl = 0:1:100;
ticklabels = cellstr(num2str(tl'));
colors = [0 0.4470 0.7410;
        0.8500 0.3250 0.0980;
        0.9290 0.6940 0.1250;
        0.4660 0.6740 0.1880;
        ];

for i = 2:3
    %{
        Reads and plots force and extension data from Instron's raw data (.csv)
    %}
    data = readtable(imported_data{i}, "VariableNamingRule", "preserve");
    e_data = -data.('Displacement'); % extension in mm
    %e_data = -1* (e_data - e_data(1)*ones(length(e_data),1));
    f_data = -data.('Force')./1000; % force in N
    %f_data = f_data - 2*f_data(1)*ones(length(f_data),1); %correction for old dataset
    plot(e_data, f_data, '-', 'LineWidth', 2.5, 'DisplayName', legend_labels{i}, 'Color', colors(i, :))
    hold on
    fprintf('Maximum Force [in N] = %f\n', max(f_data))
end

title({"Grip Force Test";'For 120\circ HSA rotation'})
xlabel('Extension [mm]')
ylabel('Force, \it F_n \rm [N]')


box on
set(gca, 'ClippingStyle', 'rectangle', 'FontName', 'Times New Roman')

xlim([-0.02 10]) % extension scale
ylim([0 16]) % force scale
xticks(tl)
xticklabels(ticklabels)
% grid on
legend('Location', 'southeast', 'Box', 'off')


% figure size
x0 = 900;
y0 = 410;
width = 350;
height = 300;
set(gcf, 'position', [x0, y0, width, height])
exportgraphics(gcf, 'D:\Srivatsan\HSA-gripper-files\Plot Images\GripForce.png', 'Resolution', 330)