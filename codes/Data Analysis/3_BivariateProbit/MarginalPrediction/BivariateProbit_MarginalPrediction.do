


use final_data.dta, clear


gen agghogs3_positive = 1 if agghogs3_LargeCAFO > 0
replace agghogs3_positive = 0 if agghogs3_positive == .
gen aggpoultry3_positive = 1 if aggpoultry3_LargeCAFO > 0
replace aggpoultry3_positive = 0 if aggpoultry3_positive == .

gen agghogs4_positive = 1 if agghogs4_LargeCAFO > 0
replace agghogs4_positive = 0 if agghogs4_positive == .
gen aggpoultry4_positive = 1 if aggpoultry4_LargeCAFO > 0
replace aggpoultry4_positive = 0 if aggpoultry4_positive == .


gen agghogs5_positive = 1 if agghogs5_LargeCAFO > 0
replace agghogs5_positive = 0 if agghogs5_positive == .
gen aggpoultry5_positive = 1 if aggpoultry5_LargeCAFO > 0
replace aggpoultry5_positive = 0 if aggpoultry5_positive == .



 
****************************** 3km ******************************
gen agghogs_positive = agghogs3_positive
gen aggpoultry_positive = aggpoultry3_positive

quietly biprobit agghogs_positive aggpoultry_positive i.race_income UrbanArea_Indicator if UrbanArea_Indicator_3km == 0
est store probit_3km
eststo m1: margins race_income, predict(p00) post
quietly biprobit agghogs_positive aggpoultry_positive i.race_income UrbanArea_Indicator if UrbanArea_Indicator_3km == 0
eststo m2: margins race_income, predict(p01) post
quietly biprobit agghogs_positive aggpoultry_positive i.race_income UrbanArea_Indicator if UrbanArea_Indicator_3km == 0
eststo m3: margins race_income, predict(p10) post
quietly biprobit agghogs_positive aggpoultry_positive i.race_income UrbanArea_Indicator if UrbanArea_Indicator_3km == 0
eststo m4: margins race_income, predict(p11) post

esttab m1 m2 m3 m4 using MarginsPred_3km_CAFOExposure_RaceIncome.tex, se starlevels(* 0.1 ** 0.05 *** 0.01) mtitles("P00" "P01" "P10" "P11") nonumbers replace




****************************** 4km ******************************
drop agghogs_positive aggpoultry_positive
gen agghogs_positive = agghogs4_positive
gen aggpoultry_positive = aggpoultry4_positive


quietly biprobit agghogs_positive aggpoultry_positive i.race_income UrbanArea_Indicator if UrbanArea_Indicator_4km == 0
est store probit_4km
eststo m1: margins race_income, predict(p00) post
quietly biprobit agghogs_positive aggpoultry_positive i.race_income UrbanArea_Indicator if UrbanArea_Indicator_4km == 0
eststo m2: margins race_income, predict(p01) post
quietly biprobit agghogs_positive aggpoultry_positive i.race_income UrbanArea_Indicator if UrbanArea_Indicator_4km == 0
eststo m3: margins race_income, predict(p10) post
quietly biprobit agghogs_positive aggpoultry_positive i.race_income UrbanArea_Indicator if UrbanArea_Indicator_4km == 0
eststo m4: margins race_income, predict(p11) post

esttab m1 m2 m3 m4 using MarginsPred_4km_CAFOExposure_RaceIncome.tex, se starlevels(* 0.1 ** 0.05 *** 0.01) mtitles("P00" "P01" "P10" "P11") nonumbers replace




****************************** 5km ******************************
drop agghogs_positive aggpoultry_positive
gen agghogs_positive = agghogs5_positive
gen aggpoultry_positive = aggpoultry5_positive

quietly biprobit agghogs_positive aggpoultry_positive i.race_income UrbanArea_Indicator if UrbanArea_Indicator_5km == 0
est store probit_5km
eststo m1: margins race_income, predict(p00) post
quietly biprobit agghogs_positive aggpoultry_positive i.race_income UrbanArea_Indicator if UrbanArea_Indicator_5km == 0
eststo m2: margins race_income, predict(p01) post
quietly biprobit agghogs_positive aggpoultry_positive i.race_income UrbanArea_Indicator if UrbanArea_Indicator_5km == 0
eststo m3: margins race_income, predict(p10) post
quietly biprobit agghogs_positive aggpoultry_positive i.race_income UrbanArea_Indicator if UrbanArea_Indicator_5km == 0
eststo m4: margins race_income, predict(p11) post

esttab m1 m2 m3 m4 using MarginsPred_5km_CAFOExposure_RaceIncome.tex, se starlevels(* 0.1 ** 0.05 *** 0.01) mtitles("P00" "P01" "P10" "P11") nonumbers replace



