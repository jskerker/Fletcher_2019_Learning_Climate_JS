%% Get condensed runoff by state file based on deterministic temperature states
% Last updated: July 1, 2021

clear all; close all;
T_det = [26.25 26.75 27.25 27.95 28.8]; % deterministic temperature values from RCP8.5 simulation data
N = 5;

% Abs precip values
s_P_abs = 66:1:97;
M_P_abs = length(s_P_abs);

% Change in temperature from one time period to next
climParam.T_min = 0;
climParam.T_max = 1.5;
climParam.T_delta = 0.05; % deg C (previously 0.05) -> will update to 0.50
s_T = climParam.T_min: climParam.T_delta: climParam.T_max;
climParam.T0 = s_T(1);
climParam.T0_abs = 26;
M_T = length(s_T);

% Absolute temperature values
T_abs_max = max(s_T) * N;
s_T_abs = climParam.T0_abs : climParam.T_delta : climParam.T0_abs+ T_abs_max;
M_T_abs = length(s_T_abs);

% Get indices for deterministic Temp values
for i=1:N
    ind(i) = find(s_T_abs == T_det(i));
end

%%
% Get T_ts and runoff data for temperature states
load('runoff_by_state_Mar16_knnboot_1t.mat');

% Get deterministic T_ts values
for i=1:N
    for j=1:N
        T_ts_det{i,j} = T_ts{ind(i),j};
    end
end

% Get deterministic runoff values
for i=1:N
    for j=1:M_P_abs
        for k=1:N
            runoff_det{i,j,k} = runoff{ind(i),j,k};
        end
    end
end

% overwrite data
runoff_old = runoff;
clear T_ts
clear runoff
T_ts = T_ts_det;
runoff = runoff_det;

save('runoff_by_state_DetTemp_Mar16_knnboot_1t', 'T_ts', 'P_ts', 'runoff');

%% Check that data aligns
samp = randi(100);
indRnd = randi(5);

plot(runoff_old{ind(indRnd),6,1}(samp,:), 'LineWidth', 1.5);
hold on
plot(runoff{indRnd,6,1}(samp,:), '--', 'LineWidth', 1.5);
test = runoff_old{ind(indRnd),6,1}(samp,:) - runoff{indRnd,6,1}(samp,:);
disp(max(test));