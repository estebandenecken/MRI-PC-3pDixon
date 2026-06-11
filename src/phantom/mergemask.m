% >---------------------------------------------------------------------< %
% Merge Masks
% Esteban Denecken C.
% >---------------------------------------------------------------------< %
% Function that merge a set of n masks in one image
% Input
%    Ms  : Set of n masks arranged in a 3D tensor
%    pov : Values between 0 and 1 to weight the different masks
% Output
%    MMs : Image created from the masks and the pov values
% >---------------------------------------------------------------------< %

function MMs = mergemask(Ms,pov)
MMs = zeros(size(Ms,1));
n = size(Ms,3);
if n == size(pov,1)
    for i = 1:n
        MMs = MMs + Ms(:,:,i)*pov(i);
    end
else
    disp('Error MergeMask: Diemensions do not match');
end
end


% >---------------------------------------------------------------------< %
