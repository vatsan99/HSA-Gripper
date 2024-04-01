data = readtable('.\0to35mm_0to130deg_NRGLandscape_1.csv');

extension = table2array(data(:, 2));
force = table2array(data(:, 3));
theta = table2array(data(:, 4));

figure()
scatter3(theta, extension, force)

% figure()
% plot(theta, force)