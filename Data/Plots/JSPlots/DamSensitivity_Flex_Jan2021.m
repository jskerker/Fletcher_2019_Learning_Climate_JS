%% create barplot of a few different dam sizing options to see how frequently
%% the flex option is chosen.
% load data
close all
clear all

% load RCP4.5 results- No discount
addpath('/Volumes/Ultra Touch/FlexDamProject/Results/RCP85 Results-DamOpt-Jan1');
load('results_RCP85_02_Jan_2021_11_37_16.mat');
action_med_75_115 = action;
storage_med_75_115 = storage;

load('results_RCP85_02_Jan_2021_13_51_05.mat');
action_perc75_90_100 = action;
storage_perc75_90_100 = storage;

load('results_RCP85_02_Jan_2021_14_05_29');
action_perc90_90_115 = action;
storage_perc90_90_115 = storage;

C = {[0.6350, 0.0780, 0.1840], [0.8500, 0.3250, 0.0980], [0.4660, 0.6740, 0.1880],...
    [0, 0.4470, 0.7410], [0.4940, 0.1840, 0.5560]};
scen = {'Median', '75th Prctile', '90th Prctile'};
years = {'2000', '2020', '2040', '2060', '2080'};
cap = {'Small', 'Large', 'Flex', 'Flex-exp'};

% create distribution for 4 capacity states over 5 time periods
s_C_bins = s_C - 0.01;
s_C_bins(5) = 4.01;

% put states into bins
for i=1:5
    C_counts_med(i, :) = histcounts(action_med_75_115(:,i,4), s_C_bins);
    C_counts_perc75(i, :) = histcounts(action_perc75_90_100(:,i,4), s_C_bins);
    C_counts_perc90(i, :) = histcounts(action_perc90_90_115(:,i,4), s_C_bins);
end

% Adjust large dam action
C_counts_med(2:5, 2) = C_counts_med(1,2);
C_counts_perc75(2:5, 2) = C_counts_perc75(1,2);
C_counts_perc90(2:5, 2) = C_counts_perc90(1,2);

exp = [0 0 0];

for j=1:4
    exp(1) = exp(1) + C_counts_med(j+1,4);
    exp(2) = exp(2) + C_counts_perc75(j+1,4);
    exp(3) = exp(3) + C_counts_perc90(j+1,4);
    
    C_counts_med(j+1,3) = C_counts_med(1,3) - exp(1);
    C_counts_perc75(j+1,3) = C_counts_perc75(1,3) - exp(2);
    C_counts_perc90(j+1,3) = C_counts_perc90(1,3) - exp(3);
end 

subplot(3, 1, 1)
bar(C_counts_med);
xticklabels(years);
ylabel('Count');
legend(cap, 'location', 'southwest');
title('Median Minimum, Dam Sizes: 75 MCM, 115 MCM');

subplot(3, 1, 2)
bar(C_counts_perc75);
xticklabels(years);
ylabel('Count');
title('75th Percentile, Dam Sizes: 90 MCM, 100 MCM');

subplot(3, 1, 3)
bar(C_counts_perc90);
xticklabels(years);
xlabel('Year');
ylabel('Count');
title('90th Percentile, Dam Sizes: 90 MCM, 115 MCM');

%% Create 2D shaded plot of % of times different dam sizes chosen

% load data from DamSensitivity_Plots_Dec2020 file
load('RCP85_results_Jan2021.mat');

f = figure('Position', [1300 -150 550 940]);
subplot(3,1,1)
s1 = scatter(comboFlex(:,1), comboFlex(:,2), [], comboFlex(:,9)/10000, 'filled');
c = colorbar;
c.Position = c.Position + [0.1 -0.0 0 0];
colormap(flipud(parula));
xlabel('Small Dam Size (MCM)');
ylabel('Large Dam Size (MCM)');
title('Action: Flex Dam');
text(comboFlex(:,1)+0.25, comboFlex(:,2)+1.2, compose(' %.2g',comboFlex(:,9)/10000))

