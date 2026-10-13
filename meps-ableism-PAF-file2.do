************************************************************************************************************
** Disability, ableism in health care settings, and health disparities among US adults: a cross-sectional decomposition analysis
** Code by Dielle J. Lundberg
** Last Updated: October 3, 2026
** Code File 2 of 18: Merge Data, Clean Data, and Create Sample
************************************************************************************************************

********************************************
**** PART 1:                            ****
**** MERGE MAIN SAMPLE & KEEP VARIABLES ****
********************************************

// Set Directory to Folder Where Data Are Saved
cd "/Users/djlworkdesktop/Library/Mobile Documents/com~apple~CloudDocs/Independent Research/MEPS-Ableism-PAF-Project/Analysis V3"

// Store Variable Names in Macros
/* List Identifiers */
local vars1 DUPERSID PANEL 
/* List Exposure/Group Measures (Rounds 2 and 4) */
local vars2 DFWLKC2 DFCOG2 DFHEAR2 DFERND2 DFSEE2 DFDRSB2 DFWLKC4 DFCOG4 DFHEAR4 DFERND4 DFSEE4 DFDRSB4 RESP2 RESP4
/* List Covariates (Round 1) */
local vars3 SEX RACEV1X RACEAX HISPANX HISPNCAT AGE1X HIDEG POVCATY1 INSCOVY1 RESP1 RTHLTH1 MNHLTH1 OBTOTVY1 ERTOTY1 IPDISY1 HIBPDXY1 OHRTDXY1 CHDDXY1 DIABDXY1_M18 CANCERY1
/* List Mediator/Cause Measures (Round 4 - SAQ) */
local vars4 SAQRDS24 SAQELIY2 LSAQWT ADPROX4 ADAPPT4 ADLIST4 ADRESP4 ADEXPL4 ADPRTM4 ADHECR4 
/* List Health Outcome Variables (Round 4 - SAQ & Round 5) */
local vars5 ADPROX4 ADGENH4 K6SUM4 PHQ24 ADPAIN4 RTHLTH5 MNHLTH5 RESP5

// Longitudinal Panel 19 (2014-2015) 
use H183.dta, clear
rename DIABDXY1 DIABDXY1_M18
rename ADPRXY4 ADPROX4
keep `vars1' `vars2' `vars3' `vars4' `vars5' EDUYRDG
gen year = 2015
save data_2015.dta, replace

// Longitudinal Panel 20 (2015-2016)  
use H193.dta, clear
rename DIABDXY1 DIABDXY1_M18
rename ADPRXY4 ADPROX4
keep `vars1' `vars2' `vars3' `vars4' `vars5' 
gen year = 2016
save data_2016.dta, replace

// Longitudinal Panel 21 (2016-2017) 
use h202.dta, clear
rename DIABDXY1 DIABDXY1_M18
keep `vars1' `vars2' `vars3' `vars4' `vars5' 
gen year = 2017
save data_2017.dta, replace

// Longitudinal Panel 23 (2018-2019) 
use h217.dta, clear
keep `vars1' `vars2' `vars3' `vars4' `vars5' 
gen year = 2019
save data_2019.dta, replace

// Longitudinal Panel 25 (2020-2021) 
use h234.dta, clear
keep `vars1' `vars2' `vars3' `vars4' `vars5' 
gen year = 2021
save data_2021.dta, replace

// Longitudinal Panel 27 (2022-2023) 
use h252.dta, clear
keep `vars1' `vars2' `vars3' `vars4' `vars5' 
gen year = 2023
save data_2023.dta, replace

// Combine Panels (19, 20, 21, 23, 25, 27)
use data_2015.dta, clear
append using data_2016.dta
append using data_2017.dta
append using data_2019.dta
append using data_2021.dta
append using data_2023.dta
label var year "Year"
save pooled_sample.dta, replace

// Erase Temporary Datasets
erase data_2015.dta
erase data_2016.dta
erase data_2017.dta
erase data_2019.dta
erase data_2021.dta
erase data_2023.dta

*************************
**** PART 2:         ****
**** CLEAN VARIABLES ****
*************************

// Load Data
use pooled_sample.dta, clear

// Divide Longitudinal SAQ Weights by 6
// Pooled 6 Panels (19, 20, 21, 23, 25, 27)
replace LSAQWT = LSAQWT / 6

**************************
** Exposure: Disability **
**************************

// Ambulation Disability, Round 2
/* Serious difficulty walking or climbing stairs */
/* 0: no; 1: yes */
gen r2_disability_ambulation = . 
replace r2_disability_ambulation = 0 if DFWLKC2 == 2
replace r2_disability_ambulation = 1 if DFWLKC2 == 1
drop DFWLKC2

