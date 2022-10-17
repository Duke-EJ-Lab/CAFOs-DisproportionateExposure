

*****************************************************************
************** import csv data into dta format *****************
****************************************************************

******************** hogs exposure ****************************
import delimited InfoUSA2014_AFO_GEODESIC_5km.csv, clear
*** initial data cleaning
drop objectid from_x from_y near_x near_y
rename in_fid Orig_fid
rename near_fid AFO_id
** merge with hog info (AFOs_SSLW data include farm information)
merge n:1 AFO_id using AFOs_SSLW.dta
keep if _merge == 3
drop _merge
save InfoUSA2014_AFO_GEODESIC_5km.dta,replace


******************** Poultry exposure ****************************
import delimited InfoUSA2014_Poultry_GEODESIC_5km.csv, clear
*** initial data cleaning
drop objectid from_x from_y near_x near_y
rename in_fid Orig_fid
rename near_fid Poultry_id
** merge with poultry info (EWG_Poultry_Final data include farm information)
merge n:1 Poultry_id using EWG_Poultry_Final.dta
keep if _merge == 3
drop _merge
save InfoUSA2014_Poultry_GEODESIC_5km.dta,replace






******************************************************
*************** hog exposure calculation **************
******************************************************

********* 1km *********
use InfoUSA2014_AFO_GEODESIC_5km.dta,clear
** drop duplicate farms
* there are a few farms with same (RegulatedActivity AllowableCount NumberOfLagoons LocationLatNum LocationLongNum SSLW FacilityName) and we only keep unique farms in our analyses. 
drop if AFO_id == 379 | AFO_id == 42 | AFO_id == 2049 | AFO_id == 20 | AFO_id == 380 | AFO_id == 71 | AFO_id == 381 | AFO_id == 2050
*** only keep farms located within 1km of households
keep if near_dist <= 1000
*** calcualte summed attributes (farm counts and SSLW) for each house (Orig_fid)
gen Count = 1
sort Orig_fid
by Orig_fid: egen AFO_Cnt_1km = total(Count)
by Orig_fid: egen AFO_SSLW_1km = total(SSLW)
sort Orig_fid
quietly by Orig_fid:  gen dup = cond(_N==1,0,_n)
keep if dup == 0 | dup == 1
keep Orig_fid AFO_Cnt_1km AFO_SSLW_1km
save InfoUSA2014_AFO_1km.dta,replace


********* 1to2km *********
use InfoUSA2014_AFO_GEODESIC_5km.dta,clear
** drop duplicate farms
drop if AFO_id == 379 | AFO_id == 42 | AFO_id == 2049 | AFO_id == 20 | AFO_id == 380 | AFO_id == 71 | AFO_id == 381 | AFO_id == 2050
*** only keep farms located within 1-2km of households
keep if near_dist <= 2000 & near_dist > 1000
*** calcualte summed attributes (farm counts and SSLW) for each house (Orig_fid)
gen Count = 1
sort Orig_fid
by Orig_fid: egen AFO_Cnt_1to2km = total(Count)
by Orig_fid: egen AFO_SSLW_1to2km = total(SSLW)
sort Orig_fid
quietly by Orig_fid:  gen dup = cond(_N==1,0,_n)
keep if dup == 0 | dup == 1
keep Orig_fid AFO_Cnt_1to2km AFO_SSLW_1to2km
save InfoUSA2014_AFO_1to2km.dta,replace


********* 2to3km *********
use InfoUSA2014_AFO_GEODESIC_5km.dta,clear
** drop duplicate farms
drop if AFO_id == 379 | AFO_id == 42 | AFO_id == 2049 | AFO_id == 20 | AFO_id == 380 | AFO_id == 71 | AFO_id == 381 | AFO_id == 2050
*** only keep farms located within 2-3km of households
keep if near_dist <= 3000 & near_dist > 2000
*** calcualte summed attributes (farm counts and SSLW) for each house (Orig_fid)
gen Count = 1
sort Orig_fid
by Orig_fid: egen AFO_Cnt_2to3km = total(Count)
by Orig_fid: egen AFO_SSLW_2to3km = total(SSLW)
sort Orig_fid
quietly by Orig_fid:  gen dup = cond(_N==1,0,_n)
keep if dup == 0 | dup == 1
keep Orig_fid AFO_Cnt_2to3km AFO_SSLW_2to3km
save InfoUSA2014_AFO_2to3km.dta,replace


