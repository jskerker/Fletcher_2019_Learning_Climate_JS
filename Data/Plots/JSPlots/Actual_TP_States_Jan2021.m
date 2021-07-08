%% Actual TP States probability distribution figure for RCP4.5 and RCP8.5

% try to get a matrix for states actually used
clear all
close all

% load data for RCP4.5, 3% discount
cd('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Mombasa_climate/SDP');
load('results_RCP45A_01_Dec_2020_19_31_36.mat', 'T_state', 'P_state','s_P_abs', 's_T_abs', 'N', 'P_bins', 'T_bins');
T_state_RCP45 = T_state;
P_state_RCP45 = P_state;
% load('T_Temp_Precip_RCP85A.mat');
% T_Temp_RCP85 = T_Temp;
% T_Precip_RCP85 = T_Precip;

% load data for RCP8.5, 3% discount
cd('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Fletcher_2019_Learning_Climate/SDP');
load('results_RCP85A_01_Dec_2020_17_13_41.mat', 'T_state', 'P_state');
T_state_RCP85 = T_state;
P_state_RCP85 = P_state;

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

% create matrices with all zeros
P_actual_RCP45 = zeros(N, length(P_bins)-1);
T_actual_RCP45 = zeros(N, length(T_bins)-1);
P_actual_RCP85 = zeros(N, length(P_bins)-1);
T_actual_RCP85 = zeros(N, length(T_bins)-1);

% for each time period (N=1 to 5) find distribution of states
for i=1:5
    P_actual_RCP45(i, :) = histcounts(P_state_RCP45(:,i), P_bins);
    T_actual_RCP45(i, :) = histcounts(T_state_RCP45(:,i),T_bins);
    P_actual_RCP85(i, :) = histcounts(P_state_RCP85(:,i), P_bins);
    T_actual_RCP85(i, :) = histcounts(T_state_RCP85(:,i),T_bins);
end

% find true/false distribution of states for use in plotting
P_actual_bool_RCP45 = logical(P_actual_RCP45);
T_actual_bool_RCP45 = logical(T_actual_RCP45);
P_actual_bool_RCP85 = logical(P_actual_RCP85);
T_actual_bool_RCP85 = logical(T_actual_RCP85);

%% Create 1D plot
C = {[0.6350, 0.0780, 0.1840], [0.8500, 0.3250, 0.0980], [0.4660, 0.6740, 0.1880],...
    [0, 0.4470, 0.7410], [0.4940, 0.1840, 0.5560]};

close all
figure('Position', [245 55 849 641]);
subplot(2,1,1)
for i=1:5
    plot(s_P_abs, P_actual_RCP45(i, :)/10000, s_P_abs, P_actual_RCP85(i, :)/10000, '--', ...
        'color', C{i}, 'LineWidth', 1)
    hold on
    xlabel('Precip State (mm/month)')
    ylabel('Probability')
    ax = gca;
    ax.FontSize = 16;
    test = {'RCP4.5 2001-2020', 'RCP8.5 2001-2020', 'RCP4.5 2021-2040', 'RCP8.5 2021-2040',...
        'RCP4.5 2041-2060', 'RCP8.5 2041-2060','RCP4.5 2061-2080', 'RCP8.5 2061-2080',...
        'RCP4.5 2081-2100', 'RCP8.5 2081-2100'}
    legend(test, 'location', 'northeast', 'FontSize', 14);
    l = legend('boxoff');
    title('Precipitation States')
    %xlim([66 97])
end

subplot(2,1,2)
for i=1:5
    plot(s_T_abs, T_actual_RCP45(i, :)/10000, s_T_abs, T_actual_RCP85(i, :)/10000, ...
        '--', 'color', C{i}, 'LineWidth', 1.5)
    hold on
    xlabel('Temp State (^oC)')
    ylabel('Probability')
    title('Temperature States')
    ax = gca;
    ax.FontSize = 16;
end