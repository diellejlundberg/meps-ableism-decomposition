************************************************************************************************************
** Disability, ableism in health care settings, and health disparities among US adults: a cross-sectional decomposition analysis
** Code by Dielle J. Lundberg
** Last Updated: October 3, 2026
** Code File 17 of 18: Table S11 and S12 (PR/PAF, Primary Model, Secondary Health Outcomes) (create output-file-15.xlsx)
************************************************************************************************************

**********************************************
** PRIMARY MODEL, SECONDARY HEALTH OUTCOMES IN SELF-REPORTED DATA **
**********************************************

// Set Working Directory
cd "/Users/djlworkdesktop/Library/Mobile Documents/com~apple~CloudDocs/Independent Research/MEPS-Ableism-PAF-Project/Analysis V3"

****************************************
** Step 0: Specify Starting Decisions **
****************************************

// Estimand: cases of poor/fair health, r5_mental, depression, and pain among disabled adults that would be averted if disabled adults' levels of low-quality health care were equalized to nondisabled adults
// PRnatural = Odis / Onondis
// PRcounter = Edis / Enondis
// %decomposition = ([PRnatural - 1] - [PRcounter - 1]) / (PRnatural - 1)
// PAF = (O - E) / O 
// PAR = O - E 
// Attributable Cases = PAR * total population of U.S. disabled adults using health care
// O = Observed cases among disabled adults
// E = Expected cases among disabled adults if disabled adults' experiences of low-quality health care were set to the levels of nondisabled adults

************************************************
** Step 1: Estimate Relationships in the Data **
************************************************

// Load Data
use dataset.dta, clear

// Set Weights (Longitudinal SAQ Weights)
svyset [pweight=LSAQWT], strata(STRA9624) psu(PSU9624) 

// Model Low-Quality Health Care (Mediator) as a Function of Group (Disability) and Confounders of Group-Mediator Relationship
svy, subpop(if subsample_sechealth == 1): logistic lowqualitycare i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance 
// Model Health (Outcome) as a Function of Low-Quality Health Care (Mediator) and Confounders of Mediator-Outcome Relationship
/* Perceived Poor/Fair Health */
svy, subpop(if subsample_sechealth == 1): logistic r5_health i.lowqualitycare##i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance i.office_visits i.er_visits i.hospital i.r1_health i.r1_mental i.high_bp i.heart_disease i.diabetes i.cancer
/* Perceived Poor/Fair Mental Health */
svy, subpop(if subsample_sechealth == 1): logistic r5_mental i.lowqualitycare##i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance i.office_visits i.er_visits i.hospital i.r1_health i.r1_mental i.high_bp i.heart_disease i.diabetes i.cancer

***********************************************************************************************************************
***********************************************************************************************************************

*******************************************************
** Step 2: Form the Natural-Course Pseudo-Population **
*******************************************************

// Set Seed
set seed 12345

// Estimate Adjusted Prevalence of Mediator in Natural Course
svy, subpop(if subsample_sechealth == 1): logistic lowqualitycare i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance 
predict lowqualitycare_prev if subsample_sechealth == 1, pr

*********************
** Disabled Adults **
*********************

