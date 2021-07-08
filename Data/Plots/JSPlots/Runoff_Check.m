%% File to plot some 20-year monthly runoff samples for various, T and P states

close all
clear all

load('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Fletcher_2019_Learning_Climate/SDP/runoff_by_state_Mar16_knnboot_1t.mat');

runoff26_66 = movmean(mean(runoff{1,1}), 12);
runoff27_66 = movmean(mean(runoff{21,1}), 12);
runoff27_77 = movmean(mean(runoff{21, 12}), 12);
runoff29_77 = movmean(mean(runoff{61, 12}), 12);
runoff27_88 = movmean(mean(runoff{21, 23}), 12);
runoff29_88 = movmean(mean(runoff{61, 23}), 12);

figure;
plot(1:240, runoff26_66, 'Color', 'b');
hold on
plot(1:240, runoff27_66, 'LineStyle', '--', 'Color', 'b');
%hold on
plot(1:240, runoff27_77, 'Color', 'r');
plot(1:240, runoff29_77, 'Color', 'r', 'LineStyle', '--');
plot(1:240, runoff27_88, 'Color', [0,0.5,0]);
plot(1:240, runoff29_88, 'Color', [0,0.5,0], 'LineStyle', '--');

legend('T=26 deg C, P=66 mm/mo', 'T=27 deg C, P=66 mm/mo', 'T=27 deg C, P=77 mm/mo',...
    'T=29 deg C, P=77 mm/mo', 'T=27 deg C, P=88 mm/mo', 'T=29 deg C, P=88 mm/mo',...
    'Location', 'northwest');
xlabel('Month');
xlim([0 240]);
xticks([0,40,80,120,160,200,240]);
ylabel('Runoff (MCM/year)');
sgtitle('Moving Avg of Monthly Runoff for Various T, P States');

figure;
plot(mean(runoff{1,1}), 'Color', 'b');
hold on
plot(mean(runoff{21, 12}), 'Color', 'r');
plot(mean(runoff{21, 23}), 'Color', [0,0.5,0]);
legend('T=26 deg C, P=66 mm/mo', 'T=27 deg C, P=77 mm/mo',...
    'T=27 deg C, P=88 mm/mo','Location', 'northwest');
xlabel('Month');
xlim([0 240]);
xticks([0,40,80,120,160,200,240]);
ylabel('Runoff (MCM/year)');
sgtitle('Monthly Runoff for Various T, P States');