********* 3to4km *********
use InfoUSA2014_AFO_GEODESIC_5km.dta,clear
** drop duplicate farms
drop if AFO_id == 379 | AFO_id == 42 | AFO_id == 2049 | AFO_id == 20 | AFO_id == 380 | AFO_id == 71 | AFO_id == 381 | AFO_id == 2050
*** only keep farms located within 3-4km of households
keep if near_dist <= 4000 & near_dist > 3000
*** calcualte summed attributes (farm counts and SSLW) for each house (Orig_fid)
gen Count = 1
sort Orig_fid
by Orig_fid: egen AFO_Cnt_3to4km = total(Count)
by Orig_fid: egen AFO_SSLW_3to4km = total(SSLW)
sort Orig_fid
quietly by Orig_fid:  gen dup = cond(_N==1,0,_n)
keep if dup == 0 | dup == 1
keep Orig_fid AFO_Cnt_3to4km AFO_SSLW_3to4km
save InfoUSA2014_AFO_3to4km.dta,replace


********* 4to5km *********
use InfoUSA2014_AFO_GEODESIC_5km.dta,clear
** drop duplicate farms
drop if AFO_id == 379 | AFO_id == 42 | AFO_id == 2049 | AFO_id == 20 | AFO_id == 380 | AFO_id == 71 | AFO_id == 381 | AFO_id == 2050
*** only keep farms located within 4-5km of households
keep if near_dist <= 5000 & near_dist > 4000
*** calcualte summed attributes (farm counts and SSLW) for each house (Orig_fid)
gen Count = 1
sort Orig_fid
by Orig_fid: egen AFO_Cnt_4to5km = total(Count)
by Orig_fid: egen AFO_SSLW_4to5km = total(SSLW)
sort Orig_fid
quietly by Orig_fid:  gen dup = cond(_N==1,0,_n)
keep if dup == 0 | dup == 1
keep Orig_fid AFO_Cnt_4to5km AFO_SSLW_4to5km
save InfoUSA2014_AFO_4to5km.dta,replace


********* merge all exposure *********
use InfoUSA2014_AFO_1km.dta,clear
merge 1:1 Orig_fid using InfoUSA2014_AFO_1to2km.dta
drop _merge
merge 1:1 Orig_fid using InfoUSA2014_AFO_2to3km.dta
drop _merge
merge 1:1 Orig_fid using InfoUSA2014_AFO_3to4km.dta
drop _merge
merge 1:1 Orig_fid using InfoUSA2014_AFO_4to5km.dta
drop _merge
replace AFO_Cnt_1km = 0 if AFO_Cnt_1km == .
replace AFO_Cnt_1to2km = 0 if AFO_Cnt_1to2km == .
replace AFO_Cnt_2to3km = 0 if AFO_Cnt_2to3km == .
replace AFO_Cnt_3to4km = 0 if AFO_Cnt_3to4km == .
replace AFO_Cnt_4to5km = 0 if AFO_Cnt_4to5km == .
replace AFO_SSLW_1km = 0 if AFO_SSLW_1km == .
replace AFO_SSLW_1to2km = 0 if AFO_SSLW_1to2km == .
replace AFO_SSLW_2to3km = 0 if AFO_SSLW_2to3km == .
replace AFO_SSLW_3to4km = 0 if AFO_SSLW_3to4km == .
replace AFO_SSLW_4to5km = 0 if AFO_SSLW_4to5km == .
save InfoUSA2014_AFO_AllRingBuffer.dta,replace




******************************************************
*************** poultry exposure calculation **************
******************************************************

********* 1km *********
use InfoUSA2014_Poultry_GEODESIC_5km.dta,clear
*** only keep farms located within 1km of households
keep if near_dist <= 1000
*** calcualte summed attributes (farm counts and bird counts) for each house (Orig_fid)
gen Count = 1
sort Orig_fid
by Orig_fid: egen Poultry_Cnt_1km = total(Count)
by Orig_fid: egen Poultry_brdcntf_1km = total(Brid_count)
sort Orig_fid
quietly by Orig_fid:  gen dup = cond(_N==1,0,_n)
keep if dup == 0 | dup == 1
keep Orig_fid Poultry_Cnt_1km Poultry_brdcntf_1km
save InfoUSA2014_Poultry_1km.dta,replace

