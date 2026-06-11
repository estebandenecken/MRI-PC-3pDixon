% >--------------------------------------------------------------------------< %
% Water Fat and Velocity Phantom
% Esteban Denecken C.
% >--------------------------------------------------------------------------< %
% Run after PC_3pDixon.m
% >--------------------------------------------------------------------------< %
clear; clc; close all;
addpath(genpath('../src'));

sfig = 2;

folder = "../out/PH PC 3p-Dixon/";
mkdir(folder+ 'MAT DIXON');
ffig = "../out/PH PC 3p-Dixon/FIGURES DIXON/";
mkdir(ffig);

load('../out/PH PC 3p-Dixon/MAT/WFV_GROUND_TRUTH.mat','WFV');
gtfig('GROUND TRUTH',WFV,ffig,sfig)

WFS = WFS_PH_PCDIXON('IM_PC_DIXON',folder,'two','IOI');
dixonfig('DX_IOI_two',WFS,ffig,sfig);
WFS = WFS_PH_PCDIXON('IM_PC_DIXON',folder,'two','OIO');
dixonfig('DX_OIO_two',WFS,ffig,sfig);

WFS = WFS_PH_PCDIXON('IM_PC_DIXON',folder,'three','IOI');
dixonfig('DX_IOI_three',WFS,ffig,sfig);
WFS = WFS_PH_PCDIXON('IM_PC_DIXON',folder,'three','OIO');
dixonfig('DX_OIO_three',WFS,ffig,sfig);

WFS = WFS_PH_PCDIXON('IM_PC_DIXON',folder,'pauly','IOI');
dixonfig('DX_IOI_pauly',WFS,ffig,sfig);
WFS = WFS_PH_PCDIXON('IM_PC_DIXON',folder,'pauly','OIO');
dixonfig('DX_OIO_pauly',WFS,ffig,sfig);

WFS = WFS_PH_PCDIXON('IM_PC_DIXON',folder,'haacke','IOI');
dixonfig('DX_IOI_haacke',WFS,ffig,sfig);
WFS = WFS_PH_PCDIXON('IM_PC_DIXON',folder,'haacke','OIO');
dixonfig('DX_OIO_haacke',WFS,ffig,sfig);


ffig = "../out/PH PC 3p-Dixon/FIGURES DIXON NT/";
mkdir(ffig);

load('../out/PH PC 3p-Dixon/MAT/WFV_GROUND_TRUTH.mat','WFV');
gtfignt('GROUND TRUTH',WFV,ffig,sfig)

WFS = WFS_PH_PCDIXON('IM_PC_DIXON',folder,'two','IOI');
dixonfignt('DX_IOI_two',WFS,ffig,sfig);
WFS = WFS_PH_PCDIXON('IM_PC_DIXON',folder,'two','OIO');
dixonfignt('DX_OIO_two',WFS,ffig,sfig);

WFS = WFS_PH_PCDIXON('IM_PC_DIXON',folder,'three','IOI');
dixonfignt('DX_IOI_three',WFS,ffig,sfig);
WFS = WFS_PH_PCDIXON('IM_PC_DIXON',folder,'three','OIO');
dixonfignt('DX_OIO_three',WFS,ffig,sfig);

WFS = WFS_PH_PCDIXON('IM_PC_DIXON',folder,'pauly','IOI');
dixonfignt('DX_IOI_pauly',WFS,ffig,sfig);
WFS = WFS_PH_PCDIXON('IM_PC_DIXON',folder,'pauly','OIO');
dixonfignt('DX_OIO_pauly',WFS,ffig,sfig);

WFS = WFS_PH_PCDIXON('IM_PC_DIXON',folder,'haacke','IOI');
dixonfignt('DX_IOI_haacke',WFS,ffig,sfig);
WFS = WFS_PH_PCDIXON('IM_PC_DIXON',folder,'haacke','OIO');
dixonfignt('DX_OIO_haacke',WFS,ffig,sfig);

% >--------------------------------------------------------------------------< %

function dixonfig(ind,WFS,ffig,sfig)
    fig0 = figure('Position',[200 200 500 400]);
    imagesc(abs(WFS.Mw)); title({'Water Magnitude'},'FontSize',40); daspect([1 1 1]);
    axis off; clim([0 1]); colormap('gray'); colorbar('FontSize',24);
    if sfig == 2; saveas(fig0,ffig + string(ind)+ ' Water Magnitude.png'); end
    
    fig0 = figure('Position',[200 200 500 400]);
    imagesc(abs(WFS.Mf)); title({'Fat Magnitude'},'FontSize',40); daspect([1 1 1]);
    axis off; clim([0 1]); colormap('gray'); colorbar('FontSize',24);
    if sfig == 2; saveas(fig0,ffig + string(ind)+ ' Fat Magnitude.png'); end
    
    fig0 = figure('Position',[200 200 500 400]);
    imagesc(angle(WFS.Mw)); title({'Water Phase'},'FontSize',40); daspect([1 1 1]);
    axis off; clim([-pi pi]); colormap('jet'); colorbar('FontSize',24);
    if sfig == 2; saveas(fig0,ffig + string(ind)+ ' Water Phase.png'); end
    
    fig0 = figure('Position',[200 200 500 400]);
    imagesc(angle(WFS.Mf)); title({'Fat Phase'},'FontSize',40); daspect([1 1 1]);
    axis off; clim([-pi pi]); colormap('jet'); colorbar('FontSize',24);
    if sfig == 2; saveas(fig0,ffig + string(ind)+ ' Fat Phase.png'); end
    
    fig0 = figure('Position',[200 200 500 400]);
    imagesc(WFS.Phi); title({'Field Map'},'FontSize',40); daspect([1 1 1]);
    axis off; clim([-70 70]); colormap('parula'); colorbar('FontSize',24);
    if sfig == 2; saveas(fig0,ffig + string(ind)+ ' Field Map.png'); end
    
    fig0 = figure('Position',[200 200 500 400]);
    imagesc(WFS.Phi0); title({'Field Map 0'},'FontSize',40); daspect([1 1 1]);
    axis off; clim([-pi pi]); colormap('parula'); colorbar('FontSize',24);
    if sfig == 2; saveas(fig0,ffig + string(ind)+ ' Field Map 0.png'); end
