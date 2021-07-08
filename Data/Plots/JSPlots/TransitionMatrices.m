%% Plot color-coded images of 2D transition matrices

clear all
close all

addpath('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Mombasa_climate')
load('T_Temp_Precip_RCP45A.mat')
T_Temp_RCP45 = T_Temp;
T_Precip_RCP45 = T_Precip;

addpath('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Mombasa_climate/SDP')
%load('T_Temp_Precip_RCP45.mat')

%addpath('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Fletcher_2019_Learning_Climate/SDP')
load('T_Temp_Precip.mat')

addpath('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Fletcher_2019_Learning_Climate/Plots/plotting utilities/cbrewer/cbrewer/cbrewer')

% Get date for file name when saving results 
datetime=datestr(now);
datetime=strrep(datetime,':','_'); %Replace colon with underscore
datetime=strrep(datetime,'-','_');%Replace minus sign with underscore
datetime=strrep(datetime,' ','_');%Replace space with underscore


[clrmp1]=cbrewer('div', 'RdBu', 100, 'cubic');

%% Temp Matrices- 5 x 2

subplot(2,5,1)
imagesc(T_Temp_RCP45(:,:,2))
%colormap(clrmp1)
colorbar
xlabel('State i')
ylabel('State i+1')
axis square
set(gca, 'YDir', 'normal')
%ylim([18 34])
title('RCP 4.5 2000-2020')

subplot(2,5,2)
imagesc(T_Temp_RCP45(:,:,2))
colorbar
xlabel('State i')
ylabel('State i+1')
axis square
set(gca, 'YDir', 'normal')
title('RCP 4.5 2021-2040')

subplot(2,5,3)
imagesc(T_Temp_RCP45(:,:,3))
colorbar
xlabel('State i')
ylabel('State i+1')
axis square
set(gca, 'YDir', 'normal')
title('RCP 4.5 2041-2060')

subplot(2,5,4)
imagesc(T_Temp_RCP45(:,:,4))
colorbar
xlabel('State i')
ylabel('State i+1')
axis square
set(gca, 'YDir', 'normal')
title('RCP 4.5 2061-2080')

subplot(2,5,5)
imagesc(T_Temp_RCP45(:,:,5))
colorbar
xlabel('State i')
ylabel('State i+1')
axis square
set(gca, 'YDir', 'normal')
title('RCP 4.5 2081-2100')

subplot(2,5,6)
imagesc(T_Temp_RCP45(:,:,2))
colorbar
xlabel('State i')
ylabel('State i+1')
axis square
set(gca, 'YDir', 'normal')
title('RCP 8.5 2000-2020')

subplot(2,5,7)
imagesc(T_Temp_RCP45(:,:,2))
colorbar
xlabel('State i')
ylabel('State i+1')
axis square
set(gca, 'YDir', 'normal')
title('RCP 8.5 2021-2040')

subplot(2,5,8)
imagesc(T_Temp_RCP45_test(:,:,3))
colorbar
xlabel('State i')
ylabel('State i+1')
axis square
set(gca, 'YDir', 'normal')
title('RCP 8.5 2041-2060')

subplot(2,5,9)
imagesc(T_Temp_RCP45_test(:,:,4))
colorbar
xlabel('State i')
ylabel('State i+1')
axis square
set(gca, 'YDir', 'normal')
title('RCP 8.5 2061-2080')

subplot(2,5,10)
imagesc(T_Temp_RCP45_test(:,:,5))
colorbar
xlabel('State i')
ylabel('State i+1')
axis square
set(gca, 'YDir', 'normal')
title('RCP 8.5 2081-2100')

%subplot(3,1,3)
%imagesc(abs(T_Temp(:,:,1) - T_Temp_RCP45(:,:,1)))
%colormap(flipud(gray(256)));
%colorbar;

sgtitle(' Temperature Transition Matrices for RCP4.5 and RCP8.5')
savename_results = strcat('TempMatrix', datetime);
cd('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Fletcher_2019_Learning_Climate/Plots/JSPlots')
%print(savename_results,'-dpng')

%% Temperature Matrices- 3 x 2
close all

