%% Figures 
% Load data and set path
if true
%addpath('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Mombasa_climate/SDP')
%load('results_RCP45A_01_Dec_2020_19_31_36.mat')
end
decade = {'2001-2020', '2021-2040', '2041-2060', '2061-2080', '2081-2100'};
decadeline = {'2001-\newline2020', '2021-\newline2040', '2041-\newline2060', '2061-\newline2080', '2081-\newline2100'};

C = {[0.6350, 0.0780, 0.1840], [0.8500, 0.3250, 0.0980], [0.4660, 0.6740, 0.1880],...
    [0, 0.4470, 0.7410], [0.4940, 0.1840, 0.5560]};
%% Optimal policies plots: Fig 4- updated to include RCP45 and RCP85

if true

% load RCP45 data
% load data for RCP4.5, 3% discount
addpath('/Volumes/Ultra Touch/FlexDamProject/Results/RCP45 Results-DamOpt-Jan2');
load('results_RCP45_03_Jan_2021_00_41_11.mat');

% Calculate initial threshold for RCP45
policy1_RCP45 =  X(:,:,1,1);
indexThresh_RCP45 = zeros(M_T_abs,1);
for i = 1:M_T_abs
    indexThresh_RCP45(i) = find(policy1_RCP45(i,:) == 3, 1);
end
threshP_RCP45 = s_P_abs(indexThresh_RCP45);

% Calculate flex exp threshold
policyflex_RCP45 = cell(1,4);
for i = 1:4
    policyflex_RCP45{i} = X(:,:,3,i+1);
end

threshPFlex_RCP45 = zeros(4, M_T_abs);
for j = 1:4
    indexThresh_RCP45 = zeros(M_T_abs,1);
    for i = 1:M_T_abs
        indexThresh_RCP45(i) = find(policyflex_RCP45{j}(i,:) == 0, 1);
    end
    threshPFlex_RCP45(j,:) = s_P_abs(indexThresh_RCP45);
end

%load RCP85 data
addpath('/Volumes/Ultra Touch/FlexDamProject/Results/RCP85 Results-DamOpt-Jan1');
load('results_RCP85_02_Jan_2021_12_31_56.mat');

% Calculate initial threshold for RCP85
policy1_RCP85 =  X(:,:,1,1);
indexThresh_RCP85 = zeros(M_T_abs,1);
for i = 1:M_T_abs
    indexThresh_RCP85(i) = find(policy1_RCP85(i,:) == 3, 1);
end
threshP_RCP85 = s_P_abs(indexThresh_RCP85);

% Calculate flex exp threshold
policyflex_RCP85 = cell(1,4);
for i = 1:4
    policyflex_RCP85{i} = X(:,:,3,i+1);
end

threshPFlex_RCP85 = zeros(4, M_T_abs);
for j = 1:4
    indexThresh_RCP85 = zeros(M_T_abs,1);
    for i = 1:M_T_abs
        indexThresh_RCP85(i) = find(policyflex_RCP85{j}(i,:) == 0, 1);
    end
    threshPFlex_RCP85(j,:) = s_P_abs(indexThresh_RCP85);
end

% load data for RCP T85/P45
addpath('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Operations/Fletcher_2019_Learning_Climate/SDP');
%load('results_nonopt_T85P45_25_Mar_2021_00_17_23.mat');
addpath('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Fletcher_2019_Learning_Climate/SDP');
load('results_nonopt_T85P45_29_Mar_2021_16_19_35.mat');

% Calculate initial threshold for T85P45
policy1_T85P45 =  X(:,:,1,1);
indexThresh_T85P45 = zeros(M_T_abs,1);
for i = 1:M_T_abs
    indexThresh_T85P45(i) = find(policy1_T85P45(i,:) == 3, 1);
end
threshP_T85P45 = s_P_abs(indexThresh_T85P45);

% Calculate flex exp threshold
policyflex_T85P45 = cell(1,4);
for i = 1:4
    policyflex_T85P45{i} = X(:,:,3,i+1);
end

threshPFlex_T85P45 = zeros(4, M_T_abs);
for j = 1:4
    indexThresh_T85P45 = zeros(M_T_abs,1);
    for i = 1:M_T_abs
        indexThresh_T85P45(i) = find(policyflex_T85P45{j}(i,:) == 0, 1);
    end
    threshPFlex_T85P45(j,:) = s_P_abs(indexThresh_T85P45);
end

% load data for RCP T45/P85
load('results_nonopt_T45P85_29_Mar_2021_16_07_55.mat');

