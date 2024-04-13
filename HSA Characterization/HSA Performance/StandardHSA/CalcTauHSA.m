clear all %#ok
close all
%% Goal: Generate Reasonable Bounds on the Value of C_Tau
%{
%}
%% INSTRON HSA DATA
 %load data
dataHSA = readtable('HSA_GRIPPER_SpringConstantData_StandardHSA');
degHSA = table2array(dataHSA(:,1));
dispHSA = table2array(dataHSA(:,2));
fHSA = table2array(dataHSA(:,3));
tauHSA = table2array(dataHSA(:,7));
 %plot force to find min energy length
fitF = fit([dispHSA,degHSA],fHSA,'poly33');
plot(fitF,[dispHSA,degHSA],fHSA)
title('Force Data and Surface')
xlabel('Displacement [mm]')
ylabel('Rotation [deg]')
zlabel('Force [N]')
%% FIND Min C_Tau
%calculate min. energy length
figure()
cValsF = coeffvalues(fitF);
fitEqF = @(x,y) cValsF(1) + cValsF(2).*x + cValsF(3).*y + cValsF(4).*x^2 + cValsF(5).*x.*y + cValsF(6).*y^2 + cValsF(7).*x^3 + cValsF(8).*x^2.*y + cValsF(9).*x.*y^2 + cValsF(10).*y^3;
fp = fimplicit(fitEqF,[0 30 0 120]);
title('Torque Data and Surface')
xlabel('Displacement [mm]')
ylabel('Rotation [deg]')
noFDisp = fliplr(fp.XData);
noFRot = fliplr(fp.YData);
 %find torque that corresponds to minF[x,y] pairs
fitTau = fit([dispHSA,degHSA],tauHSA,'poly33');
plot(fitTau,[dispHSA,degHSA],tauHSA)
title('Torue Along the Minimum Energy Path')
xlabel('Displacement [mm]')
ylabel('Rotation [deg]')
zlabel('Torque [Nmm]')
 %Use equation of surface to find torque vals corresponding to the minimum energy length
cValsT = coeffvalues(fitTau);
fitEqT = @(x,y) cValsT(1) + cValsT(2).*x + cValsT(3).*y + cValsT(4).*x.^2 + cValsT(5).*x.*y + cValsT(6).*y.^2 + cValsT(7).*x.^3 + cValsT(8).*x.^2.*y + cValsT(9).*x.*y.^2 + cValsT(10).*y.^3;
noFTau = fitEqT(noFDisp,noFRot);
 %plot zero force Torque values along the line
figure()
scatter3(noFDisp,noFRot,noFTau)
title('Torque Required Along the Minimum Energy Landscape')
xlabel('Displacement [mm]')
ylabel('Rotation [deg]')
zlabel('Torque [Nmm]')
 %calculate the all important C_tau_minimumEnergy
 minNRGIdx = find(noFRot >= min(degHSA(degHSA>0))); %find the smallest non-zero value from IRL data
c_tau_me = noFTau(minNRGIdx)./noFRot(minNRGIdx);
 %What all this boils down to:
disp(strcat('The average minimumNRG C_Tau is:',num2str(mean(c_tau_me)),'[Nmm/deg]'))

%% FIND BLOCKED C_TAU

indB = find(dispHSA < 1); %find blocked force data
torqueBlk = tauHSA(indB);
rotBlk = degHSA(indB);
c_tau_blk = torqueBlk ./ rotBlk;
disp(strcat('The average Blocked Force C_Tau is:',num2str(mean(torqueBlk(2:end)./rotBlk(2:end))),'[Nmm/deg]'))

%% Plot C_Tau
figure()
plot(noFRot(minNRGIdx),c_tau_me)
hold on 
plot(rotBlk(2:end),c_tau_blk(2:end)) %remove the (0,0) val since div0 error
title('C_Tau Values as a function of Rotation')
xlabel('Rotation [mm]')
ylabel('c_\tau [Nmm/deg]')
title('Torsional Stiffness Constant')
legend('Minimum Energy Length','Blocked Force Test')
ylim([0,4])
