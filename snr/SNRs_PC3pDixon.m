% >--------------------------------------------------------------------------< %
% PCME Phantom SNRs
% Esteban Denecken C.
% >--------------------------------------------------------------------------< %
% Run PC_3pDixon.m first
% >--------------------------------------------------------------------------< %
clear; clc; close all;
addpath(genpath('../SRC'));

mkdir("../out/PH PC 3p-Dixon/SNR");
savemat = 1;
savefig = 2;

% SNR
NSDs = (0:0.0125:0.2375)';
for SNR = 1:size(NSDs,1)
    NSD = NSDs(SNR);
    SNR_PC3pDixon
    close all
end

SNRAnalysis_PC3pDixon

% >--------------------------------------------------------------------------< %