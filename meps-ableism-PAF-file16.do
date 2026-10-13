************************************************************************************************************
** Ableism, low-quality health care, and health inequities for disabled US adults: a decomposition analysis
** Code by Dielle J. Lundberg
** Last Updated: September 28, 2026
** Code File 16 of 18: Table S9 and S10 (PR/PAF, Primary Model, Marginal Standardization Approach) (create output-file-14.xlsx)
************************************************************************************************************

******************************************************
** PRIMARY MODEL, MARGINAL STANDARDIZATION APPRAOCH **
******************************************************

// Set Working Directory
cd "/Users/djlworkdesktop/Library/Mobile Documents/com~apple~CloudDocs/Independent Research/MEPS-Ableism-PAF-Project/Analysis V3"

****************************************
** Step 0: Specify Starting Decisions **
****************************************

// Estimand: cases of poor/fair health, distress, depression, and pain among disabled adults that would be averted if disabled adults' levels of low-quality health care were equalized to nondisabled adults
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
svy, subpop(if mainsample == 1): logistic lowqualitycare i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance

// Model Health (Outcome) as a Function of Low-Quality Health Care (Mediator) and Confounders of Mediator-Outcome Relationship
/* Poor/Fair Health */
svy, subpop(if mainsample == 1): logistic gen_health i.lowqualitycare##i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance i.office_visits i.er_visits i.hospital i.r1_health i.r1_mental i.high_bp i.heart_disease i.diabetes i.cancer
/* Distress */
svy, subpop(if mainsample == 1): logistic distress i.lowqualitycare##i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance i.office_visits i.er_visits i.hospital i.r1_health i.r1_mental i.high_bp i.heart_disease i.diabetes i.cancer
/* Depression */
svy, subpop(if mainsample == 1): logistic depressed i.lowqualitycare##i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance i.office_visits i.er_visits i.hospital i.r1_health i.r1_mental i.high_bp i.heart_disease i.diabetes i.cancer
/* Pain */
svy, subpop(if mainsample == 1): logistic pain i.lowqualitycare##i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance i.office_visits i.er_visits i.hospital i.r1_health i.r1_mental i.high_bp i.heart_disease i.diabetes i.cancer

***********************************************************************************************************************
***********************************************************************************************************************

*******************************************************
** Step 2: Form the Natural-Course Pseudo-Population **
*******************************************************

// Estimate Levels of Low-Quality Health Care for Disabled and Nondisabled Adults
svy, subpop(if mainsample == 1): logistic lowqualitycare i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance
margins, subpop(if mainsample == 1) over(disability)
local hypothetical1 = r(table)[1,1]
local hypothetical2 = r(table)[1,3]

