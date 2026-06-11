% >--------------------------------------------------------------------------< %
% PCME Phantom
% Esteban Denecken C.
% >--------------------------------------------------------------------------< %

function VEL_PH_PC_WATER(name,folder)
    load(folder+ 'MAT/DCM_'+name+ '.mat','DCM');
    load(folder+ 'MAT/WFS_'+name+ '.mat','WFS');
    Ph = 0.5*angle(WFS.Mw1.*conj(WFS.Mw2));
    VEL = 2*DCM.VENC * Ph/pi;
    save(folder+ 'MAT/VEL_'+string(name)+ '.mat','VEL');
end

% >--------------------------------------------------------------------------< %