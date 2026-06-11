% >--------------------------------------------------------------------------< %
% PCME Phantom Figures
% Esteban Denecken C.
% >--------------------------------------------------------------------------< %
% Run after PC_3pDixon.m
% >--------------------------------------------------------------------------< %
clear; clc; close all;
addpath(genpath('../src'));

folder = "../out/PH PC 3p-Dixon/";
fmat = folder+"MAT/";
ffig = folder+"FIGURES UN/";
mkdir(ffig);

ind = "GROUND TRUTH";
load(fmat+ 'WFV_GROUND_TRUTH.mat');

fig0 = figure('Position',[200 200 500 400]);
imagesc(WFV.Mw); title({'Water Magnitude'},'FontSize',40); daspect([1 1 1]);
axis off; clim([0 1]); colormap('gray'); colorbar('FontSize',24);
saveas(fig0,ffig +ind+ ' Water Magnitude.png');

fig0 = figure('Position',[200 200 500 400]);
imagesc(WFV.Mf); title({'Fat Magnitude'},'FontSize',40); daspect([1 1 1]);
axis off; clim([0 1]); colormap('gray'); colorbar('FontSize',24);
saveas(fig0,ffig +ind+ ' Fat Magnitude.png');

fig0 = figure('Position',[200 200 500 400]);
imagesc(WFV.PDWF); title({'Water Fraction'},'FontSize',40); daspect([1 1 1]);
axis off; clim([0 1]); colormap('bone'); colorbar('FontSize',24);
saveas(fig0,ffig +ind+ ' Water Fraction.png');

fig0 = figure('Position',[200 200 500 400]);
imagesc(WFV.PDFF); title({'Fat Fraction'},'FontSize',40); daspect([1 1 1]);
axis off; clim([0 1]); colormap('copper'); colorbar('FontSize',24);
saveas(fig0,ffig +ind+ ' Fat Fraction.png');

fig0 = figure('Position',[200 200 500 400]);
imagesc(WFV.Phw); title({'Water Phase'},'FontSize',40); daspect([1 1 1]);
axis off; clim([-pi pi]); colormap('parula'); colorbar('FontSize',24);
saveas(fig0,ffig +ind+ ' Water Phase.png');

fig0 = figure('Position',[200 200 500 400]);
imagesc(WFV.Phf); title({'Fat Phase'},'FontSize',40); daspect([1 1 1]);
axis off; clim([-pi pi]); colormap('parula'); colorbar('FontSize',24);
saveas(fig0,ffig +ind+ ' Fat Phase.png');

fig0 = figure('Position',[200 200 500 400]);
imagesc(WFV.Phi); title({'Field Map'},'FontSize',40); daspect([1 1 1]);
axis off; clim([-70 70]); colormap('parula'); colorbar('FontSize',24);
saveas(fig0,ffig +ind+ ' Field Map.png');

fig0 = figure('Position',[200 200 500 400]);
imagesc(WFV.T2); title({'T2*'},'FontSize',40); daspect([1 1 1]);
axis off; clim([0 200]); colormap('bone'); colorbar('FontSize',24);
saveas(fig0,ffig +ind+ ' T2.png');

fig0 = figure('Position',[200 200 500 400]);
imagesc(WFV.VEL); title({'Velocity'},'FontSize',40); daspect([1 1 1]);
axis off; clim([-100 100]); colormap('jet'); colorbar('FontSize',24);
saveas(fig0,ffig +ind+ ' Velocity.png');

ind = 'PC REF';
load(fmat+ 'VEL_IM_PC_REF.mat');
load(fmat+ 'DCM_IM_PC_REF.mat');

fig0 = figure('Position',[200 200 500 400]);
imagesc(VEL); title({'Velocity'},'FontSize',40); daspect([1 1 1]);
axis off; clim([-100 100]); colormap('jet'); colorbar('FontSize',24);
saveas(fig0,ffig +ind+ ' Velocity.png');

fig0 = figure('Position',[200 200 500 400]);
imagesc(angle(DCM.SIGNAL1)); title({' Phase'},'FontSize',40); daspect([1 1 1]);
axis off; clim([-pi pi]); colormap('parula'); colorbar('FontSize',24);
saveas(fig0,ffig +ind+ ' PC Phase.png');

ind = 'PC DIXON IOI';
load(fmat+ 'WFS_IM_PC_DIXON_IOI.mat');

fig0 = figure('Position',[200 200 500 400]);
imagesc(WFS.MMw); title({'Water Magnitude'},'FontSize',40); daspect([1 1 1]);
axis off; clim([0 1]); colormap('gray'); colorbar('FontSize',24);
saveas(fig0,ffig +ind+ ' Water Magnitude.png');

fig0 = figure('Position',[200 200 500 400]);
imagesc(WFS.MMf); title({'Fat Magnitude'},'FontSize',40); daspect([1 1 1]);
axis off; clim([0 1]); colormap('gray'); colorbar('FontSize',24);
saveas(fig0,ffig +ind+ ' Fat Magnitude.png');

