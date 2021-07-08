% load data
close all
clear all

% load RCP4.5 results- No discount
addpath('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Mombasa_climate/SDP/');
load('results_RCP45A_01_Dec_2020_19_31_36.mat'); % 3% discount
C_state_RCP45A = C_state;
%load('results_RCP45B_02_Dec_2020_11_43_47.mat');
load('results_RCP45A_02_Dec_2020_11_14_55.mat'); % No discount
C_state_RCP45B = C_state;

% load RCP8.5 results- No discount
addpath('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Fletcher_2019_Learning_Climate/SDP');
load('results_RCP85A_01_Dec_2020_17_13_41.mat'); % 3% discount
C_state_RCP85A = C_state;
%load('results_RCP85B_06_Dec_2020_11_54_46.mat');
load('results_RCP85B_NoDisc_06_Dec_2020_12_09_34.mat');
C_state_RCP85B = C_state;

C = {[0.6350, 0.0780, 0.1840], [0.8500, 0.3250, 0.0980], [0.4660, 0.6740, 0.1880],...
    [0, 0.4470, 0.7410], [0.4940, 0.1840, 0.5560]};
scen = {'RCP45A', 'RCP45B', 'RCP85A', 'RCP85B'};
years = {'2000', '2020', '2040', '2060', '2080'};
cap = {'Small', 'Large', 'Flex', 'Flex-exp'};

% create distribution for 4 capacity states over 5 time periods
s_C_bins = s_C - 0.01;
s_C_bins(5) = 4.01;

%% figure comparing capacity states in each time period

for i=1:5
    C_counts_RCP45A(i, :) = histcounts(C_state_RCP45A(:,i,4), s_C_bins);
    C_counts_RCP45B(i, :) = histcounts(C_state_RCP45B(:,i,4), s_C_bins);
    C_counts_RCP85A(i, :) = histcounts(C_state_RCP85A(:,i,4), s_C_bins);
    C_counts_RCP85B(i, :) = histcounts(C_state_RCP85B(:,i,4), s_C_bins);
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

%% Regret plot precip: Fig 6 in paper

%load('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Fletcher_2019_Learning_Climate/SDP/results_RCP85_01_Dec_2020_17_13_41.mat')
load('results_RCP85B_06_Dec_2020_11_54_46.mat')
% Regret for last time period
bestOption = 0;

P_regret = [68 73 78 83 88];
damCost = squeeze(sum(damCostTime(:,:,1:3), 2));
shortCost = squeeze(sum(shortageCostTime(:,:,1:3), 2));
totalCost = squeeze(sum(totalCostTime(:,:,1:3), 2));
meanCostPnow = zeros(length(P_regret),3);
for i = 1:length(P_regret)
    % Find simulaitons with this level of precip
    ind_P = P_state(:,end) == P_regret(i);
    % Get average cost of each infra option in that P level
    totalCostPnow = totalCost(ind_P,:);
    meanCostPnow(i,:) = mean(totalCostPnow,1);
end

bestInfraCost = min(meanCostPnow,[],2);
regret = meanCostPnow - repmat(bestInfraCost, 1,3);

f = figure;
font_size = 12;
bar([meanCostPnow; regret]/1E6)
hold on
line([5.5 5.5], [0 150],'Color', 'k')
xlim([.5 10.5])
xticklabels({'68', '73','78', '83', '88', '68', '73','78', '83', '88'})
yl = ylabel('M$')
yl.Position = yl.Position - [ .2 0 0];
xl = xlabel('P in 2090 [mm/month]')
xl.Position = xl.Position - [ 0 4 0];
title('Cost and Regret for Infrastructure Alternatives by 2090 P: RCP8.5')
l = legend('Flexible', 'Large', 'Small')
%l.Position = l.Position + [-.1 -.1 0 0.1]
legend('boxoff')
% FONT
allaxes = findall(f, 'type', 'axes');
set(allaxes,'FontSize', font_size)
set(findall(allaxes,'type','text'),'FontSize', font_size)
%printsetup(f, 7, 5, 12, 1, 300, 1, 1, 'regret' )


%% %% Regret plot precip: Fig 6 in paper- dam and shortage costs with Precip
% Run this twice- first for RCP4.5 (subplot 1) and then RCP8.5 (subplot 2)
f = figure('Position', [14 122 830 548]);

%RCP4.5, 3% Discount
load('results_RCP45B_02_Dec_2020_11_43_47.mat')
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
font_size = 12;
h = plotBarStackGroups(combined, grp);
hold on

 colors = {[250,128,114]/255,[154,205,50]/255,[135,206,235]/255,[178,34,34]/255,...
     [0,0.5,0], [0,0,0.5]}'; %or define your own color order; 1 for each m segments
set(h,{'FaceColor'},colors)

yl = ylabel('M$')
yl.Position = yl.Position - [ .2 0 0];
xl = xlabel('P in 2090 [mm/month]')
xl.Position = xl.Position - [ 0 4 0];
ylim([0 150]);
sgtitle('Cost for Infrastructure Alternatives by 2090 Precip')
title('RCP4.5, 3% Discount')