subplot(2,2,1)
imagesc(T_Temp_RCP45(:,:,1))
%colormap(flipud(gray(256)))
colorbar
xlabel('State i')
ylabel('State i+1')
yticks([50, 100, 150])
axis square
set(gca, 'YDir', 'normal')
title('RCP 4.5 2000-2020')

% subplot(2,1,1)
% imagesc(T_Temp_RCP45(:,:,3))
% colorbar
% xlabel('State i')
% ylabel('State i+1')
% axis square
% set(gca, 'YDir', 'normal')
% title('RCP 4.5 2041-2060')

subplot(2,2,2)
imagesc(T_Temp_RCP45(:,:,5))
colorbar
xlabel('State i')
ylabel('State i+1')
yticks([50, 100, 150])
axis square
set(gca, 'YDir', 'normal')
title('RCP 4.5 2081-2100')

subplot(2,2,3)
imagesc(T_Temp(:,:,1))
colorbar
xlabel('State i')
ylabel('State i+1')
yticks([50, 100, 150])
axis square
set(gca, 'YDir', 'normal')
title('RCP 8.5 2000-2020')

% subplot(2,1,2)
% imagesc(T_Temp(:,:,3))
% colorbar
% xlabel('State i')
% ylabel('State i+1')
% axis square
% set(gca, 'YDir', 'normal')
% title('RCP 8.5 2041-2060')

subplot(2,2,4)
imagesc(T_Temp(:,:,5))
colorbar
xlabel('State i')
ylabel('State i+1')
yticks([50, 100, 150])
axis square
set(gca, 'YDir', 'normal')
title('RCP 8.5 2081-2100')

sgtitle(' Temperature Transition Matrices for RCP4.5 and RCP8.5')
savename_results = strcat('TempMatrix_2x2_', datetime);
print(savename_results,'-dpng')


%% Precip Transition Matrices
close all

% subplot(2,2,1)
% imagesc(T_Precip_RCP45(:,:,1))
% colorbar
% xlabel('State i')
% ylabel('State i+1')
% yticks([10, 20, 30])
% axis square
% set(gca, 'YDir', 'normal')
% caxis([0 0.5])
% title('RCP 4.5 2000-2020')

% subplot(2,5,2)
% imagesc(T_Precip_RCP45(:,:,2))
% colorbar
% xlabel('State i')
% ylabel('State i+1')
% axis square
% set(gca, 'YDir', 'normal')
% caxis([0 0.5])
% title('RCP 4.5 2021-2040')

% subplot(2,2,2)
% imagesc(T_Precip_RCP45(:,:,3))
% colorbar
% xlabel('State i')
% ylabel('State i+1')
% axis square
% set(gca, 'YDir', 'normal')
% caxis([0 0.5])
% title('RCP 4.5 2041-2060')

% subplot(2,5,4)
% imagesc(T_Precip_RCP45(:,:,4))
% colorbar
% xlabel('State i')
% ylabel('State i+1')
% axis square
% set(gca, 'YDir', 'normal')
% caxis([0 0.5])
% title('RCP 4.5 2061-2080')

subplot(2,3,1)
imagesc(T_Precip_RCP45(:,:,1))
colorbar
xlabel('State i')
ylabel('State i+1')
yticks([10, 20, 30])
axis square
set(gca, 'YDir', 'normal')
caxis([0 0.5])
title('RCP 4.5 2000-2020')

subplot(2,3,4)
imagesc(T_Precip_RCP45_test(:,:,1))
colorbar
xlabel('State i')
ylabel('State i+1')
yticks([10, 20, 30])
axis square
set(gca, 'YDir', 'normal')
caxis([0 0.5])
title('RCP 4.5 Test')

subplot(2,3,2)
imagesc(T_Precip_RCP45(:,:,3))
colorbar
xlabel('State i')
ylabel('State i+1')
yticks([10, 20, 30])
axis square
set(gca, 'YDir', 'normal')
caxis([0 0.5])
title('RCP 4.5 2041-2060')

subplot(2,3,5)
imagesc(T_Precip_RCP45_test(:,:,3))
colorbar
xlabel('State i')
ylabel('State i+1')
yticks([10, 20, 30])
axis square
set(gca, 'YDir', 'normal')
caxis([0 0.5])
title('RCP 4.5 Test')

