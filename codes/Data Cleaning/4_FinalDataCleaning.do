

*****************************************************************
***************** combine all infousa info **********************
****************************************************************
***** import InfoUSA data ****
use InfoUSA_nc_2014.dta,clear
** merge with blckgrp info **
merge 1:1 (Orig_fid familyid) using InfoUSA_CensusBlckgrp_2014.dta
drop _merge
** merge with gwater **
merge 1:1 (Orig_fid familyid) using InfoUSA_Gwater_2014.dta
drop _merge
** merge with wru race **
merge 1:1 (Orig_fid familyid) using InfoUSA_WruRace_2014.dta
drop _merge
replace race_wru = "UnMatched" if race_wru == ""
** lat/long **
gen lat_4digit = substr(lat_string,1,7)
gen long_4digit = substr(long_string,1,8)
gen lat_3digit = substr(lat_string,1,6)
gen long_3digit = substr(long_string,1,7)
gen lat_2digit = substr(lat_string,1,5)
gen long_2digit = substr(long_string,1,6)
drop lat_string long_string
save InfoUSA_hh_2014.dta,replace






******************************************************
*********** generate data for data analysis **********
******************************************************
use InfoUSA_hh_2014.dta,clear
** merge with CAFOs Exposure
merge 1:1 Orig_fid using InfoUSA2014_AFO_AllRingBuffer.dta
drop _merge
merge 1:1 Orig_fid using InfoUSA2014_Poultry_AllRingBuffer.dta
drop _merge
** drop vacant households
drop if vacant == 1
** sum income by family (sum primary and subfamily) based on locationid, only keep primary households
drop if locationid == .
gen income = find_div_1000 * 1000
gen wealth = wealth_finder_score * 1000
format %16.0g locationid
sort locationid
by locationid: egen family_income = total(income)
by locationid: egen family_wealth = total(wealth)
order locationid family_income primary_family_ind
keep if primary_family_ind == 1


******* remove coastal houses *******
merge 1:1 (Orig_fid) using NC_County_Coastline_InfoUSA2014_GEODESIC5Miles.dta
keep if _merge == 1
drop _merge

******* remove urban interior buffer 3km *******
merge 1:1 familyid using EastNC_InfoUSAID_UrbanAreaInteriorBuffer3km.dta
* _merge == 2: not in the regression sample
* _merge == 3: in the regression sample and urban house
* _merge == 1: in the regression sample and rural house
drop if _merge == 2
gen UrbanArea_Indicator_3km = 1 if _merge == 3
replace UrbanArea_Indicator_3km = 0 if _merge == 1
drop _merge


******* remove urban interior buffer 4km *******
merge 1:1 familyid using EastNC_InfoUSAID_UrbanAreaInteriorBuffer4km.dta
* _merge == 2: not in the regression sample
* _merge == 3: in the regression sample and urban house
* _merge == 1: in the regression sample and rural house
drop if _merge == 2
gen UrbanArea_Indicator_4km = 1 if _merge == 3
replace UrbanArea_Indicator_4km = 0 if _merge == 1
drop _merge


******* remove urban interior buffer 5km *******
merge 1:1 familyid using EastNC_InfoUSAID_UrbanAreaInteriorBuffer5km.dta
* _merge == 2: not in the regression sample
* _merge == 3: in the regression sample and urban house
* _merge == 1: in the regression sample and rural house
drop if _merge == 2
gen UrbanArea_Indicator_5km = 1 if _merge == 3
replace UrbanArea_Indicator_5km = 0 if _merge == 1
drop _merge

******* merge with Urban Area Indicator *******
merge 1:1 familyid using InfoUSA2014_UrbanArea_Indicator.dta
keep if _merge == 3
drop _merge


***** generate aggregated exposure *****
foreach x of varlist AFO_Cnt_1km-AFO_Cnt_4to5km{
  replace `x' = 0 if `x' == .
}
foreach x of varlist AFO_SSLW_1km-AFO_SSLW_4to5km{
  replace `x' = 0 if `x' == .
}
foreach x of varlist Poultry_Cnt_1km-Poultry_Cnt_4to5km{
  replace `x' = 0 if `x' == .
}
foreach x of varlist Poultry_brdcntf_1km-Poultry_brdcntf_4to5km{
  replace `x' = 0 if `x' == .
}

gen agghogs2 = AFO_SSLW_1km + AFO_SSLW_1to2km
gen agghogs3 = AFO_SSLW_1km + AFO_SSLW_1to2km + AFO_SSLW_2to3km
gen agghogs4 = AFO_SSLW_1km + AFO_SSLW_1to2km + AFO_SSLW_2to3km + AFO_SSLW_3to4km
gen agghogs5 = AFO_SSLW_1km + AFO_SSLW_1to2km + AFO_SSLW_2to3km + AFO_SSLW_3to4km + AFO_SSLW_4to5km

