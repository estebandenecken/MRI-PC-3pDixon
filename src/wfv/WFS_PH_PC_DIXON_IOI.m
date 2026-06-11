% >--------------------------------------------------------------------------< %
% PCME Phantom
% Esteban Denecken C.
% >--------------------------------------------------------------------------< %

function WFS_PH_PC_DIXON_IOI(name,folder)
    load(folder+ 'MAT/DCM_'+name+ '.mat','DCM');
    disp(DCM);
    S1 = DCM.SIGNAL1;
    S2 = DCM.SIGNAL2;
    M = sum(maskOO(DCM.DIM),3);
    DV1 = Dixon(S1.*M,DCM.TE,'IOI');
    DV2 = Dixon(S2.*M,DCM.TE,'IOI');
    
    % Water-Fat
    Mw = 0.5*(abs(DV1.Mw) + abs(DV2.Mw));
    Mf = 0.5*(abs(DV1.Mf) + abs(DV2.Mf));
    WFS.MMw = Mw;
    WFS.MMf = Mf;
    WFS.Mw1 = DV1.Mw; WFS.Mw2 = DV2.Mw;
    WFS.Mf1 = DV1.Mf; WFS.Mf2 = DV2.Mf;
    WFS.Phi = (DV1.Phi + DV2.Phi)/2;
    WFS.Phi1 = DV1.Phi; WFS.Phi2 = DV2.Phi;
    WFS.PDWF = Mw./(Mw + Mf);
    WFS.PDFF = Mf./(Mw + Mf);
    WFS.PDWF(isnan(WFS.PDWF)) = 0;
    WFS.PDFF(isnan(WFS.PDFF)) = 0;
    
    save(folder+ 'MAT/WFS_'+string(name)+ '.mat','WFS');
end

% >--------------------------------------------------------------------------< %