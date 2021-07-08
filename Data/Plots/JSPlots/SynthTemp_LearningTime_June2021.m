%% Precip Plot- Create plot illustrating how this works- 3 x 3 for synthetic transition matrices and distributions
%Setup
clear all; close all
addpath('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Fletcher_2019_Learning_Climate')

N = 5;

% Percent change in precip from one time period to next
climParam.P_min = -.3;
climParam.P_max = .3;
climParam.P_delta = .02; 
s_P = climParam.P_min : climParam.P_delta : climParam.P_max;
climParam.P0 = s_P(15);
climParam.P0_abs = 77; %mm/month
M_P = length(s_P);

% Change in temperature from one time period to next
climParam.T_min = 0;
climParam.T_max = 1.5;
climParam.T_delta = 0.05; % deg C
s_T = climParam.T_min: climParam.T_delta: climParam.T_max;
climParam.T0 = s_T(1);
climParam.T0_abs = 26;
M_T = length(s_T);

% Absolute temperature values
T_abs_max = max(s_T) * N;
s_T_abs = climParam.T0_abs : climParam.T_delta : climParam.T0_abs+ T_abs_max;
M_T_abs = length(s_T_abs);
T_bins = [s_T_abs-climParam.T_delta/2 s_T_abs(end)+climParam.T_delta/2];

% Absolute percip values
P_abs_max = max(s_P) * N;
s_P_abs = 66:1:97;
M_P_abs = length(s_P_abs);
P_bins = [s_P_abs-climParam.P_delta/2 s_P_abs(end)+climParam.P_delta/2];

climParam = struct;
climParam.numSamp_delta2abs = 100000;
climParam.numSampTS = 100;
climParam.checkBins = true;

% Percent change in precip from one time period to next
climParam.P_min = -.3;
climParam.P_max = .3;
climParam.P_delta = .02; 
s_P = climParam.P_min : climParam.P_delta : climParam.P_max;
climParam.P0 = s_P(15);
climParam.P0_abs = 77; %mm/month
M_P = length(s_P);

% Change in temperature from one time period to next
climParam.T_min = 0;
climParam.T_max = 1.5;
climParam.T_delta = 0.05; % deg C
s_T = climParam.T_min: climParam.T_delta: climParam.T_max;
climParam.T0 = s_T(1);
climParam.T0_abs = 26;
M_T = length(s_T);

numSamp = 25000;
decades = { '1990', '2010', '2030', '2050', '2070', '2090'};

% Starting point
T0 = s_T(1);
T0_abs = 26;
P0 = s_P(15);
P0_abs = 77;

%fig = figure;

addpath('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Fletcher_2019_Learning_Climate/Plots/plotting utilities/cbrewer/cbrewer/cbrewer');
[clrmp1]=cbrewer('seq', 'Reds', N);
[clrmp2]=cbrewer('seq', 'Blues', N);
[clrmp3]=cbrewer('seq', 'Greens', N);
[clrmp4]=cbrewer('seq', 'Purples', N);
%set(fig,'Position', [680 558 1400 750])
%set(fig, 'Position', [357 215 770 500]);
rnd = randi(1000, 1);

addpath('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Fletcher_2019_Learning_Climate/Bayesian_Quant_Learning');
% files = {'KLDiv_drier1_29May2021', 'KLdiv_wetter1_30May2021.mat', ...
%     'KLDiv_drier4_29May2021', 'KLdiv_wetter4_30May2021.mat'};
files2 = {'T_Temp_Precip_dry1', 'T_Temp_Precip_mod1', 'T_Temp_Precip_wet1', ...
    'T_Temp_Precip_dry2', 'T_Temp_Precip_mod2', 'T_Temp_Precip_wet2', ...
    'T_Temp_Precip_dry4', 'T_Temp_Precip_mod4', 'T_Temp_Precip_wet4'};

scenarios = {'Dry, High Learning', 'Mod, High Learning', 'Wet, High Learning',...
    'Dry, Medium Learning', 'Mod, Medium Learning', 'Wet, Medium Learning',...
    'Dry, Low Learning', 'Mod, Low Learning', 'Wet, Low Learning'};

%% create figure
for b=1:1
figure('Position', [360 194 856 503]);

for k=1:1
    %load(files2{k});
    % Set time series
    state_ind_P = zeros(1,N);
    state_ind_P(1) =  find(P0_abs==s_P_abs);
    randGen = true;
    %state_ind_P(2:N) = [12 17 19 22];
    
%     MAR = cellfun(@(x) mean(mean(x)), runoff);
     p = randi(numSamp,N-1);
%     T_over_time = cell(1,N);
     P_over_time = cell(1,N);
