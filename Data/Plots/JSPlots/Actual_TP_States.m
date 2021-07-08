x% try to get a matrix for states actually used
clear all
close all

% load data for RCP4.5B
addpath('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Mombasa_climate/SDP');
load('results_RCP45B_02_Dec_2020_11_43_47.mat', 'T_state', 'P_state','s_P_abs', 's_T_abs', 'N', 'P_bins', 'T_bins');
T_state_RCP45 = T_state;
P_state_RCP45 = P_state;
load('T_Temp_Precip_RCP45B.mat');
T_Temp_RCP45 = T_Temp;
T_Precip_RCP45 = T_Precip;

% load data for RCP4.5A
load('results_RCP45A_01_Dec_2020_19_31_36.mat', 'T_state', 'P_state','s_P_abs', 's_T_abs', 'N', 'P_bins', 'T_bins');
T_state_RCP45A = T_state;
P_state_RCP45A = P_state;

% this is a test to look at the discretization of the P states by
% offsetting them by 0.5 mm so from 65.5 mm to 96.5 mm for RCP8.5
addpath('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Fletcher_2019_Learning_Climate/SDP');
% load('results_RCP85_22_Nov_2020_12_32_20.mat', 'T_state', 'P_state');
% T_state_RCP85_test = T_state;
% P_state_RCP85_test = P_state;

% load data for RCP8.5B
load('results_RCP85B_06_Dec_2020_11_54_46.mat', 'T_state', 'P_state');
T_state_RCP85 = T_state;
P_state_RCP85 = P_state;

% load data for RCP8.5A
load('results_RCP85A_01_Dec_2020_17_13_41.mat', 'T_state', 'P_state')
T_state_RCP85A = T_state;
P_state_RCP85A = P_state;