% Calculate initial threshold for RCP85
policy1_T45P85 =  X(:,:,1,1);
indexThresh_T45P85 = zeros(M_T_abs,1);
for i = 1:M_T_abs
    indexThresh_T45P85(i) = find(policy1_T45P85(i,:) == 3, 1);
end
threshP_T45P85 = s_P_abs(indexThresh_T45P85);

% Calculate flex exp threshold
policyflex_T45P85 = cell(1,4);
for i = 1:4
    policyflex_T45P85{i} = X(:,:,3,i+1);
end

threshPFlex_T45P85 = zeros(4, M_T_abs);
for j = 1:4
    indexThresh_T45P85 = zeros(M_T_abs,1);
    for i = 1:M_T_abs
        indexThresh_T45P85(i) = find(policyflex_T45P85{j}(i,:) == 0, 1);
    end
    threshPFlex_T45P85(j,:) = s_P_abs(indexThresh_T45P85);
end

% Option 1: subplots
f = figure;
subplot(1,2,1)
plot(threshP_RCP45, s_T_abs, 'LineWidth', 1.5, 'Color', 'k')
hold on
plot(threshP_RCP85, s_T_abs, 'LineWidth', 2.5, 'Color', 'k', 'LineStyle', '--')
plot(threshP_T85P45, s_T_abs, 'LineWidth', 2, 'Color', 'blue', 'LineStyle', '-.')
%hold on
plot(threshP_T45P85, s_T_abs, 'LineWidth', 2, 'Color', 'red', 'LineStyle', '-.')
xlim([66, 83])
ylim([s_T_abs(1), s_T_abs(end)])
xlabel('Mean P [mm/m]')
ylabel('Mean T [degrees C]')
title('Initial policy')
ax = gca;
ax.FontSize = 16;
% added text to copy figure in paper
txt = 'Large static dam';
txt2 = 'Flexible dam';
text(67,33,txt, 'FontSize', 16);
text(75,28,txt2, 'FontSize', 16);
legend('RCP4.5', 'RCP8.5', 'T85, P45', 'T45, P85', 'Location', 'southeast');
l = legend('boxoff');
%legend('boxoff', 'Location', 'southeast');

subplot(1,2,2)
hold on
for i=1:4
    plot(threshPFlex_RCP45(i,:), s_T_abs, 'LineWidth', 1, 'Color', C{i})
    plot(threshPFlex_RCP85(i,:), s_T_abs, 'LineWidth', 1, 'Color', C{i}, 'LineStyle', '--')
    plot(threshPFlex_T85P45(i,:), s_T_abs, 'LineWidth', 1.5, 'Color', C{i}, 'LineStyle', '-.')
    plot(threshPFlex_T45P85(i,:), s_T_abs, 'LineWidth', 2, 'Color', C{i}, 'LineStyle', ':')
end
xlim([66, 83])
ylim([s_T_abs(1), s_T_abs(end)])
xlabel('Mean P [mm/mo]')
ylabel('Mean T [degrees C]')
title('Flexible dam policy')
ax = gca;
ax.FontSize = 16;
l = legend('2021-2040 RCP4.5', '2021-2040 RCP8.5', '2021-2040 T85P45', '2021-2040 T45P85', ...
    '2041-2060 RCP4.5', '2041-2060 RCP8.5', '2041-2060 T85P45', '2041-2060 T45P85', ...
    '2061-2080 RCP4.5', '2061-2080 RCP8.5', '2061-2060 T85P45', '2061-2060 T45P85',...
    '2081-2100 RCP4.5', '2081-2100 RCP8.5', '2081-2060 T85P45', '2081-2060 T45P85',...
    'Location', 'southeast')
%legend(decade{2:end}, 'Location', 'southeast');
l = legend('boxoff');
l.FontSize = 14;
l.Position = l.Position + [0.07 0 0 0];


% Option 2 combined
if false

f = figure;
plot(threshP, s_T_abs, 'LineWidth', 1.5, 'Color', 'k')
hold on
plot(threshPFlex, s_T_abs, 'LineWidth', 1.5)
xlim([70, 83])
ylim([s_T_abs(1), s_T_abs(end)])
xlabel('Mean P [mm/mo]')
ylabel('Mean T [degrees C]')

end


FigHandle = f;
figure_width = 5;
figure_height = 3;
font_size = 6;
line_width = 1;
export_ppi = 600;
print_png = true;
print_pdf = false;
savename = 'SDP plots/discounting 3 perc/sdp_policy2';
%printsetup(FigHandle, figure_width, figure_height, font_size, line_width, export_ppi, print_png, print_pdf, savename)


end


