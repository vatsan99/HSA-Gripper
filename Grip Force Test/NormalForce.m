clc 
close all

data = {'grippergapdata\grippergapdata_1.csv', 'grippergapdata\grippergapdata_2.csv', 'grippergapdata\grippergapdata_3.csv', 'grippergapdata\grippergapdata_4.csv', 'grippergapdata\grippergapdata_5.csv'};

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
    
    % calculating force from torque response
    if i == 1
        fprintf("Average Normal Force = %f\n", mean(abs(steady_torque_response))/1) % N-mm / mm
    elseif i == 2
        fprintf("Average Normal Force = %f\n", mean(abs(steady_torque_response))/10)
    elseif i == 3
        fprintf("Average Normal Force = %f\n", mean(abs(steady_torque_response))/20)
    elseif i == 4
        fprintf("Average Normal Force = %f\n", mean(abs(steady_torque_response))/30)
    elseif i == 5
        fprintf("Average Normal Force = %f\n", mean(abs(steady_torque_response))/40)
    end
end