// Cognition Disability, Round 2
/* Serious difficulty concentrating, remembering or making decisions */
/* 0: no; 1: yes */
gen r2_disability_cognition = . 
replace r2_disability_cognition = 0 if DFCOG2 == 2
replace r2_disability_cognition = 1 if DFCOG2 == 1
drop DFCOG2

// Hearing Disability, Round 2
/* Deaf or serious difficulty with hearing */
/* 0: no; 1: yes */
gen r2_disability_hearing = .
replace r2_disability_hearing = 0 if DFHEAR2 == 2
replace r2_disability_hearing = 1 if DFHEAR2 == 1
drop DFHEAR2

// Independent Living Disability, Round 2
/* Difficulty doing errands alone such as visiting a doctor's office or shopping */
/* 0: no; 1: yes */
gen r2_disability_independent = . 
replace r2_disability_independent = 0 if DFERND2 == 2
replace r2_disability_independent = 1 if DFERND2 == 1
drop DFERND2

// Seeing Disability, Round 2
/* Blind or serious difficulty with seeing even with corrective glasses */
/* 0: no; 1: yes */
gen r2_disability_seeing = .
replace r2_disability_seeing = 0 if DFSEE2 == 2
replace r2_disability_seeing = 1 if DFSEE2 == 1
drop DFSEE2

// Self-Care Disability, Round 2
/* Difficulty dressing or bathing */ 
/* 0: no; 1: yes */
gen r2_disability_selfcare = . 
replace r2_disability_selfcare = 0 if DFDRSB2 == 2
replace r2_disability_selfcare = 1 if DFDRSB2 == 1
drop DFDRSB2

// Disability, Round 2
/* 0: Nondisabled; 1: Disabled */
gen r2_disability = .
replace r2_disability = 0 if r2_disability_hearing == 0 & r2_disability_seeing == 0 & r2_disability_ambulation == 0 & r2_disability_cognition == 0 & r2_disability_selfcare == 0 & r2_disability_independent == 0
replace r2_disability = 1 if r2_disability_hearing == 1 | r2_disability_seeing == 1 | r2_disability_ambulation == 1 | r2_disability_cognition == 1 | r2_disability_selfcare == 1 | r2_disability_independent == 1

// Ambulation Disability, Round 4
/* Serious difficulty walking or climbing stairs */
/* 0: no; 1: yes */
gen r4_disability_ambulation = . 
replace r4_disability_ambulation = 0 if DFWLKC4 == 2
replace r4_disability_ambulation = 1 if DFWLKC4 == 1
drop DFWLKC4

// Cognition Disability, Round 4
/* Serious difficulty concentrating, remembering or making decisions */
/* 0: no; 1: yes */
gen r4_disability_cognition = . 
replace r4_disability_cognition = 0 if DFCOG4 == 2
replace r4_disability_cognition = 1 if DFCOG4 == 1
drop DFCOG4

// Hearing Disability, Round 4
/* Deaf or serious difficulty with hearing */
/* 0: no; 1: yes */
gen r4_disability_hearing = .
replace r4_disability_hearing = 0 if DFHEAR4 == 2
replace r4_disability_hearing = 1 if DFHEAR4 == 1
drop DFHEAR4

// Independent Living Disability, Round 4
/* Difficulty doing errands alone such as visiting a doctor's office or shopping */
/* 0: no; 1: yes */
gen r4_disability_independent = . 
replace r4_disability_independent = 0 if DFERND4 == 2
replace r4_disability_independent = 1 if DFERND4 == 1
drop DFERND4

// Seeing Disability, Round 4
/* Blind or serious difficulty with seeing even with corrective glasses */
/* 0: no; 1: yes */
gen r4_disability_seeing = .
replace r4_disability_seeing = 0 if DFSEE4 == 2
replace r4_disability_seeing = 1 if DFSEE4 == 1
drop DFSEE4

// Self-Care Disability, Round 4
/* Difficulty dressing or bathing */ 
/* 0: no; 1: yes */
gen r4_disability_selfcare = . 
replace r4_disability_selfcare = 0 if DFDRSB4 == 2
replace r4_disability_selfcare = 1 if DFDRSB4 == 1
drop DFDRSB4

// Disability, Round 4
/* 0: Nondisabled; 1: Disabled */
gen r4_disability = .
replace r4_disability = 0 if r4_disability_hearing == 0 & r4_disability_seeing == 0 & r4_disability_ambulation == 0 & r4_disability_cognition == 0 & r4_disability_selfcare == 0 & r4_disability_independent == 0
replace r4_disability = 1 if r4_disability_hearing == 1 | r4_disability_seeing == 1 | r4_disability_ambulation == 1 | r4_disability_cognition == 1 | r4_disability_selfcare == 1 | r4_disability_independent == 1

