

************************* import blckgrp data *********************
import delimited InfoUSA2014_2010CensusBlckGrp.csv, clear
* check wheter familyid still unique
format %16.0g familyid
sort familyid
quietly by familyid:  gen dup = cond(_N==1,0,_n)
sum dup
drop dup
count if join_count == 0
drop if join_count == 0
* data cleaning
drop objectid join_count target_fid shapestare shapestlen onemapsdea
rename orig_fid Orig_fid
sort Orig_fid
order Orig_fid familyid geoid10
keep Orig_fid familyid geoid10 ge_latitude_2010 ge_longitude_2010 childrenhhcount wealth_finder_score find_div_1000 owner_renter_status estmtd_home_val_div_1000 marital_status city state zip zip4 vacant ge_census_level_2010 ge_census_state_2010 ge_census_county ge_census_tract ge_census_bg ge_als_county_code_2010 ge_als_census_tract_2010 ge_als_census_bg_2010 first_name_1 last_name_1 ethnicity_code_1 first_name_2 last_name_2 ethnicity_code_2 first_name_3 last_name_3 ethnicity_code_3 total_pop
order Orig_fid familyid geoid10 ge_latitude_2010 ge_longitude_2010 childrenhhcount wealth_finder_score find_div_1000 owner_renter_status estmtd_home_val_div_1000 marital_status city state zip zip4 vacant ge_census_level_2010 ge_census_state_2010 ge_census_county ge_census_tract ge_census_bg ge_als_county_code_2010 ge_als_census_tract_2010 ge_als_census_bg_2010 first_name_1 last_name_1 ethnicity_code_1 first_name_2 last_name_2 ethnicity_code_2 first_name_3 last_name_3 ethnicity_code_3 total_pop
save InfoUSA_CensusBlckgrp_2014.dta,replace 


************************* prepare data for wru R codes *********************
use InfoUSA_CensusBlck_2014.dta,clear
keep Orig_fid familyid geoid10 ge_latitude_2010 ge_longitude_2010 last_name_1 vacant
* generate tract variable
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
sort familyid_string
quietly by familyid_string:  gen dup = cond(_N==1,0,_n)
sum dup
drop familyid dup
rename familyid_string familyid
gen LastName = proper(last_name_1)
order Orig_fid familyid ge_latitude_2010 ge_longitude_2010 CensusTract_2010 CensusBlck_2010 STATE statefp10 countyfp10 tractce10 blockce10 last_name_1 vacant
outsheet using InfoUSA_TractBlock_2014.csv, replace


************************* R steps *********************
** (1): run R codes: 1_wru_infousa_race.R
** (2): get the exported csv data: InfoUSA2014_WruRace.csv


************************* generate race dta data ******************************
import delimited InfoUSA2014_WruRace.csv, clear
format %16.0g familyid
sort familyid
quietly by familyid:  gen dup = cond(_N==1,0,_n)
sum dup
drop v1 code dup
rename race race_wru
rename orig_fid Orig_fid
save InfoUSA_WruRace_2014.dta,replace