// Simulate Outcome Values for Disabled Adults Using Simulated Mediator Values
/* Perceived Poor/Fair Health */
svy, subpop(if subsample_sechealth == 1): logistic r5_health i.lowqualitycare##i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance i.office_visits i.er_visits i.hospital i.r1_health i.r1_mental i.high_bp i.heart_disease i.diabetes i.cancer 
gen lowqualitycare_orig = lowqualitycare if subsample_sechealth == 1 & disability == 2
local r5_health_sim = 0
local num = 100
forvalues n = 1 / `num' {
	gen lowqualityhealthcare_sim = rbinomial(1, lowqualitycare_prev) if subsample_sechealth == 1 & disability == 2
	replace lowqualitycare = lowqualityhealthcare_sim if subsample_sechealth == 1 & disability == 2
	predict r5_health_sim if subsample_sechealth == 1 & disability == 2, pr
	gen r5_health_sim_weighted = r5_health_sim * LSAQWT if subsample_sechealth == 1 & disability == 2
	sum r5_health_sim_weighted if subsample_sechealth == 1 & disability == 2
	local wsum = r(sum)
	sum LSAQWT if subsample_sechealth == 1 & disability == 2
	local wdenom = r(sum)
	local r5_health_sim = `r5_health_sim' + (`wsum' / `wdenom')
	drop lowqualityhealthcare_sim r5_health_sim r5_health_sim_weighted
}
local r5_health_natural = `r5_health_sim' / `num'
display "`r5_health_natural'"
replace lowqualitycare = lowqualitycare_orig if subsample_sechealth == 1 & disability == 2
drop lowqualitycare_orig 
/* Perceived Poor/Fair Mental Health */
svy, subpop(if subsample_sechealth == 1): logistic r5_mental i.lowqualitycare##i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance i.office_visits i.er_visits i.hospital i.r1_health i.r1_mental i.high_bp i.heart_disease i.diabetes i.cancer 
gen lowqualitycare_orig = lowqualitycare if subsample_sechealth == 1 & disability == 2
local r5_mental_sim = 0
local num = 100
forvalues n = 1 / `num' {
	gen lowqualityhealthcare_sim = rbinomial(1, lowqualitycare_prev) if subsample_sechealth == 1 & disability == 2
	replace lowqualitycare = lowqualityhealthcare_sim if subsample_sechealth == 1 & disability == 2
	predict r5_mental_sim if subsample_sechealth == 1 & disability == 2, pr
	gen r5_mental_sim_weighted = r5_mental_sim * LSAQWT if subsample_sechealth == 1 & disability == 2
	sum r5_mental_sim_weighted if subsample_sechealth == 1 & disability == 2
	local wsum = r(sum)
	sum LSAQWT if subsample_sechealth == 1 & disability == 2
	local wdenom = r(sum)
	local r5_mental_sim = `r5_mental_sim' + (`wsum' / `wdenom')
	drop lowqualityhealthcare_sim r5_mental_sim r5_mental_sim_weighted
}
local r5_mental_natural = `r5_mental_sim' / `num'
display "`r5_mental_natural'"
replace lowqualitycare = lowqualitycare_orig if subsample_sechealth == 1 & disability == 2
drop lowqualitycare_orig

************************
** Nondisabled Adults **
************************

// Simulate Outcome Values for Nondisabled Adults Using Simulated Mediator Values
/* Perceived Poor/Fair Health */
svy, subpop(if subsample_sechealth == 1): logistic r5_health i.lowqualitycare##i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance i.office_visits i.er_visits i.hospital i.r1_health i.r1_mental i.high_bp i.heart_disease i.diabetes i.cancer 
gen lowqualitycare_orig = lowqualitycare if subsample_sechealth == 1 & disability == 0
local r5_health_sim = 0
local num = 100
forvalues n = 1 / `num' {
	gen lowqualityhealthcare_sim = rbinomial(1, lowqualitycare_prev) if subsample_sechealth == 1 & disability == 0
	replace lowqualitycare = lowqualityhealthcare_sim if subsample_sechealth == 1 & disability == 0
	predict r5_health_sim if subsample_sechealth == 1 & disability == 0, pr
	gen r5_health_sim_weighted = r5_health_sim * LSAQWT if subsample_sechealth == 1 & disability == 0
	sum r5_health_sim_weighted if subsample_sechealth == 1 & disability == 0
	local wsum = r(sum)
	sum LSAQWT if subsample_sechealth == 1 & disability == 0
	local wdenom = r(sum)
	local r5_health_sim = `r5_health_sim' + (`wsum' / `wdenom')
	drop lowqualityhealthcare_sim r5_health_sim r5_health_sim_weighted
}
local r5_health_natural_nondis = `r5_health_sim' / `num'
display "`r5_health_natural_nondis'"
replace lowqualitycare = lowqualitycare_orig if subsample_sechealth == 1 & disability == 0
drop lowqualitycare_orig
/* Perceived Poor/Fair Mental Health */
svy, subpop(if subsample_sechealth == 1): logistic r5_mental i.lowqualitycare##i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance i.office_visits i.er_visits i.hospital i.r1_health i.r1_mental i.high_bp i.heart_disease i.diabetes i.cancer 
gen lowqualitycare_orig = lowqualitycare if subsample_sechealth == 1 & disability == 0
local r5_mental_sim = 0
local num = 100
forvalues n = 1 / `num' {
	gen lowqualityhealthcare_sim = rbinomial(1, lowqualitycare_prev) if subsample_sechealth == 1 & disability == 0
	replace lowqualitycare = lowqualityhealthcare_sim if subsample_sechealth == 1 & disability == 0
	predict r5_mental_sim if subsample_sechealth == 1 & disability == 0, pr
	gen r5_mental_sim_weighted = r5_mental_sim * LSAQWT if subsample_sechealth == 1 & disability == 0
	sum r5_mental_sim_weighted if subsample_sechealth == 1 & disability == 0
	local wsum = r(sum)
	sum LSAQWT if subsample_sechealth == 1 & disability == 0
	local wdenom = r(sum)
	local r5_mental_sim = `r5_mental_sim' + (`wsum' / `wdenom')
	drop lowqualityhealthcare_sim r5_mental_sim r5_mental_sim_weighted
}
local r5_mental_natural_nondis = `r5_mental_sim' / `num'
display "`r5_mental_natural_nondis'"
replace lowqualitycare = lowqualitycare_orig if subsample_sechealth == 1 & disability == 0
drop lowqualitycare_orig lowqualitycare_prev