// Disability, Rounds 2 & 4 (Primary Definition)
/* 0: Nondisabled; 1: Disabled, Intermittent; 2: Disabled, Continuous */
gen disability = .
replace disability = 0 if r2_disability == 0 & r4_disability == 0
replace disability = 1 if (r2_disability == 0 & r4_disability == 1) | (r2_disability == 1 & r4_disability == 0)
replace disability = 2 if r2_disability == 1 & r4_disability == 1
label var disability "Disability"
label define disability_threelab 0 "Nondisabled" 1 "Disabled, Intermittent" 2 "Disabled, Continuous"
label values disability disability_threelab

// Disability, Rounds 2 & 4 (Secondary Definition)
/* 0: Nondisabled; 1: Disabled*/
gen disability_alt = .
replace disability_alt = 0 if r2_disability == 0 & r4_disability == 0
replace disability_alt = 1 if (r2_disability == 0 & r4_disability == 1) | (r2_disability == 1 & r4_disability == 0) | (r2_disability == 1 & r4_disability == 1)
label var disability_alt "Disability, Alternative Definition"
label define disability_twolab 0 "Nondisabled" 1 "Disabled"
label values disability_alt disability_twolab
drop r2_disability r4_disability

// Number of Disability Types Reported, Maximum of Round 2 and 4
egen counter_2 = rowtotal(r2_disability_ambulation r2_disability_cognition r2_disability_hearing r2_disability_independent r2_disability_seeing r2_disability_selfcare)
egen counter_4 = rowtotal(r4_disability_ambulation r4_disability_cognition r4_disability_hearing r4_disability_independent r4_disability_seeing r4_disability_selfcare)
gen counter = counter_2
replace counter = counter_4 if counter_4 > counter_2 & counter_4 <= 6
drop counter_2 counter_4
gen disability_type_count = .
replace disability_type_count = 0 if disability_alt == 0
replace disability_type_count = 1 if disability_alt == 1 & counter == 1
replace disability_type_count = 2 if disability_alt == 1 & counter == 2
replace disability_type_count = 3 if disability_alt == 1 & counter == 3
replace disability_type_count = 4 if disability_alt == 1 & counter == 4 & counter <= 6 
label var disability_type_count "Disability Types Reported"
label define typecountlab 0 "None" 1 "1 Type" 2 "2 Types" 3 "3 Types" 4 "4-6 Types"
label values disability_type_count typecountlab
drop counter

// Ambulation Disability, Rounds 2 and 4
/* 0: Nondisabled; 1: Disabled, Other; 2: Disabled, Yes */
gen disability_ambulation = .
replace disability_ambulation = 0 if disability == 0
replace disability_ambulation = 1 if disability == 1 | disability == 2
replace disability_ambulation = 2 if (disability == 1 | disability == 2) & r2_disability_ambulation == 1 & r4_disability_ambulation == 1
label var disability_ambulation "Ambulation Disability"
label define disabilitytypelab 0 "Nondisabled" 1 "Disabled, Other" 2 "Disabled, Yes"
label values disability_ambulation disabilitytypelab
drop r2_disability_ambulation r4_disability_ambulation

// Cognition Disability, Rounds 2 and 4
/* 0: Nondisabled; 1: Disabled, Other; 2: Disabled, Yes */
gen disability_cognition = .
replace disability_cognition = 0 if disability == 0
replace disability_cognition = 1 if disability == 1 | disability == 2
replace disability_cognition = 2 if (disability == 1 | disability == 2) & r2_disability_cognition == 1 & r4_disability_cognition == 1
label var disability_cognition "Cognition Disability"
label values disability_cognition disabilitytypelab
drop r2_disability_cognition r4_disability_cognition
 
// Hearing Disability, Rounds 2 and 4
/* 0: Nondisabled; 1: Disabled, Other; 2: Disabled, Yes */
gen disability_hearing = .
replace disability_hearing = 0 if disability == 0
replace disability_hearing = 1 if disability == 1 | disability == 2
replace disability_hearing = 2 if (disability == 1 | disability == 2) & r2_disability_hearing == 1 & r4_disability_hearing == 1
label var disability_hearing "Hearing Disability"
label values disability_hearing disabilitytypelab
drop r2_disability_hearing r4_disability_hearing

