% >--------------------------------------------------------------------------< %
% PCME Phantom
% Esteban Denecken C.
% >--------------------------------------------------------------------------< %

function WFS = WFS_PH_PCDIXON(name,folder,alg,typ)
    load(folder+ 'MAT/DCM_'+name+ '_'+string(typ)+ '.mat','DCM');
    disp(DCM);
    S = DCM.SIGNAL1;
    M = sum(maskOO(DCM.DIM),3);
    DV = DixonP(S.*M,DCM.TE,alg,typ);

    % Water-Fat
    WFS.Mw = DV.Mw;
    WFS.Mf = DV.Mf;
    WFS.Phi = DV.Phi;
    WFS.Phi0 = DV.Phi0;
    WFS.PDWF = abs(DV.Mw)./(abs(DV.Mw) + abs(DV.Mf));
    WFS.PDFF = abs(DV.Mf)./(abs(DV.Mw) + abs(DV.Mf));
    WFS.PDWF(isnan(WFS.PDWF)) = 0;
    WFS.PDFF(isnan(WFS.PDFF)) = 0;

    save(folder+ 'MAT DIXON/WFS_'+string(name)+ '_'+string(typ)+ '_'+string(alg)+ '.mat','WFS');
end

% >--------------------------------------------------------------------------< %