***********************************************************************************************************************
***********************************************************************************************************************

*******************************************************
** Step 3: Form the Counterfactual Pseudo-Population **
*******************************************************

// Estimate Adjusted Prevalence of Mediator if Disabled Adults Were Nondisabled
svy, subpop(if subsample_sechealth == 1): logistic lowqualitycare i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance
gen disability_orig = disability
replace disability = 0 if subsample_sechealth == 1 & disability_orig == 2
predict lowqualitycare_prev if subsample_sechealth == 1, pr
replace disability = disability_orig
drop disability_orig

*********************
** Disabled Adults **
*********************

// Simulate Outcome Values Using Simulated Mediator Values
/* Perceived Poor/Fair Health */
svy, subpop(if subsample_sechealth == 1): logistic r5_health i.lowqualitycare##i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance i.office_visits i.er_visits i.hospital i.r1_health i.r1_mental i.high_bp i.heart_disease i.diabetes i.cancer 
gen lowqualitycare_orig = lowqualitycare if subsample_sechealth == 1 & disability == 2
local r5_health_sim = 0
local num = 100
forvalues n = 1 / `num' {
	gen lowqualityhealthcare_sim = rbinomial(1, lowqualitycare_prev) if subsample_sechealth == 1 & disability == 2
	replace lowqualitycare = lowqualityhealthcare_sim if subsample_sechealth == 1 & disability == 2
	predict r5_health_sim if subsample_sechealth == 1 & disability == 2, pr
	gen r5_health_sim_weighted = r5_health_sim * LSAQWT if subsample_sechealth == 1 & disability == 2
	sum r5_health_sim_weighted if subsample_sechealth == 1 & disability == 2
	local wsum = r(sum)
	sum LSAQWT if subsample_sechealth == 1 & disability == 2
	local wdenom = r(sum)
	local r5_health_sim = `r5_health_sim' + (`wsum' / `wdenom')
	drop lowqualityhealthcare_sim r5_health_sim r5_health_sim_weighted
}
local r5_health_expected = `r5_health_sim' / `num'
display "`r5_health_expected'"
replace lowqualitycare = lowqualitycare_orig if subsample_sechealth == 1 & disability == 2
drop lowqualitycare_orig
/* Perceived Poor/Fair Mental Health */
svy, subpop(if subsample_sechealth == 1): logistic r5_mental i.lowqualitycare##i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance i.office_visits i.er_visits i.hospital i.r1_health i.r1_mental i.high_bp i.heart_disease i.diabetes i.cancer 
gen lowqualitycare_orig = lowqualitycare if subsample_sechealth == 1 & disability == 2
local r5_mental_sim = 0
local num = 100
forvalues n = 1 / `num' {
	gen lowqualityhealthcare_sim = rbinomial(1, lowqualitycare_prev) if subsample_sechealth == 1 & disability == 2
	replace lowqualitycare = lowqualityhealthcare_sim if subsample_sechealth == 1 & disability == 2
	predict r5_mental_sim if subsample_sechealth == 1 & disability == 2, pr
	gen r5_mental_sim_weighted = r5_mental_sim * LSAQWT if subsample_sechealth == 1 & disability == 2
	sum r5_mental_sim_weighted if subsample_sechealth == 1 & disability == 2
	local wsum = r(sum)
	sum LSAQWT if subsample_sechealth == 1 & disability == 2
	local wdenom = r(sum)
	local r5_mental_sim = `r5_mental_sim' + (`wsum' / `wdenom')
	drop lowqualityhealthcare_sim r5_mental_sim r5_mental_sim_weighted
}
local r5_mental_expected = `r5_mental_sim' / `num'
display "`r5_mental_expected'"
replace lowqualitycare = lowqualitycare_orig if subsample_sechealth == 1 & disability == 2
drop lowqualitycare_orig lowqualitycare_prev

