% >--------------------------------------------------------------------------< %
% Mean Absolute Error in Images
% Esteban Denecken C.
% >--------------------------------------------------------------------------< %
% Mean Absolute Error in Images computed pixel to pixel
% x0 and x1 : Images or arrays of images
% M : Masks of the regions of interest
% y : MAE values for each image
% >--------------------------------------------------------------------------< %

function y = immae(x0,x1,M)
	[~,~,fr] = size(x0);
    [~,~,mx] = size(M);
	y = zeros(fr,mx);
    for msk = 1:mx
        mi = M(:,:,msk);
        for frame = 1:fr
		    xx0 = x0(:,:,frame) .* mi;
		    xx1 = x1(:,:,frame) .* mi;
    	    y(frame,msk) = sum(abs(xx1(:) - xx0(:))) / sum(mi(:));
        end
    end
end

% >--------------------------------------------------------------------------< %