// Independent Living Disability, Rounds 2 and 4
/* 0: Nondisabled; 1: Disabled, Other; 2: Disabled, Yes */
gen disability_independent = .
replace disability_independent = 0 if disability == 0
replace disability_independent = 1 if disability == 1 | disability == 2
replace disability_independent = 2 if (disability == 1 | disability == 2) & r2_disability_independent == 1 & r4_disability_independent == 1
label var disability_independent "Independent Disability"
label values disability_independent disabilitytypelab
drop r2_disability_independent r4_disability_independent

// Seeing Disability, Rounds 2 and 4
/* 0: Nondisabled; 1: Disabled, Other; 2: Disabled, Yes */
gen disability_seeing = .
replace disability_seeing = 0 if disability == 0
replace disability_seeing = 1 if disability == 1 | disability == 2
replace disability_seeing = 2 if (disability == 1 | disability == 2) & r2_disability_seeing == 1 & r4_disability_seeing == 1
label var disability_seeing "Seeing Disability"
label values disability_seeing disabilitytypelab
drop r2_disability_seeing r4_disability_seeing

// Self-Care Disability, Rounds 2 and 4
/* 0: Nondisabled; 1: Disabled, Other; 2: Disabled, Yes */
gen disability_selfcare = .
replace disability_selfcare = 0 if disability == 0
replace disability_selfcare = 1 if disability == 1 | disability == 2
replace disability_selfcare = 2 if (disability == 1 | disability == 2) & r2_disability_selfcare == 1 & r4_disability_selfcare == 1
label var disability_selfcare "Self-Care Disability"
label values disability_selfcare disabilitytypelab
drop r2_disability_selfcare r4_disability_selfcare

****************
** Covariates **
****************

// Sex
/* 0: Female; 1: Male */
gen sex = .
replace sex = 0 if SEX == 2
replace sex = 1 if SEX == 1
label var sex "Sex"
label define sexlab 0 "Female" 1 "Male"
label values sex sexlab
drop SEX

// Age
/* 1: 18-29; 2: 30-39; 3: 40-49; 4: 50-59; 5: 60-69; 70+ */
/* Note: MEPS top-codes age at 85 */
gen age = .
replace age = 1 if AGE1X >= 18 & AGE1X <= 29
replace age = 2 if AGE1X >= 30 & AGE1X <= 39
replace age = 3 if AGE1X >= 40 & AGE1X <= 49
replace age = 4 if AGE1X >= 50 & AGE1X <= 59
replace age = 5 if AGE1X >= 60 & AGE1X <= 69
replace age = 6 if AGE1X >= 70 & AGE1X <= 85
label var age "Age"
label define agelab 1 "18-29" 2 "30-39" 3 "40-49" 4 "50-59" 5 "60-69" 6 "70+"
label values age agelab

// Race
/* 1: Asian; 2: Black; 3: White; 4: Other */
generate race = .
replace race = 1 if RACEV1X == 4 & RACEAX == 1 
replace race = 2 if RACEV1X == 2
replace race = 3 if RACEV1X == 1
replace race = 4 if RACEV1X == 3 | RACEV1X == 6 | (RACEV1X == 4 & RACEAX != 1)
label var race "Race"
label define racelab 1 "Asian" 2 "Black" 3 "White" 4 "Other"
label values race racelab
drop RACEV1X RACEAX

// Ethnicity (Hispanic, Latino, or of Spanish origin)
/* 1: Yes (Mexican origin); 2: Yes (all other origins); 3: No */
generate ethnicity = .
replace ethnicity = 1 if HISPANX == 1 & HISPNCAT == 1
replace ethnicity = 2 if HISPANX == 1 & HISPNCAT != 1
replace ethnicity = 3 if HISPANX == 2
label var ethnicity "Hispanic Ethnicity"
label define ethnicitylab 1 "Yes (Mexican Origin)" 2 "Yes (All Other Origins)" 3 "No"
label values ethnicity ethnicitylab
drop HISPANX HISPNCAT

// Educational Attainment
/* 1: No Degree; 2: High School Grad or GED; 3: Bachelor's Degree; 4: Master's/Doctorate Degree; 5: Other Degree */
/* Note: HIDEG is not available for some respondents in 2015, which is why EDUYRDG is needed */
gen education = .
replace education = 1 if HIDEG == 1 | ((EDUYRDG == 1 | EDUYRDG == 2) & year == 2015)
replace education = 2 if HIDEG == 2 | HIDEG == 3 | ((EDUYRDG == 3 | EDUYRDG == 4 | EDUYRDG == 5) & year == 2015)
replace education = 3 if HIDEG == 4 | (EDUYRDG == 8 & year == 2015)
replace education = 4 if HIDEG == 5 | HIDEG == 6 | (EDUYRDG == 9 & year == 2015)
replace education = 5 if HIDEG == 7 | ((EDUYRDG == 6 | EDUYRDG == 7) & year == 2015)
label var education "Educational Attainment"
label define educationlab 1 "No Degree" 2 "High School Grad or GED" 3 "Bachelor's Degree" 4 "Master's/Doctorate Degree" 5 "Other Degree" 
label values education educationlab
drop HIDEG EDUYRDG