************************
** Nondisabled Adults **
************************

// Simulate Outcome Values for Nondisabled Adults Using Simulated Mediator Values
/* Perceived Poor/Fair Health */
local r5_health_expected_nondis = `r5_health_natural_nondis'
/* r5_mental */
local r5_mental_expected_nondis = `r5_mental_natural_nondis'

***********************************************************************************************************************
***********************************************************************************************************************

********************************************
** Step 4: Compare Contrasts of Interest  **
********************************************

*******************************************************
** Confirm Natural Course Equals Observed Prevalence **
*******************************************************

// Confirm Natural Course Prevalence Equals Observed Prevalence for Disabled Adults 
/* Perceived Poor/Fair Health */
display "`r5_health_natural'"
svy, subpop(if subsample_sechealth == 1 & disability == 2): mean r5_health
/* Perceived Poor/Fair Mental Health */
display "`r5_mental_natural'"
svy, subpop(if subsample_sechealth == 1 & disability == 2): mean r5_mental

// Confirm Natural Course Prevalence Equals Observed Prevalence for Nondisabled Adults 
/* Perceived Poor/Fair Health */
display "`r5_health_natural_nondis'"
svy, subpop(if subsample_sechealth == 1 & disability == 0): mean r5_health
/* Perceived Poor/Fair Mental Health */
display "`r5_mental_natural_nondis'"
svy, subpop(if subsample_sechealth == 1 & disability == 0): mean r5_mental

*********************************************************
** Prevalence Ratios, PAF, PAR, and Attributable Cases **
*********************************************************

// Estimate US Disabled Population Using Health Care
svy, subpop(if any_visits == 1): total i.disability
matrix M = r(table)
scalar disabled_pop = M[1,3]

