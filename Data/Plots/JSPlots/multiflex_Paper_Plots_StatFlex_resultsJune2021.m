%% Multiflex plots- loop for different scenarios
clear all; close all;

N=5;
addpath('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Fletcher_2019_Learning_Climate/Plots/plotting utilities/cbrewer/cbrewer/cbrewer');
[clrmp1]=cbrewer('seq', 'Reds', N);
[clrmp2]=cbrewer('seq', 'Blues', N);
[clrmp3]=cbrewer('seq', 'Greens', N);
[clrmp4]=cbrewer('seq', 'Purples', N);
cmap1 = cbrewer('qual', 'Set2', 8);
cmap2 = cbrewer('div', 'Spectral',11);
cmap = [cmap1(1,:); cmap1(4,:); cmap2(6:end,:)];
cmap = cbrewer('qual', 'Set3', 8);

decade = {'2001-2020', '2021-2040', '2041-2060', '2061-2080', '2081-2100'};
decade_short = {'2001-20', '21-40', '41-60', '61-80', '81-2100'};
decadeline = {'2001-\newline2020', '2021-\newline2040', '2041-\newline2060', '2061-\newline2080', '2081-\newline2100'};

scenarios = {'Dry, High Learning', 'Mod, High Learning', 'Wet, High Learning',...
    'Dry, Medium Learning', 'Mod, Medium Learning', 'Wet, Medium Learning',...
    'Dry, Low Learning', 'Mod, Low Learning', 'Wet, Low Learning'};

scenarios_shortened = {'Dry, \newlineHigh', 'Mod, \newlineHigh', 'Wet, \newlineHigh', ...
    'Dry, \newlineMed', 'Mod, \newlineMed', 'Wet, \newlineMed', ...
    'Dry, \newlineLow', 'Mod, \newlineLow', 'Wet, \newlineLow'};

scenarios_subset = {'Dry, High Learning', 'Wet, High Learning',...
    'Dry, Low Learning', 'Wet, Low Learning'};

files = {'BestFlexStatic_T_Temp_Precip_dry1', 'BestFlexStatic_T_Temp_Precip_mod1', ...
    'BestFlexStatic_T_Temp_Precip_wet1', 'BestFlexStatic_T_Temp_Precip_dry2',...
    'BestFlexStatic_T_Temp_Precip_mod2', 'BestFlexStatic_T_Temp_Precip_wet2', ...
    'BestFlexStatic_T_Temp_Precip_dry4', 'BestFlexStatic_T_Temp_Precip_mod4', ...
    'BestFlexStatic_T_Temp_Precip_wet4'};

files_subset = {'BestFlexStatic_T_Temp_Precip_dry1', 'BestFlexStatic_T_Temp_Precip_wet1', ...
    'BestFlexStatic_T_Temp_Precip_dry4', 'BestFlexStatic_T_Temp_Precip_wet4'};

files_cost = {'BestFlexStatic_T_Temp_Precip_dry21pf_0d', 'BestFlexStatic_T_Temp_Precip_dry21pf_3d',...
    'BestFlexStatic_T_Temp_Precip_dry21pf_6d', 'BestFlexStatic_T_Temp_Precip_dry22pf_0d',...
    'BestFlexStatic_T_Temp_Precip_dry22pf_3d', 'BestFlexStatic_T_Temp_Precip_dry22pf_6d'};

files_cost_added28June = {'BestFlexStatic_T_Temp_Precip_dry21pf_1d', 'BestFlexStatic_T_Temp_Precip_dry21pf_2d'};

scenarios_cost = {'10% Flex Exp, 0% Discount', '10% Flex Exp, 3% Discount', '10% Flex Exp, 6% Discount',...
    '20% Flex Exp, 0% Discount', '20% Flex Exp, 3% Discount', '20% Flex Exp, 6% Discount'};

