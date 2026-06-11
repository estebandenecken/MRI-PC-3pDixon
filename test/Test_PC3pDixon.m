% >--------------------------------------------------------------------------< %
% Water Fat and Velocity Phantom
% Esteban Denecken C.
% >--------------------------------------------------------------------------< %
clear; clc; close all;
addpath(genpath('../src'));
mkdir('../out/PH PC 3p-Dixon/Test');

% Phantom Data
dim = 256;
NSD = 0.075;

% Tests
RT = zeros(10,8);

for test = 1:8
    folder = "../out/PH PC 3p-Dixon/Test/PH Test "+ string(test) + "/";

    switch test
    case 1
        mpk = 1; ki = [0 2];
    case 2
        mpk = 1; ki = [1 2];
    case 3
        mpk = 1; ki = [2 2];
    case 4
        mpk = 1; ki = [3 2];
    case 5
        mpk = 0; ki = [0 2];
    case 6
        mpk = 0; ki = [1 2];
    case 7
        mpk = 0; ki = [2 2];
    case 8
        mpk = 0; ki = [3 2];
    end

    % TEs
    TE_PC_REF = 2.037;
    TE_DIXON_OIO = (2.3:2.31:7.0)';
    TE_DIXON_IOI = (4.6:2.31:9.3)';

    mkdir(folder+ 'MAT');
    mkdir(folder+ 'FIGURES');

    tn1 = TE_PC_REF*1e-3;
    tn2 = tn1;
    bip = 1;
    DCM = PCMEPhantom(tn1,tn2,bip,NSD,ki,dim,mpk);
    PC = phasecontrast(DCM.SIGNAL1,DCM.SIGNAL2,DCM.VENC);
    DCM.PHASE = PC.V;
    DCM.DESCRIPTION = 'IM_PC_REF';
    save(folder+ 'MAT/DCM_IM_PC_REF.mat','DCM');
    fprintf('Phantom: DCM_IM_PC_REF\n');
    disp(DCM);
    fprintf('\n');

    tn1 = TE_DIXON_IOI*1e-3;
    tn2 = tn1;
    bip = 1;
    DCM = PCMEPhantom(tn1,tn2,bip,NSD,ki,dim,mpk);
    DCM.DESCRIPTION = 'IM_PC_DIXON_IOI';
    save(folder+ 'MAT/DCM_IM_PC_DIXON_IOI.mat','DCM');
    fprintf('Phantom: DCM_IM_PC_DIXON_IOI\n');
    disp(DCM);
    fprintf('\n');

    bip = 0;
    DCM = PCMEPhantom(tn1,tn2,bip,NSD,ki,dim,mpk);
    DCM.DESCRIPTION = 'IM_DIXON_IOI';
    save(folder+ 'MAT/DCM_IM_DIXON_IOI.mat','DCM');
    fprintf('Phantom: DCM_IM_DIXON_IOI\n');
    disp(DCM);
    fprintf('\n');

    tn1 = TE_DIXON_OIO*1e-3;
    tn2 = tn1;
    bip = 1;
    DCM = PCMEPhantom(tn1,tn2,bip,NSD,ki,dim,mpk);
    DCM.DESCRIPTION = 'IM_PC_DIXON_OIO';
    save(folder+ 'MAT/DCM_IM_PC_DIXON_OIO.mat','DCM');
    fprintf('Phantom: DCM_IM_PC_DIXON_OIO\n');
    disp(DCM);
    fprintf('\n');

    bip = 0;
    DCM = PCMEPhantom(tn1,tn2,bip,NSD,ki,dim,mpk);
    DCM.DESCRIPTION = 'IM_DIXON_OIO';
    save(folder+ 'MAT/DCM_IM_DIXON_OIO.mat','DCM');
    fprintf('Phantom: DCM_IM_DIXON_OIO\n');
    disp(DCM);
    fprintf('\n');

    % >--------------------------------------------------------------------------< %
    % Ground Truth

    tn1 = 2.3e-3;
    tn2 = tn1;
    bip = 1;
    DCM = PCMEPhantom(tn1,tn2,bip,NSD,ki,dim,mpk);
    DCM.DESCRIPTION = 'GROUND_TRUTH';
    fprintf('Phantom: DCM GROUND TRUTH\n');
    disp(DCM);
    fprintf('\n');

    WFV.Mw = DCM.WFV.Water.Density;
    WFV.Mf = DCM.WFV.Fat.Density;
    WFV.PDWF = abs(WFV.Mw)./(abs(WFV.Mw) + abs(WFV.Mf));
    WFV.PDFF = abs(WFV.Mf)./(abs(WFV.Mw) + abs(WFV.Mf));
    WFV.PDWF(isnan(WFV.PDWF)) = 0;
    WFV.PDFF(isnan(WFV.PDFF)) = 0;
    WFV.VEL = DCM.WFV.Water.VelField;
    WFV.Phi = DCM.WFV.FieldMap;
    WFV.T2 = DCM.WFV.T2;
    save(folder+ 'MAT/WFV_GROUND_TRUTH.mat','WFV');

    %

    % >--------------------------------------------------------------------------< %

    % Water-Fat Separation
    WFS_PH_PC_DIXON_IOI('IM_PC_DIXON_IOI',folder);
    WFS_PH_DIXON_IOI('IM_DIXON_IOI',folder);
    WFS_PH_PC_DIXON_OIO('IM_PC_DIXON_OIO',folder);
    WFS_PH_DIXON_OIO('IM_DIXON_OIO',folder);

    % Velocity estimation
    VEL_PH_PC_REF('IM_PC_REF',folder);
    VEL_PH_PC_WATER('IM_PC_DIXON_IOI',folder);
    VEL_PH_PC_WATER('IM_PC_DIXON_OIO',folder);


    % >--------------------------------------------------------------------------< %
    % Statistics ROI

    Ms = maskOO(dim);
    Frw = [1 0.915 0.832 0.749 0.666 0.583 0.5 0.417 0.334 0.251 0.168 0.085 0 1 1 1 1]' +1e-8;
    Frf = [0 0.085 0.168 0.251 0.334 0.417 0.5 0.583 0.666 0.749 0.832 0.915 1 0 0 0 0]' -1e-8;
    T2 = [200 183.85 168.08 152.31 136.54 120.77 105 89.23 73.46 57.69 41.92 26.15 10 200 200 200 25]';
    Vel = [0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0.5 0]' .* 80;
    zz = zeros(17,1);
    Fr_w = mergemask(Ms,Frw); Fr_f = mergemask(Ms,Frf);
    PDWF = Fr_w./(Fr_w + Fr_f); PDFF = Fr_f./(Fr_w + Fr_f);

    load(folder+ 'MAT/WFS_IM_PC_DIXON_IOI.mat');
    load(folder+ 'MAT/VEL_IM_PC_DIXON_IOI.mat');
    mw1 = statisticsrois(WFS.MMw,Ms);  mf1 = statisticsrois(WFS.MMf,Ms);
    fw1 = statisticsrois(WFS.PDWF,Ms); ff1 = statisticsrois(WFS.PDFF,Ms);
    bb1 = statisticsrois(WFS.Phi,Ms);  vv1 = statisticsrois(VEL,Ms);
    load(folder+ 'MAT/WFS_IM_DIXON_IOI.mat');
    mw2 = statisticsrois(WFS.MMw,Ms);  mf2 = statisticsrois(WFS.MMf,Ms);
    fw2 = statisticsrois(WFS.PDWF,Ms); ff2 = statisticsrois(WFS.PDFF,Ms);
    bb2 = statisticsrois(WFS.Phi,Ms);  vv2 = statisticsrois(zeros(dim),Ms);
    load(folder+ 'MAT/WFS_IM_PC_DIXON_OIO.mat');
    load(folder+ 'MAT/VEL_IM_PC_DIXON_OIO.mat');
    mw3 = statisticsrois(WFS.MMw,Ms);  mf3 = statisticsrois(WFS.MMf,Ms);
    fw3 = statisticsrois(WFS.PDWF,Ms); ff3 = statisticsrois(WFS.PDFF,Ms);
    bb3 = statisticsrois(WFS.Phi,Ms);  vv3 = statisticsrois(VEL,Ms);
    load(folder+ 'MAT/WFS_IM_DIXON_OIO.mat');
    mw4 = statisticsrois(WFS.MMw,Ms);  mf4 = statisticsrois(WFS.MMf,Ms);
    fw4 = statisticsrois(WFS.PDWF,Ms); ff4 = statisticsrois(WFS.PDFF,Ms);
    bb4 = statisticsrois(WFS.Phi,Ms);  vv4 = statisticsrois(zeros(dim),Ms);
    load(folder+ 'MAT/VEL_IM_PC_REF.mat');
    mw5 = statisticsrois(zeros(dim),Ms); mf5 = statisticsrois(zeros(dim),Ms);
    fw5 = statisticsrois(zeros(dim),Ms); ff5 = statisticsrois(zeros(dim),Ms);
    bb5 = statisticsrois(zeros(dim),Ms); vv5 = statisticsrois(VEL,Ms);

    xx = zeros(17,3);
    xx(:,1) = round(Frw,3); xx(:,2) = round(Frf,3); xx(:,3) = Vel;

    L = ["Water"; "Fat"; "Velocity"; "PC DIXON IOI"; "DIXON IOI";
        "PC DIXON OIO"; "DIXON OIO"; "PC REF"];

    mw_Avg = xx; mf_Avg = xx; fw_Avg = xx; ff_Avg = xx;
    mw_Med = xx; mf_Med = xx; fw_Med = xx; ff_Med = xx;
    mw_Std = xx; mf_Std = xx; fw_Std = xx; ff_Std = xx;
    mw_Max = xx; mf_Max = xx; fw_Max = xx; ff_Max = xx;
    mw_Min = xx; mf_Min = xx; fw_Min = xx; ff_Min = xx;

    bb_Avg = xx; vv_Avg = xx;
    bb_Med = xx; vv_Med = xx;
    bb_Std = xx; vv_Std = xx;
    bb_Max = xx; vv_Max = xx;
    bb_Min = xx; vv_Min = xx;

    for i = 1:5
        mw = eval('mw'+string(i));     mf = eval('mf'+string(i));
        mw_Avg = cat(2,mw_Avg,mw.Avg); mf_Avg = cat(2,mf_Avg,mf.Avg);
        mw_Med = cat(2,mw_Med,mw.Med); mf_Med = cat(2,mf_Med,mf.Med);
        mw_Std = cat(2,mw_Std,mw.Std); mf_Std = cat(2,mf_Std,mf.Std);
        mw_Max = cat(2,mw_Max,mw.Max); mf_Max = cat(2,mf_Max,mf.Max);
        mw_Min = cat(2,mw_Min,mw.Min); mf_Min = cat(2,mf_Min,mf.Min);

        fw = eval('fw'+string(i));     ff = eval('ff'+string(i));
        fw_Avg = cat(2,fw_Avg,fw.Avg); ff_Avg = cat(2,ff_Avg,ff.Avg);
        fw_Med = cat(2,fw_Med,fw.Med); ff_Med = cat(2,ff_Med,ff.Med);
        fw_Std = cat(2,fw_Std,fw.Std); ff_Std = cat(2,ff_Std,ff.Std);
        fw_Max = cat(2,fw_Max,fw.Max); ff_Max = cat(2,ff_Max,ff.Max);
        fw_Min = cat(2,fw_Min,fw.Min); ff_Min = cat(2,ff_Min,ff.Min);
        
        bb = eval('bb'+string(i));     vv = eval('vv'+string(i));
        bb_Avg = cat(2,bb_Avg,bb.Avg); vv_Avg = cat(2,vv_Avg,vv.Avg);
        bb_Med = cat(2,bb_Med,bb.Med); vv_Med = cat(2,vv_Med,vv.Med);
        bb_Std = cat(2,bb_Std,bb.Std); vv_Std = cat(2,vv_Std,vv.Std);
        bb_Max = cat(2,bb_Max,bb.Max); vv_Max = cat(2,vv_Max,vv.Max);
        bb_Min = cat(2,bb_Min,bb.Min); vv_Min = cat(2,vv_Min,vv.Min);
    end

    MwQ.Avg = mw_Avg(1:13,:); MfQ.Avg = mf_Avg(1:13,:);
    MwQ.Med = mw_Med(1:13,:); MfQ.Med = mf_Med(1:13,:);
    MwQ.Std = mw_Std(1:13,:); MfQ.Std = mf_Std(1:13,:);
    MwQ.Max = mw_Max(1:13,:); MfQ.Max = mf_Max(1:13,:);
    MwQ.Min = mw_Min(1:13,:); MfQ.Min = mf_Min(1:13,:);

    PDWFQ.Avg = fw_Avg(1:13,:); PDFFQ.Avg = ff_Avg(1:13,:);
    PDWFQ.Med = fw_Med(1:13,:); PDFFQ.Med = ff_Med(1:13,:);
    PDWFQ.Std = fw_Std(1:13,:); PDFFQ.Std = ff_Std(1:13,:);
    PDWFQ.Max = fw_Max(1:13,:); PDFFQ.Max = ff_Max(1:13,:);
    PDWFQ.Min = fw_Min(1:13,:); PDFFQ.Min = ff_Min(1:13,:);

    DB0Q.Avg = bb_Avg(1:13,:); VelQ.Avg = vv_Avg(14:16,:);
    DB0Q.Med = bb_Med(1:13,:); VelQ.Med = vv_Med(14:16,:);
    DB0Q.Std = bb_Std(1:13,:); VelQ.Std = vv_Std(14:16,:);
    DB0Q.Max = bb_Max(1:13,:); VelQ.Max = vv_Max(14:16,:);
    DB0Q.Min = bb_Min(1:13,:); VelQ.Min = vv_Min(14:16,:);

    fprintf('Water Quantification PH: \n'); disp(MwQ);
    fprintf('Fat Quantification PH: \n'); disp(MfQ);
    fprintf('Water Fraction Quantification PH: \n'); disp(PDWFQ);
    fprintf('Fat Fraction Quantification PH: \n'); disp(PDFFQ);
    fprintf('Velocity Quantification PH: \n'); disp(VelQ);
    fprintf('Field Map Quantification PH: \n'); disp(DB0Q);

    save(folder+ 'StatisticsROI_PH.mat','MwQ','MfQ','PDWFQ','PDFFQ','VelQ','DB0Q','L');

    %

    % >--------------------------------------------------------------------------< %
    % Statistics PX

    Mwf = mergemask(Ms,[1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0]');
    Mvw = mergemask(Ms,[0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 0]');

    load(folder+ 'MAT/WFV_GROUND_TRUTH.mat');
    mw0 = WFV.Mw;   mf0 = WFV.Mf;
    fw0 = WFV.PDWF; ff0 = WFV.PDFF; vv0 = WFV.VEL;
    load(folder+ 'MAT/WFS_IM_PC_DIXON_IOI.mat');
    load(folder+ 'MAT/VEL_IM_PC_DIXON_IOI.mat');
    mw1 = WFS.MMw;  mf1 = WFS.MMf;
    fw1 = WFS.PDWF; ff1 = WFS.PDFF; vv1 = VEL;
    load(folder+ 'MAT/WFS_IM_DIXON_IOI.mat');
    mw2 = WFS.MMw;  mf2 = WFS.MMf;
    fw2 = WFS.PDWF; ff2 = WFS.PDFF;
    load(folder+ 'MAT/WFS_IM_PC_DIXON_OIO.mat');
    load(folder+ 'MAT/VEL_IM_PC_DIXON_OIO.mat');
    mw3 = WFS.MMw;  mf3 = WFS.MMf;
    fw3 = WFS.PDWF; ff3 = WFS.PDFF; vv3 = VEL;
    load(folder+ 'MAT/WFS_IM_DIXON_OIO.mat');
    mw4 = WFS.MMw;  mf4 = WFS.MMf;
    fw4 = WFS.PDWF; ff4 = WFS.PDFF;
    load(folder+ 'MAT/VEL_IM_PC_REF.mat');
    mw5 = zeros(dim); mf5 = zeros(dim);
    fw5 = zeros(dim); ff5 = zeros(dim); vv5 = VEL;

    STmwp = statisticsroipx(mw1,mw0,Mwf); STmfp = statisticsroipx(mf1,mf0,Mwf);
    STfwp = statisticsroipx(fw1,fw0,Mwf); STffp = statisticsroipx(ff1,ff0,Mwf);
    STvvp = statisticsroipx(vv1,vv0,Mvw);
    STmws = statisticsroipx(mw2,mw0,Mwf); STmfs = statisticsroipx(mf2,mf0,Mwf);
    STfws = statisticsroipx(fw2,fw0,Mwf); STffs = statisticsroipx(ff2,ff0,Mwf);
    STvvs = statisticsroipx(vv5,vv0,Mvw);
    save(folder+ 'StatisticsPX_PH_DXI0.mat','STmwp','STmfp','STfwp','STffp','STvvp',...
        'STmws','STmfs','STfws','STffs','STvvs');
    STmwp = statisticsroipx(mw3,mw0,Mwf); STmfp = statisticsroipx(mf3,mf0,Mwf);
    STfwp = statisticsroipx(fw3,fw0,Mwf); STffp = statisticsroipx(ff3,ff0,Mwf);
    STvvp = statisticsroipx(vv3,vv0,Mvw);
    STmws = statisticsroipx(mw4,mw0,Mwf); STmfs = statisticsroipx(mf4,mf0,Mwf);
    STfws = statisticsroipx(fw4,fw0,Mwf); STffs = statisticsroipx(ff4,ff0,Mwf);
    STvvs = statisticsroipx(vv5,vv0,Mvw);
    save(folder+ 'StatisticsPX_PH_DXO0.mat','STmwp','STmfp','STfwp','STffp','STvvp',...
        'STmws','STmfs','STfws','STffs','STvvs');

    STmw = statisticsroipx(mw1,mw2,Mwf); STmf = statisticsroipx(mf1,mf2,Mwf);
    STfw = statisticsroipx(fw1,fw2,Mwf); STff = statisticsroipx(ff1,ff2,Mwf);
    STvv = statisticsroipx(vv1,vv5,Mvw);
    save(folder+ 'StatisticsPX_PH_DXI.mat','STmw','STmf','STfw','STff','STvv');
    STmw = statisticsroipx(mw3,mw4,Mwf); STmf = statisticsroipx(mf3,mf4,Mwf);
    STfw = statisticsroipx(fw3,fw4,Mwf); STff = statisticsroipx(ff3,ff4,Mwf);
    STvv = statisticsroipx(vv3,vv5,Mvw);
    save(folder+ 'StatisticsPX_PH_DXO.mat','STmw','STmf','STfw','STff','STvv');

    % >--------------------------------------------------------------------------< %
    % Fat Fraction Plots

    load(folder + 'StatisticsROI_PH.mat');

    FF = [0 0.085 0.168 0.251 0.334 0.417 0.5 0.583 0.666 0.749 0.832 0.915 1]';
    VV = [80 80 40]';

    X1 = PDFFQ.Med(:,4); % PC DIXON IOI
    Y1 = PDFFQ.Med(:,5); % DIXON IOI
    X2 = PDFFQ.Med(:,6); % PC DIXON OIO
    Y2 = PDFFQ.Med(:,7); % DIXON OIO

    Z1 = VelQ.Avg(:,4); % PC DIXON IOI
    Z2 = VelQ.Avg(:,6); % PC DIXON OIO
    Z3 = VelQ.Avg(:,8); % PC REF

    % Error Percentage
    fprintf('PDFF\n');
    fprintf('PC DIXON IOI');
    disp(100*mean(abs(FF-X1)));
    fprintf('DIXON IOI');
    disp(100*mean(abs(FF-Y1)));
    fprintf('PC DIXON OIO');
    disp(100*mean(abs(FF-X2)));
    fprintf('DIXON OIO');
    disp(100*mean(abs(FF-Y2)));
    fprintf('\n');

    fprintf('Velocity\n');
    fprintf('PC DIXON IOI');
    disp(100*mean(abs(VV-Z1)./VV));
    fprintf('PC DIXON OIO');
    disp(100*mean(abs(VV-Z2)./VV));
    fprintf('PC REF');
    disp(100*mean(abs(VV-Z3)./VV));

    % Plots

    fig = figure('Position',[300 300 750 600]);
    hold on;
    plot(FF, abs(FF-X1),'or','MarkerSize',8,'MarkerFaceColor','r');
    plot(FF, abs(FF-Y1),'ob','MarkerSize',8,'MarkerFaceColor','b');
    title('Fat Fraction Error','FontSize',30);
    legend('PC 3p-Dixon IP-OP-IP','3p-Dixon IP-OP-IP','FontSize',20,'Location','northwest');
    xlabel('Fat Fraction','FontSize',24,'FontWeight','bold');
    ylabel('Error','FontSize',24,'FontWeight','bold');
    ax = gca;
    ax.XAxis.FontSize = 20;
    ax.YAxis.FontSize = 20;
    ax.XAxis.LineWidth = 2; ax.XAxis.FontWeight = 'bold';
    ax.YAxis.LineWidth = 2; ax.YAxis.FontWeight = 'bold';
    xlim([-0.02 1.02]);
    ylim([0 0.25]);
    hold off;
    exportgraphics(fig,strcat(folder + 'FIGURES/FatFractionError_IOI_'+string(test)+ '.tiff'),'Resolution',300);

    fig = figure('Position',[300 300 750 600]);
    hold on;
    plot(FF, abs(FF-X2),'or','MarkerSize',8,'MarkerFaceColor','r');
    plot(FF, abs(FF-Y2),'ob','MarkerSize',8,'MarkerFaceColor','b');
    title('Fat Fraction Error','FontSize',30);
    legend('PC 3p-Dixon OP-IP-OP','3p-Dixon OP-IP-OP','FontSize',20,'Location','northwest');
    xlabel('Fat Fraction','FontSize',24,'FontWeight','bold');
    ylabel('Error','FontSize',24,'FontWeight','bold');
    ax = gca;
    ax.XAxis.FontSize = 20;
    ax.YAxis.FontSize = 20;
    ax.XAxis.LineWidth = 2; ax.XAxis.FontWeight = 'bold';
    ax.YAxis.LineWidth = 2; ax.YAxis.FontWeight = 'bold';
    xlim([-0.02 1.02]);
    ylim([0 0.25]);
    hold off;
    exportgraphics(fig,strcat(folder + 'FIGURES/FatFractionError_OIO_'+string(test)+ '.tiff'),'Resolution',300);
    
    fig = figure('Position',[300 300 750 600]);
    hold on;
    plot(FF, abs(FF-X1),'or','MarkerSize',8,'MarkerFaceColor','r');
    plot(FF, abs(FF-Y1),'ob','MarkerSize',8,'MarkerFaceColor','b');
    xlabel('Fat Fraction','FontSize',24,'FontWeight','bold');
    ylabel('Error','FontSize',24,'FontWeight','bold');
    ax = gca;
    ax.XAxis.FontSize = 20;
    ax.YAxis.FontSize = 20;
    ax.XAxis.LineWidth = 2; ax.XAxis.FontWeight = 'bold';
    ax.YAxis.LineWidth = 2; ax.YAxis.FontWeight = 'bold';
    xlim([-0.02 1.02]);
    ylim([0 0.25]);
    hold off;
    exportgraphics(fig,strcat('../out/PH PC 3p-Dixon/Test/FatFractionError_IOI_'+string(test)+ '.tiff'),'Resolution',300);

    fig = figure('Position',[300 300 750 600]);
    hold on;
    plot(FF, abs(FF-X2),'or','MarkerSize',8,'MarkerFaceColor','r');
    plot(FF, abs(FF-Y2),'ob','MarkerSize',8,'MarkerFaceColor','b');
    xlabel('Fat Fraction','FontSize',24,'FontWeight','bold');
    ylabel('Error','FontSize',24,'FontWeight','bold');
    ax = gca;
    ax.XAxis.FontSize = 20;
    ax.YAxis.FontSize = 20;
    ax.XAxis.LineWidth = 2; ax.XAxis.FontWeight = 'bold';
    ax.YAxis.LineWidth = 2; ax.YAxis.FontWeight = 'bold';
    xlim([-0.02 1.02]);
    ylim([0 0.25]);
    hold off;
    exportgraphics(fig,strcat('../out/PH PC 3p-Dixon/Test/FatFractionError_OIO_'+string(test)+ '.tiff'),'Resolution',300);


    % Test Results
    RT(1,test) = mpk;
    RT(2,test) = ki(1);
    RT(3,test) = ki(2);
    RT(4,test) = 100*mean(abs(FF-X1));
    RT(5,test) = 100*mean(abs(FF-Y1));
    RT(6,test) = 100*mean(abs(FF-X2));
    RT(7,test) = 100*mean(abs(FF-Y2));
    RT(8,test) = 100*mean(abs(VV-Z1)./VV);
    RT(9,test) = 100*mean(abs(VV-Z2)./VV);
    RT(10,test) = 100*mean(abs(VV-Z3)./VV);
end
save('../out/PH PC 3p-Dixon/Test/RT.mat','RT');

% >--------------------------------------------------------------------------< %