// Estimate Prevalence Ratios, PAF, PAR, and Attributable Cases
/* Poor/Fair Health */
local PR_natural_r5_health = `r5_health_natural' / `r5_health_natural_nondis'
local PR_counter_r5_health = `r5_health_expected' / `r5_health_expected_nondis'
local decomp_r5_health = ((`PR_natural_r5_health' - 1) - (`PR_counter_r5_health' - 1)) / (`PR_natural_r5_health' - 1) * 100
local PAF_r5_health = (`r5_health_natural' - `r5_health_expected') / `r5_health_natural' * 100
local PAR_r5_health = (`r5_health_natural' - `r5_health_expected') * 1000
local cases_r5_health = (`r5_health_natural' - `r5_health_expected') * disabled_pop
display "`PR_natural_r5_health'"
display "`PR_counter_r5_health'"
display "`decomp_r5_health'"
display "`PAF_r5_health'"
display "`PAR_r5_health'"
display "`cases_r5_health'"
/* Perceived Poor/Fair Mental Health */
local PR_natural_r5_mental = `r5_mental_natural' / `r5_mental_natural_nondis'
local PR_counter_r5_mental = `r5_mental_expected' / `r5_mental_expected_nondis'
local decomp_r5_mental = ((`PR_natural_r5_mental' - 1) - (`PR_counter_r5_mental' - 1)) / (`PR_natural_r5_mental' - 1) * 100
local PAF_r5_mental = (`r5_mental_natural' - `r5_mental_expected') / `r5_mental_natural' * 100
local PAR_r5_mental = (`r5_mental_natural' - `r5_mental_expected') * 1000
local cases_r5_mental = (`r5_mental_natural' - `r5_mental_expected') * disabled_pop
display "`PR_natural_r5_mental'"
display "`PR_counter_r5_mental'"
display "`decomp_r5_mental'"
display "`PAF_r5_mental'"
display "`PAR_r5_mental'"
display "`cases_r5_mental'"

// Export Results
putexcel set "output-file-15.xlsx", sheet("tableS11and12-1") replace
putexcel A1 = "PR_natural_r5_health"
putexcel A2 = "PR_counter_r5_health"
putexcel A3 = "decomp_r5_health"
putexcel A4 = "PAF_r5_health"
putexcel A5 = "PAR_r5_health"
putexcel A6 = "cases_r5_health"
putexcel A7 = "PR_natural_r5_mental"
putexcel A8 = "PR_counter_r5_mental"
putexcel A9 = "decomp_r5_mental"
putexcel A10 = "PAF_r5_mental"
putexcel A11 = "PAR_r5_mental"
putexcel A12 = "cases_r5_mental"
putexcel B1 = `PR_natural_r5_health'
putexcel B2 = `PR_counter_r5_health'
putexcel B3 = `decomp_r5_health'
putexcel B4 = `PAF_r5_health'
putexcel B5 = `PAR_r5_health'
putexcel B6 = `cases_r5_health'
putexcel B7 = `PR_natural_r5_mental'
putexcel B8 = `PR_counter_r5_mental'
putexcel B9 = `decomp_r5_mental'
putexcel B10 = `PAF_r5_mental'
putexcel B11 = `PAR_r5_mental'
putexcel B12 = `cases_r5_mental'

***********************************************************************************************************************
***********************************************************************************************************************

************************************************
** Step 5: Use Bootstrapping to Estimate CIs **
************************************************

// Load Data
use dataset.dta, clear

// Set Weights (Longitudinal SAQ Weights)
svyset [pweight=LSAQWT], strata(STRA9624) psu(PSU9624) 

// Load Bootstrap
capture program drop paf_bootstrap
program define paf_bootstrap, rclass

*******************************************************
** Step 5a: Form the Natural-Course Pseudo-Population **
*******************************************************

// Estimate Adjusted Prevalence of Mediator in Natural Course
logistic lowqualitycare i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance [pweight = LSAQWT] if subsample_sechealth == 1
predict lowqualitycare_prev if subsample_sechealth == 1, pr

*********************
** Disabled Adults **
*********************

// Simulate Outcome Values for Disabled Adults Using Simulated Mediator Values
/* Perceived Poor/Fair Health */
logistic r5_health i.lowqualitycare##i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance i.office_visits i.er_visits i.hospital i.r1_health i.r1_mental i.high_bp i.heart_disease i.diabetes i.cancer [pweight = LSAQWT] if subsample_sechealth == 1
gen lowqualitycare_orig = lowqualitycare if subsample_sechealth == 1 & disability == 2
local r5_health_sim = 0
local num = 100
forvalues n = 1 / `num' {
	gen lowqualityhealthcare_sim = rbinomial(1, lowqualitycare_prev) if subsample_sechealth == 1 & disability == 2
	replace lowqualitycare = lowqualityhealthcare_sim if subsample_sechealth == 1 & disability == 2
	predict r5_health_sim if subsample_sechealth == 1 & disability == 2, pr
	gen r5_health_sim_weighted = r5_health_sim * LSAQWT if subsample_sechealth == 1 & disability == 2
	sum r5_health_sim_weighted if subsample_sechealth == 1 & disability == 2
	local wsum = r(sum)
	sum LSAQWT if subsample_sechealth == 1 & disability == 2
	local wdenom = r(sum)
	local r5_health_sim = `r5_health_sim' + (`wsum' / `wdenom')
	drop lowqualityhealthcare_sim r5_health_sim r5_health_sim_weighted
}
local r5_health_natural = `r5_health_sim' / `num'
display "`r5_health_natural'"
replace lowqualitycare = lowqualitycare_orig if subsample_sechealth == 1 & disability == 2
drop lowqualitycare_orig
/* Perceived Poor/Fair Mental Health */
logistic r5_mental i.lowqualitycare##i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance i.office_visits i.er_visits i.hospital i.r1_health i.r1_mental i.high_bp i.heart_disease i.diabetes i.cancer [pweight = LSAQWT] if subsample_sechealth == 1
gen lowqualitycare_orig = lowqualitycare if subsample_sechealth == 1 & disability == 2
local r5_mental_sim = 0
local num = 100
forvalues n = 1 / `num' {
	gen lowqualityhealthcare_sim = rbinomial(1, lowqualitycare_prev) if subsample_sechealth == 1 & disability == 2
	replace lowqualitycare = lowqualityhealthcare_sim if subsample_sechealth == 1 & disability == 2
	predict r5_mental_sim if subsample_sechealth == 1 & disability == 2, pr
	gen r5_mental_sim_weighted = r5_mental_sim * LSAQWT if subsample_sechealth == 1 & disability == 2
	sum r5_mental_sim_weighted if subsample_sechealth == 1 & disability == 2
	local wsum = r(sum)
	sum LSAQWT if subsample_sechealth == 1 & disability == 2
	local wdenom = r(sum)
	local r5_mental_sim = `r5_mental_sim' + (`wsum' / `wdenom')
	drop lowqualityhealthcare_sim r5_mental_sim r5_mental_sim_weighted
}
local r5_mental_natural = `r5_mental_sim' / `num'
display "`r5_mental_natural'"
replace lowqualitycare = lowqualitycare_orig if subsample_sechealth == 1 & disability == 2
drop lowqualitycare_orig 

************************
** Nondisabled Adults **
************************

// Simulate Outcome Values for Nondisabled Adults Using Simulated Mediator Values
/* Perceived Poor/Fair Health */
logistic r5_health i.lowqualitycare##i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance i.office_visits i.er_visits i.hospital i.r1_health i.r1_mental i.high_bp i.heart_disease i.diabetes i.cancer [pweight = LSAQWT] if subsample_sechealth == 1
gen lowqualitycare_orig = lowqualitycare if subsample_sechealth == 1 & disability == 0
local r5_health_sim = 0
local num = 100
forvalues n = 1 / `num' {
	gen lowqualityhealthcare_sim = rbinomial(1, lowqualitycare_prev) if subsample_sechealth == 1 & disability == 0
	replace lowqualitycare = lowqualityhealthcare_sim if subsample_sechealth == 1 & disability == 0
	predict r5_health_sim if subsample_sechealth == 1 & disability == 0, pr
	gen r5_health_sim_weighted = r5_health_sim * LSAQWT if subsample_sechealth == 1 & disability == 0
	sum r5_health_sim_weighted if subsample_sechealth == 1 & disability == 0
	local wsum = r(sum)
	sum LSAQWT if subsample_sechealth == 1 & disability == 0
	local wdenom = r(sum)
	local r5_health_sim = `r5_health_sim' + (`wsum' / `wdenom')
	drop lowqualityhealthcare_sim r5_health_sim r5_health_sim_weighted
}
local r5_health_natural_nondis = `r5_health_sim' / `num'
display "`r5_health_natural_nondis'"
replace lowqualitycare = lowqualitycare_orig if subsample_sechealth == 1 & disability == 0
drop lowqualitycare_orig
/* Perceived Poor/Fair Mental Health */
logistic r5_mental i.lowqualitycare##i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance i.office_visits i.er_visits i.hospital i.r1_health i.r1_mental i.high_bp i.heart_disease i.diabetes i.cancer [pweight = LSAQWT] if subsample_sechealth == 1
gen lowqualitycare_orig = lowqualitycare if subsample_sechealth == 1 & disability == 0
local r5_mental_sim = 0
local num = 100
forvalues n = 1 / `num' {
	gen lowqualityhealthcare_sim = rbinomial(1, lowqualitycare_prev) if subsample_sechealth == 1 & disability == 0
	replace lowqualitycare = lowqualityhealthcare_sim if subsample_sechealth == 1 & disability == 0
	predict r5_mental_sim if subsample_sechealth == 1 & disability == 0, pr
	gen r5_mental_sim_weighted = r5_mental_sim * LSAQWT if subsample_sechealth == 1 & disability == 0
	sum r5_mental_sim_weighted if subsample_sechealth == 1 & disability == 0
	local wsum = r(sum)
	sum LSAQWT if subsample_sechealth == 1 & disability == 0
	local wdenom = r(sum)
	local r5_mental_sim = `r5_mental_sim' + (`wsum' / `wdenom')
	drop lowqualityhealthcare_sim r5_mental_sim r5_mental_sim_weighted
}
local r5_mental_natural_nondis = `r5_mental_sim' / `num'
display "`r5_mental_natural_nondis'"
replace lowqualitycare = lowqualitycare_orig if subsample_sechealth == 1 & disability == 0
drop lowqualitycare_orig lowqualitycare_prev

*******************************************************
** Step 5b: Form the Counterfactual Pseudo-Population **
*******************************************************

// Estimate Adjusted Prevalence of Mediator if Disabled Adults Were Nondisabled
logistic lowqualitycare i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance [pweight = LSAQWT] if subsample_sechealth == 1
gen disability_orig = disability
replace disability = 0 if subsample_sechealth == 1 & disability_orig == 2
predict lowqualitycare_prev if subsample_sechealth == 1, pr
replace disability = disability_orig
drop disability_orig

*********************
** Disabled Adults **
*********************

// Simulate Outcome Values Using Simulated Mediator Values
/* Poor/Fair Health */
logistic r5_health i.lowqualitycare##i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance i.office_visits i.er_visits i.hospital i.r1_health i.r1_mental i.high_bp i.heart_disease i.diabetes i.cancer [pweight = LSAQWT] if subsample_sechealth == 1
gen lowqualitycare_orig = lowqualitycare if subsample_sechealth == 1 & disability == 2
local r5_health_sim = 0
local num = 100
forvalues n = 1 / `num' {
	gen lowqualityhealthcare_sim = rbinomial(1, lowqualitycare_prev) if subsample_sechealth == 1 & disability == 2
	replace lowqualitycare = lowqualityhealthcare_sim if subsample_sechealth == 1 & disability == 2
	predict r5_health_sim if subsample_sechealth == 1 & disability == 2, pr
	gen r5_health_sim_weighted = r5_health_sim * LSAQWT if subsample_sechealth == 1 & disability == 2
	sum r5_health_sim_weighted if subsample_sechealth == 1 & disability == 2
	local wsum = r(sum)
	sum LSAQWT if subsample_sechealth == 1 & disability == 2
	local wdenom = r(sum)
	local r5_health_sim = `r5_health_sim' + (`wsum' / `wdenom')
	drop lowqualityhealthcare_sim r5_health_sim r5_health_sim_weighted
}
local r5_health_expected = `r5_health_sim' / `num'
display "`r5_health_expected'"
replace lowqualitycare = lowqualitycare_orig if subsample_sechealth == 1 & disability == 2
drop lowqualitycare_orig
/* Perceived Poor/Fair Mental Health */
logistic r5_mental i.lowqualitycare##i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance i.office_visits i.er_visits i.hospital i.r1_health i.r1_mental i.high_bp i.heart_disease i.diabetes i.cancer [pweight = LSAQWT] if subsample_sechealth == 1
gen lowqualitycare_orig = lowqualitycare if subsample_sechealth == 1 & disability == 2
local r5_mental_sim = 0
local num = 100
forvalues n = 1 / `num' {
	gen lowqualityhealthcare_sim = rbinomial(1, lowqualitycare_prev) if subsample_sechealth == 1 & disability == 2
	replace lowqualitycare = lowqualityhealthcare_sim if subsample_sechealth == 1 & disability == 2
	predict r5_mental_sim if subsample_sechealth == 1 & disability == 2, pr
	gen r5_mental_sim_weighted = r5_mental_sim * LSAQWT if subsample_sechealth == 1 & disability == 2
	sum r5_mental_sim_weighted if subsample_sechealth == 1 & disability == 2
	local wsum = r(sum)
	sum LSAQWT if subsample_sechealth == 1 & disability == 2
	local wdenom = r(sum)
	local r5_mental_sim = `r5_mental_sim' + (`wsum' / `wdenom')
	drop lowqualityhealthcare_sim r5_mental_sim r5_mental_sim_weighted
}
local r5_mental_expected = `r5_mental_sim' / `num'
display "`r5_mental_expected'"
replace lowqualitycare = lowqualitycare_orig if subsample_sechealth == 1 & disability == 2
drop lowqualitycare_orig lowqualitycare_prev

************************
** Nondisabled Adults **
************************

// Simulate Outcome Values for Nondisabled Adults Using Simulated Mediator Values
/* Perceived Poor/Fair Health */
local r5_health_expected_nondis = `r5_health_natural_nondis'
/* Perceived Poor/Fair Mental Health */
local r5_mental_expected_nondis = `r5_mental_natural_nondis'

********************************************
** Step 5c: Compare Contrasts of Interest  **
********************************************

*********************************************************
** Prevalence Ratios, PAF, PAR, and Attributable Cases **
*********************************************************

// Estimate US Disabled Population
total i.disability [pweight=LSAQWT] if any_visits==1
matrix M = r(table)
scalar disabled_pop = M[1,3]

// Estimate Prevalence Ratios, PAF, PAR, and Attributable Cases
/* Perceived Poor/Fair Health */
scalar PR_natural_r5_health = `r5_health_natural' / `r5_health_natural_nondis'
scalar PR_counter_r5_health = `r5_health_expected' / `r5_health_expected_nondis'
scalar decomp_r5_health = ((PR_natural_r5_health - 1) - (PR_counter_r5_health - 1)) / (PR_natural_r5_health - 1) * 100
scalar PAF_r5_health = (`r5_health_natural' - `r5_health_expected') / `r5_health_natural' * 100
scalar PAR_r5_health = (`r5_health_natural' - `r5_health_expected') * 1000
scalar cases_r5_health = (`r5_health_natural' - `r5_health_expected') * disabled_pop
/* Perceived Poor/Fair Mental Health */
scalar PR_natural_r5_mental = `r5_mental_natural' / `r5_mental_natural_nondis'
scalar PR_counter_r5_mental = `r5_mental_expected' / `r5_mental_expected_nondis'
scalar decomp_r5_mental = ((PR_natural_r5_mental - 1) - (PR_counter_r5_mental - 1)) / (PR_natural_r5_mental - 1) * 100
scalar PAF_r5_mental = (`r5_mental_natural' - `r5_mental_expected') / `r5_mental_natural' * 100
scalar PAR_r5_mental = (`r5_mental_natural' - `r5_mental_expected') * 1000
scalar cases_r5_mental = (`r5_mental_natural' - `r5_mental_expected') * disabled_pop

// Return Values
return scalar PR_natural_r5_health = PR_natural_r5_health
return scalar PR_counter_r5_health = PR_counter_r5_health
return scalar decomp_r5_health = decomp_r5_health
return scalar PAF_r5_health = PAF_r5_health
return scalar PAR_r5_health = PAR_r5_health
return scalar cases_r5_health = cases_r5_health
return scalar PR_natural_r5_mental = PR_natural_r5_mental
return scalar PR_counter_r5_mental = PR_counter_r5_mental
return scalar decomp_r5_mental = decomp_r5_mental
return scalar PAF_r5_mental = PAF_r5_mental
return scalar PAR_r5_mental = PAR_r5_mental
return scalar cases_r5_mental = cases_r5_mental
end

// Run Bootstrap (500 Iterations)
bootstrap ///
PR_natural_r5_health = r(PR_natural_r5_health) PR_counter_r5_health = r(PR_counter_r5_health) decomp_r5_health = r(decomp_r5_health) ///
PAF_r5_health = r(PAF_r5_health) PAR_r5_health = r(PAR_r5_health) cases_r5_health = r(cases_r5_health) ///
PR_natural_r5_mental = r(PR_natural_r5_mental) PR_counter_r5_mental = r(PR_counter_r5_mental) decomp_r5_mental = r(decomp_r5_mental) ///
PAF_r5_mental = r(PAF_r5_mental) PAR_r5_mental = r(PAR_r5_mental) cases_r5_mental = r(cases_r5_mental), ///
reps(500) seed(12345) strata(STRA9624) cluster(PSU9624): paf_bootstrap

// Export Results
estat bootstrap, all
putexcel set "output-file-15.xlsx", sheet("tableS11and12-2") modify
matrix results = e(b)'
putexcel A1 = matrix(results)
putexcel set "output-file-15.xlsx", sheet("tableS11and12-2") modify
matrix results = e(ci_bc)'
putexcel B1 = matrix(results)

***********************************************************************************************************************
***********************************************************************************************************************

****************
** End of File *
****************
