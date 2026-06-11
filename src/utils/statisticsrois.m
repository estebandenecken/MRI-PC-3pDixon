% >--------------------------------------------------------------------------< %
% Statistics ROIs
% Esteban Denecken C.
% >--------------------------------------------------------------------------< %
% Statistics of image IM in the ROIs defined by the mask Ms
% >--------------------------------------------------------------------------< %

function ST = statisticsrois(IM,Ms)
    n = size(Ms,3);
    MS_Avg = zeros(n,1);
    MS_Med = zeros(n,1);
    MS_Std = zeros(n,1);
	MS_Max = zeros(n,1);
    MS_Min = zeros(n,1);
    for roi = 1:n
        m = Ms(:,:,roi);
		r = IM(:);
		r = r(m(:) == 1);
        MS_Avg(roi) = mean(r);
        MS_Med(roi) = median(r);
        MS_Std(roi) = std(r);
		MS_Max(roi) = max(r);
		MS_Min(roi) = min(r);
    end
    ST.Avg = MS_Avg;
    ST.Med = MS_Med;
    ST.Std = MS_Std;
	ST.Max = MS_Max;
	ST.Min = MS_Min;
end


% >--------------------------------------------------------------------------< %