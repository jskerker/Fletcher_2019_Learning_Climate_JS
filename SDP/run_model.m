function perc75 = run_model(x)

addpath('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Fletcher_2019_Learning_Climate/SDP');
addpath('/Users/jenniferskerker/Documents/GradSchool/Research/Project1/Code/Models/Fletcher_2019_Learning_Climate/Streamflow_yield_analysis');
x = round(x/5)*5
run('sdp_climate_opttest.m');
medCostFlex = median(sum(totalCostTime(:,:,3), 2));
meanCostFlex = mean(sum(totalCostTime(:,:,3), 2));
perc75 = prctile(sum(totalCostTime(:,:,3), 2),75);
perc90 = prctile(sum(totalCostTime(:,:,3), 2),90);
disp(medCostFlex)