gen aggpoultry2 = Poultry_brdcntf_1km + Poultry_brdcntf_1to2km
gen aggpoultry3 = Poultry_brdcntf_1km + Poultry_brdcntf_1to2km + Poultry_brdcntf_2to3km
gen aggpoultry4 = Poultry_brdcntf_1km + Poultry_brdcntf_1to2km + Poultry_brdcntf_2to3km + Poultry_brdcntf_3to4km
gen aggpoultry5 = Poultry_brdcntf_1km + Poultry_brdcntf_1to2km + Poultry_brdcntf_2to3km + Poultry_brdcntf_3to4km + Poultry_brdcntf_4to5km

gen agghogs2_LargeCAFO = agghogs2/1000000
gen agghogs3_LargeCAFO = agghogs3/1000000
gen agghogs4_LargeCAFO = agghogs4/1000000
gen agghogs5_LargeCAFO = agghogs5/1000000

gen aggpoultry2_LargeCAFO = aggpoultry2/100000
gen aggpoultry3_LargeCAFO = aggpoultry3/100000
gen aggpoultry4_LargeCAFO = aggpoultry4/100000
gen aggpoultry5_LargeCAFO = aggpoultry5/100000



****** race variables ******
gen race_W = 1 if race_wru == "W" == 1
gen race_B= 1 if race_wru == "B" == 1
gen race_H = 1 if race_wru == "H" == 1
mvencode race_W race_B race_H, mv(0)
** only keep W,B,H
keep if race_wru == "B" | race_wru == "H" | race_wru == "W"

****** other demographics ******
** age
gen age_before30 = 1 if head_hh_age_code == "A" | head_hh_age_code == "B"
gen age_30To50 = 1 if head_hh_age_code == "C" | head_hh_age_code == "D" | head_hh_age_code == "E" | head_hh_age_code == "F"
gen age_after50 = 1 if head_hh_age_code == "G" | head_hh_age_code == "H" | head_hh_age_code == "I" | head_hh_age_code == "J" | head_hh_age_code == "K" | head_hh_age_code == "L" | head_hh_age_code == "M"
mvencode age_before30 age_30To50 age_after50, mv(0)
** owner and renter indicator
gen owner = 1 if owner_renter_status == 7 | owner_renter_status == 8 | owner_renter_status == 9
replace owner = 0 if owner == .
** income by race group **
gen white_low = 1 if race_W == 1 & family_income <= 35000
gen black_low = 1 if race_B == 1 & family_income <= 35000
gen his_low = 1 if race_H == 1 & family_income <= 35000
gen white_medium = 1 if race_W == 1 & family_income > 35000 & family_income <= 100000
gen black_medium = 1 if race_B == 1 & family_income > 35000 & family_income <= 100000
gen his_medium = 1 if race_H == 1 & family_income > 35000 & family_income <= 100000
gen white_high = 1 if race_W == 1 & family_income > 100000
gen black_high = 1 if race_B == 1 & family_income > 100000
gen his_high = 1 if race_H == 1 & family_income > 100000
mvencode white_low-his_high, mv(0)

gen income_reg = family_income/1000



****** East NC indicator ******
gen fips = statefp10 + countyfp10
destring (fips), replace
gen EastNC_ind = 1 if fips == 37013 | fips == 37015 | fips == 37017 | fips == 37019 | fips == 37029 | fips == 37031 | fips == 37041 | fips == 37047 | fips == 37049 | fips == 37051 | fips == 37053 | fips == 37055 | fips == 37061 | fips == 37065 | fips == 37069 | fips == 37073 | fips == 37079 | fips == 37083 | fips == 37085 | fips == 37091 | fips == 37093 | fips == 37095 | fips == 37101 | fips == 37103 | fips == 37107 | fips == 37117 | fips == 37127 | fips == 37129 | fips == 37131 | fips == 37133 | fips == 37137 | fips == 37139 | fips == 37141 | fips == 37143 | fips == 37147 | fips == 37155 | fips == 37163 | fips == 37165 | fips == 37177 | fips == 37185 | fips == 37187 | fips == 37191 | fips == 37195
replace EastNC_ind = 0 if EastNC_ind == .
** only keep East NC households
keep if EastNC_ind == 1


keep familyid family_income race_W race_B race_H UrbanArea_Indicator_3km UrbanArea_Indicator_4km UrbanArea_Indicator_5km UrbanArea_Indicator agghogs3km_LargeCAFO aggpoultry3km_LargeCAFO agghogs4km_LargeCAFO aggpoultry4km_LargeCAFO agghogs5km_LargeCAFO aggpoultry5km_LargeCAFO owner family_wealth gwater


save final_data.dta, replace
outsheet using final_data.csv, replace






