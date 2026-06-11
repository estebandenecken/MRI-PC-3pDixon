% >--------------------------------------------------------------------------< %
% Statistics ROIs
% Esteban Denecken C.
% >--------------------------------------------------------------------------< %

function ST = statisticsroipx(IM1,IM2,Ms)
    IM1(isnan(IM1)) = 0;
    IM2(isnan(IM2)) = 0;
    x1 = IM1.*Ms; x1 = x1(:); 
    x2 = IM2.*Ms; x2 = x2(:);
    
    % Mean Absolute Error
    ST.MAE = immae(IM1,IM2,Ms);

    % Wilcoxon Signed Rank Test
    [p,h] = signrank(x1,x2);
    ST.Wsrt = [h p];
    % Wilcoxon Rank Sum Test
    [p,h] = ranksum(x1,x2);
    ST.Wrst = [h p];
    
    % Paired Sample T-Test
    [h,p] = ttest(x1,x2);
    ST.Tpst = [h p];
    % Two Sample T-Test
    [h,p] = ttest2(x1,x2);
    ST.Ttst = [h p];
end


% >--------------------------------------------------------------------------< %