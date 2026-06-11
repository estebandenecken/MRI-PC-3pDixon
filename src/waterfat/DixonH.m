% >---------------------------------------------------------------------< %
% Dixon Water-Fat Separation
% Esteban Denecken C.
% >---------------------------------------------------------------------< %
% Function that performs Three-point Dixon Water-Fat Separation
% in an MRI acquisition Haacke 2014 version.
% Input
%    Sn  : Signal acquisition
%    tn  : Echo times [s]
%    typ : Three-point Dixon IOI or OIO
% Output
%    Mw   : Water image
%    Mf   : Fat image
%    Phi  : Estimated Field Map [Hz]
% >---------------------------------------------------------------------< %

function Dx = DixonH(Sn,tn,typ)
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

Dx.Mw = Mw;
Dx.Mf = Mf;
Dx.Phi = Phi;
end


% >---------------------------------------------------------------------< %