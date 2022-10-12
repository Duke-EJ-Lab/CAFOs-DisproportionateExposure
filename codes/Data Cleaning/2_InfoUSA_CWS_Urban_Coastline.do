


************************* CWS ******************************
import delimited using InfoUSA2014_CWS_Merge.csv, clear
* check wheter familyid still unique
format %16.0g familyid
sort familyid
quietly by familyid:  gen dup = cond(_N==1,0,_n)
sum dup
drop dup
* generate gwater variable
gen gwater = 1 if join_count == 0
replace gwater = 0 if join_count != 0
* data cleaning
rename orig_fid Orig_fid
drop objectid join_count target_fid
save InfoUSA_Gwater_2014.dta,replace




************************* urban households (inner buffer) ******************************
********* 3km *********
import delimited NC_CensusUrbanAreas2010_Negative3kmBuffer_InfoUSA_Join.csv,clear
format %16.0g familyid
** drop urban areas with no house falls in
drop if join_fid == -1
sort familyid
quietly by familyid:  gen dup = cond(_N==1,0,_n)
keep familyid
save EastNC_InfoUSAID_UrbanAreaInteriorBuffer3km.dta,replace

********* 4km *********
import delimited NC_CensusUrbanAreas2010_Negative4kmBuffer_InfoUSA_Join.csv,clear
format %16.0g familyid
** drop urban areas with no house falls in
drop if join_fid == -1
sort familyid
quietly by familyid:  gen dup = cond(_N==1,0,_n)
keep familyid
save EastNC_InfoUSAID_UrbanAreaInteriorBuffer4km.dta,replace

********* 5km *********
import delimited NC_CensusUrbanAreas2010_Negative5kmBuffer_InfoUSA_Join.csv,clear
format %16.0g familyid
** drop urban areas with no house falls in
drop if join_fid == -1
sort familyid
quietly by familyid:  gen dup = cond(_N==1,0,_n)
keep familyid
save EastNC_InfoUSAID_UrbanAreaInteriorBuffer5km.dta,replace



************************* urban households ******************************
import delimited InfoUSA2014_UrbanArea_Match.csv, clear 
rename join_count UrbanArea_Indicator
keep familyid UrbanArea_Indicator ge_latitude_2010 ge_longitude_2010
order familyid UrbanArea_Indicator ge_latitude_2010 ge_longitude_2010
format %16.0g familyid
save InfoUSA2014_UrbanArea_Indicator.dta,replace



************************* coastal households ******************************
import delimited NC_County_Coastline_InfoUSA2014_GEODESIC5Miles.csv, clear 
format %16.0g orig_fid familyid locationid
rename in_fid NC_County_Coastline_id
rename orig_fid Orig_fid
** keep unique house id
sort Orig_fid
quietly by Orig_fid:  gen dup = cond(_N==1,0,_n)
keep if dup == 0 | dup == 1
keep NC_County_Coastline_id Orig_fid familyid locationid near_angle
save NC_County_Coastline_InfoUSA2014_GEODESIC5Miles.dta",replace

