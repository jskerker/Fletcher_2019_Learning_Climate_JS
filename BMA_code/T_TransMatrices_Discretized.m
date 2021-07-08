% Update Temperature transition matrices
clear all;
close all;

% load data
load('T_Temp_Precip_RCP85A');

%test_matrix = T_Temp(:,:,1);
%test_row = T_Temp(:,1,1);
%% Version 1 w/ binning as follows: 1-10, 11-20, 21-30, ..., 141-150, 151
k = size(T_Temp, 3);
t = size(T_Temp, 2);
d = 16; % new discretization
dt = round(t/(d-1));
s = [2 3 3 2 10];
% for every time period transition matrix, N
for l=1:5
    % for every column (time period n)
    count = 1;
    for j=1:dt:d*dt
        
        lower_limit = 1;
        % combine rows to go from 0.05 discretization to 0.5
        for i=1:d
             if i == d
                 upper_limit = 151;
             else
                 upper_limit = i*dt;
             end
         
            T_new_row(i) = sum(T_Temp(lower_limit:upper_limit,min(j+s(l), 151),l));
            disp([count, (j+l), lower_limit, upper_limit]);
            lower_limit = upper_limit + 1;
        end

        T_new_matrix(:,count,l) = T_new_row;
        count = count + 1;
    end
end

%T_Temp_new = zeros(16,16,5);
T_Temp_new = T_new_matrix;

%% Version 5 w/ averaging and binning as follows: 1-10, 11-20, 21-30, ..., 141-150, 151
k = size(T_Temp, 3);
t = size(T_Temp, 2);
d = 16; % new discretization
dt = round(t/(d-1));

% for every time period transition matrix, N
for l=1:5
    % for every column (time period n)
    count = 1;
    for j=1:dt:d*dt
        
        new_col(:,count) = mean(T_Temp(:,j+1:min(151, j+2),l), 2);
        count = count + 1;
    end
    
    lower_limit = 1;
    % combine rows to go from 0.05 discretization to 0.5
    for i=1:d
        if i == d
            upper_limit = 151;
        else
            upper_limit = i*dt;
        end
        
        T_new_mat(i,:) = sum(new_col(lower_limit:upper_limit,:), 1);
        disp([count, (j), lower_limit, upper_limit]);
        lower_limit = upper_limit + 1;
    end

    T_new_matrix(:,:,l) = T_new_mat;
        
    
end

%T_Temp_new = zeros(16,16,5);
T_Temp_new = T_new_matrix;
%% Version 3 w/ binning as follows: 1-5, 6-15, 16-25, ..., 146-151
k = size(T_Temp, 3);
t = size(T_Temp, 2);
d = 16; % new discretization
dt = round(t/(d-1));

% for every time period transition matrix, N
for l=1:5
    % for every column (time period n)
    count = 1;
    for j=1:dt:d*dt
        
        lower_limit = 1;
        % combine rows to go from 0.05 discretization to 0.5
        for i=1:d
             if i == d
                 upper_limit = 151;
             else
                 upper_limit = (i-1)*dt+5;
             end
         
            T_new_row(i) = sum(T_Temp(lower_limit:upper_limit,j,l));
            disp([count, lower_limit, upper_limit]);
            lower_limit = upper_limit + 1;
        end

        T_new_matrix(:,count,l) = T_new_row;
        count = count + 1;
    end
end

%T_Temp_new = zeros(16,16,5);
T_Temp_new = T_new_matrix;
%% Version 4 w/ binning as follows: 1-6, 7-16, 17-26, ..., 147-151
k = size(T_Temp, 3);
t = size(T_Temp, 2);
d = 16; % new discretization
dt = round(t/(d-1));

% for every time period transition matrix, N
for l=1:5
    % for every column (time period n)
    count = 1;
    for j=1:dt:d*dt
        
        lower_limit = 1;
        % combine rows to go from 0.05 discretization to 0.5
        for i=1:d
             if i == d
                 upper_limit = 151;
             else
                 upper_limit = (i-1)*dt+6;
             end
            m = round((lower_limit + upper_limit)/2);
            T_new_row(i) = sum(T_Temp(lower_limit:upper_limit,min(j, 151),l));
            disp([count, min(j, 151), lower_limit, upper_limit]);
            lower_limit = upper_limit + 1;
        end

        T_new_matrix(:,count,l) = T_new_row;
        count = count + 1;
    end
end

%T_Temp_new = zeros(16,16,5);
T_Temp_new = T_new_matrix;
%% create plots to test discretization
decades = {'1990-2010', '2010-2030', '2030-2050', '2050-2070', '2070-2090'};
figure;
for n=1:k
    subplot(3,2,n)
    imagesc(T_new_matrix(:,:,n));
    colorbar;
    set(gca, 'YDir', 'normal');
    title(['Time Period: ', decades{n}]);
    xticks(5:5:16);
    xticklabels(28:2.5:33.5);
    yticks(5:5:16);
    yticklabels(28:2.5:33.5);
end

sgtitle('Temp Transition Matrices- Rediscretized into 0.50-degree Bins');
[fileLoc, fileName] = fileparts(matlab.desktop.editor.getActiveFilename);
text(-5, -5, string(fileLoc));
text(-5, -6, string(fileName));

%% Inputs for temperature
N = 5;

% Change in temperature from one time period to next
climParam.T_min = 0;
climParam.T_max = 1.5;
climParam.T_delta = 0.5; % deg C
s_T = climParam.T_min: climParam.T_delta: climParam.T_max;
climParam.T0 = s_T(1);
climParam.T0_abs = 26;
M_T = length(s_T);