fig0 = figure('Position',[200 200 500 400]);
imagesc(WFS.PDWF); title({'Water Fraction'},'FontSize',40); daspect([1 1 1]);
axis off; clim([0 1]); colormap('bone'); colorbar('FontSize',24);
saveas(fig0,ffig +ind+ ' Water Fraction.png');

fig0 = figure('Position',[200 200 500 400]);
imagesc(WFS.PDFF); title({'Fat Fraction'},'FontSize',40); daspect([1 1 1]);
axis off; clim([0 1]); colormap('copper'); colorbar('FontSize',24);
saveas(fig0,ffig +ind+ ' Fat Fraction.png');

fig0 = figure('Position',[200 200 500 400]);
imagesc(angle(WFS.Mw1)); title({'Water Phase'},'FontSize',40); daspect([1 1 1]);
axis off; clim([-pi pi]); colormap('parula'); colorbar('FontSize',24);
saveas(fig0,ffig +ind+ ' Water Phase.png');

fig0 = figure('Position',[200 200 500 400]);
imagesc(angle(WFS.Mf1)); title({'Fat Phase'},'FontSize',40); daspect([1 1 1]);
axis off; clim([-pi pi]); colormap('parula'); colorbar('FontSize',24);
saveas(fig0,ffig +ind+ ' Fat Phase.png');

fig0 = figure('Position',[200 200 500 400]);
imagesc(WFS.Phi); title({'Field Map'},'FontSize',40); daspect([1 1 1]);
axis off; clim([-70 70]); colormap('parula'); colorbar('FontSize',24);
saveas(fig0,ffig +ind+ ' Field Map.png');

load(fmat+ 'VEL_IM_PC_DIXON_IOI.mat');

fig0 = figure('Position',[200 200 500 400]);
imagesc(VEL); title({'Velocity'},'FontSize',40); daspect([1 1 1]);
axis off; clim([-100 100]); colormap('jet'); colorbar('FontSize',24);
saveas(fig0,ffig +ind+ ' Velocity.png');

ind = 'DIXON IOI';
load(fmat+ 'WFS_IM_DIXON_IOI.mat');

fig0 = figure('Position',[200 200 500 400]);
imagesc(WFS.MMw); title({'Water Magnitude'},'FontSize',40); daspect([1 1 1]);
axis off; clim([0 1]); colormap('gray'); colorbar('FontSize',24);
saveas(fig0,ffig +ind+ ' Water Magnitude.png');

fig0 = figure('Position',[200 200 500 400]);
imagesc(WFS.MMf); title({'Fat Magnitude'},'FontSize',40); daspect([1 1 1]);
axis off; clim([0 1]); colormap('gray'); colorbar('FontSize',24);
saveas(fig0,ffig +ind+ ' Fat Magnitude.png');

fig0 = figure('Position',[200 200 500 400]);
imagesc(WFS.PDWF); title({'Water Fraction'},'FontSize',40); daspect([1 1 1]);
axis off; clim([0 1]); colormap('bone'); colorbar('FontSize',24);
saveas(fig0,ffig +ind+ ' Water Fraction.png');

fig0 = figure('Position',[200 200 500 400]);
imagesc(WFS.PDFF); title({'Fat Fraction'},'FontSize',40); daspect([1 1 1]);
axis off; clim([0 1]); colormap('copper'); colorbar('FontSize',24);
saveas(fig0,ffig +ind+ ' Fat Fraction.png');

fig0 = figure('Position',[200 200 500 400]);
imagesc(angle(WFS.Mw)); title({'Water Phase'},'FontSize',40); daspect([1 1 1]);
axis off; clim([-pi pi]); colormap('parula'); colorbar('FontSize',24);
saveas(fig0,ffig +ind+ ' Water Phase.png');

fig0 = figure('Position',[200 200 500 400]);
imagesc(angle(WFS.Mf)); title({'Fat Phase'},'FontSize',40); daspect([1 1 1]);
axis off; clim([-pi pi]); colormap('parula'); colorbar('FontSize',24);
saveas(fig0,ffig +ind+ ' Fat Phase.png');

fig0 = figure('Position',[200 200 500 400]);
imagesc(WFS.Phi); title({'Field Map'},'FontSize',40); daspect([1 1 1]);
axis off; clim([-70 70]); colormap('parula'); colorbar('FontSize',24);
saveas(fig0,ffig +ind+ ' Field Map.png');

ind = 'PC DIXON OIO';
load(fmat+ 'WFS_IM_PC_DIXON_OIO.mat');

fig0 = figure('Position',[200 200 500 400]);
imagesc(WFS.MMw); title({'Water Magnitude'},'FontSize',40); daspect([1 1 1]);
axis off; clim([0 1]); colormap('gray'); colorbar('FontSize',24);
saveas(fig0,ffig +ind+ ' Water Magnitude.png');

