%% Regret plot precip: Fig 6 in paper- dam and shortage costs with Precip
% looking at 3% and no discount rate for RCP4.5 and RCP8.5
clear all;
close all;

addpath('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Fletcher_2019_Learning_Climate/SDP');
addpath('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Fletcher_2019_Learning_Climate/Plots/JSPlots');
f = figure('Position', [14 122 830 548]);

%RCP8.5, 3% Discount
load('results_RCP85A_01_Dec_2020_17_13_41.mat')
shortageCostTime_85_3 = shortageCostTime;
% Regret for last time period
bestOption = 0;

P_regret = [68 73 78 83 88];
damCost = squeeze(sum(damCostTime(:,:,1:3), 2));
shortCost = squeeze(sum(shortageCostTime(:,:,1:3), 2));
totalCost = squeeze(sum(totalCostTime(:,:,1:3), 2));
meanCostPnow = zeros(length(P_regret),3);
grp = {68, 73, 78, 83, 88};
for i = 1:length(P_regret)
    % Find simulaitons with this level of precip
    ind_P = P_state(:,end) == P_regret(i);
    % Get average cost of each infra option in that P level
    damCostPnow = damCost(ind_P,:);
    damMeanCostPnow(i,:) = mean(damCostPnow,1);
    
    shortageCostPnow = shortCost(ind_P,:);
    shortMeanCostPnow(i,:) = mean(shortageCostPnow,1);
    
    totalCostPnow = totalCost(ind_P,:);
    meanCostPnow(i,:) = mean(totalCostPnow,1);
end

combined(:,:,1) = damMeanCostPnow/1E6;
combined(:,:,2) = shortMeanCostPnow/1E6;

bestInfraCost = min(meanCostPnow,[],2);
regret = meanCostPnow - repmat(bestInfraCost, 1,3);

subplot(2,2,2)
font_size = 16;
h = plotBarStackGroups(combined, grp);
hold on

 colors = {[250,128,114]/255,[154,205,50]/255,[135,206,235]/255,[178,34,34]/255,...
     [0,0.5,0], [0,0,0.5]}'; %or define your own color order; 1 for each m segments
set(h,{'FaceColor'},colors)

yl = ylabel('M$')
yl.Position = yl.Position - [ .2 0 0];
xl = xlabel('P in 2090 [mm/month]')
%xl.Position = xl.Position - [ 0 4 0];
ylim([0 150]);
sgtitle('Cost for Infrastructure Alternatives by 2090 Precip: RCP8.5, 3% Discount')
title('RCP8.5, 3% Discount')

% % FONT
ax = gca;
ax.FontSize = font_size;
% allaxes = findall(f, 'type', 'axes');
% set(allaxes,'FontSize', font_size)
% set(findall(allaxes,'type','text'),'FontSize', font_size)
%font_size = 16;

%RCP4.5, 3% Discount
addpath('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Mombasa_climate/SDP');
load('results_RCP45A_01_Dec_2020_19_31_36.mat');
shortageCostTime_45_3 = shortageCostTime;
% Regret for last time period
bestOption = 0;

P_regret = [68 73 78 83 88];
damCost = squeeze(sum(damCostTime(:,:,1:3), 2));
shortCost = squeeze(sum(shortageCostTime(:,:,1:3), 2));
totalCost = squeeze(sum(totalCostTime(:,:,1:3), 2));
meanCostPnow = zeros(length(P_regret),3);
grp = {68, 73, 78, 83, 88};
for i = 1:length(P_regret)
    % Find simulaitons with this level of precip
    ind_P = P_state(:,end) == P_regret(i);
    % Get average cost of each infra option in that P level
    damCostPnow = damCost(ind_P,:);
    damMeanCostPnow(i,:) = mean(damCostPnow,1);
    
    shortageCostPnow = shortCost(ind_P,:);
    shortMeanCostPnow(i,:) = mean(shortageCostPnow,1);
    
    totalCostPnow = totalCost(ind_P,:);
    meanCostPnow(i,:) = mean(totalCostPnow,1);
end

combined(:,:,1) = damMeanCostPnow/1E6;
combined(:,:,2) = shortMeanCostPnow/1E6;

bestInfraCost = min(meanCostPnow,[],2);
regret = meanCostPnow - repmat(bestInfraCost, 1,3);

