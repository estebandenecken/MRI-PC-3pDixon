% >---------------------------------------------------------------------< %
% Dixon Water-Fat Separation
% Esteban Denecken C.
% >---------------------------------------------------------------------< %
% Function that performs Three-point Dixon Water-Fat Separation
% in an MRI acquisition preserving the phase information
% Input
%    Sn  : Signal acquisition
%    tn  : Echo times [s]
%    typ : Three-point Dixon IOI or OIO
% Output
%    Mw   : Water image
%    Mf   : Fat image
%    Phi  : Estimated Field Map [Hz]
% >---------------------------------------------------------------------< %

function Dx = Dixon(Sn,tn,typ)
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

Dx.Mw = Mw;
Dx.Mf = Mf;
Dx.Phi = Phi;
end


% >---------------------------------------------------------------------< %