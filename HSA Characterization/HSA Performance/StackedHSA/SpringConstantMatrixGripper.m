clear all %#ok
close all;
clc;
%{
Calcualte the spring constant for an HSA at different extentsions and
rotations

inputs: instron test data from XXXX method

Outputs: a single matrix of values representing the spring constants for
each stepped distance and angle of rotation. 
%}

%% User Inputs
saveData = true; %true to save, false to not save spring constant and potential energy fields
verbosePlots = false; %true to display additional plots when running the code
dispStart = 0; %in mm
dispDelta = 5; %in mm
dispEnd = 30; %in mm
thetaStart = 0; %in deg
thetaDelta = 10; %in deg
thetaEnd = 120; %in deg
testRepeat = 1; %ten times through range
extensionTol = 0.1+0.1*dispEnd; %in mm, tolerance for Disp Over/Undershoot
thetaTol = 3+0.1*thetaEnd; %in deg, tolerance for Rotation motor Over/undershoot
indexStep = 26; %Number of datapoints to use in calcs for fit.

dispSteps = dispStart:dispDelta:dispEnd;
rotSteps = thetaStart:thetaDelta:thetaEnd;

 %% Load Data and plot
Data = readtable('HSAGripper-TestSet2-7Apr-DoubleHSA.csv');
readRange = height(Data);
time = table2array(Data(1:readRange,1));
disp = table2array(Data(1:readRange,2));
force = table2array(Data(1:readRange,3));
theta = -table2array(Data(1:readRange,4));
torque = table2array(Data(1:readRange,5));

if verbosePlots == true
    figure()
    hold on
    subplot(1,3,1)
    plot(disp,force,'r.')
    title ('force displacement curve for all data')
    subplot(1,3,2)
    plot(time,force,'r.')
    title ('force time curve for all data')
    subplot(1,3,3)
    plot(time,disp,'r.')
    title ('time displacement curve for all data')
end

 %% Build Index For Where Jumps Happen

TestStart = ~[0;abs(diff(disp)) < 0.1]; %zero to get the first dataset
indexTestStart = (find(TestStart)); %ensure data is an int

indexTestStart(disp(indexTestStart) >=dispEnd+extensionTol) = []; %remove displacement values above max height
indexTestStart(disp(indexTestStart) <dispStart-extensionTol) = []; %remove displacement values below min displacement
indexTestStart(theta(indexTestStart) >=thetaEnd+thetaTol) = []; %remove theta values above the cutoff. Add one for system error
indexTestStart(theta(indexTestStart) <thetaStart-thetaTol) = [];%remove theta values below the cutoff. Remove one for system error
% indexTestStart(disp(indexTestStart+indexStep) - disp(indexTestStart) <=.5) = [];
% indexTestStart(diff(indexTestStart)<=700) = []; % removes tests too close together
% indexTestStart = indexTestStart+1; % move the offset to the start of the test

 % minor validation check
totalTestsMax = length(dispSteps)*length(rotSteps)*testRepeat; %Testing ceiling
if length(indexTestStart)<=totalTestsMax
    fprintf('\n Number of tests is less than or equal to the maximum possible \n\n')
else
    fprintf('\n\n Caution: validation failed. Reported tests longer than possible test combinations \n\n')
end

%% calculate best fit lines for each test
indexTestEnd = indexTestStart+indexStep;
indMat = int32(vec_linspace(indexTestStart,indexTestEnd,indexStep+1));

%for testing
dispdiff =  disp(indMat(:,end)) - disp(indMat(:,1));

