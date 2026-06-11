% >--------------------------------------------------------------------------< %
% Phase-contrast Multi-echo Phantom
% Esteban Denecken C.
% >--------------------------------------------------------------------------< %
% Function that builds a water-fat and velocity phantom
% given the dimension (square images) and echo times.
% This phantom has fat and water concentrations.
% velocity mixed in same pixels.
% Only the water concnetration has velocity
% The output are two acquisitions with bipolar pulses of different
% polarity.
% Input
%    tn1  : Echo times 1 [s]
%    tn2  : Echo times 2 [s]
%    bip  : Bipolar pulse acquisition
%    NSD  : Noise Standard Deviation for Signal-to-noise ratio
%    ki   : Phantom options
%    dim  : Dimension of the phantom
% Output
%    PH
% >--------------------------------------------------------------------------< %

function PH = PCMEPhantom(tn1,tn2,bip,NSD,ki,dim,mpk)

    % Parameters
    % gamma [rad/s/T]  -> Gyromagnetic Constant
    % fcs [Hz]         -> Chemical Shift Frequency of Fat
    % tn [s]           -> 1 ms = 1e-3 s Echo times
    % fin [Hz]         -> Range of frequency Field Map
    % G [T/cm]         -> 1 mT/m = 1e-5 T/cm Gradient Amplitude
	
	% TEs
	tn = cat(1,tn1,tn2);
	if bip == 0 && sum(tn1 == tn2) > 0
		tn = tn1;
	end
	
    % Velocities
    vew = 80; vef = 0;

    gamma = 2.675e8; % [rad/s/T]
	B0 = 1.5; % [T]
    fin = 2.6e-6 * gamma*B0/(2*pi);
    
    % Chemical shift fat
    sigmafreq = -3.40*1e-6;
    amps = 1;
    if mpk == 1
        sigmafreq = [-3.80, -3.40, -2.60, -1.94, -0.39, 0.60]*1e-6;
        amps = [0.087 0.693 0.128 0.004 0.039 0.048];
    end
    fcs = -gamma*B0 * sigmafreq;
    
    % Velocity Encoding of Water
    venc = 100; % [cm/s]

    % Bipolar Gradient
    Tauv = 0.6e-3; % Duration
    Gv = pi/(2*gamma*venc*Tauv^2); % Amplitude

    % Phantom
    % Mask
    A = 1;
    Ms = maskOO(dim);
    Fr_w = A*mergemask(Ms,[1 0.915 0.832 0.749 0.666 0.583 0.5 0.417 0.334 0.251 0.168 0.085 0 1 1 1 1]' +1e-8);
    Fr_f = A*mergemask(Ms,[0 0.085 0.168 0.251 0.334 0.417 0.5 0.583 0.666 0.749 0.832 0.915 1 0 0 0 0]' -1e-8);
    
    Fr_vw = mergemask(Ms,[0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0.5 0]') .* vew;
    Fr_vf = mergemask(Ms,[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0   0]') .* vef;
    
    % T2*
    % T2w = 200e-3;    % T2* Water [ms]
    % T2f = 10e-3;     % T2* Fat [ms]
    % T2 = T2w * Fr_w + T2f * Fr_f;
    T2 = mergemask(Ms,[200 183.85 168.08 152.31 136.54 120.77 105 89.23 73.46 57.69 41.92 26.15 10 200 200 200 25]');

    % T2* and Noise
    R2 = zeros(dim);
    NN1 = zeros(dim);
    NN2 = zeros(dim);
    seed = 0; rng(seed); % Random Seed
    
    if ki(1) == 1
        % T2*
        R2 = 1 ./ (T2 * 1e-3);
    end
    if ki(1) == 2
        % T2*
        R2 = 1 ./ (T2 * 1e-3);
        
        % Noise
        NN1 = A * random('Normal',0,NSD,dim) + 1i*random('Normal',0,NSD,dim);
        NN2 = A * random('Normal',0,NSD,dim) + 1i*random('Normal',0,NSD,dim);
    end
    if ki(1) == 3
        % T2*
        R2 = zeros(dim);
        
        % Noise
        RN = 1 ./ (100 * 1e-3);
        NN1 = A * random('Normal',0,NSD,dim) + 1i*random('Normal',0,NSD,dim);
        NN2 = A * random('Normal',0,NSD,dim) + 1i*random('Normal',0,NSD,dim);
    end
    
    % Initial Phase
    Phi0w1 = zeros(dim); Phi0f1 = zeros(dim);
    Phi0w2 = zeros(dim); Phi0f2 = zeros(dim);
    
    if ki(2) == 1
        Phi0 = (rand(dim)-0.5) * pi/2;
        Phi0w1 = Phi0; Phi0f1 = Phi0;
        Phi0w2 = Phi0; Phi0f2 = Phi0;
    end
    if ki(2) == 2
        Phi01 = (rand(dim)-0.5) * pi/2;
        Phi02 = (rand(dim)-0.5) * pi/2;
        Phi0w1 = Phi01; Phi0f1 = Phi02;
        Phi0w2 = Phi01; Phi0f2 = Phi02;
    end
    if ki(2) == 3
        Phi0 = imresize((rand(8)-0.5) * pi/2,dim/8);
        Phi0w1 = Phi0; Phi0f1 = Phi0;
        Phi0w2 = Phi0; Phi0f2 = Phi0;
    end
    if ki(2) == 4
        Phi01 = imresize((rand(8)-0.5) * pi/2,dim/8);
        Phi02 = imresize((rand(8)-0.5) * pi/2,dim/8);
        Phi0w1 = Phi01; Phi0f1 = Phi02;
        Phi0w2 = Phi01; Phi0f2 = Phi02;
    end
    
    % Linear Field
    fieldL = zeros(dim);
    for xx = 1:dim
        for yy = 1:dim
            % fieldL(xx,yy) = (xx + yy - 1 - dim)/(dim - 1);
			fieldL(xx,yy) = (0.8*dim^2 - xx^2 - yy^2)/(2*dim^2);
        end
    end
    % fieldL = zeros(dim);
    
    % Field Map
    Phi = fieldL * fin; % [Hz]
    
    % Velocity induced phase - Negative Polarity
    Ph_vw1 = gamma*Gv*Tauv^2 * Fr_vw;   % [rad]
    Ph_vw1 = angle(exp(1i*Ph_vw1));
    Ph_vf1 = gamma*Gv*Tauv^2 * Fr_vf;   % [rad]
    Ph_vf1 = angle(exp(1i*Ph_vf1));
    
    % Velocity induced phase - Positive Polarity
    Ph_vw2 = -gamma*Gv*Tauv^2 * Fr_vw;   % [rad]
    Ph_vw2 = angle(exp(1i*Ph_vw2));
    Ph_vf2 = -gamma*Gv*Tauv^2 * Fr_vf;   % [rad]
    Ph_vf2 = angle(exp(1i*Ph_vf2));
    
    szt = size(tn1,1);
    Sn1 = zeros(dim,dim,szt);
    for i = 1:szt
        % Phase
        Ph_cs = sum(amps.*exp(-1i*fcs*tn1(i))) * ones(dim);
        Ph_w = exp(1i*(Phi0w1 + Ph_vw1));
        Ph_f = exp(1i*(Phi0f1 + Ph_vf1)) .* Ph_cs;
        Ph_m = exp(1i*2*pi*Phi.*tn1(i) - tn1(i)*R2);
        % Acquisition
        Sn1(:,:,i) = (Fr_w.*Ph_w + Fr_f.*Ph_f) .* Ph_m + NN1;
    end
    szt = size(tn2,1);
    Sn2 = zeros(dim,dim,szt);
    for i = 1:szt
        % Phase
        Ph_cs = sum(amps.*exp(-1i*fcs*tn2(i))) * ones(dim);
        Ph_w = exp(1i*(Phi0w2 + Ph_vw2));
        Ph_f = exp(1i*(Phi0f2 + Ph_vf2)) .* Ph_cs;
        Ph_m = exp(1i*2*pi*Phi.*tn2(i) - tn2(i)*R2);
        % Acquisition
        Sn2(:,:,i) = (Fr_w.*Ph_w + Fr_f.*Ph_f) .* Ph_m + NN2;
    end
    szt = size(tn,1);
    Sn = zeros(dim,dim,szt);
    for i = 1:szt
        % Phase
        Ph_cs = sum(amps.*exp(-1i*fcs*tn(i))) * ones(dim);
        Ph_w = exp(1i*Phi0w1);
        Ph_f = exp(1i*Phi0f1) .* Ph_cs;
        Ph_m = exp(1i*2*pi*Phi.*tn(i) - tn(i)*R2);
        % Acquisition
        Sn(:,:,i) = (Fr_w.*Ph_w + Fr_f.*Ph_f) .* Ph_m + NN1;
        if i > size(tn1,1)
            Sn(:,:,i) = (Fr_w.*Ph_w + Fr_f.*Ph_f) .* Ph_m + NN2;
        end
        if ki(1) == 4
            % Acquisition
            Sn(:,:,i) = (Fr_w.*Ph_w + Fr_f.*Ph_f) .* Ph_m + NN1*tn(i)*RN;
            if i > size(tn1,1)
                Sn(:,:,i) = (Fr_w.*Ph_w + Fr_f.*Ph_f) .* Ph_m + NN2*tn(i)*RN;
            end
        end
    end
    
    % Ground Truth
    GTw1 = Fr_w.*exp(1i*Phi0w1);
    GTf1 = Fr_f.*exp(1i*Phi0f1);
    GTw2 = Fr_w.*exp(1i*Phi0w2);
    GTf2 = Fr_f.*exp(1i*Phi0f2);
    
    % Output
    if bip == 1
        Water.Density = Fr_w;               % Water density
        Water.InitPhase1 = angle(GTw1);     % Initial phase Water Image 1
        Water.InitPhase2 = angle(GTw2);     % Initial phase Water Image 2
        Water.VelField = Fr_vw;             % Velocity Field of Water
        Water.VelPhase1 = Ph_vw1;           % Velocity Phase Encoding Negative Polarity
        Water.VelPhase2 = Ph_vw2;           % Velocity Phase Encoding Positive Polarity
        Water.GT1 = GTw1;                   % Ground Truth Water Image 1
        Water.GT2 = GTw2;                   % Ground Truth Water Image 2
        
        Fat.Density = Fr_f;                 % Fat density
        Fat.InitPhase1 = angle(GTf1);       % Initial phase Fat Image 1
        Fat.InitPhase2 = angle(GTf2);       % Initial phase Fat Image 2
        Fat.VelField = Fr_vf;               % Velocity Field of Fat
        Fat.VelPhase1 = Ph_vf1;             % Velocity Phase Encoding Negative Polarity
        Fat.VelPhase2 = Ph_vf2;             % Velocity Phase Encoding Positive Polarity
        Fat.GT1 = GTf1;                     % Ground Truth Fat Image 1
        Fat.GT2 = GTf2;                     % Ground Truth Fat Image 2
        
        Velocity.Gv = Gv;                 % Bipolar pulse amplitude
        Velocity.Tau = Tauv;              % Bipolar pulse duration
        Velocity.Polarity = [-1 1]';      % Bipolar pulse polarity
        
        WFV.FieldMap = Phi;           % Field Map of Field Map [Hz]
        WFV.T2 = T2;                  % T2* Map [ms]
        
        WFV.Water = Water;            % Ground Truth Water
        WFV.Fat = Fat;                % Ground Truth Fat
        WFV.Velocity = Velocity;      % Velocity parameters
        
        if isequal(tn1,tn2)
            PH.TE = tn1;            % Echo times Acquisitions
        else
            PH.TE1 = tn1;           % Echo times Acquisition 1
            PH.TE2 = tn2;           % Echo times Acquisition 2
        end
        PH.SIGNAL1 = Sn1;           % MRI Acquisition 1
        PH.SIGNAL2 = Sn2;           % MRI Acquisition 2
        PH.VENC = venc;             % Velocity encoding
    end
    if bip == 0
        Water.Density = Fr_w;              % Water density
        Water.InitPhase = angle(GTw1);     % Initial phase Water Image
        Water.GT = GTw1;                   % Ground Truth Water Image
        Fat.Density = Fr_f;                % Fat density
        Fat.InitPhase = angle(GTf1);       % Initial phase Fat Image
        Fat.GT = GTf1;                     % Ground Truth Fat Image

        WFV.FieldMap = Phi;           % Field Map of Field Map [Hz]
        WFV.T2 = T2;                  % T2* Map [ms]
        
        WFV.Water = Water;            % Ground Truth Water
        WFV.Fat = Fat;                % Ground Truth Fat

        PH.TE = tn;                 % Echo times Acquisitions
        PH.SIGNAL = Sn;             % MRI Acquisition
    end
    PH.WFV = WFV;
    PH.DESCRIPTION = 'PHANTOM';
    PH.DIM = dim;               % Image Size
end
    
    
% >--------------------------------------------------------------------------< %