// Family Income
/* 1: Below Poverty Line; 2: Near Poverty Line; 3: Low Income; 4: Middle Income; 5: High Income */
gen income = .
replace income = 1 if POVCATY1 == 1
replace income = 2 if POVCATY1 == 2
replace income = 3 if POVCATY1 == 3
replace income = 4 if POVCATY1 == 4
replace income = 5 if POVCATY1 == 5
label var income "Family Income"
label define incomelab 1 "Below Poverty Line" 2 "Near Poverty Line" 3 "Low Income" 4 "Middle Income" 5 "High Income"
label values income incomelab
drop POVCATY1

// Health Insurance, Round 1
/* 1: Any Private; 2: Public Only; 3: Uninsured */
gen insurance = . 
replace insurance = 1 if INSCOVY1 == 1
replace insurance = 2 if INSCOVY1 == 2
replace insurance = 3 if INSCOVY1 == 3
label var insurance "Health Insurance"
label define insurancelab 1 "Any Private" 2 "Public Only" 3 "Uninsured"
label values insurance insurancelab
drop INSCOVY1

// Number of Office-Based Provider Visits, Year 1
/* 0: 0; 1: 1; 2: 2; 3: 3-4; 4: 5-9: 5: 10+ */
gen office_visits = .
replace office_visits = 0 if OBTOTVY1 == 0
replace office_visits = 1 if OBTOTVY1 == 1
replace office_visits = 2 if OBTOTVY1 == 2
replace office_visits = 3 if OBTOTVY1 == 3 | OBTOTVY1 == 4
replace office_visits = 4 if OBTOTVY1 >= 5 & OBTOTVY1 <= 9
replace office_visits = 5 if OBTOTVY1 >= 10 & OBTOTVY1 <= 10000
label var office_visits "Baseline Office-Based Provider Visits"
label define office_visits_lab 0 "0" 1 "1" 2 "2" 3 "3-4" 4 "5-9" 5 "10+"
label values office_visits office_visits_lab
drop OBTOTVY1

// Number of Emergency Room Visits, Year 1
/* 0: 0; 1: 1; 2: 2+ */
gen er_visits = .
replace er_visits = 0 if ERTOTY1 == 0 
replace er_visits = 1 if ERTOTY1 == 1
replace er_visits = 2 if ERTOTY1 >= 2 & ERTOTY1 <= 10000
label var er_visits "Baseline ER Visits"
label define er_visits_lab 0 "0" 1 "1" 2 "2+"
label values er_visits er_visits_lab
drop ERTOTY1

// Any Hospitalizations, Year 1
/* 0: no; 1: yes */
gen hospital = .
replace hospital = 0 if IPDISY1 == 0
replace hospital = 1 if IPDISY1 >= 1 & IPDISY1 <= 10000
label var hospital "Baseline Hospitalizations"
label values hospital yesno
drop IPDISY1

// Baseline Health, Round 1
/* Rated health as poor or fair rather than good, very good, or excellent */
/* 0: no; 1: yes */
gen r1_health = .
replace r1_health = 0 if RTHLTH1 == 1 | RTHLTH1 == 2 | RTHLTH1 == 3
replace r1_health = 1 if RTHLTH1 == 4 | RTHLTH1 == 5 
label var r1_health "Baseline Poor/Fair Health"
label values r1_health yesno
drop RTHLTH1

// Baseline Mental Health, Round 1
/* Rated health as poor or fair rather than good, very good, or excellent */
/* 0: no; 1: yes */
gen r1_mental = .
replace r1_mental = 0 if MNHLTH1 == 1 | MNHLTH1 == 2 | MNHLTH1 == 3
replace r1_mental = 1 if MNHLTH1 == 4 | MNHLTH1 == 5 
label var r1_mental "Baseline Poor/Fair Mental Health"
label values r1_mental yesno
drop MNHLTH1

// Ever Received High Blood Pressure Diagnosis, Year 1
gen high_bp = .
replace high_bp = 0 if HIBPDXY1 == 2
replace high_bp = 1 if HIBPDXY1 == 1
label var high_bp "High Blood Pressure, Ever Diagnosed"
label values high_bp yesno
drop HIBPDX