********* 1to2km *********
use InfoUSA2014_Poultry_GEODESIC_5km.dta,clear
*** only keep farms located within 1-2km of households
keep if near_dist <= 2000 & near_dist > 1000
*** calcualte summed attributes (farm counts and bird counts) for each house (Orig_fid)
gen Count = 1
sort Orig_fid
by Orig_fid: egen Poultry_Cnt_1to2km = total(Count)
by Orig_fid: egen Poultry_brdcntf_1to2km = total(Brid_count)
sort Orig_fid
quietly by Orig_fid:  gen dup = cond(_N==1,0,_n)
keep if dup == 0 | dup == 1
keep Orig_fid Poultry_Cnt_1to2km Poultry_brdcntf_1to2km
save InfoUSA2014_Poultry_1to2km.dta,replace

********* 2to3km *********
use InfoUSA2014_Poultry_GEODESIC_5km.dta,clear
*** only keep farms located within 2-3km of households
keep if near_dist <= 3000 & near_dist > 2000
*** calcualte summed attributes (farm counts and bird counts) for each house (Orig_fid)
gen Count = 1
sort Orig_fid
by Orig_fid: egen Poultry_Cnt_2to3km = total(Count)
by Orig_fid: egen Poultry_brdcntf_2to3km = total(Brid_count)
sort Orig_fid
quietly by Orig_fid:  gen dup = cond(_N==1,0,_n)
keep if dup == 0 | dup == 1
keep Orig_fid Poultry_Cnt_2to3km Poultry_brdcntf_2to3km
save InfoUSA2014_Poultry_2to3km.dta,replace

********* 3to4km *********
use InfoUSA2014_Poultry_GEODESIC_5km.dta,clear
*** only keep farms located within 3-4km of households
keep if near_dist <= 4000 & near_dist > 3000
*** calcualte summed attributes (farm counts and bird counts) for each house (Orig_fid)
gen Count = 1
sort Orig_fid
by Orig_fid: egen Poultry_Cnt_3to4km = total(Count)
by Orig_fid: egen Poultry_brdcntf_3to4km = total(Brid_count)
sort Orig_fid
quietly by Orig_fid:  gen dup = cond(_N==1,0,_n)
keep if dup == 0 | dup == 1
keep Orig_fid Poultry_Cnt_3to4km Poultry_brdcntf_3to4km
save InfoUSA2014_Poultry_3to4km.dta,replace

********* 4to5km *********
use InfoUSA2014_Poultry_GEODESIC_5km.dta,clear
*** only keep farms located within 4-5km of households
keep if near_dist <= 5000 & near_dist > 4000
*** calcualte summed attributes (farm counts and bird counts) for each house (Orig_fid)
gen Count = 1
sort Orig_fid
by Orig_fid: egen Poultry_Cnt_4to5km = total(Count)
by Orig_fid: egen Poultry_brdcntf_4to5km = total(Brid_count)
sort Orig_fid
quietly by Orig_fid:  gen dup = cond(_N==1,0,_n)
keep if dup == 0 | dup == 1
keep Orig_fid Poultry_Cnt_4to5km Poultry_brdcntf_4to5km
save InfoUSA2014_Poultry_4to5km.dta,replace


********* merge all exposure *********
use InfoUSA2014_Poultry_1km.dta,clear
merge 1:1 Orig_fid using InfoUSA2014_Poultry_1to2km.dta
drop _merge
merge 1:1 Orig_fid using InfoUSA2014_Poultry_2to3km.dta
drop _merge
merge 1:1 Orig_fid using InfoUSA2014_Poultry_3to4km.dta
drop _merge
merge 1:1 Orig_fid using InfoUSA2014_Poultry_4to5km.dta
drop _merge
replace Poultry_Cnt_1km = 0 if Poultry_Cnt_1km == .
replace Poultry_Cnt_1to2km = 0 if Poultry_Cnt_1to2km == .
replace Poultry_Cnt_2to3km = 0 if Poultry_Cnt_2to3km == .
replace Poultry_Cnt_3to4km = 0 if Poultry_Cnt_3to4km == .
replace Poultry_Cnt_4to5km = 0 if Poultry_Cnt_4to5km == .
replace Poultry_brdcntf_1km = 0 if Poultry_brdcntf_1km == .
replace Poultry_brdcntf_1to2km = 0 if Poultry_brdcntf_1to2km == .
replace Poultry_brdcntf_2to3km = 0 if Poultry_brdcntf_2to3km == .
replace Poultry_brdcntf_3to4km = 0 if Poultry_brdcntf_3to4km == .
replace Poultry_brdcntf_4to5km = 0 if Poultry_brdcntf_4to5km == .
save InfoUSA2014_Poultry_AllRingBuffer.dta,replace


