% >--------------------------------------------------------------------------< %
% PCME Phantom
% Esteban Denecken C.
% >--------------------------------------------------------------------------< %

function WFS_PH_DIXON_OIO(name,folder)
    load(folder+ 'MAT/DCM_'+name+ '.mat','DCM');
    disp(DCM);
    S = DCM.SIGNAL;
    M = sum(maskOO(DCM.DIM),3);
    DV = DixonH(S.*M,DCM.TE,'OIO');

    % Water-Fat
    WFS.MMw = abs(DV.Mw);
    WFS.MMf = abs(DV.Mf);
    WFS.Mw = DV.Mw;
    WFS.Mf = DV.Mf;
    WFS.Phi = DV.Phi;
    WFS.PDWF = abs(DV.Mw)./(abs(DV.Mw) + abs(DV.Mf));
    WFS.PDFF = abs(DV.Mf)./(abs(DV.Mw) + abs(DV.Mf));
    WFS.PDWF(isnan(WFS.PDWF)) = 0;
    WFS.PDFF(isnan(WFS.PDFF)) = 0;

    save(folder+ 'MAT/WFS_'+string(name)+ '.mat','WFS');
end

% >--------------------------------------------------------------------------< %