// Ever Received Heart Disease Diagnosis, , Year 1
gen heart_disease = .
replace heart_disease = 0 if CHDDXY1 == 2 & OHRTDXY1 == 2
replace heart_disease = 1 if CHDDXY1 == 1 | OHRTDXY1 == 1
label var heart_disease "Heart Disease, Ever Diagnosed"
label values heart_disease yesno
drop CHDDX OHRTDX

// Ever Received Diabetes Diagnosis, Year 1
gen diabetes = .
replace diabetes = 0 if DIABDXY1_M18 == 2
replace diabetes = 1 if DIABDXY1_M18 == 1
label var diabetes "Diabetes, Ever Diagnosed"
label values diabetes yesno
drop DIABDXY1_M18

// Ever Received Cancer Diagnosis, Year 1
gen cancer = .
replace cancer = 0 if CANCERY1 == 2
replace cancer = 1 if CANCERY1 == 1
label var cancer "Cancer, Ever Diagnosed"
label values cancer yesno
drop CANCERY1

// Self-Reported Responses, Round 1
/* 0: No; 1: First Respondent */
gen proxy_r1 = .
replace proxy_r1 = 0 if RESP1 == 2
replace proxy_r1 = 1 if RESP1 == 1
label var proxy_r1 "Self-Reported Responses, Round 1"
label define proxylab 0 "No" 1 "First Respondent"
label values proxy_r1 proxylab
drop RESP1

// Self-Reported Responses, Round 2
/* 0: No; 1: First Respondent */
gen proxy_r2 = .
replace proxy_r2 = 0 if RESP2 == 2
replace proxy_r2 = 1 if RESP2 == 1
label var proxy_r2 "Self-Reported Responses, Round 2"
label values proxy_r2 proxylab
drop RESP2

// Self-Reported Responses, Round 4
/* 0: No; 1: First Respondent */
gen proxy_r4 = .
replace proxy_r4 = 0 if RESP4 == 2
replace proxy_r4 = 1 if RESP4 == 1
label var proxy_r4 "Self-Reported Responses, Round 4"
label values proxy_r4 proxylab
drop RESP4

// Self-Reported Responses, SAQ Round 4
/* 0: No or Unknown; 1: Yes */
gen proxy_saq = .
replace proxy_saq = 0 if SAQELIY2 == 1
replace proxy_saq = 1 if SAQELIY2 == 1 & ADPROX4 == 1
label var proxy_saq "Self-Reported Responses, SAQ"
label define proxy_lab 0 "No or Unknown" 1 "Yes"
label values proxy_saq proxy_lab
drop ADPROX4

// Survey Year
/* 1: 2014-2015; 2: 2015-2016; 3: 2016-2017; 4: 2018-2019; 5: 2020-2021; 5: 2022-2023 */
gen survey_year = .
replace survey_year = 1 if year == 2015
replace survey_year = 2 if year == 2016
replace survey_year = 3 if year == 2017
replace survey_year = 4 if year == 2019
replace survey_year = 5 if year == 2021
replace survey_year = 6 if year == 2023
label var survey_year "Survey Year"
label define survey_yearlab 1 "2014-2015" 2 "2015-2016" 3 "2016-2017" 4 "2018-2019" 5 "2020-2021" 6 "2022-2023" 
label values survey_year survey_yearlab
drop year

**************************************
** Mediator: Low-Quality Health Care **
**************************************

// Any Health Care Visits, SAQ Round 4
/* in the last 12 months, times you went to a doctor's office or clinic to get health care */
/* 0: No; 1: Yes */
gen any_visits = .
replace any_visits = 0 if ADAPPT4 == 0
replace any_visits = 1 if ADAPPT4 >= 1 & ADAPPT4 <= 6
label var any_visits "Any Health Care Visits in Last 12 Months"
label values any_visits yesno
drop ADAPPT4

// Health Professionals Did Not Listen Carefully, SAQ Round 4 
/* doctors or other health professionals never or only sometimes listened carefully to you */
/* 0: no; 1: yes */
gen listening = .
replace listening = 0 if ADLIST4 == 3 | ADLIST4 == 4
replace listening = 1 if ADLIST4 == 1 | ADLIST4 == 2
label var listening "Did Not Listen Carefully"
label values listening yesno
drop ADLIST4

