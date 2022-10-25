# CAFOs-EJ

In the data cleaning, We build a data set that combines information of both swine and poultry farms with detailed household-level demographic micro-data InfoUSA.
After geocoding InfoUSA and farm data, we first identify the block/block group and community water system for each household. 
By calculating the distance between InfoUSA household and animal farms, we calculate the aggregated CAFO exposure for each household. 
We use R package ``wru" to impute individual race/ethnicity. The package utilizes the Bayes’ Rule and use individual surname and geo-location (e.g., census block) to compute the posterior probability of each racial category for any given individual. In this study, we use households' surnames and census block to impute race. 

In the data analysis, we first plot the actual CAFO exposure at each income level for each race and bootstrap the corresponding 95% confidence intervals. 
In the second panel, we plot the difference in the exposure between minority group and White residents and in the third panel, we show how these differences vary across drinking water sources. 
In the last part, we calculate the joint probability of being exposed to hog and poultry CAFOs – i.e., being exposed to neither type of CAFO, being exposed to either hogs or poultry, or being exposed to both hogs and poultry. 


# Data
Data sets are publicly available (in https://github.com/Duke-EJ-Lab/CAFOs-EJ/tree/main/data/PublicData):
-	Census data: 2010 Census Block Group data and 2010 Census Urban Area
-	Hog farm data: animal facility map data are provided by NC DEQ.
-	Community water data are managed by the NC DEQ Division of Water Resources.

Data sets used under Data User Agreement:
-	InfoUSA are accessed  under a use agreement with Duke University.
-	Poultry farm data are accessed under an agreement with Environmental Working Group.

# Codes
The codes are separated into "Data Cleaning" and "Data Analysis" and both are uploaded to https://github.com/Duke-EJ-Lab/CAFOs-EJ/tree/main/codes

## Data Cleaning:
- 0_ArcGIS_DataCleaning.docx describes the ArcGIS analyses in this study.
- 1_InfoUSA_WRUrace.do and 1_wru_infousa_race.R uses R package "WRU" to impute InfoUSA races.
- 2_InfoUSA_CWS_Urban_Coastline.do cleans and merges InfoUSA data with community water system, urban area, and coast area data.
- 3_CAFOExposure.do calculates hog/poultry exposure
- 4_FinalDataCleaning.do generates the data for data analysis.


## Data Analysis:
- To smooth the plots, we use moving average calculation to average the points at nearby income levels for each income. 
All codes regarding exposure plots need to use MATLAB codes func_SampleDraw.m, func_MA_CAFO.m, and func_CI95.m.
- Folder https://github.com/Duke-EJ-Lab/CAFOs-EJ/tree/main/codes/Data%20Analysis/1_ExposurePlots plots the hog/poultry exposure for each race.
- Folder https://github.com/Duke-EJ-Lab/CAFOs-EJ/tree/main/codes/Data%20Analysis/2_ExposureDiff plots the exposure difference between Black and white, 
and Hispanics and white.
- Folder https://github.com/Duke-EJ-Lab/CAFOs-EJ/tree/main/codes/Data%20Analysis/3_BivariateProbit runs the bivariate probit. 