pCoeff = zeros(length(indMat),2);
pCoeffT = zeros(length(indMat),2);
forceFit = zeros(length(indMat),indexStep+1);
torqueFit = zeros(length(indMat),indexStep+1);
for iter = 1:length(indMat)-1 %for each grouping, calc the best fit line
    pCoeff(iter+1,:) = polyfit(disp(indMat(iter+1,:)),force(indMat(iter+1,:)),1);
    forceFit(iter+1,:) = polyval(pCoeff(iter+1,:),disp(indMat(iter+1,:)));
    pCoeffT(iter+1,:) = polyfit(disp(indMat(iter+1,:)),torque(indMat(iter+1,:)),1);
    torqueFit(iter+1,:) = polyval(pCoeffT(iter+1,:),disp(indMat(iter+1,:)));
end
fMean = mean(forceFit,2);
kFit = (forceFit(:,end) - forceFit(:,1)) ./ (disp(indMat(:,end)) - disp(indMat(:,1)));
kRaw = (force(indMat(:,end)) - force(indMat(:,1))) ./ (disp(indMat(:,end)) - disp(indMat(:,1)));
tauMean =mean(torqueFit,2);
if verbosePlots == true
    % Plot a fitline versus raw data for validation 
    figure()
    hold on
    plot(disp(indMat(3,:)),forceFit(3,:),LineWidth=3)
    plot(disp(indMat(3,:)),force(indMat(3,:)),LineWidth=3)
    legend ('fit line - 10mm,0deg','raw data- 10mm,0deg')
    title ('force displacement data [mN vs mm]')
    figure()
    hold on
    plot(disp(indMat(end-8,:)),forceFit(end-8,:),LineWidth=3)
    plot(disp(indMat(end-8,:)),force(indMat(end-8,:)),LineWidth=3)
    legend ('fit line -8th to last','raw data -8th to last')
    title ('force displacement data [mN vs mm]')
end
 %% Plot the spring constants versus rotation vs extension
if verbosePlots == true
    dotSize = 12;
    figure()
    hold on
    title ('Fitted Spring Constant as a Function of Rotation and Displacement','FontSize', 18)
    ylabel('degrees of rotation [deg]','FontSize', 14); xlabel('extension from rest [mm]','FontSize', 14); zlabel('spring constant [N/m]','FontSize', 14);
    scatter3(disp(indMat(:,1)),theta(indMat(:,1)),kFit,dotSize,kFit,'filled')
    view(130,-35)
    colorbar

    figure()
    hold on
    title ('Raw Spring Constant as a Function of Rotation and Displacement','FontSize', 18)
    ylabel('degrees of rotation [deg]','FontSize', 14); xlabel('extension from rest [mm]','FontSize', 14); zlabel('spring constant [N/m]','FontSize', 14);
    scatter3(disp(indMat(:,1)),theta(indMat(:,1)),kRaw,dotSize,kFit,'filled')
    view(130,-35)
    colorbar
end
 %% Plot the Potential Energy versus rotation vs extension
dispM = disp(indMat(:,1))./1000; %convert mm to m
potEngK = 0.5*kFit.*dispM.^2; %PE = 0.5*Kx^2