subplot(3,1,2)
scatter(comboFlex(:,1), comboFlex(:,2), [], comboFlex(:,7)/10000, 'filled');
c = colorbar;
c.Position = c.Position + [0.1 -0.00 0 0];
colormap(flipud(parula));
xlabel('Small Dam Size (MCM)');
ylabel('Large Dam Size (MCM)');
title('Action: Small Dam');
text(comboFlex(:,1)+0.25, comboFlex(:,2)+1.2, compose(' %.2g',comboFlex(:,7)/10000))

subplot(3,1,3)
scatter(comboFlex(:,1), comboFlex(:,2), [], comboFlex(:,8)/10000, 'filled');
c = colorbar;
c.Position = c.Position + [0.1 -0.00 0 0];
colormap(flipud(parula));
xlabel('Small Dam Size (MCM)');
ylabel('Large Dam Size (MCM)');
title('Action: Large Dam');
text(comboFlex(:,1)+0.25, comboFlex(:,2)+1.2, compose(' %.2g',comboFlex(:,8)/10000))
sgtitle('RCP8.5 Proportions of Dam Size Actions');

%% Create scatter plot of dam expansions

% subplot(2,2,1)
% for i = 1:4
%     countExp = 
% scatter(comboFlex(:,1), comboFlex(:,2), if(squeeze(countFlex(:,4,2))/comboFlex(:,9), );
% end 
% end


%% replicate part of figure 5-- barplot for RCP8.5

% put Jan2021 RCP8.5 data into action cell
for i=1:size(actionsFlex,3)
    action{i,1} = squeeze(actionsFlex(:,:,i));
end

decade = {'2001-2020', '2021-2040', '2041-2060', '2061-2080', '2081-2100'};
[R,~] = size(action{1});
labels = {'a)', 'b)', 'c)', 'd)', 'e)', 'f)'};

f = figure;
cmap1 = cbrewer('qual', 'Set2', 8);
cmap2 = cbrewer('div', 'Spectral',11);
cmap = [cmap1(1,:); cmap1(4,:); cmap2(6:end,:)];
cmap = cbrewer('qual', 'Set3', 8);

% histogram w/ stacked bars
x=1:20;
y=(10-floor((x-1)/4))+mod(x-1,4)*10+10;

for k = 1:length(x)
    % frequency of 1st decision
    act1 = action{y(k)}(:,1,end);
    small = sum(act1 == 1);
    large = sum(act1 == 2);
    flex = sum(act1 == 3);
    
    % frequency of exp decision
    actexp = action{y(k)}(:,2:end,end);
    exp1 = sum(actexp(:,1) == 4);
    exp2 = sum(actexp(:,2) == 4);
    exp3 = sum(actexp(:,3) == 4);
    exp4 = sum(actexp(:,4) == 4);
    expnever = R - exp1 - exp2 - exp3 - exp4;
    
    % plot bars
    subplot(5,4,k)
    colormap(cmap)
    b1 = bar([1 1.5],[small large flex; nan(1,3)], .8,'stacked');
    b1(1).FaceColor = cmap1(1,:);
    b1(2).FaceColor = cmap1(2,:);
    b1(3).FaceColor = cmap1(3,:);
    hold on
    b2 = bar([1.5 2],[exp1 exp2 exp3 exp4 expnever; nan(1,5)], .8, 'stacked');
    for i = 1:5
        b2(i).FaceColor = cmap2(i+5,:);
    end
    xlim([0.7 1.8])
    set(gca,'xtick',[1 1.5])
    set(gca,'xticklabel',{'1st', 'exp'})
    if k == 1
        [l1, l2] = legend([b1(2) b1(3) b2], { 'large', 'flex', decade{2:end}, 'never'}, 'FontSize', 6);
        %title('Infra decisions') 
        
%         for i=8:14
%             left = l2(i).Children.Vertices(1,1);
%             width = l2(i).Children.Vertices(3,1) - l2(i).Children.Vertices(2,1);
%             l2(i).Children.Vertices(3:4,1) = left + width/2;
%         end
%         
%         for i=1:7
%             l2(i).Position(1) = l2(i).Position(1) - width/2;
%         end
%         
%         l1.Position(1) = l1.Position(1) - .008;
%         l1.Position(2) = l1.Position(2) - .06;
        
    end
    %text(0.2,1000, labels{k*2-1})
    if mod(k,4) == 1
        ylabel('Frequency');
    end
    title(strcat('[', num2str(storFlex(y(k),1)), ', ', num2str(storFlex(y(k),2)),']'));
end
sgtitle('RCP8.5 Infr Decisions: [Small Dam, Large Dam] (MCM)');

%% Create bar plots for data w/ >= 99% flex dams

%% get data for bar plots
% get counts of each dam size for 10,000 runs
s_C = [1 2 3 4];
s_C_bins = s_C - 0.01;
s_C_bins(5) = 4.01;
for i=1:size(actionsFlex,3)
    flex99(i,1:4) = histcounts(actionsFlex(:,1,i),s_C_bins) 
end

% get flex data/dam sizes w/ flex >=99%
j = 1;
for i=1:size(actionsFlex,3)
    if flex99(i,3)/10000 >= 0.99
        numCount(j) = i;
        j = j+1;
    end
end

%% create bar plots
for i=1:length(numCount)
    action{i,1} = squeeze(actionsFlex(:,:,numCount(i)));
end

decade = {'2001-2020', '2021-2040', '2041-2060', '2061-2080', '2081-2100'};
[R,~] = size(action{1});

f = figure;
cmap1 = cbrewer('qual', 'Set2', 8);
cmap2 = cbrewer('div', 'Spectral',11);
cmap = [cmap1(1,:); cmap1(4,:); cmap2(6:end,:)];
cmap = cbrewer('qual', 'Set3', 8);

for k = 1:length(numCount)
    % frequency of 1st decision
    act1 = action{k}(:,1,end);
    small = sum(act1 == 1);
    large = sum(act1 == 2);
    flex = sum(act1 == 3);
    
    % frequency of exp decision
    actexp = action{k}(:,2:end,end);
    exp1 = sum(actexp(:,1) == 4);
    exp2 = sum(actexp(:,2) == 4);
    exp3 = sum(actexp(:,3) == 4);
    exp4 = sum(actexp(:,4) == 4);
    expnever = R - exp1 - exp2 - exp3 - exp4;
    
    % plot bars
    subplot(4,2,k)
    colormap(cmap)
    b1 = bar([1 1.5],[small large flex; nan(1,3)], .8,'stacked');
    b1(1).FaceColor = cmap1(1,:);
    b1(2).FaceColor = cmap1(2,:);
    b1(3).FaceColor = cmap1(3,:);
    hold on
    b2 = bar([1.5 2],[exp1 exp2 exp3 exp4 expnever; nan(1,5)], .8, 'stacked');
    for i = 1:5
        b2(i).FaceColor = cmap2(i+5,:);
    end
    xlim([0.7 1.8])
    set(gca,'xtick',[1 1.5])
    set(gca,'xticklabel',{'1st', 'exp'})
    if k == 1
        [l1, l2] = legend([b1(2) b1(3) b2], { 'large', 'flex', decade{2:end}, 'never'}, 'FontSize', 6);
        
    end
    if mod(k,4) == 1
        ylabel('Frequency');
    end
    title(strcat('[', num2str(storFlex(numCount(k),1)), ', ', num2str(storFlex(numCount(k),2)),']'));
end
sgtitle('RCP8.5 Infr Decisions when >=99% Flex: [Small Dam, Large Dam] (MCM)');