subplot(2,2,1)
%font_size = 12;
h = plotBarStackGroups(combined, grp);
hold on

set(h,{'FaceColor'},colors)
yl = ylabel('M$')
yl.Position = yl.Position - [ .2 0 0];
xl = xlabel('P in 2090 [mm/month]')
%xl.Position = xl.Position - [ 0 4 0];
ylim([0 150]);
title('RCP4.5, 3% Discount')

% FONT
ax = gca;
ax.FontSize = font_size;
% allaxes = findall(f, 'type', 'axes');
% set(allaxes,'FontSize', font_size)
% set(findall(allaxes,'type','text'),'FontSize', font_size)
%printsetup(f, 7, 5, 12, 1, 300, 1, 1, 'regret' )

%RCP4.5, no discount
load('results_RCP45A_02_Dec_2020_11_14_55.mat');
shortageCostTime_45_0 = shortageCostTime;
% Regret for last time period
bestOption = 0;

P_regret = [68 73 78 83 88];
damCost = squeeze(sum(damCostTime(:,:,1:3), 2));
shortCost = squeeze(sum(shortageCostTime(:,:,1:3), 2));
totalCost = squeeze(sum(totalCostTime(:,:,1:3), 2));
meanCostPnow = zeros(length(P_regret),3);
grp = {68, 73, 78, 83, 88};
for i = 1:length(P_regret)
    % Find simulaitons with this level of precip
    ind_P = P_state(:,end) == P_regret(i);
    % Get average cost of each infra option in that P level
    damCostPnow = damCost(ind_P,:);
    damMeanCostPnow(i,:) = mean(damCostPnow,1);
    
    shortageCostPnow = shortCost(ind_P,:);
    shortMeanCostPnow(i,:) = mean(shortageCostPnow,1);
    
    totalCostPnow = totalCost(ind_P,:);
    meanCostPnow(i,:) = mean(totalCostPnow,1);
end

combined(:,:,1) = damMeanCostPnow/1E6;
combined(:,:,2) = shortMeanCostPnow/1E6;

bestInfraCost = min(meanCostPnow,[],2);
regret = meanCostPnow - repmat(bestInfraCost, 1,3);

subplot(2,2,3)
h = plotBarStackGroups(combined, grp);
hold on

set(h,{'FaceColor'},colors)
yl = ylabel('M$')
yl.Position = yl.Position - [ .2 0 0];
xl = xlabel('P in 2090 [mm/month]')
%xl.Position = xl.Position - [ 0 4 0];
ylim([0 300]);
title('RCP4.5, No Discount')

% FONT
ax = gca;
ax.FontSize = font_size;
% allaxes = findall(f, 'type', 'axes');
% set(allaxes,'FontSize', font_size)
% set(findall(allaxes,'type','text'),'FontSize', font_size)
%printsetup(f, 7, 5, 12, 1, 300, 1, 1, 'regret' )

%RCP8.5, No discount
load('results_RCP85B_NoDisc_06_Dec_2020_12_09_34.mat');
shortageCostTime_85_0 = shortageCostTime;
% Regret for last time period
bestOption = 0;

P_regret = [68 73 78 83 88];
damCost = squeeze(sum(damCostTime(:,:,1:3), 2));
shortCost = squeeze(sum(shortageCostTime(:,:,1:3), 2));
totalCost = squeeze(sum(totalCostTime(:,:,1:3), 2));
meanCostPnow = zeros(length(P_regret),3);
grp = {68, 73, 78, 83, 88};
for i = 1:length(P_regret)
    % Find simulaitons with this level of precip
    ind_P = P_state(:,end) == P_regret(i);
    % Get average cost of each infra option in that P level
    damCostPnow = damCost(ind_P,:);
    damMeanCostPnow(i,:) = mean(damCostPnow,1);
    
    shortageCostPnow = shortCost(ind_P,:);
    shortMeanCostPnow(i,:) = mean(shortageCostPnow,1);
    
    totalCostPnow = totalCost(ind_P,:);
    meanCostPnow(i,:) = mean(totalCostPnow,1);
end

combined(:,:,1) = damMeanCostPnow/1E6;
combined(:,:,2) = shortMeanCostPnow/1E6;

