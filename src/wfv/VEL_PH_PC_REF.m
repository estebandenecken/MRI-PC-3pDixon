% >--------------------------------------------------------------------------< %
% PCME Phantom
% Esteban Denecken C.
% >--------------------------------------------------------------------------< %

function VEL_PH_PC_REF(name,folder)
    load(folder+ 'MAT/DCM_'+name+ '.mat','DCM');
    Ph = 0.5*angle(DCM.SIGNAL1.*conj(DCM.SIGNAL2));
    VEL = 2*DCM.VENC * Ph/pi;
    save(folder+ 'MAT/VEL_'+string(name)+ '.mat','VEL');
end

% >--------------------------------------------------------------------------< %