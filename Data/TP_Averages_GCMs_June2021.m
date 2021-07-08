%% get monthly averages for RCP8.5 temp and precip projections for each
% 20-year time period for Keani
% June 2021

% load data
addpath('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Fletcher_2019_Learning_Climate/Data');
load('Mombasa_TandP-45-85.mat');

%% Get averages across all GCMs for 20-year periods (monthly data)
% average across 21 GCMs
P85_avgGCM = mean(Pij_85, 2);
T85_avgGCM = mean(Tij_85, 2);

% average for 20-year time periods for each month
for i=1:5
    for j=1:12
        rng = j+480*(i-1):12:480*i;
        %disp(rng);
        P85_avgs(i,j) = mean(P85_avgGCM(rng));
        T85_avgs(i,j) = mean(T85_avgGCM(rng));
    end
    
end

save('Mombasa_TP85_avgs', 'P85_avgs', 'T85_avgs');
%% test January and October for one time period
rng_Jan20002020 = 1:12:480;
P85_Jan = Pij_85(rng_Jan20002020, :);
P85_avg_Jan = mean(P85_Jan, 'all');

rng_Oct20402060 = (10+960):12:1440;
P85_Oct = Pij_85(rng_Oct20402060, :);
P85_avg_Oct = mean(P85_Oct, 'all');
%% Plot data

figure('Position', [360 161 802 536]);
subplot(2,1,1)
plot(transpose(P85_avgs), 'LineWidth', 1.5);
xlim([1 12]);
xticks(1:1:12);
xticklabels({'Jan', 'Feb', 'Mar', 'Apr', 'May', 'June', 'July', 'Aug', 'Sept', 'Oct', 'Nov', 'Dec'});
xlabel('Month of the Year');
ylabel('Avg. Precip (mm/mo)');
set(gca, 'YScale', 'log');
legend('2000-2020', '2020-2040', '2040-2060', '2060-2080', '2080-2100', ...
    'Location', 'southeast');
legend('boxoff');
title('Monthly Precip Data for 20-Year Time Periods');

subplot(2,1,2)
plot(transpose(T85_avgs), 'LineWidth', 1.5);
xlim([1 12]);
xticks(1:1:12);
xticklabels({'Jan', 'Feb', 'Mar', 'Apr', 'May', 'June', 'July', 'Aug', 'Sept', 'Oct', 'Nov', 'Dec'});
xlabel('Month of the Year');
ylabel('Avg. Monthly Temp (^oC)');
title('Monthly Temp Data for 20-Year Time Periods');

sgtitle('Monthly Precip (Log Scale) and Temp Data for RCP8.5 GCMs for 20-year Time Periods', 'FontSize', 13);