if verbosePlots == true
     %Spring
    figure()
    hold on
    title ('Fitted Spring Potential Energy as a Function of Rotation and Displacement','FontSize', 18)
    %xlabel('degrees of rotation [deg]','FontSize', 14); ylabel('extension from rest [mm]','FontSize', 14); zlabel('Potential Energy[J]','FontSize', 14);
    %scatter3(theta(indMat(:,1)),disp(indMat(:,1)),potEngK,dotSize,potEngK,'filled')
    ylabel('degrees of rotation [deg]','FontSize', 14); xlabel('extension from rest [mm]','FontSize', 14); zlabel('Potential Energy[J]','FontSize', 14);
    scatter3(disp(indMat(:,1)),theta(indMat(:,1)),potEngK,dotSize,potEngK,'filled')
    view(130,-35)
    colorbar

    figure()
    hold on
    title ('Fitted Spring Potential Energy','FontSize', 18)
    ylabel('degrees of rotation [deg]','FontSize', 14); xlabel('extension from rest [mm]','FontSize', 14); zlabel('Potential Energy[J]','FontSize', 14);
    scatter3(disp(indMat(:,1)),theta(indMat(:,1)),potEngK,dotSize,potEngK,'filled')
    view(130,-35)
    set(gca,'XLim',[0 80],'YLim',[0 270],'ZLim',[0 80])
    colorbar

    figure()
    hold on
    title ('Gamut Sampling Vs Goal','FontSize', 18)
    xlabel('degrees of rotation [deg]','FontSize', 14); ylabel('extension from rest [mm]','FontSize', 14);
    scatter(theta(indMat(:,1)),disp(indMat(:,1)),'filled')
    auxTrajX = linspace(thetaStart,thetaEnd,100);
    auxTrajY = 0.236.*auxTrajX;
    plot(auxTrajX,auxTrajY,LineWidth=3)
    legend('sample points','auxetic trajectory')


    % Mean Force Heatmap
    figure()
    hold on
    title ('Mean Force as a Function of Rotation and Displacement','FontSize', 18)
    ylabel('degrees of rotation [deg]','FontSize', 14); xlabel('extension from rest [mm]','FontSize', 14); zlabel('Mean Force [mN]','FontSize', 14);
    scatter3(disp(indMat(:,1)),theta(indMat(:,1)),fMean,dotSize,fMean,'filled')
    view(130,-35)
    colorbar

    % Mean Torque Heatmap
    figure()
    hold on
    title ('Mean Torque as a Function of Rotation and Displacement','FontSize', 18)
    ylabel('degrees of rotation [deg]','FontSize', 14); xlabel('extension from rest [mm]','FontSize', 14); zlabel('Mean Torque [Nmm]','FontSize', 14);
    scatter3(disp(indMat(:,1)),theta(indMat(:,1)),tauMean,dotSize,tauMean,'filled')
    view(130,-35)
    colorbar
end


 %force integral over disp and theta
% forceShaped = reshape(force(indMat(:,1))/1000,length(dispSteps),[]); %divide by 1000 to get N from mN
% potEngShaped = cumtrapz(dispSteps/1000,forceShaped,1); %divide by 1000 to get m from mm
% potEng = reshape(potEngShaped,1,[]);
% 
% 
% figure()
% hold on
% title ('Force Integral Potential Energy as a Function of Rotation and Displacement','FontSize', 18)
% xlabel('degrees of rotation [deg]','FontSize', 14); ylabel('extension from rest [mm]','FontSize', 14); zlabel('Potential Energy[J]','FontSize', 14);
% scatter3(theta(indMat(:,1)),disp(indMat(:,1)),potEng,dotSize,potEng,'filled')
% view(130,-35)
% colorbar

 %% Save Data
 if saveData == true
     saveVals = array2table([theta(indMat(:,1)),disp(indMat(:,1)),fMean*.001,kFit,kRaw,potEngK,tauMean]);
     saveVals.Properties.VariableNames(1:7) = {'rotation in degrees','displacement in mm','Force in Newtons','Fit spring constant in Newtons per Meter','Raw spring constant in Newtons per Meter','Spring Potential Energy in Joules','Fit Torque in Nmm'};
     writetable(saveVals,'HSA_GRIPPER_SpringConstantData_DoubleHSA.csv');

     testSavedData = readtable('HSA_GRIPPER_SpringConstantData_DoubleHSA.csv','PreserveVariableNames',true);
     fprintf('\n Data saved to file with name: \n HSA_GRIPPER_SpringConstantData_DoubleHSA.csv \n\n')

 end

 function y = vec_linspace(start, goal, steps)
    start = start';
    goal = goal';
    x = linspace(0,1,steps);
    % difference = (goal - start);
    % 
    % multip = difference'*x;
    % 
    % onesvec = ones(1, steps);
    % startvec = start' * onesvec;
    % 
    % y = startvec + multip;
    y = start' * ones(1, steps) + (goal - start)'*x;
 end
