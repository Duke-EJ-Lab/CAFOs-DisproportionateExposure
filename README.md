# Disproportionate Exposure to Confined Animal Feeding Operations (CAFOs) in Eastern NC 

This analysis seeks to investigate the differences in exposure to CAFOs, accounting for race and ethniciy, renter/owner status, and method of access to water in the home for both hog and poultry CAFOs. 

In the data cleaning we:
* geocode InfoUSA and farm data
* identify water systems for each household
* find the distance between our InfoUSA households and CAFO's, then calculate the aggregated CAFO exposure for each household by drawing a (3-5km) buffer around each home and calculating the total "steady state live weight" (SSLW) of hog CAFOs and the total bird counts in poultry CAFOs that fall within that buffer. 
* impute individual race + ethnicity using the `wru` R package. The package uses the individual surnames and census block to compute the posterior probability of each racial category for each individual.

In the data analysis we: 
* plot actual CAFO exposure at each income level for each race, and bootstrap the 95% confidence intervals
* plot the difference in exposure between minority and white residents, and show how those differences vary across drinking water sources. 
* calculate the joint probability of being exposed to hot and poultry CAFOs – i.e., being exposed to neither type of CAFO, being exposed to either hogs or poultry, or being exposed to both hogs and poultry. 


# Data

Publicly available datasets can be found in the [data folder](https://github.com/Duke-EJ-Lab/CAFOs-DisproportionateExposure/tree/main/data/PublicData) of this repo:
*	Census data: 2010 Census Block Group data and 2010 Census Urban Area
*	Hog farm data: animal facility map data are provided by NC DEQ.
*	Community water data are managed by the NC DEQ Division of Water Resources.

Data sets that were used under Data Use Agreements have example rows in the [Data under DUA](https://github.com/Duke-EJ-Lab/CAFOs-DisproportionateExposure/tree/main/data/Data%20under%20DUA) folder:
* These are completely made up rows with common names and ID's that don't exist in the data to give a sense of the format of the original data. 
*	InfoUSA are accessed  under a use agreement with Duke University.
*	Poultry farm data are accessed under an agreement with Environmental Working Group.

# Code

The code is separated into "Data Cleaning" and "Data Analysis".

## Data Cleaning:
- 0_ArcGIS_DataCleaning.docx describes the ArcGIS analyses in this study.
- 1_InfoUSA_WRUrace.do and 1_wru_infousa_race.R uses R package "WRU" to impute InfoUSA races.
- 2_InfoUSA_CWS_Urban_Coastline.do cleans and merges InfoUSA data with community water system, urban area, and coast area data.
- 3_CAFOExposure.do calculates hog/poultry exposure
- 4_FinalDataCleaning.do generates the data for data analysis.


## Data Analysis:
* To smooth the plots, we use moving average calculation to average the points at nearby income levels for each income. All code used to build exposure plots references the MATLAB files `func_SampleDraw.m`, `func_MA_CAFO.m`, and `func_CI95.m`.
* The `1_ExposurePlots` folder contains code to plot the hog/poultry exposure for each race.
* The `2_ExposureDiff` folder contains code that plots the exposure difference for black, hispanic and white populations.
* The `3_BivariateProbit` folder runs the bivariate probit code. 