% Absolute temperature values
T_abs_max = max(s_T) * N;
s_T_abs = climParam.T0_abs : climParam.T_delta : climParam.T0_abs+ T_abs_max;
M_T_abs = length(s_T_abs);
T_bins = [s_T_abs-climParam.T_delta/2 s_T_abs(end)+climParam.T_delta/2];

numSamp = 25000;
decades = { '1990', '2010', '2030', '2050', '2070', '2090'};

% Starting point
T0 = s_T(1);
T0_abs = 26;

%% test using updated temperature transition matrices compared to previous discretization

numRuns = 100;

for M=1:numRuns
    % Set time series
    state_ind_T = zeros(1,N);
    state_ind_T(1) = find(T0_abs==s_T_abs);
    randGen = true;

    p = randi(numSamp,N-1);
    T_over_time = cell(1,N);

    for t = 1:N
            % Sample forward distribution given current state
            T_current = s_T_abs(state_ind_T(t));
            [T_over_time{t}] = T2forwardSimTempDiscretized(T_Temp_new, s_T_abs, N, t, T_current, numSamp, false, 4);

            % Sample next time period
            if randGen
                state_ind_T(t+1) = find(T_over_time{t}(p(t),2)==s_T_abs);
            end
           
    end
    
    if N==5
        state_ind_T_runs(M,:) = state_ind_T;
    end
end

T_state_test = s_T_abs(state_ind_T_runs);
T_bins_test = T_bins;
s_T_abs_test = s_T_abs;
%% compare to previous results for RCP8.5 temperature states

% load data for RCP8.5, 3% discount
cd('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Fletcher_2019_Learning_Climate/SDP');
load('results_RCP85A_01_Dec_2020_17_13_41.mat', 'T_state', 'P_state', 'T_bins', 's_T_abs');
T_state_RCP85 = T_state;

time = {'2001-2020', '2021-2040', '2041-2060', '2061-2080', '2081-2100'};
r1 = 'RCP4.5 ';
r2 = 'RCP8.5 ';

addpath('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Fletcher_2019_Learning_Climate/Plots/plotting utilities/cbrewer/cbrewer/cbrewer')
[clrmp1]=cbrewer('div', 'RdBu', 100, 'cubic');

% create matrices with all zeros
T_actual_Test = zeros(N, length(T_bins_test)-1); %re-discretized
T_actual_RCP85 = zeros(N, length(T_bins)-1);

% for each time period (N=1 to 5) find distribution of states
for i=1:5
    T_actual_RCP85(i, :) = histcounts(T_state_RCP85(:,i),T_bins);
    T_actual_Test(i, :) = histcounts(T_state_test(:,i+1), T_bins_test);
end

%% Histogram plots for comparison
figure;
for i=1:5
    subplot(5,2,i*2-1)
    histogram(T_state_test(:,i+1), T_bins_test);
    
    subplot(5,2,i*2)
    histogram(T_state_RCP85(:,i), T_bins);
end
%% Create 1D plot
C = {[0.6350, 0.0780, 0.1840], [0.8500, 0.3250, 0.0980], [0.4660, 0.6740, 0.1880],...
    [0, 0.4470, 0.7410], [0.4940, 0.1840, 0.5560]};

close all
figure('Position', [245 55 849 641]);
for i=1:5
    plot(s_T_abs, T_actual_RCP85(i, :)/10000, ...
        '--', 'color', C{i}, 'LineWidth', 1.5)
    hold on
    plot(s_T_abs_test, T_actual_Test(i, :)/1000, 'color', C{i}, 'LineWidth', 1.5);
    xlabel('Temp State (^oC)');
    ylabel('Probability')
    ax = gca;
    ax.FontSize = 16;
    test = {'RCP8.5 2001-2020', 'RCP8.5 Re-disc 2001-2020', 'RCP8.5 2021-2040', 'RCP8.5 Re-disc 2021-2040',...
        'RCP8.5 2041-2060', 'RCP8.5 Re-disc 2041-2060','RCP8.5 2061-2080', 'RCP8.5 Re-disc 2061-2080',...
        'RCP8.5 2081-2100', 'RCP8.5 Re-disc 2081-2100'}
    legend(test, 'location', 'northeast', 'FontSize', 14);
    l = legend('boxoff');
    title('Temperature States')
    %xlim([66 97])
end

%% Version 2 SSD w/ binning as follows: 1-1, 2-11, 12-21, ..., 142-151
k = size(T_Temp, 3);
t = size(T_Temp, 2);
d = 16; % new discretization
dt = round(t/(d-1));

% for every time period transition matrix, N
for l=1:5
    % for every column (time period n)
    count = 1;
    for j=1:dt:d*dt
        
        lower_limit = 1;
        % combine rows to go from 0.05 discretization to 0.5
        for i=1:d
%             if i == 1
%                 upper_limit = lower_limit;
%             else
%                 upper_limit = (i-1)*dt+1;
%             end
            upper_limit = (i-1)*dt+1;
         
            T_new_row(i) = sum(T_Temp(lower_limit:upper_limit,j,l));
            disp([count, lower_limit, upper_limit]);
            lower_limit = upper_limit + 1;
        end

        T_new_matrix(:,count,l) = T_new_row;
        count = count + 1;
    end
end

%T_Temp_new = zeros(16,16,5);
T_Temp_new = T_new_matrix;