%     MAR_over_time_wet = cell(1,N);
    
    for t = 1:N
        % Sample forward distribution given current state
        %T_current = s_T_abs(state_ind_T(t));
        P_current = s_P_abs(state_ind_P(t));
        %[T_over_time{t}] = T2forwardSimTemp(T_Temp, s_T_abs, N, t, T_current, numSamp, false);
        [P_over_time{t}] = T2forwardSimTemp(T_Precip, s_P_abs, N, t, P_current, numSamp, false);

        % Lookup MAR and yield for forward distribution
        %T_ind = arrayfun(@(x) find(x == s_T_abs), T_over_time{t});
        P_ind = arrayfun(@(x) find(x == s_P_abs), P_over_time{t});
        %[~,t_steps] = size(T_ind);
        %MAR_over_time_wet{t} = zeros(size(T_ind));
        %yield_over_time_wet{t} = zeros(size(T_ind));
%         for i = 1:numSamp
%             for j = 1:t_steps   
%                 MAR_over_time_wet{t}(i,j) = MAR(T_ind(i,j), P_ind(i,j), 1);
%                 yield_over_time_wet{t}(i,j) = unmet_dom(T_ind(i,j), P_ind(i,j),1, 1) ;   % 80 MCM storage
%             end
%         end

    
    
    % Sample next time period
        if k < 4
            if randGen
            %state_ind_T(t+1) = find(T_over_time{t}(p(t),2)==s_T_abs);
                state_ind_P(t+1) = find(P_over_time{t}(p(t),2)==s_P_abs);
            end
            if mod(k,3) == 1
                state_ind_P_dry = state_ind_P;
            elseif mod(k,3) == 2
                state_ind_P_mod = state_ind_P;
            else
                state_ind_P_wet = state_ind_P;
            end
        else
            if mod(k,3) == 1
                state_ind_P = state_ind_P_dry
            elseif mod(k,3) == 2
                state_ind_P = state_ind_P_mod
            else
                state_ind_P = state_ind_P_wet
            end
        end
    end

    for t =1:N
        x = t:N+1;
        X=[x,fliplr(x)];
    %     T_p01 = prctile(T_over_time{t},.01);
    %     T_p995 = prctile(T_over_time{t},99.9);
        P_p01 = prctile(P_over_time{t},.01);
        P_p995 = prctile(P_over_time{t},99.9);
    %     MAR_p01 = prctile(MAR_over_time{t},.01);
    %     MAR_p995 = prctile(MAR_over_time{t},99.9);
    %     yield_p01 = prctile(yield_over_time{t},.01);
    %     yield_p995 = prctile(yield_over_time{t},99.9);

        %subplot(3,3,k)
        
        Y=[P_p01,fliplr(P_p995)];
        hold on
        if mod(k,3) == 1
            fill(X,Y-P0_abs,clrmp1(t,:), 'LineWidth', 1);
        elseif mod(k,3) == 2
            fill(X,Y-P0_abs,clrmp3(t,:), 'LineWidth', 1);
        else
            fill(X,Y-P0_abs,clrmp2(t,:), 'LineWidth', 1);
        end
        scatter(t,s_P_abs(state_ind_P(t))-P0_abs, 'k', 'MarkerFaceColor', 'k') 
        xticks(1:6)
        xticklabels(decades)
        ylabel('mm/month')
        %ylim([-12 22]);
        if N==5
            % Calc precip using bin discretization
            KLDiv_Precip_Simple(k,:) = CalcKLDivergence(P_over_time, 3, 0, 1e-4, 50); 
        end
        
        KLdiv = KLDiv_Precip_Simple(k,10);
        %title([scenarios{k}, ' (', num2str(KLdiv, '%.3f'), ')'], 'FontSize', 12);
        set(gca,'Units','normalized')
        if t ==1
        yLabelHandle = get( gca ,'YLabel' );
        pos  = get( yLabelHandle , 'position' );
        pos1 = pos - [0.15 0 0]; 
        set( yLabelHandle , 'position' , pos1 );
        end

        frames(t) = getframe(gcf);

    end
end
sgtitle('Change in Monthly Precipitation Predictions in Low and High Learning, Wet and Dry Scenarios');
end

%% Expanded State Space Version
% Precip Plot- Create plot illustrating how this works- 3 x 3 for synthetic transition matrices and distributions
%Setup
clear all; close all
addpath('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Fletcher_2019_Learning_Climate')

N = 5;

% Percent change in precip from one time period to next
% climParam.P_min = -.3;
% climParam.P_max = .3;
% climParam.P_delta = .02; 
% s_P = climParam.P_min : climParam.P_delta : climParam.P_max;
% climParam.P0 = s_P(15);
% climParam.P0_abs = 77; %mm/month
% M_P = length(s_P);