bestInfraCost = min(meanCostPnow,[],2);
regret = meanCostPnow - repmat(bestInfraCost, 1,3);

subplot(2,2,4)
h = plotBarStackGroups(combined, grp);
hold on

set(h,{'FaceColor'},colors)
yl = ylabel('M$')
yl.Position = yl.Position - [ .2 0 0];
xl = xlabel('P in 2090 [mm/month]')
%xl.Position = xl.Position - [ 0 4 0];
ylim([0 300]);
title('RCP8.5, No Discount')

% % legend
l = legend('Flexible Dam', 'Flex Shortage', 'Large Dam', ...
      'Large Shortage', 'Small Dam', 'Small Shortage')
l.FontSize = 14;
legend('boxoff')

% FONT
ax = gca;
ax.FontSize = font_size;
% allaxes = findall(f, 'type', 'axes');
% set(allaxes,'FontSize', font_size)
% set(findall(allaxes,'type','text'),'FontSize', font_size)
%printsetup(f, 7, 5, 12, 1, 300, 1, 1, 'regret' )

%% look at actions chosen for RCP4.5 and RCP8.5 w/ 3% and 0% discount
% need to load files (above) and save actions w/ diff names
% create distribution for 4 capacity states over 5 time periods
s_C_bins = s_C - 0.01;
s_C_bins(5) = 4.01;
years = {'2000', '2020', '2040', '2060', '2080'};
cap = {'Small', 'Large', 'Flex', 'Flex-exp'};

for i=1:5
    C_counts_RCP45A(i, :) = histcounts(action_RCP45A(:,i,4), s_C_bins);
    C_counts_RCP45B(i, :) = histcounts(action_RCP45_nodisc(:,i,4), s_C_bins);
    C_counts_RCP85A(i, :) = histcounts(action_RCP85A(:,i,4), s_C_bins);
    C_counts_RCP85B(i, :) = histcounts(action_RCP85_nodisc(:,i,4), s_C_bins);
end

subplot(2, 2, 1)
bar(C_counts_RCP45A);
xticklabels(years);
ylabel('Count');
legend(cap, 'location', 'southwest');
title('RCP4.5 3% Discount');

subplot(2, 2, 2)
bar(C_counts_RCP45B);
xticklabels(years);
title('RCP4.5 No Discount');

subplot(2, 2, 3)
bar(C_counts_RCP85A);
xticklabels(years);
xlabel('Year');
ylabel('Count');
title('RCP8.5 3% Discount');

subplot(2, 2, 4)
bar(C_counts_RCP85B);
xticklabels(years);
xlabel('Year');
title('RCP8.5 No Discount');

sgtitle('Capacity States in Each Time Period');

%% if time add supplementary figure of shortage costs over time w/ and w/o discounting
years = {'1990', '2010', '2030', '2050', '2070'};
figure;
subplot(2,1,1)
pos_1 = 1.2:1:5.2;
b1 = boxplot(shortageCostTime_85_3(:,:,1)/1000000, 'colors', 'r', 'positions', pos_1, 'width',...
    0.15, 'symbol', '')
hold on

pos_2 = 1.4:1:5.4;
b2 = boxplot(shortageCostTime_85_0(:,:,1)/1000000, 'colors', 'b', 'positions', pos_2, 'width', 0.15,...
    'symbol', '')
set(gca, 'XTickLabel', time)
ax = gca;
ax.FontSize = 16;
xlabel('Year')
ylabel('Cost ($M)');
legend([b1(1,1), b2(1,1)], {'3% Discount', 'No Discount'}, 'Location', 'northeast')
title('RCP8.5 Shortage Costs for the Small Dam');

subplot(2,1,2)
pos_1 = 1.2:1:5.2;
b1 = boxplot(shortageCostTime_45_3(:,:,1)/1000000, 'colors', 'r', 'positions', pos_1, 'width',...
    0.15, 'symbol', '')
hold on

pos_2 = 1.4:1:5.4;
b2 = boxplot(shortageCostTime_45_0(:,:,1)/1000000, 'colors', 'b', 'positions', pos_2, 'width', 0.15,...
    'symbol', '')
set(gca, 'XTickLabel', time)
ax = gca;
ax.FontSize = 16;
xlabel('Year')
ylabel('Cost ($M)');
title('RCP4.5 Shortage Costs for the Small Dam');