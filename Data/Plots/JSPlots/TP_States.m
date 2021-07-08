% Plot time series of transition matrices
clear all
close all

% Get date for file name when saving results 
datetime=datestr(now);
datetime=strrep(datetime,':','_'); %Replace colon with underscore
datetime=strrep(datetime,'-','_');%Replace minus sign with underscore
datetime=strrep(datetime,' ','_');%Replace space with underscore

%load data
addpath('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Fletcher_2019_Learning_Climate/SDP')
% Pre-rounded RCP8.5 data
% load('results_RCP85_02_Dec_2020_16_47_59.mat', 'T_state', 'P_state', 'T0samp', 'P0samp')
% T_state_RCP85_orig = T_state
% P_state_RCP85_orig = P_state
% T0_RCP85_orig = mean(T0samp)
% P0_RCP85_orig = mean(P0samp)

% New RCP8.5A data
load('results_RCP85A_01_Dec_2020_17_13_41.mat', 'T_state', 'P_state', 'T0samp', 'P0samp', 'N')
T_state_RCP85A = T_state
P_state_RCP85A = P_state
T0_RCP85A = mean(T0samp)
P0_RCP85A = mean(P0samp)

% New RCP8.5B data
load('results_RCP85B_06_Dec_2020_11_54_46.mat', 'T_state', 'P_state', 'T0samp', 'P0samp', 'N')
T_state_RCP85B = T_state
P_state_RCP85B = P_state
T0_RCP85B = mean(T0samp)
P0_RCP85B = mean(P0samp)

addpath('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Mombasa_climate/SDP')
% New RCP4.5A data
load('results_RCP45A_01_Dec_2020_19_31_36.mat', 'T_state', 'P_state','T0samp', 'P0samp')
T_state_RCP45A = T_state
P_state_RCP45A = P_state
T0_RCP45A = mean(T0samp)
P0_RCP45A = mean(P0samp)

% New RCP4.5B data
load('results_RCP45B_02_Dec_2020_11_43_47.mat', 'T_state', 'P_state', 'T0samp', 'P0samp')
T_state_RCP45B = T_state
P_state_RCP45B = P_state
T0_RCP45B = mean(T0samp)
P0_RCP45B = mean(P0samp)

time = [1990, 2010, 2030, 2050, 2070]
r1 = randperm(10000,100);

%% Plot data

subplot(2,1,1)
for i= 1:100
    plot(time, T_state_RCP45A(r1(i), :), 'Color', 'r')
    hold on
    plot(time, T_state_RCP45B(r1(i), :), 'Color', 'b')
end
xlabel('Year')
legend('RCP4.5A', 'RCP4.5B', 'Location', 'northwest')
xticks(time)
xticklabels(time)
ylabel('Temp (^oC)')
title('Temperature')

subplot(2,1,2)
for i= 1:100
    plot(time, P_state_RCP45A(r1(i), :), 'Color', 'r')
    hold on
    plot(time, P_state_RCP45B(r1(i), :), 'Color', 'b')
end
xlabel('Year')
xticks(time)
xticklabels(time)
ylabel('Precip (mm/month)')
title('Precipitation')

%% Save figure

sgtitle(' Sample Temperature and Precipitation States')
savename_results = strcat('TimeSeries', datetime);
cd('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Fletcher_2019_Learning_Climate/Plots/JSPlots')
print(savename_results,'-dpng')

%% Plot example for mu/nu illustration

i = round(rand*10000,0);
plot(time, T_state_RCP85A(i, :)-T0_RCP85A, 'Color', 'k', 'LineWidth', 2.5, ...
    'Marker', 'o','MarkerSize', 12, 'MarkerFaceColor', 'k');


xp = xlabel('Year')
xp.Position = xp.Position + [10 0 0]
%legend('RCP8.5 Orig', 'RCP8.5A', 'RCP8.5B', 'Location', 'northwest')
xticks(time)
xticklabels(time)
ylabel('Temp (^oC)')
ylim([-0.2 3]);
%title('\DeltaTemperature')
ax = gca;
ax.FontSize = 16;

%% Delta T and and % delta P
close all

subplot(2,1,1)
for i= 1:100
%     plot(time, T_state_RCP85_orig(r1(i), :)-T0_RCP85_orig, 'Color', [0.39 0.83 0.07]);
%     hold on
    plot(time, T_state_RCP85A(r1(i), :)-T0_RCP85A, 'Color', 'r');
    hold on
    plot(time, T_state_RCP85B(r1(i), :)-T0_RCP85B, 'Color', 'b');
end
xlabel('Year')
legend('RCP8.5 Orig', 'RCP8.5A', 'RCP8.5B', 'Location', 'northwest')
xticks(time)
xticklabels(time)
ylabel('Temp (^oC)')
title('\DeltaTemperature')