// Health Professionals Did Not Communicate Clearly, SAQ Round 4
/* doctors or other health professionals never or only sometimes explained things in a way that was easy to understand */
/* 0: no; 1: yes */
gen explain = .
replace explain = 0 if ADEXPL4 == 3 | ADEXPL4 == 4
replace explain = 1 if ADEXPL4 == 1 | ADEXPL4 == 2
label var explain "Did Not Communicate Clearly"
label values explain yesno
drop ADEXPL4

// Health Professionals Did Not Show Respect, SAQ Round 4
/* doctors or other health professionals never or only sometimes showed respect for what you had to say */
/* 0: no; 1: yes */
gen respect = .
replace respect = 0 if ADRESP4 == 3 | ADRESP4 == 4
replace respect = 1 if ADRESP4 == 1 | ADRESP4 == 2
label var respect "Did Not Show Respect"
label values respect yesno
drop ADRESP4

// Health Professionals Did Not Spend Enough Time, SAQ Round 4 
/* doctors or other health professionals never or only sometimes spent enough time with you */
/* 0: no; 1: yes */
gen time = .
replace time = 0 if ADPRTM4 == 3 | ADPRTM4 == 4
replace time = 1 if ADPRTM4 == 1 | ADPRTM4 == 2
label var time "Did Not Spend Enough Time"
label values time yesno
drop ADPRTM4

// Dissatisfaction with Health Care, SAQ Round 4
/* rated all health care as less than 5 out of 10 [0 was worst possible care and 10 was best]) */
/* 0: no; 1: yes */
gen satisfaction = .
replace satisfaction = 0 if ADHECR4 >= 5 & ADHECR4 <= 10
replace satisfaction = 1 if ADHECR4 >= 0 & ADHECR4 <= 4
label var satisfaction "Dissatisfied with Health Care"
label values satisfaction yesno
drop ADHECR4

// Any Low-Quality Health Care, SAQ Round 4
/* reported one or more of the above 5 dimensions of low-quality health care */
/* 0: no; 1: yes */
gen lowqualitycare = .
replace lowqualitycare = 0 if listening == 0 & respect == 0 & explain == 0 & time == 0 & satisfaction == 0 
replace lowqualitycare = 1 if listening == 1 | respect == 1 | explain == 1 | time == 1 | satisfaction == 1 
label var lowqualitycare "Low-Quality Health Care"
label values lowqualitycare yesno

*********************
** Outcome: Health **
*********************

// Self-Reported Poor/Fair Health, SAQ Round 4
/* rated current health as poor or fair rather than good, very good, or excellent */
/* 0: no; 1: yes */
gen gen_health = .
replace gen_health = 0 if ADGENH4 == 1 | ADGENH4 == 2 | ADGENH4 == 3
replace gen_health = 1 if ADGENH4 == 4 | ADGENH4 == 5
label var gen_health "Poor/Fair Health"
label values gen_health yesno
drop ADGENH4

// Serious Psychological Distress (K6), SAQ Round 4
/* scored a 13 or higher over the past 30 days on the Kessler-6 Index */
/* 0: no; 1: yes */
gen distress = .
replace distress = 0 if K6SUM4 >= 0 & K6SUM4 <= 12
replace distress = 1 if K6SUM4 >= 13 & K6SUM4 <= 24
label var distress "Serious Psychological Distress (K6)"
label values distress yesno
drop K6SUM4

// High-Impact Pain, SAQ Round 4
/* pain that interfered with your normal work [work outside the home and housework] moderately, quite a bit, or extremely over the past 4 weeks */
/* 0: no; 1: yes */
gen pain = .
replace pain = 0 if ADPAIN4 == 1 | ADPAIN4 == 2
replace pain = 1 if ADPAIN4 == 3 | ADPAIN4 == 4 | ADPAIN4 == 5
label var pain "High-Impact Pain"
label values pain yesno
drop ADPAIN4

// Depressed Mood (PHQ-2), SAQ Round 4
/* scored a 3 or higher over the past 2 weeks on the PHQ-2 */
/* 0: no; 1: yes */
gen depressed = .
replace depressed = 0 if PHQ24 >= 0 & PHQ24 <= 2
replace depressed = 1 if PHQ24 >= 3 & PHQ24 <= 6
label var depressed "Depressed Mood (PHQ-2)"
label values depressed yesno
drop PHQ24

// Rated Health, Round 5
/* perceived health as poor or fair rather than good, very good, or excellent */
/* 0: no; 1: yes */
gen r5_health = .
replace r5_health = 0 if RTHLTH5 == 1 | RTHLTH5 == 2 | RTHLTH5 == 3
replace r5_health = 1 if RTHLTH5 == 4 | RTHLTH5 == 5 
label var r5_health "Poor/Fair Health"
label values r5_health yesno
drop RTHLTH5

