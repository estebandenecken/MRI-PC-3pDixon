% >---------------------------------------------------------------------< %
% Dixon Water-Fat Separation
% Esteban Denecken C.
% >---------------------------------------------------------------------< %
% Function that performs a Two-point or Three-point Dixon Water-Fat
% Separation in an MRI acquisition using different algorithms
% Input
%    Sn  : Signal acquisition
%    tn  : Echo times [s]
%    typ : Three-point Dixon IOI or OIO
%    alg : Algorithm
% Output
%    Mw   : Water image
%    Mf   : Fat image
%    Phi0 : Estimated initial inhomogeneities [rad/s]
%    Phi  : Estimated inhomogeneities [rad/s] in 1 [ms]
% >---------------------------------------------------------------------< %

function Dx = DixonP(Sn,tn,alg,typ)
Phi = zeros(size(Sn(:,:,1)));
Phi0 = zeros(size(Sn(:,:,1)));

if alg == "two"
    Mw = 0.5*(Sn(:,:,1) + Sn(:,:,2));
    Mf = 0.5*(Sn(:,:,1) - Sn(:,:,2));
end

if alg == "three"
    gB = angle(conj(Sn(:,:,1)) .* Sn(:,:,3)) / (tn(3) - tn(1));
    if typ == "IOI"
        Mw = 0.5*(Sn(:,:,1).*exp(-1i*gB*tn(1))+Sn(:,:,2).*exp(-1i*gB*tn(2)));
        Mf = 0.5*(Sn(:,:,1).*exp(-1i*gB*tn(1))-Sn(:,:,2).*exp(-1i*gB*tn(2)));
    end
    if typ == "OIO"
        Mw = 0.5*(Sn(:,:,2).*exp(-1i*gB*tn(2))+Sn(:,:,1).*exp(-1i*gB*tn(1)));
        Mf = 0.5*(Sn(:,:,2).*exp(-1i*gB*tn(2))-Sn(:,:,1).*exp(-1i*gB*tn(1)));
    end
    Phi = gB ./ (2*pi);
end

if alg == "pauly"
    if typ == "IOI"
        Phi = 0.5*angle(conj(Sn(:,:,1)) .* Sn(:,:,3));
        Phi0 = angle(Sn(:,:,1));
        Mw = 0.5*(Sn(:,:,1) + Sn(:,:,2).*exp(-1i*Phi)).*exp(-1i*Phi0);
        Mf = 0.5*(Sn(:,:,1) - Sn(:,:,2).*exp(-1i*Phi)).*exp(-1i*Phi0);
    end
    if typ == "OIO"
        Phi = 0.5*angle(conj(Sn(:,:,1)) .* Sn(:,:,3));
        Phi0 = angle(Sn(:,:,2));
        Mw = 0.5*(Sn(:,:,2) + Sn(:,:,1).*exp(1i*Phi)).*exp(-1i*Phi0);
        Mf = 0.5*(Sn(:,:,2) - Sn(:,:,1).*exp(1i*Phi)).*exp(-1i*Phi0);
    end
    Phi = Phi ./ (2*pi.*(tn(3) - tn(1)));
end

if alg == "haacke"
    Phi = angle(conj(Sn(:,:,1)) .* Sn(:,:,3));
    gB = Phi / (tn(3) - tn(1));
    Phi0 = angle(Sn(:,:,1)) - gB*tn(1);

    if typ == "IOI"
        S_in = 0.5*(abs(Sn(:,:,1)) + abs(Sn(:,:,3)));
        S_op = Sn(:,:,2).*exp(-1i*Phi0).*exp(-1i*gB*tn(2));
    end
    if typ == "OIO"
        S_in = Sn(:,:,2).*exp(-1i*Phi0).*exp(-1i*gB*tn(2));
        S_op = 0.5*(abs(Sn(:,:,1)) + abs(Sn(:,:,3)));
    end
    Mw = 0.5*(S_in + S_op);
    Mf = 0.5*(S_in - S_op);
    Phi = gB ./ (2*pi);
end

Dx.Mw = Mw;
Dx.Mf = Mf;
Dx.Phi0 = Phi0;
Dx.Phi = Phi;
end


% >---------------------------------------------------------------------< %