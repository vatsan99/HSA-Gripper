clc 
close all

%{
    This script processes the data from a normal force test performed on the Instron testing apparatus

	Estimates force from torque data
%}

data = {'grippergapdata\grippergapdata_1.csv', 'grippergapdata\grippergapdata_2.csv', 'grippergapdata\grippergapdata_3.csv', 'grippergapdata\grippergapdata_4.csv', 'grippergapdata\grippergapdata_5.csv'};

gap = 52.25; % distance from the point of application of force to the axis

div = [1, 10, 20, 30, 40]; % distance from the object

for i = 1:5
    raw_data = readtable(data{i}, "VariableNamingRule", "preserve");
    time = raw_data.('Time');
    torque = raw_data.('Torque');

    [minValue, minIndex] = min(torque);
    tolerance = 0.005; % acceptable difference value

    % Find the index where the data starts to become steady
    steadyStartIndex = find(abs(diff(torque(minIndex:end))) < tolerance, 1, 'first') + minIndex;

    steady_torque_response = torque(steadyStartIndex:end);

    plot(time(steadyStartIndex:end), steady_torque_response, '.')
    hold on

    fprintf("Average Normal Force = %f\n", abs(mean((steady_torque_response)/gap))) % N-mm / mm
    

end

xlabel('Time [s]')
ylabel('Torque [Nmm]')