subplot(2,1,2)
for i= 1:100
%     plot(time, (P_state_RCP85_orig(r1(i), :)-P0_RCP85_orig) ./ P0_RCP85_orig, 'Color', [0.39 0.83 0.07])
%     hold on
    plot(time, (P_state_RCP85A(r1(i), :)-P0_RCP85A) ./ P0_RCP85A, 'Color', 'r')
    hold on
    plot(time, (P_state_RCP85B(r1(i), :)-P0_RCP85B) ./ P0_RCP85B, 'Color', 'b')
end
xlabel('Year')
xticks(time)
xticklabels(time)
ylabel('Precip (% Change)')
title('% \DeltaPrecipitation')

sgtitle(' Sample \DeltaT and %\DeltaP States')
savename_results = strcat('TimeSeries_Deltas_', datetime);
cd('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Fletcher_2019_Learning_Climate/Plots/JSPlots')
%print(savename_results,'-dpng')

%% Delta T and and % delta P for RCP4.5 comparison
close all

subplot(2,1,1)
for i= 1:100
%     plot(time, T_state_RCP45A(r1(i), :)-T0_RCP45A, 'Color', 'r')
%     hold on
    plot(time, T_state_RCP45B(r1(i), :)-T0_RCP45B, 'Color', 'b')
    hold on
%     plot(time, T_state_RCP85A(r1(i), :)-T0_RCP85A, 'Color', [0.39 0.83 0.07])
%     hold on
    plot(time, T_state_RCP85B(r1(i), :)-T0_RCP85B, 'Color', [0.49 0.18 0.56])
    hold on
end
xlabel('Year')
legend('RCP4.5A', 'RCP4.5B', 'RCP8.5A', 'RCP8.5B', 'Location', 'northwest')
xticks(time)
xticklabels(time)
ylabel('Temp (^oC)')
title('\DeltaTemperature')

subplot(2,1,2)
for i= 1:100
    plot(time, (P_state_RCP45A(r1(i), :)-P0_RCP45A) ./ P0_RCP45A, 'Color', 'r')
    hold on
%     plot(time, (P_state_RCP45B(r1(i), :)-P0_RCP45B) ./ P0_RCP45B, 'Color', 'b')
%     hold on
    plot(time, (P_state_RCP85A(r1(i), :)-P0_RCP85A) ./ P0_RCP85A, 'Color', [0.39 0.83 0.07])
    hold on
    plot(time, (P_state_RCP85B(r1(i), :)-P0_RCP85B) ./ P0_RCP85B, 'Color', [0.49 0.18 0.56])
end
xlabel('Year')
xticks(time)
xticklabels(time)
ylabel('Precip (% Change)')
title('% \DeltaPrecipitation')

sgtitle(' Sample \DeltaT and %\DeltaP States')
savename_results = strcat('TimeSeries_Deltas_', datetime);
cd('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Fletcher_2019_Learning_Climate/Plots/JSPlots')
%print(savename_results,'-dpng')

%% Delta T and and % delta P to compare to GCM data
% updated January 17, 2021
close all

subplot(2,1,1)
for i= 1:100
    plot(time, T_state_RCP45B(r1(i), :)-T0_RCP45B, 'Color', 'r')
    hold on
    plot(time, T_state_RCP85B(r1(i), :)-T0_RCP85B, 'Color', 'b')
end
xlabel('Year')
legend('RCP4.5', 'RCP8.5', 'Location', 'northwest')
ax = gca;
ax.FontSize = 14;
xticks(time)
xticklabels(time)
ylabel('Temp (^oC)')
title('\DeltaTemperature')

subplot(2,1,2)
for i= 1:100
    plot(time, (P_state_RCP45A(r1(i), :)-P0_RCP45A) ./ P0_RCP45A*100, 'Color', 'r')
    hold on
    plot(time, (P_state_RCP85A(r1(i), :)-P0_RCP85A) ./ P0_RCP85A*100, 'Color', 'b')
end
xlabel('Year')
ax = gca;
ax.FontSize = 14;
xticks(time)
xticklabels(time)
ylabel('Precip (% Change)')
title('% \DeltaPrecipitation')

sgtitle(' Sample \DeltaT and %\DeltaP States')
savename_results = strcat('TimeSeries_Deltas_', datetime);
cd('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Fletcher_2019_Learning_Climate/Plots/JSPlots')
%print(savename_results,'-dpng')
%% Create boxplots- A comparison

close all
figure('Position', [1307 -142 1074 946]);