end

function gtfig(ind,WFV,ffig,sfig)
    fig0 = figure('Position',[200 200 500 400]);
    imagesc(WFV.Mw); title({'Water Magnitude'},'FontSize',40); daspect([1 1 1]);
    axis off; clim([0 1]); colormap('gray'); colorbar('FontSize',24);
    if sfig == 2; saveas(fig0,ffig + string(ind)+ ' Water Magnitude.png'); end
    
    fig0 = figure('Position',[200 200 500 400]);
    imagesc(WFV.Mf); title({'Fat Magnitude'},'FontSize',40); daspect([1 1 1]);
    axis off; clim([0 1]); colormap('gray'); colorbar('FontSize',24);
    if sfig == 2; saveas(fig0,ffig + string(ind)+ ' Fat Magnitude.png'); end
    
    fig0 = figure('Position',[200 200 500 400]);
    imagesc(WFV.VEL*pi/(2*100)); title({'Water Phase'},'FontSize',40); daspect([1 1 1]);
    axis off; clim([-pi pi]); colormap('jet'); colorbar('FontSize',24);
    if sfig == 2; saveas(fig0,ffig + string(ind)+ ' Water Phase.png'); end
    
    fig0 = figure('Position',[200 200 500 400]);
    imagesc(WFV.Phi); title({'Field Map'},'FontSize',40); daspect([1 1 1]);
    axis off; clim([-70 70]); colormap('parula'); colorbar('FontSize',24);
    if sfig == 2; saveas(fig0,ffig + string(ind)+ ' Field Map.png'); end
end

function dixonfignt(ind,WFS,ffig,sfig)
    fig0 = figure('Position',[200 200 500 400]);
    imagesc(abs(WFS.Mw)); daspect([1 1 1]);
    axis off; clim([0 1]); colormap('gray'); colorbar('FontSize',24);
    if sfig == 2; saveas(fig0,ffig + string(ind)+ ' Water Magnitude.png'); end
    
    fig0 = figure('Position',[200 200 500 400]);
    imagesc(abs(WFS.Mf)); daspect([1 1 1]);
    axis off; clim([0 1]); colormap('gray'); colorbar('FontSize',24);
    if sfig == 2; saveas(fig0,ffig + string(ind)+ ' Fat Magnitude.png'); end
    
    fig0 = figure('Position',[200 200 500 400]);
    imagesc(angle(WFS.Mw)); daspect([1 1 1]);
    axis off; clim([-pi pi]); colormap('jet'); colorbar('FontSize',24);
    if sfig == 2; saveas(fig0,ffig + string(ind)+ ' Water Phase.png'); end
    
    fig0 = figure('Position',[200 200 500 400]);
    imagesc(angle(WFS.Mf)); daspect([1 1 1]);
    axis off; clim([-pi pi]); colormap('jet'); colorbar('FontSize',24);
    if sfig == 2; saveas(fig0,ffig + string(ind)+ ' Fat Phase.png'); end
    
    fig0 = figure('Position',[200 200 500 400]);
    imagesc(WFS.Phi); daspect([1 1 1]);
    axis off; clim([-70 70]); colormap('parula'); colorbar('FontSize',24);
    if sfig == 2; saveas(fig0,ffig + string(ind)+ ' Field Map.png'); end
    
    fig0 = figure('Position',[200 200 500 400]);
    imagesc(WFS.Phi0); daspect([1 1 1]);
    axis off; clim([-pi pi]); colormap('parula'); colorbar('FontSize',24);
    if sfig == 2; saveas(fig0,ffig + string(ind)+ ' Field Map 0.png'); end
end

function gtfignt(ind,WFV,ffig,sfig)
    fig0 = figure('Position',[200 200 500 400]);
    imagesc(WFV.Mw); daspect([1 1 1]);
    axis off; clim([0 1]); colormap('gray'); colorbar('FontSize',24);
    if sfig == 2; saveas(fig0,ffig + string(ind)+ ' Water Magnitude.png'); end
    
    fig0 = figure('Position',[200 200 500 400]);
    imagesc(WFV.Mf); daspect([1 1 1]);
    axis off; clim([0 1]); colormap('gray'); colorbar('FontSize',24);
    if sfig == 2; saveas(fig0,ffig + string(ind)+ ' Fat Magnitude.png'); end
    
    fig0 = figure('Position',[200 200 500 400]);
    imagesc(WFV.VEL*pi/(2*100)); daspect([1 1 1]);
    axis off; clim([-pi pi]); colormap('jet'); colorbar('FontSize',24);
    if sfig == 2; saveas(fig0,ffig + string(ind)+ ' Water Phase.png'); end
    
    fig0 = figure('Position',[200 200 500 400]);
    imagesc(WFV.Phi); daspect([1 1 1]);
    axis off; clim([-70 70]); colormap('parula'); colorbar('FontSize',24);
    if sfig == 2; saveas(fig0,ffig + string(ind)+ ' Field Map.png'); end
end

% >--------------------------------------------------------------------------< %