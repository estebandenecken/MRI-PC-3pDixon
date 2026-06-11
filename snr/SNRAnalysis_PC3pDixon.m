% >--------------------------------------------------------------------------< %
% SNR Analysis
% Esteban Denecken C.
% >--------------------------------------------------------------------------< %
% Run SNRs_PC3pDixon.m first
% >--------------------------------------------------------------------------< %
clear; clc; close all;
addpath(genpath('../src'));

mkdir('../out/PH PC 3p-Dixon/SNR/Plots');
NSDs = (0:0.0125:0.2375)';

XIP = zeros(20,1); MIP = zeros(20,13);
XIS = zeros(20,1); MIS = zeros(20,13);
XOP = zeros(20,1); MOP = zeros(20,13);
XOS = zeros(20,1); MOS = zeros(20,13);
for i = 1:20
    load('../out/PH PC 3p-Dixon/SNR/PH_SNR_'+string(i)+ '/StatisticsPX_PH_DXI0.mat');
    XIP(i) = STffp.MAE;
    XIS(i) = STffs.MAE;
    load('../out/PH PC 3p-Dixon/SNR/PH_SNR_'+string(i)+ '/StatisticsPX_PH_DXO0.mat');
    XOP(i) = STffp.MAE;
    XOS(i) = STffs.MAE;
    load('../out/PH PC 3p-Dixon/SNR/PH_SNR_'+string(i)+ '/StatisticsROI_PH.mat');
    MIP(i,:) = abs(PDFFQ.Med(:,4)' - PDFFQ.Med(:,2)');
    MIS(i,:) = abs(PDFFQ.Med(:,5)' - PDFFQ.Med(:,2)');
    MOP(i,:) = abs(PDFFQ.Med(:,6)' - PDFFQ.Med(:,2)');
    MOS(i,:) = abs(PDFFQ.Med(:,7)' - PDFFQ.Med(:,2)');
end

fig = figure('Position',[300 300 620 500]);
hold on
plot(NSDs,100*mean(MIP,2),'-r','LineWidth',3);
plot(NSDs,100*mean(MIS,2),'-b','LineWidth',3);
legend('PC 3p-Dixon IP-OP-IP','3p-Dixon IP-OP-IP','FontSize',20,'Location','southeast');
xlabel('SD of Gaussian Noise','FontSize',24,'FontWeight','bold');
ylabel('Percentage Error','FontSize',24,'FontWeight','bold');
ax = gca;
ax.XAxis.FontSize = 20;
ax.YAxis.FontSize = 20;
ax.XAxis.LineWidth = 2; ax.XAxis.FontWeight = 'bold';
ax.YAxis.LineWidth = 2; ax.YAxis.FontWeight = 'bold';
xlim([0 0.25]);
ylim([0 20]);
hold off;
exportgraphics(fig,strcat('../out/PH PC 3p-Dixon/SNR/Plots/ERROR_IOI.pdf'),'Resolution',300);

fig = figure('Position',[300 300 620 500]);
hold on
plot(NSDs,100*mean(MOP,2),'-r','LineWidth',3);
plot(NSDs,100*mean(MOS,2),'-b','LineWidth',3);
legend('PC 3p-Dixon OP-IP-OP','3p-Dixon OP-IP-OP','FontSize',20,'Location','southeast');
xlabel('SD of Gaussian Noise','FontSize',24,'FontWeight','bold');
ylabel('Percentage Error','FontSize',24,'FontWeight','bold');
ax = gca;
ax.XAxis.FontSize = 20;
ax.YAxis.FontSize = 20;
ax.XAxis.LineWidth = 2; ax.XAxis.FontWeight = 'bold';
ax.YAxis.LineWidth = 2; ax.YAxis.FontWeight = 'bold';
xlim([0 0.25]);
ylim([0 20]);
hold off;
exportgraphics(fig,strcat('../out/PH PC 3p-Dixon/SNR/Plots/ERROR_OIO.pdf'),'Resolution',300);


% >--------------------------------------------------------------------------< %