order = [1 4 7 2 5 8 3 6 9];
%% Figure 8 for subset of scenarios
% to change for all scenarios run from b=1:9, use files and scenarios vs
% subsets and change from subplot(2,2,..) to (subplot(3,3,...)
figure('Position', [114 106 1135 590]);
for b=1:9
    load(files{b});
    s_C_bins = s_C - 0.01;
    s_C_bins(end+1) = s_C(end)+0.01;

    clear actCounts;
    clear actCounts_test;
    for k=1:5
        actCounts(k,:) = histcounts(action(:,k,3), s_C_bins);
        actCounts_test(k,:) = histcounts(action(:,k,3), s_C_bins);
    end

    for j=2:5
        actCounts(j,1) = actCounts(1,1);
        actCounts(j,2) = actCounts(j-1,2) - sum(actCounts(j,3:end));
        actCounts(j,3:end) = actCounts(j-1,3:end) + actCounts(j,3:end);
    end

    subplot(3,3,b)
    colormap(cmap);
    b1 = bar(actCounts, 'stacked');
    for i=1:length(b1)
        b1(i).FaceColor = cmap1(i,:);
    end
    xticklabels(decade);
    xlabel('Time Period');
    ylabel('Frequency');
    capState = {'Static', 'Flex, Unexpanded', 'Flex, Exp:+10', ...
        'Flex, Exp:+20', 'Flex, Exp:+30', 'Flex, Exp:+40', 'Flex, Exp:+50'};
    legend(capState, 'location', 'southwest', 'FontSize', 7);
    title([scenarios_cost{b}, ':\newlineStatic Dam = ', num2str(bestAct_static(5)), ...
        ', Flex Dam = ', num2str(bestAct_flex(2))]);
end
sgtitle('Dam Expansion Decisions over Time')
%sgtitle('Dry, Medium Learning w/ 5% Upfront Cap Cost Increase for Flex Dam: Dam Expansion Decisions over Time')
%% Figure 5 barplot portion

for b=1:9
    load(files{order(b)});
    %load(files{b});
    % frequency of exp decision
    actexp(:,:,b) = action(:,2:end,end); % action{k}(:,2:end,end);
    exp1(b,:) = sum(actexp(:,1,b) == s_C(3:end),'all');
    exp2(b,:) = sum(actexp(:,2,b) == s_C(3:end),'all');
    exp3(b,:) = sum(actexp(:,3,b) == s_C(3:end),'all');
    exp4(b,:) = sum(actexp(:,4,b) == s_C(3:end),'all'); % any expansion s_C >=4
    expnever(b,:) = R - exp1(b,:) - exp2(b,:) - exp3(b,:) - exp4(b,:);
    scen_short_reorder{b} = scenarios_shortened{order(b)};
end

figure;
colormap(cmap)
b2 = bar([exp1 exp2 exp3 exp4 expnever], .8, 'stacked');
for i = 1:5
    b2(i).FaceColor = cmap2(i+5,:);
end
set(gca,'xticklabel',scen_short_reorder)
%set(gca,'xticklabel',scenarios_shortened)

legend([b2], {decade{2:end}, 'never'}, 'FontSize', 10);
ylabel('Frequency')
sgtitle('Expanded Flexible Dam Scenarios')
%sgtitle('Expanded Flexible Dam Scenarios: By Learning Scenario')
%% Figure 8b- Heatmaps for each Timestep
exp1Reshape = reshape(exp1./i, [3 3]);
exp2Reshape = reshape(exp2./i, [3 3]);
exp3Reshape = reshape(exp3./i, [3 3]);
exp4Reshape = reshape(exp4./i, [3 3]);
expneverReshape = reshape(expnever./i, [3 3]);

figure;
subplot(2,3,1);
heatmap(exp1Reshape);
ax = gca;
ax.XDisplayLabels = {'Dry', 'Mod', 'Wet'};
ax.YDisplayLabels = {'High', 'Medium', 'Low'};
title('2021-2040');

subplot(2,3,2);
heatmap(exp2Reshape);
ax = gca;
ax.XDisplayLabels = {'Dry', 'Mod', 'Wet'};
ax.YDisplayLabels = {'High', 'Medium', 'Low'};
title('2041-2060');

subplot(2,3,3);
heatmap(exp3Reshape);
ax = gca;
ax.XDisplayLabels = {'Dry', 'Mod', 'Wet'};
ax.YDisplayLabels = {'High', 'Medium', 'Low'};
title('2061-2080');

subplot(2,3,4);
heatmap(exp4Reshape);
ax = gca;
ax.XDisplayLabels = {'Dry', 'Mod', 'Wet'};
ax.YDisplayLabels = {'High', 'Medium', 'Low'};
title('2081-2100');

subplot(2,3,5);
heatmap(expneverReshape);
ax = gca;
ax.XDisplayLabels = {'Dry', 'Mod', 'Wet'};
ax.YDisplayLabels = {'High', 'Medium', 'Low'};
title('never expand');
sgtitle('Heatmaps for Proportion of Total Instances (10,000) Expanded by Time Period')
%% Figure 7 Barplots for all expansion scenarios
for b=1:9
    load(files{order(b)});
    % frequency of each exp threshold decision
    actexp(:,:,b) = action(:,2:end,end); % action{k}(:,2:end,end);
    %exp = struct;
    for i=3:7
        exp(b,i-2) = sum(actexp(:,1:end,b) == i,'all');
    end
end

figure;
colormap(cmap)
expnever = 10000-sum(exp, 2);

b2 = bar([exp expnever], .8, 'stacked');
for i = 1:5
    b2(i).FaceColor = cmap2(i+5,:);
end
set(gca,'xticklabel',scen_short_reorder)

capState = {'Static', 'Flex, Unexpanded', 'Flex, Exp:+10', ...
    'Flex, Exp:+20', 'Flex, Exp:+30', 'Flex, Exp:+40', 'Flex, Exp:+50'};
legend([b2], {capState{3:end}, 'Never'}, 'FontSize', 10);
ylabel('Frequency')
sgtitle('Infrastructure Expansion Decisions')

%% Shortage Costs (Measure of Regret)

prctiles = [10 50 90 95 99];
shortCosts = zeros(length(files), length(prctiles));

for b=1:9
    load(files{order(b)});
    % frequency of each exp threshold decision
    for c=1:length(prctiles)
        shortCosts(b, c) = prctile(sum(shortageCostTime(:,:,3), 2), prctiles(c));
        damCosts(b, c) = prctile(sum(damCostTime(:,:,3), 2), prctiles(c));
        totalCosts(b, c) = prctile(sum(totalCostTime(:,:,3), 2), prctiles(c));
    end
end

%% Reshape shortage costs and plot in heatmaps

scen = length(prctiles);

figure;
for b=1:scen-2
    data = reshape(shortCosts(:,b+2), [3 3]);
    subplot(scen-2,3,b*3-2);
    heatmap(data);
    ax = gca;
    ax.XDisplayLabels = {'Dry', 'Mod', 'Wet'};
    ax.YDisplayLabels = {'High', 'Medium', 'Low'};
    if b==1
        title(['Shortage Costs:\newline', num2str(prctiles(b+2)), 'th Percentile']);
    else
        title([num2str(prctiles(b+2)), 'th Percentile']);
    end
    
    dataDam = reshape(damCosts(:,b+2), [3 3]);
    subplot(scen-2,3,b*3-1);
    heatmap(dataDam);
    ax = gca;
    ax.XDisplayLabels = {'Dry', 'Mod', 'Wet'};
    ax.YDisplayLabels = {'High', 'Medium', 'Low'};
    if b==1
        title(['Dam Costs:\newline', num2str(prctiles(b+2)), 'th Percentile']);
    else
        title([num2str(prctiles(b+2)), 'th Percentile']);
    end
    
    dataTotals = reshape(totalCosts(:,b+2), [3 3]);
    subplot(scen-2,3,b*3);
    heatmap(dataTotals);
    ax = gca;
    ax.XDisplayLabels = {'Dry', 'Mod', 'Wet'};
    ax.YDisplayLabels = {'High', 'Medium', 'Low'};
    if b==1
        title(['Total Costs:\newline', num2str(prctiles(b+2)), 'th Percentile']);
    else
        title([num2str(prctiles(b+2)), 'th Percentile']);
    end
    
end

%% Shortage Costs (Measure of Regret)- Version 2- look at boxplots/violin plots
% look at dry, mod, wet separately

for b=1:9
    load(files{order(b)});
        shortCosts(:, b) = sum(shortageCostTime(:,:,3), 2);
        damCosts(:, b) = sum(damCostTime(:,:,3), 2);
        totalCosts(:, b) = sum(totalCostTime(:,:,3), 2);
end

%% BOXPLOTS/VOILIN PLOTS

addpath('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Fletcher_2019_Learning_Climate/Plots/plotting utilities/Violinplot-Matlab-master/');
figure('Position', [333 134 557 546]);
subplot(3,1,1);
vs = violinplot(shortCosts(:,1:3)/1E6);
xticklabels({'High', 'Medium', 'Low'});
xlabel('Amount of Learning');
ylabel('Shortage Costs ($M)');
title('Dry Scenarios');

subplot(3,1,2)
vs2 = violinplot(shortCosts(:,4:6)/1E6);
xticklabels({'High', 'Medium', 'Low'});
xlabel('Amount of Learning');
ylabel('Shortage Costs ($M)');
title('Moderate Scenarios');

subplot(3,1,3)
vs3 = violinplot(shortCosts(:,7:9)/1E6);
xticklabels({'High', 'Medium', 'Low'});
xlabel('Amount of Learning');
ylabel('Shortage Costs ($M)');
title('Wet Scenarios');

sgtitle('Shortage Costs ($M) for all Scenarios');

%% Boxplot for Shortage Costs
figure('Position', [333 72 518 608]);
subplot(3,1,1);
b1 = boxplot(shortCosts(:,1:3)/1E6, 'width', 0.6, 'symbol', 'x');
set(b1, 'LineWidth', 1.5);
xticklabels({'High', 'Medium', 'Low'});
xlabel('Amount of Learning');
ylabel('Shortage Costs ($M)');
title('Dry Scenarios');

subplot(3,1,2)
b2 = boxplot(shortCosts(:,4:6)/1E6, 'width', 0.6, 'symbol', 'x');
set(b2, 'LineWidth', 1.5);
xticklabels({'High', 'Medium', 'Low'});
xlabel('Amount of Learning');
ylabel('Shortage Costs ($M)');
title('Moderate Scenarios');

subplot(3,1,3)
b3 = boxplot(shortCosts(:,7:9)/1E6, 'width', 0.6, 'symbol', 'x');
set(b3, 'LineWidth', 1.5);
xticklabels({'High', 'Medium', 'Low'});
xlabel('Amount of Learning');
ylabel('Shortage Costs ($M)');
title('Wet Scenarios');

sgtitle('Shortage Costs ($M) for all Scenarios');
%% Dam Costs- Violin Plot

figure('Position', [333 134 557 546]);
subplot(3,1,1);
vs = violinplot(damCosts(:,1:3)/1E6);
xticklabels({'High', 'Medium', 'Low'});
xlabel('Amount of Learning');
ylabel('Dam Costs ($M)');
title('Dry Scenarios');

subplot(3,1,2)
vs2 = violinplot(damCosts(:,4:6)/1E6);
xticklabels({'High', 'Medium', 'Low'});
xlabel('Amount of Learning');
ylabel('Dam Costs ($M)');
title('Moderate Scenarios');

subplot(3,1,3)
vs4 = violinplot(damCosts(:,7:9)/1E6);
xticklabels({'High', 'Medium', 'Low'});
xlabel('Amount of Learning');
ylabel('Dam Costs ($M)');
title('Wet Scenarios');

sgtitle('Dam Costs ($M) for all Scenarios');

%% Dam Costs- Boxplot

figure('Position', [333 134 557 546]);
subplot(3,1,1);
b1 = boxplot(damCosts(:,1:3)/1E6, 'width', 0.6, 'symbol', 'x');
set(b1, 'LineWidth', 1.5);
xticklabels({'High', 'Medium', 'Low'});
xlabel('Amount of Learning');
ylabel('Dam Costs ($M)');
title('Dry Scenarios');

subplot(3,1,2)
b2 = boxplot(damCosts(:,4:6)/1E6, 'width', 0.6, 'symbol', 'x');
set(b2, 'LineWidth', 1.5);
xticklabels({'High', 'Medium', 'Low'});
xlabel('Amount of Learning');
ylabel('Dam Costs ($M)');
title('Moderate Scenarios');

subplot(3,1,3)
b3 = boxplot(damCosts(:,7:9)/1E6, 'width', 0.6, 'symbol', 'x');
set(b3, 'LineWidth', 1.5);
xticklabels({'High', 'Medium', 'Low'});
xlabel('Amount of Learning');
ylabel('Dam Costs ($M)');
title('Wet Scenarios');

sgtitle('Dam Costs ($M) for all Scenarios');
%% total costs violin plot

figure('Position', [333 134 557 546]);
subplot(3,1,1);
vs = violinplot(totalCosts(:,1:3)/1E6);
xticklabels({'High', 'Medium', 'Low'});
xlabel('Amount of Learning');
ylabel('Total Costs ($M)');
title('Dry Scenarios');

subplot(3,1,2)
vs2 = violinplot(totalCosts(:,4:6)/1E6);
xticklabels({'High', 'Medium', 'Low'});
xlabel('Amount of Learning');
ylabel('Total Costs ($M)');
title('Moderate Scenarios');

subplot(3,1,3)
vs3 = violinplot(totalCosts(:,7:9)/1E6);
xticklabels({'High', 'Medium', 'Low'});
xlabel('Amount of Learning');
ylabel('Total Costs ($M)');
title('Wet Scenarios');

sgtitle('Total Costs ($M) for all Scenarios');

%% Total Costs- Boxplot

figure('Position', [333 134 557 546]);
subplot(3,1,1);
b1 = boxplot(totalCosts(:,1:3)/1E6, 'width', 0.6, 'symbol', 'x');
set(b1, 'LineWidth', 1.5);
xticklabels({'High', 'Medium', 'Low'});
xlabel('Amount of Learning');
ylabel('Total Costs ($M)');
title('Dry Scenarios');

subplot(3,1,2)
b2 = boxplot(totalCosts(:,4:6)/1E6, 'width', 0.6, 'symbol', 'x');
set(b2, 'LineWidth', 1.5);
xticklabels({'High', 'Medium', 'Low'});
xlabel('Amount of Learning');
ylabel('Total Costs ($M)');
title('Moderate Scenarios');

subplot(3,1,3)
b3 = boxplot(totalCosts(:,7:9)/1E6, 'width', 0.6, 'symbol', 'x');
set(b3, 'LineWidth', 1.5);
xticklabels({'High', 'Medium', 'Low'});
xlabel('Amount of Learning');
ylabel('Total Costs ($M)');
title('Wet Scenarios');

sgtitle('Total Costs ($M) for all Scenarios');
%% Figure 8 for subset of scenarios- Cost Sensitivities (6/24)
% to change for all scenarios run from b=1:9, use files and scenarios vs
% subsets and change from subplot(2,2,..) to (subplot(3,3,...)
figure('Position', [114 106 1135 590]);
for b=1:6
    load(files_cost{b});
    s_C_bins = s_C - 0.01;
    s_C_bins(end+1) = s_C(end)+0.01;

    clear actCounts;
    clear actCounts_test;
    for k=1:5
        actCounts(k,:) = histcounts(action(:,k,3), s_C_bins);
        actCounts_test(k,:) = histcounts(action(:,k,3), s_C_bins);
    end

    for j=2:5
        actCounts(j,1) = actCounts(1,1);
        actCounts(j,2) = actCounts(j-1,2) - sum(actCounts(j,3:end));
        actCounts(j,3:end) = actCounts(j-1,3:end) + actCounts(j,3:end);
    end

    subplot(2,3,b)
    colormap(cmap);
    b1 = bar(actCounts, 'stacked');
    for i=1:length(b1)
        b1(i).FaceColor = cmap1(i,:);
    end
    xticklabels(decade_short);
    xlabel('Time Period');
    ylabel('Frequency');
    capState = {'Static', 'Flex, Unexpanded', 'Flex, Exp:+10', ...
        'Flex, Exp:+20', 'Flex, Exp:+30', 'Flex, Exp:+40', 'Flex, Exp:+50'};
    legend(capState, 'location', 'southwest', 'FontSize', 7);
    title([scenarios_cost{b}, ':\newlineStatic Dam = ', num2str(bestAct_static(5)), ...
        ', Flex Dam = ', num2str(bestAct_flex(2))]);
end
%sgtitle('Dam Expansion Decisions over Time')
sgtitle('Dry, Medium Learning w/ 5% Upfront Cap Cost Increase for Flex Dam: Dam Expansion Decisions over Time')

%% For Cost Scenarios, determine fraction flexible and fraction flex expanded

scen = length(files_cost_added28June);

fracFlex = zeros(scen, 1);
fracFlexExp = zeros(scen, 2);

for b=1:scen
    load(files_cost_added28June{b});
    s_C_bins = s_C - 0.01;
    s_C_bins(end+1) = s_C(end)+0.01;

    clear actCounts;
    for k=1:5
        actCounts(k,:) = histcounts(action(:,k,3), s_C_bins);
    end
    
    fracFlex(b) = actCounts(1,2)/i;
    fracFlexExp(b,1) = sum(actCounts(2:end, 3:end), 'all')/i;
    fracFlexExp(b,2) = sum(actCounts(2:end, 3:end), 'all')/actCounts(1,2);
    
end

%% Look at shortage costs over time
pos1 = 1:1:5;
figure;
for m=1:3
    b1 = boxplot(shortageCostTime(:,:,m)/(1E6), 'width', 0.2, 'position', pos1,...
        'Colors', cmap(m+3,:));
    b2(m,1) = b1(1,1);
    hold on
    set(b1, 'LineWidth', 2);
    xticks(1.3:1:5.3);
    xticklabels(decade);
    xlabel('Time Period');
    ylabel('Shortage Costs ($M)');
    xlim([0.5 6]);
    pos1 = pos1 + 0.3;
end
legend(b2, {'Flex', 'Static', 'Best Policy'});
legend('boxoff');
title({['Dry, Medium Learning: ', num2str(x(8)*100), '% Discount Rate, ', ...
    num2str(x(7)*100), '% Expansion Flex Dam Cost, '], ...
    ['Static Dam Size: ', num2str(x(5)), ', Flex Dam Size: ', num2str(x(2))]}, ...
    'FontSize', 12);