% load data for previous RCP8.5 results (before rounding of bma2TransMat
% function was implemented
% load('results_RCP85_02_Nov_2020_16_47_59.mat', 'T_state', 'P_state');
% T_state_RCP85_orig = T_state;
% P_state_RCP85_orig = P_state;

% load transition matrix data for RCP8.5
load('T_Temp_Precip_RCP85B.mat');
T_Temp_RCP85 = T_Temp;
T_Precip_RCP85 = T_Precip;

% load transition matrix data for RCP8.5 discretization test
% load('T_Temp_Precip_RCP85B_test2.mat');
% T_Temp_RCP85_test = T_Temp;
% T_Precip_RCP85_test = T_Precip;

time = {'2001-2020', '2021-2040', '2041-2060', '2061-2080', '2081-2100'};
r1 = 'RCP4.5 ';
r2 = 'RCP8.5 ';

% Create matrices for actual T and P states
P_state_rounded_RCP45 = round(P_state_RCP45);
for i = 1:length(s_P_abs)
    for t = 1:N-1
        P_current = s_P_abs(i);
        indexNow = find(P_state_rounded_RCP45(:,t) == P_current);
        relevant_deltas = P_state_rounded_RCP45(indexNow,t+1) - P_state_rounded_RCP45(indexNow,t);
        P_next = P_current + relevant_deltas;
        T_Precip_abs_RCP45(:,i,t) = histcounts(P_next, P_bins, 'Normalization', 'Probability');     
    end
end

for i = 1:length(s_T_abs)
    for t = 1:N-1
        T_current = s_T_abs(i);
        indexNow = find(T_state_RCP45(:,t) == T_current);
        relevant_deltas = T_state_RCP45(indexNow,t+1) - T_state_RCP45(indexNow,t);
        T_next = T_current + relevant_deltas;
        T_Temp_abs_RCP45(:,i,t) = histcounts(T_next, T_bins, 'Normalization', 'Probability');     
    end
end 

addpath('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Fletcher_2019_Learning_Climate/Plots/plotting utilities/cbrewer/cbrewer/cbrewer')
[clrmp1]=cbrewer('div', 'RdBu', 100, 'cubic');
%% Create matrix for each T and P state values

% create matrices with all zeros
P_actual_RCP45 = zeros(N, length(P_bins)-1);
T_actual_RCP45 = zeros(N, length(T_bins)-1);
P_actual_RCP85 = zeros(N, length(P_bins)-1);
T_actual_RCP85 = zeros(N, length(T_bins)-1);
% P_actual_RCP85_test = zeros(N, length(P_bins)-1);
% T_actual_RCP85_test = zeros(N, length(T_bins)-1);
% P_actual_RCP85_orig = zeros(N, length(P_bins)-1);
% T_actual_RCP85_orig = zeros(N, length(T_bins)-1);
P_actual_RCP85A = zeros(N, length(P_bins)-1);
T_actual_RCP85A = zeros(N, length(T_bins)-1);

% for each time period (N=1 to 5) find distribution of states
for i=1:5
    P_actual_RCP45(i, :) = histcounts(P_state_RCP45(:,i), P_bins);
    T_actual_RCP45(i, :) = histcounts(T_state_RCP45(:,i),T_bins);
%     P_actual_RCP85_test(i, :) = histcounts(P_state_RCP85_test(:,i), P_bins);
%     T_actual_RCP85_test(i, :) = histcounts(T_state_RCP85_test(:,i),T_bins);
    P_actual_RCP85(i, :) = histcounts(P_state_RCP85(:,i), P_bins);
    T_actual_RCP85(i, :) = histcounts(T_state_RCP85(:,i),T_bins);
%     P_actual_RCP85_orig(i, :) = histcounts(P_state_RCP85_orig(:,i), P_bins);
%     T_actual_RCP85_orig(i, :) = histcounts(T_state_RCP85_orig(:,i), T_bins);
    
    P_actual_RCP85A(i, :) = histcounts(P_state_RCP85A(:,i), P_bins);
    T_actual_RCP85A(i, :) = histcounts(T_state_RCP85A(:,i),T_bins);
    
end

% find true/false distribution of states for use in plotting
P_actual_bool_RCP45 = logical(P_actual_RCP45);
T_actual_bool_RCP45 = logical(T_actual_RCP45);
% P_actual_bool_RCP85_test = logical(P_actual_RCP85_test);
% T_actual_bool_RCP85_test = logical(T_actual_RCP85_test);
P_actual_bool_RCP85 = logical(P_actual_RCP85);
T_actual_bool_RCP85 = logical(T_actual_RCP85);
% P_actual_bool_RCP85_orig = logical(P_actual_RCP85_orig);
% T_actual_bool_RCP85_orig = logical(T_actual_RCP85_orig);
%% % Create 1D plot
C = {[0.6350, 0.0780, 0.1840], [0.8500, 0.3250, 0.0980], [0.4660, 0.6740, 0.1880],...
    [0, 0.4470, 0.7410], [0.4940, 0.1840, 0.5560]};

close all
figure('Position', [245 55 849 641]);
subplot(2,1,1)
for i=1:5
    plot(s_P_abs, P_actual_RCP45(i, :), s_P_abs, P_actual_RCP85(i, :), '--', ...
        'color', C{i}, 'LineWidth', 1)
    hold on
    xlabel('Precip State (mm/month)')
    ylabel('Count')
    test = {'RCP8.5 2001-2020 Test', 'RCP8.5 2001-2020B', 'RCP8.5 2021-2040 Test', 'RCP8.5 2021-2040B',...
        'RCP8.5 2041-2060 Test', 'RCP8.5 2041-2060B','RCP8.5 2061-2080 Test', 'RCP8.5 2061-2080B',...
        'RCP8.5 2081-2100 Test', 'RCP8.5 2081-2100B'}
    legend(test, 'location', 'northeast')
    title('Precipitation States')
    %xlim([66 97])
end

subplot(2,1,2)
for i=1:5
    plot(s_T_abs, T_actual_RCP45(i, :), s_T_abs, T_actual_RCP85(i, :), ...
        '--', 'color', C{i}, 'LineWidth', 1)
    hold on
    xlabel('Temp State (^oC)')
    ylabel('Count')
    title('Temperature States')
    
end

%%  Create 1D plot for RCP4.5 P bin test
C = {[0.6350, 0.0780, 0.1840], [0.8500, 0.3250, 0.0980], [0.4660, 0.6740, 0.1880],...
    [0, 0.4470, 0.7410], [0.4940, 0.1840, 0.5560]};

subplot(2,1,1)
for i=1:5
    plot(s_P_abs, P_actual_RCP45(i, :), s_P_abs, P_actual_RCP45_test(i, :), ...
        '--', 'color', C{i}, 'LineWidth', 1)
    hold on
    xlabel('Precip State (mm/month)')
    ylabel('Count')
    test = {'RCP4.5 2001-2020', 'RCP4.5 2001-2020 Test', 'RCP4.5 2021-2040', 'RCP4.5 2021-2040 Test',...
        'RCP4.5 2041-2060', 'RCP4.5 2041-2060 Test','RCP4.5 2061-2080', 'RCP4.5 2061-2080 Test',...
        'RCP4.5 2081-2100', 'RCP4.5 2081-2100 Test'}
    legend(test)
    title('Precipitation States')
    %xlim([66 97])
end

subplot(2,1,2)
for i=1:5
    plot(s_T_abs, T_actual_RCP45(i, :), s_T_abs, T_actual_RCP45_test(i, :), ...
        '--', 'color', C{i}, 'LineWidth', 1)
    hold on
    xlabel('Temp State (^oC)')
    ylabel('Count')
    title('Temperature States')
    
end

%% Create 2D matrix plots for RCP4.5 Temp

figure('Position', [230 55 834 650]);
for i=1:4
    subplot(2,2,i)
    minTi = min(find(T_actual_bool_RCP45(i,:)));
    maxTi = max(find(T_actual_bool_RCP45(i,:)));
    minTj = min(find(T_actual_bool_RCP45(i+1,:)));
    maxTj = max(find(T_actual_bool_RCP45(i+1,:)));
    iRange = minTi*0.05+25.95:0.05:maxTi*0.05+25.95;
    jRange = minTj*0.05+25.95:0.05:maxTj*0.05+25.95;
    imagesc(T_Temp_RCP45(:,:,i))
    
    % only show portion of image that T/P states fall into
%     axis([minTi maxTi minTj maxTj]);
%     xticklabels(iRange);
%     yticklabels(jRange);
    colorbar
    
    xlabel('State i temp (^oC)')
    ylabel('State i+1 temp (^oC)')
    axis square
    set(gca, 'YDir', 'normal')
    title(['Temp ', num2str(time{i}), ' to ', num2str(time{i+1})])
    sgtitle('RCP4.5 Temperature States')
end
%% Create 2D matrix plot for RCP4.5 Precip

figure('Position', [230 55 834 650]);
for i=1:4
    subplot(2,2,i)
    minPi = min(find(P_actual_bool_RCP45(i,:)));
    maxPi = max(find(P_actual_bool_RCP45(i,:)));
    minPj = min(find(P_actual_bool_RCP45(i+1,:)));
    maxPj = max(find(P_actual_bool_RCP45(i+1,:)));
    iRange = 65+minPi:4:65+maxPi;
    jRange = 65+minPj:4:65+maxPj;
    imagesc(T_Precip_RCP45(:,:,i))
    
    % only show portion of image that T/P states fall into
    axis([minPi maxPi minPj maxPj]);
    xticks(minPi:4:maxPi);
    yticks(minPj:4:maxPj);
    xticklabels(iRange);
    yticklabels(jRange);
    colorbar;
    caxis([0 1]);
    
    xlabel('State i Prec (mm/mo)')
    ylabel('State i+1 Prec (mm/mo)')
    axis square
    set(gca, 'YDir', 'normal')
    title(['Precip ', num2str(time{i}), ' to ', num2str(time{i+1})])
    sgtitle('RCP4.5 Precipitation States')
end
%% Create 2D matrix plots for RCP8.5 Temp

figure('Position', [230 55 834 650]);
for i=1:4
    subplot(2,2,i)
    minTi = min(find(T_actual_bool_RCP85(i,:)));
    maxTi = max(find(T_actual_bool_RCP85(i,:)));
    minTj = min(find(T_actual_bool_RCP85(i+1,:)));
    maxTj = max(find(T_actual_bool_RCP85(i+1,:)));
    iRange = minTi*0.05+25.95:0.1:maxTi*0.05+25.95;
    jRange = minTj*0.05+25.95:0.1:maxTj*0.05+25.95;
    imagesc(T_Temp_RCP85(:,:,i))
    
    % only show portion of image that T/P states fall into
    axis([minTi maxTi minTj maxTj]);
    % ticks sets the spacing of the x and y axis labels- this must be
    % equally spaced with iRange and jRange
    xticks(minTi:2:maxTi);
    yticks(minTj:2:maxTj);
    xticklabels(iRange);
    yticklabels(jRange);
    colorbar
    
    xlabel('State i temp (^oC)')
    ylabel('State i+1 temp (^oC)')
    axis square
    set(gca, 'YDir', 'normal')
    title(['Temp ', num2str(time{i}), ' to ', num2str(time{i+1})])
    sgtitle('RCP8.5 Temperature States')
end

%% Create 1 x 2 plot with RCP8.5 temp and precip transition matrix- last time period- zoomed in on states used

figure('Position', [175 263 865 387]);
%figure;

% get temp and precip ranges
i = 2
minTi = min(find(T_actual_bool_RCP85(i,:)));
maxTi = max(find(T_actual_bool_RCP85(i,:)));
minTj = min(find(T_actual_bool_RCP85(i+1,:)));
maxTj = max(find(T_actual_bool_RCP85(i+1,:)));
TiRange = minTi*0.05+25.95:0.1:maxTi*0.05+25.95;
TjRange = minTj*0.05+25.95:0.1:maxTj*0.05+25.95;
minPi = min(find(P_actual_bool_RCP45(i,:)));
maxPi = max(find(P_actual_bool_RCP45(i,:)));
minPj = min(find(P_actual_bool_RCP45(i+1,:)));
maxPj = max(find(P_actual_bool_RCP45(i+1,:)));
PiRange = 65+minPi:4:65+maxPi;
PjRange = 65+minPj:4:65+maxPj;

subplot(1,2,1)
imagesc(T_Temp_RCP85(:,:,2))
colorbar;
caxis([0 1]);
axis([minTi maxTi minTj maxTj]);
xticks(minTi:2:maxTi);
yticks(minTj:2:maxTj);
xticklabels(TiRange);
yticklabels(TjRange);
xlabel('State i Temp (^oC)')
ylabel('State i+1 Temp (^oC)')
axis square
set(gca, 'YDir', 'normal')
ax = gca;
ax.FontSize = 16;
title('Temp: 2021-2040 to 2041-2060');

subplot(1,2,2)
imagesc(T_Precip_RCP85(:,:,2))
colorbar;
caxis([0 1]);
axis([minPi maxPi minPj maxPj]);
xticks(minPi:4:maxPi);
yticks(minPj:4:maxPj);
xticklabels(PiRange);
yticklabels(PjRange);
xlabel('State i Prec (mm/mo)')
ylabel('State i+1 Prec (mm/mo)')
axis square
set(gca, 'YDir', 'normal')
ax = gca;
ax.FontSize = 16;
title('Precip: 2021-2040 to 2041-2060');

%% Create 1 x 2 plot with RCP8.5 temp and precip transition matrix- last time period

figure('Position', [175 263 865 387]);
%figure;
subplot(1,2,1)
imagesc(T_Temp_RCP85(:,:,2))
colorbar;
caxis([0 1]);
xticks([1:20:151]);
xticklabels([26:1:33.5]);
yticks([1:20:151]);
yticklabels([26:1:33.5]);
xlabel('State i Temp (^oC)')
ylabel('State i+1 Temp (^oC)')
axis square
set(gca, 'YDir', 'normal')
ax = gca;
ax.FontSize = 16;
title('Temp: 2021-2040 to 2041-2060');

subplot(1,2,2)
imagesc(T_Precip_RCP85(:,:,2))
colorbar;
caxis([0 1]);
xticks([1:5:31]);
xticklabels([66:5:97]);
yticks([1:5:31]);
yticklabels([66:5:97]);
xlabel('State i Prec (mm/mo)')
ylabel('State i+1 Prec (mm/mo)')
axis square
set(gca, 'YDir', 'normal')
ax = gca;
ax.FontSize = 16;
title('Precip: 2021-2040 to 2041-2060');
%% Create 2D matrix plot for RCP8.5 Precip test

figure('Position', [230 55 834 650]);
for i=1:4
    subplot(2,2,i)
    minPi = min(find(P_actual_bool_RCP85_test(i,:)));
    maxPi = max(find(P_actual_bool_RCP85_test(i,:)));
    minPj = min(find(P_actual_bool_RCP85_test(i+1,:)));
    maxPj = max(find(P_actual_bool_RCP85_test(i+1,:)));
    iRange = 64.5+minPi:4:64.5+maxPi;
    jRange = 64.5+minPj:4:64.5+maxPj;
    imagesc(T_Precip_RCP85_test(:,:,i))
    
    % only show portion of image that T/P states fall into
    axis([minPi maxPi minPj maxPj]);
    xticks(minPi:4:maxPi);
    yticks(minPj:4:maxPj);
    xticklabels(iRange);
    yticklabels(jRange);
    colorbar;
    caxis([0 1]);
    
    xlabel('State i Prec (mm/mo)')
    ylabel('State i+1 Prec (mm/mo)')
    axis square
    set(gca, 'YDir', 'normal')
    title(['Precip ', num2str(time{i}), ' to ', num2str(time{i+1})])
    sgtitle('RCP8.5 Precipitation States Discretization Test')
end

%% Step 3 for Jan 2021 presentation- PDF plot of one temp state
figure('Position', [360 309 638 389]);
plot(T_Temp_RCP85(:,18, 2), 'LineWidth', 3)
hold on
plot(T_Temp_RCP85(:,19, 2), 'LineWidth', 3)
plot(T_Temp_RCP85(:,20, 2), 'LineWidth', 3)
axis([1 40 0 0.8]);
xticks([1:5:40]);
xticklabels([26:0.25:29]);
xlabel('Temp in state i+1 (^oC)');
ylabel('Probability');
legend({'T = 26.85 ^oC', 'T = 26.90 ^oC', 'T = 26.95 ^oC'}, 'Location', 'northeast')
l = legend('boxoff')

%% Create 2D matrix plot for Prec RCP8.5 - RCP4.5

figure('Position', [230 55 834 650]);
for i=1:4
    subplot(2,2,i)
    minPi = min([find(P_actual_bool_RCP45(i,:)), find(P_actual_bool_RCP85(i,:))]);
    maxPi = max([find(P_actual_bool_RCP45(i,:)), find(P_actual_bool_RCP85(i,:))]);
    minPj = min([find(P_actual_bool_RCP45(i+1,:)), find(P_actual_bool_RCP85(i+1,:))]);
    maxPj = max([find(P_actual_bool_RCP45(i+1,:)), find(P_actual_bool_RCP85(i+1,:))]);
    iRange = 65+minPi:4:65+maxPi;
    jRange = 65+minPj:4:65+maxPj;
    imagesc(T_Precip_RCP85(:,:,i)-T_Precip_RCP45(:,:,i));
    
    % only show portion of image that T/P states fall into
    axis([minPi maxPi minPj maxPj]);
    xticks(minPi:4:maxPi);
    yticks(minPj:4:maxPj);
    xticklabels(iRange);
    yticklabels(jRange);
    colormap(clrmp1);
    colorbar;
    caxis([-0.5 0.5]);
    
    xlabel('State i Prec (mm/mo)')
    ylabel('State i+1 Prec (mm/mo)')
    axis square
    set(gca, 'YDir', 'normal')
    title(['Precip ', num2str(time{i}), ' to ', num2str(time{i+1})])
    sgtitle('RCP8.5-RCP4.5 Precipitation States')
end

%% Create 2D matrix plot for Temp RCP8.5 - RCP4.5

figure('Position', [230 55 834 650]);
for i=1:4
    subplot(2,2,i)
    minTi = min([find(T_actual_bool_RCP45(i,:)), find(T_actual_bool_RCP85(i,:))]);
    maxTi = max([find(T_actual_bool_RCP45(i,:)), find(T_actual_bool_RCP85(i,:))]);
    minTj = min([find(T_actual_bool_RCP45(i+1,:)), find(T_actual_bool_RCP85(i+1,:))]);
    maxTj = max([find(T_actual_bool_RCP45(i+1,:)), find(T_actual_bool_RCP85(i+1,:))]);
    iRange = minTi*0.05+25.95:0.1:maxTi*0.05+25.95;
    jRange = minTj*0.05+25.95:0.1:maxTj*0.05+25.95;
    imagesc(T_Temp_RCP85(:,:,i)-T_Temp_RCP45(:,:,i));
    
    % only show portion of image that T/P states fall into
    axis([minTi maxTi minTj maxTj]);
    xticks(minTi:2:maxTi);
    yticks(minTj:2:maxTj);
    xticklabels(iRange);
    yticklabels(jRange);
    colormap(clrmp1);
    colorbar;
    caxis([-0.5 0.5]);
    
    xlabel('State i Temp (^oC)')
    ylabel('State i+1 Temp (^oC)')
    axis square
    set(gca, 'YDir', 'normal')
    title(['Precip ', num2str(time{i}), ' to ', num2str(time{i+1})])
    sgtitle('RCP8.5-RCP4.5 Temperature States')
end

