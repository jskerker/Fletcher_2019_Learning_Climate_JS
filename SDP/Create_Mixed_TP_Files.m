%% Create file with mixed Temp/Precip RCP4.5/RCP8.5 files
clear all

% load RCP4.5 files
addpath('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Mombasa_climate/SDP')

load('T_Temp_Precip_RCP45A')
T_Temp_RCP45{1} = T_Temp;
T_Precip_RCP45{1} = T_Precip;

load('T_Temp_Precip_RCP45B')
T_Temp_RCP45{2} = T_Temp;
T_Precip_RCP45{2} = T_Precip;

% load RCP8.5 files
addpath('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Fletcher_2019_Learning_Climate/SDP')

load('T_Temp_Precip_RCP85A')
T_Temp_RCP85{1} = T_Temp;
T_Precip_RCP85{1} = T_Precip;

load('T_Temp_Precip_RCP85B')
T_Temp_RCP85{2} = T_Temp;
T_Precip_RCP85{2} = T_Precip;

% Set path for saving files
cd('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Fletcher_2019_Learning_Climate/SDP');

% Create RCP4.5 Temp/RCP8.5 Precip file to run
X = randi(2,1,2);
T_Temp = T_Temp_RCP45{X(1)};
T_Precip = T_Precip_RCP85{X(2)};
save('T_Temp45_Precip85', 'T_Temp', 'T_Precip');

% Create RCP8.5 Temp/RCP4.5 Precip file to run
X = randi(2,1,2);
T_Temp = T_Temp_RCP85{X(1)};
T_Precip = T_Precip_RCP45{X(2)};
save('T_Temp85_Precip45', 'T_Temp', 'T_Precip');