fig0 = figure('Position',[200 200 500 400]);
imagesc(WFS.MMf); title({'Fat Magnitude'},'FontSize',40); daspect([1 1 1]);
axis off; clim([0 1]); colormap('gray'); colorbar('FontSize',24);
saveas(fig0,ffig +ind+ ' Fat Magnitude.png');

fig0 = figure('Position',[200 200 500 400]);
imagesc(WFS.PDWF); title({'Water Fraction'},'FontSize',40); daspect([1 1 1]);
axis off; clim([0 1]); colormap('bone'); colorbar('FontSize',24);
saveas(fig0,ffig +ind+ ' Water Fraction.png');

fig0 = figure('Position',[200 200 500 400]);
imagesc(WFS.PDFF); title({'Fat Fraction'},'FontSize',40); daspect([1 1 1]);
axis off; clim([0 1]); colormap('copper'); colorbar('FontSize',24);
saveas(fig0,ffig +ind+ ' Fat Fraction.png');

fig0 = figure('Position',[200 200 500 400]);
imagesc(angle(WFS.Mw1)); title({'Water Phase'},'FontSize',40); daspect([1 1 1]);
axis off; clim([-pi pi]); colormap('parula'); colorbar('FontSize',24);
saveas(fig0,ffig +ind+ ' Water Phase.png');

fig0 = figure('Position',[200 200 500 400]);
imagesc(angle(WFS.Mf1)); title({'Fat Phase'},'FontSize',40); daspect([1 1 1]);
axis off; clim([-pi pi]); colormap('parula'); colorbar('FontSize',24);
saveas(fig0,ffig +ind+ ' Fat Phase.png');

fig0 = figure('Position',[200 200 500 400]);
imagesc(WFS.Phi); title({'Field Map'},'FontSize',40); daspect([1 1 1]);
axis off; clim([-70 70]); colormap('parula'); colorbar('FontSize',24);
saveas(fig0,ffig +ind+ ' Field Map.png');

load(fmat+ 'VEL_IM_PC_DIXON_OIO.mat');

fig0 = figure('Position',[200 200 500 400]);
imagesc(VEL); title({'Velocity'},'FontSize',40); daspect([1 1 1]);
axis off; clim([-100 100]); colormap('jet'); colorbar('FontSize',24);
saveas(fig0,ffig +ind+ ' Velocity.png');

ind = 'DIXON OIO';
load(fmat+ 'WFS_IM_DIXON_OIO.mat');

fig0 = figure('Position',[200 200 500 400]);
imagesc(WFS.MMw); title({'Water Magnitude'},'FontSize',40); daspect([1 1 1]);
axis off; clim([0 1]); colormap('gray'); colorbar('FontSize',24);
saveas(fig0,ffig +ind+ ' Water Magnitude.png');

fig0 = figure('Position',[200 200 500 400]);
imagesc(WFS.MMf); title({'Fat Magnitude'},'FontSize',40); daspect([1 1 1]);
axis off; clim([0 1]); colormap('gray'); colorbar('FontSize',24);
saveas(fig0,ffig +ind+ ' Fat Magnitude.png');

fig0 = figure('Position',[200 200 500 400]);
imagesc(WFS.PDWF); title({'Water Fraction'},'FontSize',40); daspect([1 1 1]);
axis off; clim([0 1]); colormap('bone'); colorbar('FontSize',24);
saveas(fig0,ffig +ind+ ' Water Fraction.png');

fig0 = figure('Position',[200 200 500 400]);
imagesc(WFS.PDFF); title({'Fat Fraction'},'FontSize',40); daspect([1 1 1]);
axis off; clim([0 1]); colormap('copper'); colorbar('FontSize',24);
saveas(fig0,ffig +ind+ ' Fat Fraction.png');

fig0 = figure('Position',[200 200 500 400]);
imagesc(angle(WFS.Mw)); title({'Water Phase'},'FontSize',40); daspect([1 1 1]);
axis off; clim([-pi pi]); colormap('parula'); colorbar('FontSize',24);
saveas(fig0,ffig +ind+ ' Water Phase.png');

fig0 = figure('Position',[200 200 500 400]);
imagesc(angle(WFS.Mf)); title({'Fat Phase'},'FontSize',40); daspect([1 1 1]);
axis off; clim([-pi pi]); colormap('parula'); colorbar('FontSize',24);
saveas(fig0,ffig +ind+ ' Fat Phase.png');

fig0 = figure('Position',[200 200 500 400]);
imagesc(WFS.Phi); title({'Field Map'},'FontSize',40); daspect([1 1 1]);
axis off; clim([-70 70]); colormap('parula'); colorbar('FontSize',24);
saveas(fig0,ffig +ind+ ' Field Map.png');


% >--------------------------------------------------------------------------< %