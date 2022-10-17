

************************* import block data *********************
*** import data
import delimited InfoUSA2014_2010CensusBlck.csv, clear
*** drop households who do not geographically fall in any block
count if join_count == 0
drop if join_count == 0
*** variables cleaning
rename orig_fid Orig_fid
keep Orig_fid familyid geoid10 ge_latitude_2010 ge_longitude_2010 childrenhhcount wealth_finder_score find_div_1000 owner_renter_status estmtd_home_val_div_1000 marital_status city state zip zip4 vacant ge_census_level_2010 ge_census_state_2010 ge_census_county ge_census_tract ge_census_bg ge_als_county_code_2010 ge_als_census_tract_2010 ge_als_census_bg_2010 first_name_1 last_name_1 ethnicity_code_1 first_name_2 last_name_2 ethnicity_code_2 first_name_3 last_name_3 ethnicity_code_3 total_pop
order Orig_fid familyid geoid10 ge_latitude_2010 ge_longitude_2010 childrenhhcount wealth_finder_score find_div_1000 owner_renter_status estmtd_home_val_div_1000 marital_status city state zip zip4 vacant ge_census_level_2010 ge_census_state_2010 ge_census_county ge_census_tract ge_census_bg ge_als_county_code_2010 ge_als_census_tract_2010 ge_als_census_bg_2010 first_name_1 last_name_1 ethnicity_code_1 first_name_2 last_name_2 ethnicity_code_2 first_name_3 last_name_3 ethnicity_code_3 total_pop
*** geoid10 is the block codes 
save InfoUSA_CensusBlck_2014.dta,replace 



************************* prepare InfoUSA data for wru R codes *********************
use InfoUSA_CensusBlck_2014.dta,clear
keep Orig_fid familyid geoid10 ge_latitude_2010 ge_longitude_2010 last_name_1 vacant
*** generate tract variable
rename geoid10 CensusBlck_2010
gen CensusTract_2010 = substr(CensusBlck_2010,1,11)
* separate variable into state, county, tract, block
gen STATE = "NC"
gen statefp10 = substr(CensusBlck_2010,1,2)
gen countyfp10 = substr(CensusBlck_2010,3,3)
gen tractce10 = substr(CensusBlck_2010,6,6)
gen blockce10 = substr(CensusBlck_2010,12,4)
* string family id
tostring (familyid), generate (familyid_string) format(%18.0f) force
rename familyid_string familyid
*** generate last name variable (capitalize first letter)
gen LastName = proper(last_name_1)
order Orig_fid familyid ge_latitude_2010 ge_longitude_2010 CensusTract_2010 CensusBlck_2010 STATE statefp10 countyfp10 tractce10 blockce10 last_name_1 vacant
outsheet using InfoUSA_TractBlock_2014.csv, replace


************************* R steps *********************
** (1): run R codes: 1_wru_infousa_race.R
** (2): get the exported csv data: InfoUSA2014_WruRace.csv


************************* generate race dta data ******************************
*** import csv data from R step
import delimited InfoUSA2014_WruRace.csv, clear
format %16.0g familyid
sort familyid
drop v1 code
*** race variable
rename race race_wru
rename orig_fid Orig_fid
save InfoUSA_WruRace_2014.dta,replace




************** generate blckgrp data *************
*** import data
import delimited InfoUSA2014_2010CensusBlckgrp.csv, clear
*** drop households who do not geographically fall in any block
count if join_count == 0
drop if join_count == 0
*** variables cleaning
rename orig_fid Orig_fid
keep Orig_fid familyid geoid10 ge_latitude_2010 ge_longitude_2010 childrenhhcount wealth_finder_score find_div_1000 owner_renter_status estmtd_home_val_div_1000 marital_status city state zip zip4 vacant ge_census_level_2010 ge_census_state_2010 ge_census_county ge_census_tract ge_census_bg ge_als_county_code_2010 ge_als_census_tract_2010 ge_als_census_bg_2010 first_name_1 last_name_1 ethnicity_code_1 first_name_2 last_name_2 ethnicity_code_2 first_name_3 last_name_3 ethnicity_code_3 total_pop
order Orig_fid familyid geoid10 ge_latitude_2010 ge_longitude_2010 childrenhhcount wealth_finder_score find_div_1000 owner_renter_status estmtd_home_val_div_1000 marital_status city state zip zip4 vacant ge_census_level_2010 ge_census_state_2010 ge_census_county ge_census_tract ge_census_bg ge_als_county_code_2010 ge_als_census_tract_2010 ge_als_census_bg_2010 first_name_1 last_name_1 ethnicity_code_1 first_name_2 last_name_2 ethnicity_code_2 first_name_3 last_name_3 ethnicity_code_3 total_pop
*** geoid10 is the block codes 
save InfoUSA2014_2010CensusBlckgrp.dta,replace 