// Natural Course Prevalence for Poor/Fair Health for Nondisabled and Disabled Adults
svy, subpop(if mainsample == 1): logistic gen_health c.lowqualitycare##i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance i.office_visits i.er_visits i.hospital i.r1_health i.r1_mental i.high_bp i.heart_disease i.diabetes i.cancer
margins, subpop(if mainsample == 1) over(disability) at(lowqualitycare = `hypothetical1')
local gen_health_natural_nondis = r(table)[1,1]
margins, subpop(if mainsample == 1) over(disability) at(lowqualitycare = `hypothetical2')
local gen_health_natural = r(table)[1,3]

// Natural Course Prevalence for Distress for Nondisabled and Disabled Adults
svy, subpop(if mainsample == 1): logistic distress c.lowqualitycare##i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance i.office_visits i.er_visits i.hospital i.r1_health i.r1_mental i.high_bp i.heart_disease i.diabetes i.cancer
margins, subpop(if mainsample == 1) over(disability) at(lowqualitycare = `hypothetical1')
local distress_natural_nondis = r(table)[1,1]
margins, subpop(if mainsample == 1) over(disability) at(lowqualitycare = `hypothetical2')
local distress_natural = r(table)[1,3]

// Natural Course Prevalence for Depression for Nondisabled and Disabled Adults
svy, subpop(if mainsample == 1): logistic depressed c.lowqualitycare##i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance i.office_visits i.er_visits i.hospital i.r1_health i.r1_mental i.high_bp i.heart_disease i.diabetes i.cancer
margins, subpop(if mainsample == 1) over(disability) at(lowqualitycare = `hypothetical1')
local depressed_natural_nondis = r(table)[1,1]
margins, subpop(if mainsample == 1) over(disability) at(lowqualitycare = `hypothetical2')
local depressed_natural = r(table)[1,3]

// Natural Course Prevalence for Pain for Nondisabled and Disabled Adults
svy, subpop(if mainsample == 1): logistic pain c.lowqualitycare##i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance i.office_visits i.er_visits i.hospital i.r1_health i.r1_mental i.high_bp i.heart_disease i.diabetes i.cancer
margins, subpop(if mainsample == 1) over(disability) at(lowqualitycare = `hypothetical1')
local pain_natural_nondis = r(table)[1,1]
margins, subpop(if mainsample == 1) over(disability) at(lowqualitycare = `hypothetical2')
local pain_natural = r(table)[1,3]

***********************************************************************************************************************
***********************************************************************************************************************

*******************************************************
** Step 3: Form the Counterfactual Pseudo-Population **
*******************************************************

// Estimate Levels of Low-Quality Health Care for Disabled Adults If They Were Nondisabled
svy, subpop(if mainsample == 1): logistic lowqualitycare i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance
margins i.disability, subpop(if mainsample == 1 & disability == 2)
local hypothetical3 = r(table)[1,1]

// Counterfactual Prevalence for Poor/Fair Health for Disabled Adults
svy, subpop(if mainsample == 1): logistic gen_health c.lowqualitycare##i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance i.office_visits i.er_visits i.hospital i.r1_health i.r1_mental i.high_bp i.heart_disease i.diabetes i.cancer
margins, subpop(if mainsample == 1) over(disability) at(lowqualitycare = `hypothetical3')
local gen_health_expected = r(table)[1,3]

// Counterfactual Prevalence for Distress for Disabled Adults
svy, subpop(if mainsample == 1): logistic distress c.lowqualitycare##i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance i.office_visits i.er_visits i.hospital i.r1_health i.r1_mental i.high_bp i.heart_disease i.diabetes i.cancer
margins, subpop(if mainsample == 1) over(disability) at(lowqualitycare = `hypothetical3')
local distress_expected = r(table)[1,3]

// Counterfactual Prevalence for Depression for Disabled Adults
svy, subpop(if mainsample == 1): logistic depressed c.lowqualitycare##i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance i.office_visits i.er_visits i.hospital i.r1_health i.r1_mental i.high_bp i.heart_disease i.diabetes i.cancer
margins, subpop(if mainsample == 1) over(disability) at(lowqualitycare = `hypothetical3')
local depressed_expected = r(table)[1,3]

// Counterfactual Prevalence for Pain for Disabled Adults
svy, subpop(if mainsample == 1): logistic pain c.lowqualitycare##i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance i.office_visits i.er_visits i.hospital i.r1_health i.r1_mental i.high_bp i.heart_disease i.diabetes i.cancer
margins, subpop(if mainsample == 1) over(disability) at(lowqualitycare = `hypothetical3')
local pain_expected = r(table)[1,3]

// Counterfactual Prevalence for Nondisabled Adults
/* Poor/Fair Health */
local gen_health_expected_nondis = `gen_health_natural_nondis'
/* Distress */
local distress_expected_nondis = `distress_natural_nondis'
/* Depression */
local depressed_expected_nondis = `depressed_natural_nondis'
/* Pain */
local pain_expected_nondis = `pain_natural_nondis'

***********************************************************************************************************************
***********************************************************************************************************************

********************************************
** Step 4: Compare Contrasts of Interest  **
********************************************

*******************************************************
** Confirm Natural Course Equals Observed Prevalence **
*******************************************************

// Confirm Natural Course Prevalence Equals Observed Prevalence for Disabled Adults 
/* Poor/Fair Health */
display "`gen_health_natural'"
svy, subpop(if mainsample == 1 & disability == 2): mean gen_health
/* Distress */
display "`distress_natural'"
svy, subpop(if mainsample == 1 & disability == 2): mean distress
/* Depression */
display "`depressed_natural'"
svy, subpop(if mainsample == 1 & disability == 2): mean depressed
/* Pain */
display "`pain_natural'"
svy, subpop(if mainsample == 1 & disability == 2): mean pain

// Confirm Natural Course Prevalence Equals Observed Prevalence for Nondisabled Adults 
/* Poor/Fair Health */
display "`gen_health_natural_nondis'"
svy, subpop(if mainsample == 1 & disability == 0): mean gen_health
/* Distress */
display "`distress_natural_nondis'"
svy, subpop(if mainsample == 1 & disability == 0): mean distress
/* Depression */
display "`depressed_natural_nondis'"
svy, subpop(if mainsample == 1 & disability == 0): mean depressed
/* Pain */
display "`pain_natural_nondis'"
svy, subpop(if mainsample == 1 & disability == 0): mean pain

*********************************************************
** Prevalence Ratios, PAF, PAR, and Attributable Cases **
*********************************************************

// Estimate US Disabled Population Using Health Care
svy, subpop(if any_visits == 1): total i.disability
matrix M = r(table)
scalar disabled_pop = M[1,3]

// Estimate Prevalence Ratios, PAF, PAR, and Attributable Cases
/* Poor/Fair Health */
local PR_natural_gen_health = `gen_health_natural' / `gen_health_natural_nondis'
local PR_counter_gen_health = `gen_health_expected' / `gen_health_expected_nondis'
local decomp_gen_health = ((`PR_natural_gen_health' - 1) - (`PR_counter_gen_health' - 1)) / (`PR_natural_gen_health' - 1) * 100
local PAF_gen_health = (`gen_health_natural' - `gen_health_expected') / `gen_health_natural' * 100
local PAR_gen_health = (`gen_health_natural' - `gen_health_expected') * 1000
local cases_gen_health = (`gen_health_natural' - `gen_health_expected') * disabled_pop
display "`PR_natural_gen_health'"
display "`PR_counter_gen_health'"
display "`decomp_gen_health'"
display "`PAF_gen_health'"
display "`PAR_gen_health'"
display "`cases_gen_health'"
/* Distress */
local PR_natural_distress = `distress_natural' / `distress_natural_nondis'
local PR_counter_distress = `distress_expected' / `distress_expected_nondis'
local decomp_distress = ((`PR_natural_distress' - 1) - (`PR_counter_distress' - 1)) / (`PR_natural_distress' - 1) * 100
local PAF_distress = (`distress_natural' - `distress_expected') / `distress_natural' * 100
local PAR_distress = (`distress_natural' - `distress_expected') * 1000
local cases_distress = (`distress_natural' - `distress_expected') * disabled_pop
display "`PR_natural_distress'"
display "`PR_counter_distress'"
display "`decomp_distress'"
display "`PAF_distress'"
display "`PAR_distress'"
display "`cases_distress'"
/* Depression */
local PR_natural_depressed = `depressed_natural' / `depressed_natural_nondis'
local PR_counter_depressed = `depressed_expected' / `depressed_expected_nondis'
local decomp_depressed = ((`PR_natural_depressed' - 1) - (`PR_counter_depressed' - 1)) / (`PR_natural_depressed' - 1) * 100
local PAF_depressed = (`depressed_natural' - `depressed_expected') / `depressed_natural' * 100
local PAR_depressed = (`depressed_natural' - `depressed_expected') * 1000
local cases_depressed = (`depressed_natural' - `depressed_expected') * disabled_pop
display "`PAF_depressed'"
display "`PAR_depressed'" 
display "`cases_depressed'"
/* Pain */
local PR_natural_pain = `pain_natural' / `pain_natural_nondis'
local PR_counter_pain = `pain_expected' / `pain_expected_nondis'
local decomp_pain = ((`PR_natural_pain' - 1) - (`PR_counter_pain' - 1)) / (`PR_natural_pain' - 1) * 100
local PAF_pain = (`pain_natural' - `pain_expected') / `pain_natural' * 100
local PAR_pain = (`pain_natural' - `pain_expected') * 1000 
local cases_pain = (`pain_natural' - `pain_expected') * disabled_pop
display "`PAF_pain'"
display "`PAR_pain'"
display "`cases_pain'"

// Export Results
putexcel set "output-file-14.xlsx", sheet("tablesS9and10j-1") replace
putexcel A1 = "PR_natural_gen_health"
putexcel A2 = "PR_counter_gen_health"
putexcel A3 = "decomp_gen_health"
putexcel A4 = "PAF_gen_health"
putexcel A5 = "PAR_gen_health"
putexcel A6 = "cases_gen_health"
putexcel A7 = "PR_natural_distress"
putexcel A8 = "PR_counter_distress"
putexcel A9 = "decomp_distress"
putexcel A10 = "PAF_distress"
putexcel A11 = "PAR_distress"
putexcel A12 = "cases_distress"
putexcel A13 = "PR_natural_depressed"
putexcel A14 = "PR_counter_depressed"
putexcel A15 = "decomp_depressed"
putexcel A16 = "PAF_depressed"
putexcel A17 = "PAR_depressed"
putexcel A18 = "cases_depressed"
putexcel A19 = "PR_natural_pain"
putexcel A20 = "PR_counter_pain"
putexcel A21 = "decomp_pain"
putexcel A22 = "PAF_pain"
putexcel A23 = "PAR_pain"
putexcel A24 = "cases_pain"
putexcel B1 = `PR_natural_gen_health'
putexcel B2 = `PR_counter_gen_health'
putexcel B3 = `decomp_gen_health'
putexcel B4 = `PAF_gen_health'
putexcel B5 = `PAR_gen_health'
putexcel B6 = `cases_gen_health'
putexcel B7 = `PR_natural_distress'
putexcel B8 = `PR_counter_distress'
putexcel B9 = `decomp_distress'
putexcel B10 = `PAF_distress'
putexcel B11 = `PAR_distress'
putexcel B12 = `cases_distress'
putexcel B13 = `PR_natural_depressed'
putexcel B14 = `PR_counter_depressed'
putexcel B15 = `decomp_depressed'
putexcel B16 = `PAF_depressed'
putexcel B17 = `PAR_depressed'
putexcel B18 = `cases_depressed'
putexcel B19 = `PR_natural_pain'
putexcel B20 = `PR_counter_pain'
putexcel B21 = `decomp_pain'
putexcel B22 = `PAF_pain'
putexcel B23 = `PAR_pain'
putexcel B24 = `cases_pain'

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

********************************************************
** Step 5a: Form the Natural-Course Pseudo-Population **
********************************************************

// Estimate Levels of Low-Quality Health Care for Disabled and Nondisabled Adults
svy, subpop(if mainsample == 1): logistic lowqualitycare i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance
margins, subpop(if mainsample == 1) over(disability)
local hypothetical1 = r(table)[1,1]
local hypothetical2 = r(table)[1,3]

// Natural Course Prevalence for Poor/Fair Health for Nondisabled and Disabled Adults
svy, subpop(if mainsample == 1): logistic gen_health c.lowqualitycare##i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance i.office_visits i.er_visits i.hospital i.r1_health i.r1_mental i.high_bp i.heart_disease i.diabetes i.cancer
margins, subpop(if mainsample == 1) over(disability) at(lowqualitycare = `hypothetical1')
local gen_health_natural_nondis = r(table)[1,1]
margins, subpop(if mainsample == 1) over(disability) at(lowqualitycare = `hypothetical2')
local gen_health_natural = r(table)[1,3]

// Natural Course Prevalence for Distress for Nondisabled and Disabled Adults
svy, subpop(if mainsample == 1): logistic distress c.lowqualitycare##i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance i.office_visits i.er_visits i.hospital i.r1_health i.r1_mental i.high_bp i.heart_disease i.diabetes i.cancer
margins, subpop(if mainsample == 1) over(disability) at(lowqualitycare = `hypothetical1')
local distress_natural_nondis = r(table)[1,1]
margins, subpop(if mainsample == 1) over(disability) at(lowqualitycare = `hypothetical2')
local distress_natural = r(table)[1,3]

// Natural Course Prevalence for Depression for Nondisabled and Disabled Adults
svy, subpop(if mainsample == 1): logistic depressed c.lowqualitycare##i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance i.office_visits i.er_visits i.hospital i.r1_health i.r1_mental i.high_bp i.heart_disease i.diabetes i.cancer
margins, subpop(if mainsample == 1) over(disability) at(lowqualitycare = `hypothetical1')
local depressed_natural_nondis = r(table)[1,1]
margins, subpop(if mainsample == 1) over(disability) at(lowqualitycare = `hypothetical2')
local depressed_natural = r(table)[1,3]

// Natural Course Prevalence for Pain for Nondisabled and Disabled Adults
svy, subpop(if mainsample == 1): logistic pain c.lowqualitycare##i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance i.office_visits i.er_visits i.hospital i.r1_health i.r1_mental i.high_bp i.heart_disease i.diabetes i.cancer
margins, subpop(if mainsample == 1) over(disability) at(lowqualitycare = `hypothetical1')
local pain_natural_nondis = r(table)[1,1]
margins, subpop(if mainsample == 1) over(disability) at(lowqualitycare = `hypothetical2')
local pain_natural = r(table)[1,3]

********************************************************
** Step 5b: Form the Counterfactual Pseudo-Population **
********************************************************

// Estimate Levels of Low-Quality Health Care for Disabled Adults If They Were Nondisabled
svy, subpop(if mainsample == 1): logistic lowqualitycare i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance
margins i.disability, subpop(if mainsample == 1 & disability == 2)
local hypothetical3 = r(table)[1,1]

// Counterfactual Prevalence for Poor/Fair Health for Disabled Adults
svy, subpop(if mainsample == 1): logistic gen_health c.lowqualitycare##i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance i.office_visits i.er_visits i.hospital i.r1_health i.r1_mental i.high_bp i.heart_disease i.diabetes i.cancer
margins, subpop(if mainsample == 1) over(disability) at(lowqualitycare = `hypothetical3')
local gen_health_expected = r(table)[1,3]

// Counterfactual Prevalence for Distress for Disabled Adults
svy, subpop(if mainsample == 1): logistic distress c.lowqualitycare##i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance i.office_visits i.er_visits i.hospital i.r1_health i.r1_mental i.high_bp i.heart_disease i.diabetes i.cancer
margins, subpop(if mainsample == 1) over(disability) at(lowqualitycare = `hypothetical3')
local distress_expected = r(table)[1,3]

// Counterfactual Prevalence for Depression for Disabled Adults
svy, subpop(if mainsample == 1): logistic depressed c.lowqualitycare##i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance i.office_visits i.er_visits i.hospital i.r1_health i.r1_mental i.high_bp i.heart_disease i.diabetes i.cancer
margins, subpop(if mainsample == 1) over(disability) at(lowqualitycare = `hypothetical3')
local depressed_expected = r(table)[1,3]

// Counterfactual Prevalence for Depression for Disabled Adults
svy, subpop(if mainsample == 1): logistic pain c.lowqualitycare##i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance i.office_visits i.er_visits i.hospital i.r1_health i.r1_mental i.high_bp i.heart_disease i.diabetes i.cancer
margins, subpop(if mainsample == 1) over(disability) at(lowqualitycare = `hypothetical3')
local pain_expected = r(table)[1,3]

// Counterfactual Prevalence for Nondisabled Adults
/* Poor/Fair Health */
local gen_health_expected_nondis = `gen_health_natural_nondis'
/* Distress */
local distress_expected_nondis = `distress_natural_nondis'
/* Depression */
local depressed_expected_nondis = `depressed_natural_nondis'
/* Pain */
local pain_expected_nondis = `pain_natural_nondis'

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
/* Poor/Fair Health */
scalar PR_natural_gen_health = `gen_health_natural' / `gen_health_natural_nondis'
scalar PR_counter_gen_health = `gen_health_expected' / `gen_health_expected_nondis'
scalar decomp_gen_health = ((PR_natural_gen_health - 1) - (PR_counter_gen_health - 1)) / (PR_natural_gen_health - 1) * 100
scalar PAF_gen_health = (`gen_health_natural' - `gen_health_expected') / `gen_health_natural' * 100
scalar PAR_gen_health = (`gen_health_natural' - `gen_health_expected') * 1000
scalar cases_gen_health = (`gen_health_natural' - `gen_health_expected') * disabled_pop
/* Distress */
scalar PR_natural_distress = `distress_natural' / `distress_natural_nondis'
scalar PR_counter_distress = `distress_expected' / `distress_expected_nondis'
scalar decomp_distress = ((PR_natural_distress - 1) - (PR_counter_distress - 1)) / (PR_natural_distress - 1) * 100
scalar PAF_distress = (`distress_natural' - `distress_expected') / `distress_natural' * 100
scalar PAR_distress = (`distress_natural' - `distress_expected') * 1000
scalar cases_distress = (`distress_natural' - `distress_expected') * disabled_pop
/* Depression */
scalar PR_natural_depressed = `depressed_natural' / `depressed_natural_nondis'
scalar PR_counter_depressed = `depressed_expected' / `depressed_expected_nondis'
scalar decomp_depressed = ((PR_natural_depressed - 1) - (PR_counter_depressed - 1)) / (PR_natural_depressed - 1) * 100
scalar PAF_depressed = (`depressed_natural' - `depressed_expected') / `depressed_natural' * 100
scalar PAR_depressed = (`depressed_natural' - `depressed_expected') * 1000
scalar cases_depressed = (`depressed_natural' - `depressed_expected') * disabled_pop
/* Pain */
scalar PR_natural_pain = `pain_natural' / `pain_natural_nondis'
scalar PR_counter_pain = `pain_expected' / `pain_expected_nondis'
scalar decomp_pain = ((PR_natural_pain - 1) - (PR_counter_pain - 1)) / (PR_natural_pain - 1) * 100
scalar PAF_pain = (`pain_natural' - `pain_expected') / `pain_natural' * 100
scalar PAR_pain = (`pain_natural' - `pain_expected') * 1000 
scalar cases_pain = (`pain_natural' - `pain_expected') * disabled_pop

// Return Values
return scalar PR_natural_gen_health = PR_natural_gen_health
return scalar PR_counter_gen_health = PR_counter_gen_health
return scalar decomp_gen_health = decomp_gen_health
return scalar PAF_gen_health = PAF_gen_health
return scalar PAR_gen_health = PAR_gen_health
return scalar cases_gen_health = cases_gen_health
return scalar PR_natural_distress = PR_natural_distress
return scalar PR_counter_distress = PR_counter_distress
return scalar decomp_distress = decomp_distress
return scalar PAF_distress = PAF_distress
return scalar PAR_distress = PAR_distress
return scalar cases_distress = cases_distress
return scalar PR_natural_depressed = PR_natural_depressed
return scalar PR_counter_depressed = PR_counter_depressed
return scalar decomp_depressed = decomp_depressed
return scalar PAF_depressed = PAF_depressed
return scalar PAR_depressed = PAR_depressed
return scalar cases_depressed = cases_depressed
return scalar PR_natural_pain = PR_natural_pain
return scalar PR_counter_pain = PR_counter_pain
return scalar decomp_pain = decomp_pain
return scalar PAF_pain = PAF_pain
return scalar PAR_pain = PAR_pain
return scalar cases_pain = cases_pain
end

// Run Bootstrap (500 Iterations)
bootstrap ///
PR_natural_gen_health = r(PR_natural_gen_health) PR_counter_gen_health = r(PR_counter_gen_health) decomp_gen_health = r(decomp_gen_health) ///
PAF_gen_health = r(PAF_gen_health) PAR_gen_health = r(PAR_gen_health) cases_gen_health = r(cases_gen_health) ///
PR_natural_distress = r(PR_natural_distress) PR_counter_distress = r(PR_counter_distress) decomp_distress = r(decomp_distress) ///
PAF_distress = r(PAF_distress) PAR_distress = r(PAR_distress) cases_distress = r(cases_distress) ///
PR_natural_depressed = r(PR_natural_depressed) PR_counter_depressed = r(PR_counter_depressed) decomp_depressed = r(decomp_depressed) ///
PAF_depressed = r(PAF_depressed) PAR_depressed = r(PAR_depressed) cases_depressed = r(cases_depressed) ///
PR_natural_pain = r(PR_natural_pain) PR_counter_pain = r(PR_counter_pain) decomp_pain = r(decomp_pain) ///
PAF_pain = r(PAF_pain) PAR_pain = r(PAR_pain) cases_pain = r(cases_pain), ///
reps(500) seed(12345) strata(STRA9624) cluster(PSU9624): paf_bootstrap

// Export Results
estat bootstrap, all
putexcel set "output-file-14.xlsx", sheet("tablesS9and10j-2") modify
matrix results = e(b)'
putexcel A1 = matrix(results)
putexcel set "output-file-14.xlsx", sheet("tablesS9and10j-2") modify
matrix results = e(ci_bc)'
putexcel B1 = matrix(results)

****************
** End of File *
****************
