# Fletcher_2019_Learning_Climate_JS
This is a cleaned up version of files relevant to ongoing components of this project.

Title: Learning about climate change uncertainty enables flexible water infrastructure planning
Authors: Sarah Fletcher, Megan Lickely, and Kenneth Strzepek

READ ME

Code documentation by Sarah Fletcher
Massachusetts Institute of Technology
Last updated: January 2019


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

OVERVIEW AND INSTALLATION

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Code used and developed for this project comprises 3 main components:

1) Bayesian statistical model
3) Streamflow and yield analysis
3) Stochastic dynamic program (SDP)

Software used to run the code includes R and MATLAB (R2016b). Parts of the analysis were run on a supercomputing cluster.

All the code and data files in the github repository should be downloaded. No other special installation is required; installation download time is ~1 hr depending on internet download speed. 

In order to run on a new computer, you will need to change the project path in three places: BMA_code/MomUni_P.R line 16, BMA_code/MomUni_T.R line 16, and SDP/sdp_climate.m line 18 and 20. 

Please note that we have included the code and data necessary to generate the results presented in the paper. There were many other analyses done throughout to debug, check, plot, and validate individual pieces of the model; these are not inlcuded here given the large volume of code. 



~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

DATA

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Two data files used as input to the analysis are inlcuded in the "Data" folder.

1) "Mwache_streamflow_montly_1976to1990_JuneToMay_cumec.mat" 

	This data file contains monthly streamflow gauge data from 1976 to 1990 on the Mwache river.  These data was used to calibrate the rainfall-runoff model CLIRUN. This data was obtained from: 

	CES Consultants. (2013). Feasibility Study, Preliminary and Detailed Engineering Designs of Development of Mwache Multi-Purpose Dam Project along Mwache River: Hydrology Report. Nairobi, Kenya.


2) "Mombasa_TandP.mat"

	This data file contains historical monthly precipitation (P0) in mm/month and temperature data (T0) in degrees C from Climate Research Unit (CRU) dataset version TS.3.21 for 1901 to 2012. It also contains projected monthly precipitation (Pij) in mm/month and temperature data (Tij) in degrees C from an ensemble of 21 General Circulation Model projections from 1901 to 2100. The GCM ensembles used are listed (in the same order) in SI Table 1. These data are spatial averages over over 2 degrees S to 6 degrees S and 38 degrees E to 42 degrees E, overlaying the Mwache catchment.


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

INSTRUCTIONS

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Step 1: Run Bayeisan statistical model analysis

The code for the Bayesian statistical model is contained in the folder BMA_code. 
To complete this analysis the following steps are needed:

	1) Run pre_process_BMA.m in MATLAB. 

		This takes historical and projected climate data from the file Input/Mombasa_TandP.mat and formats it to prepare for the Bayeisan analysis.


	2) Run MomUni_P.R and MomUni_T.R scripts using R. Typical run time on a desktop computer is ~ 5 hours. 
	
		These scripts do batch analysis of the Bayesian modeling for each virtual future observation of T and P, resulting in a unique probability distribution for each. To do this, they call the script REA.Gibbs.r, which was graciously provided by Dr. Claudia Tebaldi at NCAR. This code reflects the Bayesian statistical analysis developed by Dr. Tebaldi and her colleagues in:

		Smith, R. L., Tebaldi, C., Nychka, D., & Mearns, L. O. (2009). Bayesian Modeling of Uncertainty in Ensembles of Climate Models. Journal of the American Statistical Association, 104(485), 97???116. https://doi.org/10.1198/jasa.2009.0007

		This results in a set of .mat files that start with "BMA_results_"  that will be used subsequently.



Step 2: Streamflow and yield analysis

	This analysis is directly incorporated into the script that runs the SDP optimaztion model, so it does not need to be run separately. However, there are three major components you may wish to review:

	1) Ranfall-runoff model

		We estimate runoff in the Mwache dam using the CLIRUN II rainfall-runoff model. See for additional information: Strzepek, K., & Mccluskey, A. l. (2010). Modeling the Impact of Climate Change on Global Hydrology and Water Availability.

		The folder "CLIRUN" contains all the code in this model. We calibrated this model using streamflow gauge data as described in the text of the paper. We considered several different calibrations and chose the one that had 1) a high R-squared 2) good validation against MAR, and 3) relatively insensitive to initial paramter values. Because the calibration process uses an approximate search algorithm and is sensitive to initial conditions, we include the calibrated model for reviewers' use. However, the calibration code can be inspected: see file "Calibrator.m" . The calibrated rainfall-runoff model can be run using the file "Simulator.m"

	2) Stochastic weather generator

		We develop monthly timeseries of temperature and precipitation for each of the possible 20-year mean T and P states using a k-nn bootstrapping approach developed by: Rajagopalan, B., & Lall, U. (1999). A k-nearest-neighbor Simulator for Daily Precipitation and Other Variables. Water Resources Research, 35(10), 3089???3101. https://doi.org/10.1029/1999WR900028

		This code can be found in the file "SDP/mean2TPtimeseriesMJL_2.m"

	3) Water system model (reservoir operations)

		We assume fixed reservoir operating policies based on storage thresholds. This can be found in the file "SDP/runoff2yield.m"


Step 3: Stochastic dynamic programming (SDP) and simulation

	The SDP planning model integrates the two previous pieces of analysis with cost information to develop optimal policies for developing and expanding infrastructure. Monte Carlo simulation is then used to see how the optimal policies developed by the SDP peform against cost and reliability objectives, as well as how static policies perform. 

	To complete this analysis there are two steps. Typical runtime on desktop computer is ~1 hour if existing intermeidate data files are used. 

	1) Run SDP

		The file "SDP/sdp_climate.m" is the main script used to run the SDP model. Other functions in the SDP folder are supporting functions called by the main file. Run parameters at the top of the file can be changed for sensitvity analysis on, for example, the shortage penalty, discount rate, and planning scenario (demand and prescence of desalination). Additionally, there are toggles to load previous components of the analysis: for example, the stochastic runoff time series can be saved and called in later runs for sensitivity analysis. The output includes the optimal SDP policies.

	2) Run forward Monte Carlo simulation

		This is the last section in the "SDP/sdp_climate.m" script. Setting runParam.forwardSim to true will enable the simulation to run.

	3) Plots

		The figures in the paper can be generated using the three files in the Plots folder that end with "plots.m" . Saved results are from following the previous steps can be found in the files "SDP/results...[A,B, or C]..." corresponding to Planning Scenarios A, B, and C in Table 1. Please note that the Bayesian updating figure randomly selects a unique time series on each run, so it will not appear exactly like the plot in the paper. 









