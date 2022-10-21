



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