% % FONT
allaxes = findall(f, 'type', 'axes');
set(allaxes,'FontSize', font_size)
set(findall(allaxes,'type','text'),'FontSize', font_size)
% %printsetup(f, 7, 5, 12, 1, 300, 1, 1, 'regret' )

%RCP8.5, 3% Discount
load('results_RCP85B_06_Dec_2020_11_54_46.mat');
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
font_size = 12;
h = plotBarStackGroups(combined, grp);
hold on

set(h,{'FaceColor'},colors)
yl = ylabel('M$')
yl.Position = yl.Position - [ .2 0 0];
xl = xlabel('P in 2090 [mm/month]')
xl.Position = xl.Position - [ 0 4 0];
ylim([0 150]);
title('RCP8.5, 3% Discount')

% FONT
allaxes = findall(f, 'type', 'axes');
set(allaxes,'FontSize', font_size)
set(findall(allaxes,'type','text'),'FontSize', font_size)
%printsetup(f, 7, 5, 12, 1, 300, 1, 1, 'regret' )

%RCP4.5, No Discount
load('results_RCP45A_02_Dec_2020_11_14_55.mat');
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
font_size = 12;
h = plotBarStackGroups(combined, grp);
hold on

set(h,{'FaceColor'},colors)
yl = ylabel('M$')
yl.Position = yl.Position - [ .2 0 0];
xl = xlabel('P in 2090 [mm/month]')
xl.Position = xl.Position - [ 0 4 0];
ylim([0 300]);
title('RCP4.5, No Discount')

% FONT
allaxes = findall(f, 'type', 'axes');
set(allaxes,'FontSize', font_size)
set(findall(allaxes,'type','text'),'FontSize', font_size)
%printsetup(f, 7, 5, 12, 1, 300, 1, 1, 'regret' )

%RCP8.5, No Discount
load('results_RCP85B_NoDisc_06_Dec_2020_12_09_34.mat');
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
font_size = 12;
h = plotBarStackGroups(combined, grp);
hold on

set(h,{'FaceColor'},colors)
yl = ylabel('M$')
yl.Position = yl.Position - [ .2 0 0];
xl = xlabel('P in 2090 [mm/month]')
xl.Position = xl.Position - [ 0 4 0];
ylim([0 300]);
title('RCP8.5, No Discount')

% % legend
l = legend('Flexible Dam', 'Flex Shortage', 'Large Dam', ...
      'Large Shortage', 'Small Dam', 'Small Shortage')
% %l.Position = l.Position + [-.1 -.1 0 0.1]
legend('boxoff')

% FONT
allaxes = findall(f, 'type', 'axes');
set(allaxes,'FontSize', font_size)
set(findall(allaxes,'type','text'),'FontSize', font_size)
%printsetup(f, 7, 5, 12, 1, 300, 1, 1, 'regret' )

%% %% Regret plot for Temperature

% subplot for RCP4.5
% 3% Discount
load('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Mombasa_climate/SDP/results_RCP45A_30_Nov_2020_09_55_29.mat')
%No discount
load('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Mombasa_climate/SDP/results_RCP45A_18_Nov_2020_15_09_55.mat')
% Regret for last time period
f = figure;
subplot(2,1,1)
bestOption = 0;

T_regret = [27.85 27.95 28.05 28.15];
totalCost = squeeze(sum(totalCostTime(:,:,1:3), 2));
meanCostTnow = zeros(length(T_regret),3);
for i = 1:length(T_regret)
    % Find simulaitons with this level of precip
    ind_T = T_state(:,end) == T_regret(i);
    % Get average cost of each infra option in that P level
    totalCostTnow = totalCost(ind_T,:);
    meanCostTnow(i,:) = mean(totalCostTnow,1);
end

bestInfraCost = min(meanCostTnow,[],2);
regret = meanCostTnow - repmat(bestInfraCost, 1,3);

font_size = 12;
bar([meanCostTnow; regret]/1E6)
hold on
line([4.5 4.5], [0 3000],'Color', 'k')
xlim([.5 8.5])
xticklabels({'27.85', '27.95', '28.05', '28.15', '27.85', '27.95', '28.05', '28.15'})
yl = ylabel('M$')
yl.Position = yl.Position - [ .2 0 0];
xl = xlabel('T in 2090 [^oC]')
xl.Position = xl.Position - [ 0 4 0];
title('RCP4.5')
sgtitle('Cost and Regret for Infrastructure Alternatives by 2090 T w/ No Discount')
l = legend('Flexible', 'Large', 'Small')
%l.Position = l.Position + [-.1 -.1 0 0.1]
legend('boxoff')
% FONT
allaxes = findall(f, 'type', 'axes');
set(allaxes,'FontSize', font_size)
set(findall(allaxes,'type','text'),'FontSize', font_size)
%printsetup(f, 7, 5, 12, 1, 300, 1, 1, 'regret' )

