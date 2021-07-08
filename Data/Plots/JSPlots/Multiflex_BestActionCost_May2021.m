%% Best Value/Action Plots

% load data
% add line to load data here
%addpath('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Operations/Fletcher_2019_Learning_Climate/SDP');
%load('multiflex_sdp_results_50_3exp');

decade = {'2001-2020', '2021-2040', '2041-2060', '2061-2080', '2081-2100'};
decadeline = {'2001-\newline2020', '2021-\newline2040', '2041-\newline2060', '2061-\newline2080', '2081-\newline2100'};


%capState = {'Small', 'Large', 'Flex, Unexpanded', 'Flex, Exp:+10', ...
%    'Flex, Exp:+20', 'Flex, Exp:+30', 'Flex, Exp:+40'};
capState = {'Static', 'Flex, Unexpanded', 'Flex, Exp:+10', ...
    'Flex, Exp:+20', 'Flex, Exp:+30', 'Flex, Exp:+40'};
%%
k = 7;
figure
for j=1:5 % j is for the # of time periods
    for i=1:k % i is for the number of capacity/expansion states
        subplot(5,k,i+(j-1)*k)
        imagesc(X(:,:,i,j));
        colorbar;
        %caxis([0 max(max(max(V(:,:,:,j))))]);
        set(gca, 'YDir', 'normal');
        %ylim([0 57]);
        if j==1
            title(capState{i});
        elseif j==5
            xlabel('P State');
        end
        if i==1
            ylabel(['N=', num2str(j), ', T State']);
        end
    end
    
end
%sgtitle(['Best Value (SDP), Static Dam: ', num2str(optParam.staticCap), ', Flex Dam: ', num2str(optParam.smallCap)]);