subplot(2,1,1)
pos_1 = 1.2:1:5.2;
b1 = boxplot(T_state_RCP45A-T0_RCP45A, 'colors', 'r', 'positions', pos_1, 'width',...
    0.15, 'symbol', '')
hold on

pos_2 = 1.4:1:5.4;
b2 = boxplot(T_state_RCP45B-T0_RCP45B, 'colors', 'b', 'positions', pos_2, 'width', 0.15,...
    'symbol', '')
hold on

pos_3 = 1.6:1:5.6;
b3 = boxplot(T_state_RCP85A-T0_RCP85A, 'colors', [0.39 0.83 0.07], 'positions', pos_3, 'width', 0.15,...
    'symbol', '')
hold on

pos_4 = 1.8:1:5.8;
b4 = boxplot(T_state_RCP85B-T0_RCP85B, 'colors', [0.49 0.18 0.56], 'positions', pos_4, 'width', 0.15,...
    'symbol', '')
hold on
xlim([1 6])

legend([b1(4,1), b2(4,1), b3(4,1), b4(4,1)], {'RCP4.5A', 'RCP4.5B', 'RCP8.5A', 'RCP8.5B'}, 'Location', 'northwest');
set(gca, 'XTickLabel', time)
xlabel('Year')
ylabel('\DeltaT (^oC)')
title('\DeltaT for Each Time Period')

subplot(2,1,2)
pos_1 = 1.2:1:5.2;
b1 = boxplot((P_state_RCP45A-P0_RCP45A) ./ P0_RCP45A, 'colors', 'r', 'positions', pos_1, 'width',...
    0.15, 'symbol', '')
hold on

pos_2 = 1.4:1:5.4;
b2 = boxplot((P_state_RCP45B-P0_RCP45B) ./ P0_RCP45B, 'colors', 'b', 'positions', pos_2, 'width', 0.15,...
    'symbol', '')
hold on

pos_2 = 1.6:1:5.6;
b3 = boxplot((P_state_RCP85A-P0_RCP85A) ./ P0_RCP85A, 'colors', [0.39 0.83 0.07], 'positions', pos_3, 'width', 0.15,...
    'symbol', '')
hold on

pos_2 = 1.8:1:5.8;
b4 = boxplot((P_state_RCP85B-P0_RCP85B) ./ P0_RCP85B, 'colors', [0.49 0.18 0.56], 'positions', pos_4, 'width', 0.15,...
    'symbol', '')
hold on

xlim([1 6]);
set(gca, 'XTickLabel', time)
xlabel('Year')
ylabel('% \DeltaP')
title('%\DeltaP for Each Time Period')

%% Create boxplots for RCP8.5 comparison

close all

pos_1 = 0.9:1:4.9; %first time period is not showing up- fix this
subplot(2,1,1)
b1 = boxplot(T_state_RCP85_orig-T0_RCP85_orig, 'colors', [0.39 0.83 0.07], 'positions', pos_1, 'width',...
    0.2, 'symbol', '')
hold on

pos_2 = 1.1:1:5.1;
b2 = boxplot(T_state_RCP85A-T0_RCP85A, 'colors', 'r', 'positions', pos_2, 'width', 0.2,...
    'symbol', '')
hold on

pos_3 = 1.3:1:5.3;
b3 = boxplot(T_state_RCP85B-T0_RCP85B, 'colors', 'b', 'positions', pos_3, 'width', 0.2,...
    'symbol', '')

legend([b1(4,1), b2(4,1), b3(4,1)], {'RCP8.5A Original', 'RCP8.5A', 'RCP8.5B'}, 'Location', 'northwest');
set(gca, 'XTickLabel', time)
xlabel('Year')
ylabel('\DeltaT (^oC)')
title('\DeltaT for Each Time Period')


subplot(2,1,2)
pos_1 = 0.9:1:4.9;
box_RCP85_orig = boxplot((P_state_RCP85_orig-P0_RCP85_orig) ./ P0_RCP85_orig, 'colors', [0.39 0.83 0.07], 'positions', pos_1, 'width',...
    0.2, 'symbol', '')

hold on

pos_2 = 1.1:1:5.1;
box_RCP85 = boxplot((P_state_RCP85A-P0_RCP85A) ./ P0_RCP85A, 'colors', 'r', 'positions', pos_2, 'width', 0.2,...
    'symbol', '')


pos_3 = 1.3:1:5.3;
box_RCP85 = boxplot((P_state_RCP85B-P0_RCP85B) ./ P0_RCP85B, 'colors', 'b', 'positions', pos_3, 'width', 0.2,...
    'symbol', '')


set(gca, 'XTickLabel', time)
xlabel('Year')
ylabel('% \DeltaP')
title('%\DeltaPrecip for Each Time Period')