% subplot for RCP8.5
% 3% Discount
load('results_RCP45A_01_Dec_2020_19_31_36.mat')
%No Discount
%load('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Fletcher_2019_Learning_Climate/SDP/results_RCP85A_30_Nov_2020_10_36_21.mat')
% Regret for last time period
subplot(2,1,2)
bestOption = 0;

T_regret = [28.7 28.8 28.9 29.0];
totalCost = squeeze(sum(totalCostTime(:,:,1:3), 2));
meanCostTnow = zeros(length(T_regret),3);
for i = 1:length(T_regret)
    % Find simulaitons with this level of precip
    ind_T = T_state(:,end) == T_regret(i);
    % Get average cost of each infra option in that P level
    totalCostTnow = totalCost(ind_T,:);
    meanCostTnow(i,:) = mean(totalCostTnow,1);
end

bestInfraCost = min(meanCostTnow,[],2);
regret = meanCostTnow - repmat(bestInfraCost, 1,3);

%f = figure;
font_size = 12;
bar([meanCostTnow; regret]/1E6)
hold on
line([4.5 4.5], [0 3000],'Color', 'k')
xlim([.5 8.5])
xticklabels({'28.7', '28.8', '28.9', '29.0', '28.7', '28.8', '28.9', '29.0'})
yl = ylabel('M$')
yl.Position = yl.Position - [ .2 0 0];
xl = xlabel('T in 2090 [^oC]')
xl.Position = xl.Position - [ 0 4 0];
title('RCP8.5')
l = legend('Flexible', 'Large', 'Small')
%l.Position = l.Position + [-.1 -.1 0 0.1]
legend('boxoff')
% FONT
allaxes = findall(f, 'type', 'axes');
set(allaxes,'FontSize', font_size)
set(findall(allaxes,'type','text'),'FontSize', font_size)
%printsetup(f, 7, 5, 12, 1, 300, 1, 1, 'regret' )

%% 3D scatter plot
time = {'2000-2020', '2021-2040', '2041-2060', '2061-2080', '2081-2100'};
%RCP4.5 plot
%3% discount
load('results_RCP45A_01_Dec_2020_19_31_36.mat')
%No discount

for i=1:5
    combo(:,:,i) = [T_state(:,i), P_state(:,i), C_state(:,i,4)];
end

figure('Position', [140 136 977 535]);
subplot(1,2,1)
%subplot(1,2,1)
for i=1:5
    scatter3(combo(:,1,i), combo(:,2,i), combo(:,3,i))
    hold on
end
l = legend(time);
l.Position = l.Position + [0 0 0.1 -0.08];
legend('boxoff')
xl = xlabel('Temp (^oC)');
yl = ylabel('Precip (mm/month)');
zl = zlabel('Dam Alternative');
zl.Position = zl.Position + [0.3 -3 0]
title('RCP4.5: 3% Discount');
zticks(1:1:4);
zticklabels({'Small', 'Large', 'Flex', 'Flex Expanded'});

% Use align functions to rotate labels
h = rotate3d;
set(h, 'ActionPreCallback', 'set(gcf,''windowbuttonmotionfcn'',@align_axislabel)')
set(h, 'ActionPostCallback', 'set(gcf,''windowbuttonmotionfcn'','''')')
set(gcf, 'ResizeFcn', @align_axislabel)
align_axislabel([], gca)
axislabel_translation_slider;
zl.Position = zl.Position + [21 0 0]
yl.Position = yl.Position + [0 2 0] %Use value of 1 for 3% discount
xl.Position = xl.Position + [0 3 0]

%% 

%RCP8.5 plot
% 3% Discount
%load('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Fletcher_2019_Learning_Climate/SDP/results_RCP85B_18_Nov_2020_16_12_52.mat')
%No Discount
%load('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Fletcher_2019_Learning_Climate/SDP/results_RCP85A_30_Nov_2020_10_36_21.mat')
load('results_RCP45A_02_Dec_2020_11_14_55.mat');
for i=1:5
    combo(:,:,i) = [T_state(:,i), P_state(:,i), C_state(:,i,4)];
end

subplot(1,2,2)
for i=1:5
    scatter3(combo(:,1,i), combo(:,2,i), combo(:,3,i))
    hold on
end

xl = xlabel('Temp (^oC)');
yl = ylabel('Precip (mm/month)');
zl = zlabel('Dam Alternative');
zl.Position = zl.Position + [0.3 -3 0]
title('RCP4.5: No Discount');
zticks(1:1:4);
zticklabels({'Small', 'Large', 'Flex', 'Flex Expanded'});
sgtitle('Temp, Precip, and Cap States');

% Use align functions to rotate labels
h = rotate3d;
set(h, 'ActionPreCallback', 'set(gcf,''windowbuttonmotionfcn'',@align_axislabel)')
set(h, 'ActionPostCallback', 'set(gcf,''windowbuttonmotionfcn'','''')')
set(gcf, 'ResizeFcn', @align_axislabel)
align_axislabel([], gca)
axislabel_translation_slider;
zl.Position = zl.Position + [21 0 0]
xl.Position = xl.Position + [0 1.3 0]
yl.Position = yl.Position + [0 2 0]