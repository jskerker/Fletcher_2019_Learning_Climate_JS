%% Post process KL Divergence Plots Testing

action_subset = action(rndSamps,:,3);

addpath('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Fletcher_2019_Learning_Climate/Plots/plotting utilities/cbrewer/cbrewer/cbrewer');
cmap1 = cbrewer('qual', 'Set2', 8);
cmap2 = cbrewer('div', 'Spectral',11);
cmap = [cmap1(1,:); cmap1(4,:); cmap2(6:end,:)];
cmap = cbrewer('qual', 'Set3', 8);
cmap3 = cbrewer('div', 'RdYlBu', 11);
%cmap3 = cbrewer('seq', 'YlGnBu', 6);
%% Attempt 1: two bar plots, one by # instances, one by frequency
binExtent_precip = max((KLDiv_Precip_Simple(:,4,2)))- min((KLDiv_Precip_Simple(:,4,2)));
KLD_bins = 0:0.5:max((KLDiv_Precip_Simple(:,4,2)))+0.5;
KLD = KLDiv_Precip_Simple(:,4,2);

indices = zeros(length(KLD_bins)-1, 100);
acts = nan(length(KLD_bins)-1, 100);

for i=1:length(KLD_bins)-1
    vals = find(KLD >= KLD_bins(i) & KLD < KLD_bins(i+1));
    indices(i,1:length(vals)) = vals;
    acts(i,1:length(vals)) = action_subset(vals, 2);
    actsCnt(i,:) = histcounts(acts(i,:), [-0.01 s_C_bins]);
end
cols = [1,4:8];
actsCntSubset = actsCnt(:,cols);
actsCntSum = sum(actsCntSubset, 2);

% bar plots
figure;
subplot(3,1,1:2)
b1 = bar(actsCntSubset, 'stacked');

for i=1:length(b1)
    b1(i).FaceColor = cmap3(i+5,:);
end
legend('No Exp', '+10', '+20', '+30', '+40', '+50')
%xticks(0.5:0.25:2.75)
xticks(0.5:1:11.5)
xticklabels(0:0.5:3)
xlabel('KL Divergence');
ylabel('# of Instances');
title('Bar Plot of Expansion by KL Divergence for Precip');

subplot(3,1,3)
b2 = bar(actsCntSubset./actsCntSum, 'stacked');
for i=1:length(b2)
    b2(i).FaceColor = cmap3(i+5,:);
end
xticks(0.5:1:11.5)
xticklabels(0:0.5:3)
xlabel('KL Divergence');
ylabel('Frequency');

%% Attempt 2: Avg KLD by Time Period- make for 2010, 2030, 2050, 2070
minInd = [1 11 17 20];
maxInd = [4 13 18 20];
subP = [1 2 7 8];

figure;

for n=1:4
    clear actsCnt; clear actsCntSubset; clear actsCntSum;
    
    % get max value
    
    % figure out increment/ number of bins
    inc = 0.5;
    
    %KLD = KLDiv_Precip_Simple(:,
    KLD_bins = 0:inc:max(max(KLDiv_Precip_Simple(:,minInd(n):maxInd(n),m)))+inc;
    KLD = mean(KLDiv_Precip_Simple(:,minInd(n):maxInd(n),m), 2);   
    
    % get number of actions sorted by KLD bins
    indices = zeros(length(KLD_bins)-1, 100);
    acts = nan(length(KLD_bins)-1, 100);
    for i=1:length(KLD_bins)-1
        vals = find(KLD >= KLD_bins(i) & KLD < KLD_bins(i+1));
        indices(i,1:length(vals)) = vals;
        acts(i,1:length(vals)) = action_subset(vals, n+1);
        actsCnt(i,:) = histcounts(acts(i,:), [-0.01 s_C_bins]);
    end
    cols = [1,4:8];
    actsCntSubset = actsCnt(:,cols);
    actsCntSum = sum(actsCntSubset, 2);

    % bar plots
    %figure;
    subplot(6,2,[subP(n) subP(n)+2])
    b1 = bar(actsCntSubset, 'stacked');

    for i=1:length(b1)
        b1(i).FaceColor = cmap3(i+5,:);
    end
    legend('No Exp', '+10', '+20', '+30', '+40', '+50')
    %xticks(0.5:0.25:2.75)
    xticks(0.5:1:length(KLD_bins)+inc);
    xticklabels(0:inc:length(KLD_bins)*inc);
    %xlabel('KL Divergence');
    ylabel('# of Instances');
    title(num2str(decades{n+1}));

    subplot(6,2,subP(n)+4)
    b2 = bar(actsCntSubset./actsCntSum, 'stacked');
    for i=1:length(b2)
        b2(i).FaceColor = cmap3(i+5,:);
    end
    xticks(0.5:1:length(KLD_bins)+inc);
    xticklabels(0:inc:length(KLD_bins)*inc);
    xlabel('KL Divergence');
    ylabel('Frequency');
end
%% Attempt 3: Attempt 2 + Discounting 

%% Attempt 4: Dam Sizes instead of Expansions