subplot(2,3,3)
imagesc(T_Precip_RCP45(:,:,5))
colorbar
xlabel('State i')
ylabel('State i+1')
yticks([10, 20, 30])
axis square
set(gca, 'YDir', 'normal')
caxis([0 0.5])
title('RCP 4.5 2081-2100')

subplot(2,3,6)
imagesc(T_Precip_RCP45_test(:,:,5))
colorbar
xlabel('State i')
ylabel('State i+1')
yticks([10, 20, 30])
axis square
set(gca, 'YDir', 'normal')
caxis([0 0.5])
title('RCP 4.5 Test')

%sgtitle('Precipitation Transition Matrices for RCP4.5 and RCP8.5')
savename_results = strcat('PrecipMatrix_2x1_2061_', datetime);
% fig.PaperPositionMode = 'manual'
% orient(fig, 'landscape')
%print(savename_results,'-dpng')

%% Precip Difference
close all

subplot(2,2,1)
imagesc(T_Precip_RCP45_test(:,:,1) - T_Precip_RCP45(:,:,1))
colormap(clrmp1);
c = colorbar;
caxis([-0.6 0.6])
c.Ticks=[-0.6 0 0.6];
axis square
set(gca, 'YDir', 'normal')
xlabel('State i')
ylabel('State i+1')
yticks([10, 20, 30])
title('Precip 2000-2020')

% subplot(3,1,2)
% imagesc(T_Precip(:,:,3) - T_Precip_RCP45(:,:,3))
% c = colorbar;
% caxis([-0.2 0.2])
% c.Ticks=[-0.2 0 0.2];
% axis square
% set(gca, 'YDir', 'normal')
% xlabel('State i')
% ylabel('State i+1')
% yticks([10, 20, 30])
% title('2041-2060')

subplot(2,2,2)
imagesc(T_Precip_RCP45_test(:,:,5) - T_Precip_RCP45(:,:,5))
c = colorbar;
caxis([-0.6 0.6])
c.Ticks=[-0.6 0 0.6];
axis square
set(gca, 'YDir', 'normal')
xlabel('State i')
ylabel('State i+1')
yticks([10, 20, 30])
title('Precip 2081-2100')

% sgtitle('Precip Trans Matrices for (RCP8.5 - RCP4.5)')
% savename_results = strcat('PrecipMatrixDiff', datetime);
% print(savename_results,'-dpdf', '-fillpage')

%% %% Temperature Value Difference
% close all

subplot(2,2,3)
t = imagesc(T_Temp_RCP45_test(:,:,1) - T_Temp_RCP45(:,:,1))
colormap(clrmp1);
colorbar;
caxis([-1 1])
xlabel('State i')
ylabel('State i+1')
yticks([50, 100, 150])
axis square
set(gca, 'YDir', 'normal')
title('Temp 2000-2020')

% subplot(2,2,2)
% imagesc(T_Temp(:,:,2) - T_Temp_RCP45(:,:,2))
% colorbar;
% caxis([-1 1])
% xlabel('State i')
% ylabel('State i+1')
% yticks([50, 100, 150])
% axis square
% set(gca, 'YDir', 'normal')
% title('2021-2040')

% subplot(2,2,3)
% imagesc(T_Temp(:,:,4) - T_Temp_RCP45(:,:,4))
% colorbar;
% caxis([-1 1])
% xlabel('State i')
% ylabel('State i+1')
% yticks([50, 100, 150])
% axis square
% set(gca, 'YDir', 'normal')
% title('2061-2080')
% % 
subplot(2,2,4)
imagesc(T_Temp_RCP45_test(:,:,5) - T_Temp_RCP45(:,:,5))
colorbar;
caxis([-1 1])
xlabel('State i')
ylabel('State i+1')
yticks([50, 100, 150])
axis square
set(gca, 'YDir', 'normal')
title('Temp 2081-2100')

sgtitle('T and P Differences (RCP4.5 Test - RCP4.5)')
savename_results = strcat('MatrixDifferences_2x2_', datetime);
%print(savename_results,'-dpng')
