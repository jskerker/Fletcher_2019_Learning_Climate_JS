% Plot optimal policy states for RCP4.5 and RCP8.5
clear all
close all

% data for both time periods
%[clrmp1]=cbrewer('div', 'RdBu', 100, 'cubic');
time = {'2000-2020', '2021-2040', '2041-2060', '2061-2080', '2081-2100'};

f = figure('Position', [326 23 649 666]);
%RCP4.5 data
% 3% discount
load('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Mombasa_climate/SDP/results_RCP45A_01_Dec_2020_19_31_36.mat')
X_RCP45A = X;
% No Discount
%load('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Mombasa_climate/SDP/results_RCP45A_02_Dec_2020_11_14_55.mat')
% RCP45A
for i=1:5
    subplot(4,5,i)
    imagesc(s_P_abs, s_T_abs,(X(:,:,3,i)));
    %colormap(clrmp1);
    if i==1
        colorbar('Ticks',[1,2,3],...
            'TickLabels',{'Small', 'Large', 'Flex'});
        caxis([1 3]);
        title(['RCP4.5A: ', num2str(time{i})]);
        ylabel('T (^oC)');
    else
        colorbar('Ticks',[0,4],'TickLabels', {'No Exp', 'Expand'});
        title(num2str(time{i}));
    end
    set(gca, 'YDir', 'normal')
    
end

% RCP45B
load('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Mombasa_climate/SDP/results_RCP45B_02_Dec_2020_11_43_47.mat')
X_RCP45B = X;
for i=1:5
    subplot(4,5,i+5)
    imagesc(s_P_abs, s_T_abs,(X(:,:,3,i)));
    %colormap(clrmp1);
    if i==1
        colorbar('Ticks',[1,2,3],...
            'TickLabels',{'Small', 'Large', 'Flex'});
        caxis([1 3]);
        title(['RCP4.5B: ', num2str(time{i})]);
        ylabel('T (^oC)');
    else
        colorbar('Ticks',[0,4],'TickLabels', {'No Exp', 'Expand'});
        title(num2str(time{i}));
    end
    set(gca, 'YDir', 'normal')
end


%RCP8.5 data
% 3% discount
load('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Fletcher_2019_Learning_Climate/SDP/results_RCP85A_01_Dec_2020_17_13_41.mat')
X_RCP85A = X;
% No Discount
%load('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Fletcher_2019_Learning_Climate/SDP/results_RCP85A_02_Dec_2020_10_17_05.mat')
% RCP85A
for i=1:5
    subplot(4,5,i+10)
    imagesc(s_P_abs, s_T_abs,(X(:,:,3,i)));
    %colormap(clrmp1);
    if i==1
        colorbar('Ticks',[1,2,3],...
            'TickLabels',{'Small', 'Large', 'Flex'});
        caxis([1 3]);
        title(['RCP8.5A: ', num2str(time{i})]);
        ylabel('T (^oC)');
    else
        colorbar('Ticks',[0,4],'TickLabels', {'No Exp', 'Expand'});
        title(num2str(time{i}));
    end
    set(gca, 'YDir', 'normal')
    
end

% RCP85B
load('/Users/jenniferskerker/Documents/GradSchool/Research//Project1/Code/Models/Fletcher_2019_Learning_Climate/SDP/results_RCP85B_02_Dec_2020_10_47_54.mat')
X_RCP85B = X;
for i=1:5
    subplot(4,5,i+15)
    imagesc(s_P_abs, s_T_abs,(X(:,:,3,i)));
    %colormap(clrmp1);
    if i==1
        colorbar('Ticks',[1,2,3],...
            'TickLabels',{'Small', 'Large', 'Flex'});
        caxis([1 3]);
        title(['RCP8.5B: ', num2str(time{i})]);
        ylabel('T (^oC)');
    else
        colorbar('Ticks',[0,4],'TickLabels', {'No Exp', 'Expand'});
        title(num2str(time{i}));
    end
    set(gca, 'YDir', 'normal')
    xlabel('P (mm/mo)');
    
end

sgtitle('Optimal Policies from SDP: 3% Discount');

%% 4x4 plot with differences for every combination of datasets
addpath('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Mombasa_climate/SDP/');
addpath('/Users/jenniferskerker/Documents/GradSchool/Research//Project1/Code/Models/Fletcher_2019_Learning_Climate/SDP/');
addpath('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Fletcher_2019_Learning_Climate/Plots/plotting utilities/cbrewer/cbrewer/cbrewer')

[clrmp1]=cbrewer('div', 'RdBu', 100, 'cubic');
data = {'results_RCP45A_01_Dec_2020_19_31_36.mat', 'results_RCP45B_02_Dec_2020_11_43_47.mat', 'results_RCP85A_01_Dec_2020_17_13_41.mat',...
    'results_RCP85B_02_Dec_2020_10_47_54.mat'}
file = {'RCP4.5A', 'RCP4.5B', 'RCP8.5A', 'RCP8.5B'};

f = figure('Position',[225 39 913 647]);
for i=1:4
    load(data{i}, 'X', 's_P_abs', 's_T_abs');
    X_orig = X
    for j=1:4
        subplot(4,4,(j+4*(i-1)))
        load(data{j}, 'X');
        imagesc(s_P_abs, s_T_abs,(X_orig(:,:,3,5)-X(:,:,3,5)));
        colormap(clrmp1);
        colorbar;
        caxis([-2 2]);
        set(gca, 'YDir', 'normal')
        if j==1
            ylabel({num2str(file{i}); ' Temp (^oC)'});
        end
        if i==1
            title(num2str(file{j}));
        end
        if i==4
            xlabel('Precip (mm/mo)');
        end
    end

end

sgtitle('Difference between X and Y (Y - X) Axis Datasets for Time N=5');