% Absolute precip values
%P_abs_max = max(s_P) * N;
s_P_abs = 47:1:107;
M_P_abs = length(s_P_abs);
%P_bins = [s_P_abs-climParam.P_delta/2 s_P_abs(end)+climParam.P_delta/2];

% climParam = struct;
% climParam.numSamp_delta2abs = 100000;
% climParam.numSampTS = 100;
% climParam.checkBins = true;

% Percent change in precip from one time period to next
% climParam.P_min = -.3;
% climParam.P_max = .3;
% climParam.P_delta = .02; 
% s_P = climParam.P_min : climParam.P_delta : climParam.P_max;
% climParam.P0 = s_P(15);
% climParam.P0_abs = 77; %mm/month
% M_P = length(s_P);

numSamp = 25000;
decades = { '1990', '2010', '2030', '2050', '2070', '2090'};

% Starting point
%P0 = s_P(15);
P0_abs = 77;

%fig = figure;

addpath('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Fletcher_2019_Learning_Climate/Plots/plotting utilities/cbrewer/cbrewer/cbrewer');
[clrmp1]=cbrewer('seq', 'Reds', N);
[clrmp2]=cbrewer('seq', 'Blues', N);
[clrmp3]=cbrewer('seq', 'Greens', N);
[clrmp4]=cbrewer('seq', 'Purples', N);
%set(fig,'Position', [680 558 1400 750])
%set(fig, 'Position', [357 215 770 500]);
rnd = randi(1000, 1);

addpath('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Fletcher_2019_Learning_Climate/Bayesian_Quant_Learning');
% files = {'KLDiv_drier1_29May2021', 'KLdiv_wetter1_30May2021.mat', ...
%     'KLDiv_drier4_29May2021', 'KLdiv_wetter4_30May2021.mat'};
files2 = {'T_Temp_Precip_dry1', 'T_Temp_Precip_mod1', 'T_Temp_Precip_wet1', ...
    'T_Temp_Precip_dry2', 'T_Temp_Precip_mod2', 'T_Temp_Precip_wet2', ...
    'T_Temp_Precip_dry4', 'T_Temp_Precip_mod4', 'T_Temp_Precip_wet4'};

scenarios = {'Dry, High Learning', 'Mod, High Learning', 'Wet, High Learning',...
    'Dry, Medium Learning', 'Mod, Medium Learning', 'Wet, Medium Learning',...
    'Dry, Low Learning', 'Mod, Low Learning', 'Wet, Low Learning'};

%% run 100 instances to see how many "work" where the high learning scenarios have higher values
% than the mod and low learning
tic
for b=1:100

for k=1:9
    load(files2{k});
    % Set time series
    state_ind_P = zeros(1,N);
    state_ind_P(1) =  find(P0_abs==s_P_abs);
    randGen = true;
    
     p = randi(numSamp,N-1);
     P_over_time = cell(1,N);


    for t = 1:N
        % Sample forward distribution given current state
        P_current = s_P_abs(state_ind_P(t));
        [P_over_time{t}] = T2forwardSimTemp(T_Precip, s_P_abs, N, t, P_current, numSamp, false);
        P_ind = arrayfun(@(x) find(x == s_P_abs), P_over_time{t});
        
        % Sample next time period
        if k < 4
            if randGen
                state_ind_P(t+1) = find(P_over_time{t}(p(t),2)==s_P_abs);
            end
            if mod(k,3) == 1
                state_ind_P_dry = state_ind_P;
            elseif mod(k,3) == 2
                state_ind_P_mod = state_ind_P;
            else
                state_ind_P_wet = state_ind_P;
            end
        else
                if mod(k,3) == 1
                    state_ind_P = state_ind_P_dry;
                elseif mod(k,3) == 2
                    state_ind_P = state_ind_P_mod;
                else
                    state_ind_P = state_ind_P_wet;
                end
        end
    end

    KLDiv_Precip_Simple(k,:) = CalcKLDivergence(P_over_time, 3, 0, 1e-4, 50);
    

end
KLDiv(b,:) = transpose(KLDiv_Precip_Simple(:,10));
stateMsg = ['b = ', num2str(b)];
disp(stateMsg);
end
toc

% code to count number of runs where high learning greater than mod and low,
% and mod learning > low learning
count = 0;
for i=1:length(KLDiv)
    if (KLDiv(i,1) > KLDiv(i,4) && KLDiv(i,4) > KLDiv(i,7) && ...
        KLDiv(i,2) > KLDiv(i,5) && KLDiv(i,5) > KLDiv(i,8) && ...
        KLDiv(i,3) > KLDiv(i,6) && KLDiv(i,6) > KLDiv(i,9))
        count = count + 1;
    end
end

save('KLDiv_count')