% >--------------------------------------------------------------------------< %
% Phase-contrast
% Esteban Denecken C.
% >--------------------------------------------------------------------------< %
% Function that compute Phase Contrast between two acquisitions
% Input
%    S1   : Acquisition 1 - Negative polarity
%    S2   : Acquisition 2 - Positive polarity
%    Venc : Velocity encoding
%    fig  : 1 Show figure, 2 Show and Save figure, 0 No
%    tit  : Title
% Output
%    PC.Ph : Phase Contrast Image
%    PC.V  : Velocity Image
% >--------------------------------------------------------------------------< %

function PC = phasecontrast(S1,S2,Venc)
    Ph = 0.5*angle(S1.*conj(S2));
    Vel = 2*Venc * Ph/pi;
    
    PC.Ph = Ph;
    PC.V = Vel;
end

% >--------------------------------------------------------------------------< %