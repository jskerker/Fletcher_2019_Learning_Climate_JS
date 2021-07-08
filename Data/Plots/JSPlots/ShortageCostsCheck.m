clear all
close all

%load data
%load('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Fletcher_2019_Learning_Climate/SDP/shortage_costs_28_Feb_2018_17_04_42.mat')
% RCP8.5
%load('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Fletcher_2019_Learning_Climate/SDP/results_RCP85A_01_Dec_2020_17_13_41.mat')
addpath('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Operations/Fletcher_2019_Learning_Climate/SDP')
load('results_12_Feb_2021_10_53_10.mat')
shortageCost_3disc = shortageCost;
%RCP4.5
%load('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Mombasa_climate/SDP/results_RCP45_01_Dec_2020_19_31_36.mat')
%load('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Fletcher_2019_Learning_Climate/SDP/SSD/results_RCP85A_18_Nov_2020_15_53_26.mat', 's_P_abs', 's_T_abs')
time = {'2000-2020', '2021-2040', '2041-2060', '2061-2080', '2081-2100'};

%Plot data
figure('Position', [357 38 648 660]);
for i=1:5
    subplot(5,2,2*i-1)
    imagesc(s_P_abs, s_T_abs, shortageCost_3disc(:,:,1,i))
    set(gca, 'YDir', 'normal')
    colorbar;
    ylabel('T (^oC)');
    if i==1
        title(['Small Dam, 3% Discount: ', num2str(time{i})]);
    else
        title(time{i});
    end
    if i==5
        xlabel('P (mm/mo)');
    end
    %caxis([0 2*10^10])
    
    load('results_RCP85B_06_Dec_2020_11_54_46.mat', 'shortageCost')
    subplot(5,2,2*i)
    imagesc(s_P_abs, s_T_abs, shortageCost(:,:,1,i))
    set(gca, 'YDir', 'normal')
    colorbar;
    ylabel('T (^oC)');
    if i==1
        title(['Small Dam, No Discount: ', num2str(time{i})]);
    else
        title(time{i});
    end
    if i==5
        xlabel('P (mm/mo)');
    end
    %caxis([0 2*10^10])
    
end

sgtitle('Dam Shortage Cost Matrix');