// Rated Mental Health, Round 5
/* perceived mental health as poor or fair rather than good, very good, or excellent */
/* 0: no; 1: yes */
gen r5_mental = .
replace r5_mental = 0 if MNHLTH5 == 1 | MNHLTH5 == 2 | MNHLTH5 == 3
replace r5_mental = 1 if MNHLTH5 == 4 | MNHLTH5 == 5 
label var r5_mental "Poor/Fair Mental Health"
label values r5_mental yesno
drop MNHLTH5

// Self-Reported Responses, Round 5
/* 0: No; 1: First Respondent */
gen proxy_r5 = .
replace proxy_r5 = 0 if RESP5 == 2
replace proxy_r5 = 1 if RESP5 == 1
label var proxy_r5 "Self-Reported Health Status"
label values proxy_r5 proxy_disabilitylab
drop RESP5

// Save Full Clean Pooled Data
save data_pooled.dta, replace

***********************************************
**** PART 3:                               ****
**** MERGE EXPOSURE, OUTCOME, AND VARIANCE ****
***********************************************

// Prepare Variance Structure
use h36u24.dta, clear
keep DUPERSID PANEL STRA9624 PSU9624
save variance_temp.dta, replace

// Merge in Variance
use data_pooled.dta, clear
merge 1:1 DUPERSID PANEL using variance_temp.dta
keep if _merge == 3 
drop _merge

***********************
**** PART 4:       ****
**** CREATE SAMPLE ****
***********************

// Note: Output Used for eFigure 1 (Flow Chart)

// Limit Dataset to SAQ Respondents
count
keep if SAQRDS24 == 0 | SAQRDS24 == 1
count
drop SAQRDS24

// Create Main Sample Flag for Respondents who Completed SAQ at Round 4
gen mainsample = 1 if SAQELIY2 == 1
label var mainsample "Main Sample Flag"
count if mainsample == 1
drop SAQELIY2

// Limit to Adults 18+ at Round 1
replace mainsample = . if AGE1X >= 0 & AGE1X <= 17
count if mainsample == 1
drop AGE1X

// Limit to Respondents Who Reported 1+ Health Care Visits
replace mainsample = . if any_visits == 0 | any_visits == .
count if mainsample == 1

// Exclude Respondents from Main Sample Flag with Missing Data on Disability
replace mainsample = . if disability == .
count if mainsample == 1

// Exclude Respondents from Main Sample Flag with Missing Data on Covariates of Exposure-Mediator Association
foreach lname in proxy_r1 proxy_r2 proxy_r4 proxy_saq survey_year age sex race ethnicity education income insurance  {
replace mainsample = . if `lname' == .
count if mainsample == 1
}

// Exclude Respondents from Main Sample Flag with Missing Data on Additional Covariates of Mediator-Outcome Association
foreach lname in office_visits er_visits hospital r1_health r1_mental high_bp heart_disease diabetes  {
replace mainsample = . if `lname' == .
count if mainsample == 1
}

// Exclude Respondents from Main Sample Flag with Missing Data on Health Care Quality
replace mainsample = . if lowqualitycare == .
count if mainsample == 1

// Exclude Respondents from Sample Flag with Missing Data on Primary Health Outcomes
foreach lname in gen_health distress depressed pain {
replace mainsample = . if `lname' == .
count if mainsample == 1
}

// Count Main Sample
count if mainsample == 1

***************************
**** PART 5:           ****
**** CREATE SUBSAMPLES ****
***************************

// Create Subsample Flag for Main Sample Respondents Limited to Ages 18-69
gen subsample_age = mainsample
replace subsample_age = . if age == 6
/* Count Subsample */
count if subsample_age == 1

// Create Subsample Flag for Main Sample Respondents with Only Self-Reported Data
gen subsample_selfreport = mainsample
foreach lname in proxy_r1 proxy_r2 proxy_r4 proxy_saq {
replace subsample_selfreport = . if `lname' == 0
count if subsample_selfreport == 1
}
/* Count Subsample */
count if subsample_selfreport == 1

// Create Subsample Flag for Main Sample Respondents with Self-Reported Data on Secondary Health Outcomes
gen subsample_sechealth = mainsample
replace subsample_sechealth = . if proxy_r5 == 0 | proxy_r5 == .
foreach lname in r5_health r5_mental {
replace subsample_sechealth = . if `lname' == .
count if subsample_sechealth == 1
}
/* Count Subsample */
count if subsample_sechealth == 1

// Save Dataset
save dataset.dta, replace

// Erase Temporary Datasets
erase data_pooled.dta

****************
** End of File *
****************
