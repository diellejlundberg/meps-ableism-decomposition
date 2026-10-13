************************************************************************************************************
** Disability, ableism in health care settings, and health disparities among US adults: a cross-sectional decomposition analysis
** Code by Dielle J. Lundberg
** Last Updated: October 3, 2026
** Code File 3 of 18: Figure 2, Tables 1-2, and Table S1 (Main Tables and Figures) (create output-file-1.xlsx)
************************************************************************************************************

// Set Directory to Folder Where Data (and Other Do Files) Are Saved
cd "/Users/djlworkdesktop/Library/Mobile Documents/com~apple~CloudDocs/Independent Research/MEPS-Ableism-PAF-Project/Analysis V3"

***************
** Figure 2. **
***************

// Load Data and Set Output
use dataset.dta, clear
putexcel set "output-file-1.xlsx", sheet("figure2") replace

// Set Weights (SAQ Survey)
svyset [pweight=LSAQWT], strata(STRA9624) psu(PSU9624) 

// Association of Disability with Low-Quality Health Care
svy, subpop(if mainsample == 1): logistic lowqualitycare i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance
margins i.disability, post subpop(if mainsample == 1)
putexcel A1 = "Low-Quality Health Care"
lincom _b[0.disability] * 1000
putexcel B1 = `r(estimate)'
putexcel C1 = `r(lb)'
putexcel D1 = `r(ub)'
lincom _b[1.disability] * 1000
putexcel E1 = `r(estimate)'
putexcel F1 = `r(lb)'
putexcel G1 = `r(ub)'
lincom _b[2.disability] * 1000
putexcel H1 = `r(estimate)'
putexcel I1 = `r(lb)'
putexcel J1 = `r(ub)'

// Association of Disability and Low-Quality Care with Poor/Fair Health
svy, subpop(if mainsample == 1): logistic gen_health i.lowqualitycare##i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance i.office_visits i.er_visits i.hospital i.r1_health i.r1_mental i.high_bp i.heart_disease i.diabetes 
margins i.disability#i.lowqualitycare, post subpop(if mainsample == 1)
putexcel A2 = "Poor/Fair Health"
lincom _b[0.disability#0.lowqualitycare] * 1000
putexcel B2 = `r(estimate)'
putexcel C2 = `r(lb)'
putexcel D2 = `r(ub)'
lincom _b[0.disability#1.lowqualitycare] * 1000
putexcel E2 = `r(estimate)'
putexcel F2 = `r(lb)'
putexcel G2 = `r(ub)'
lincom _b[1.disability#0.lowqualitycare] * 1000
putexcel H2 = `r(estimate)'
putexcel I2 = `r(lb)'
putexcel J2 = `r(ub)'
lincom _b[1.disability#1.lowqualitycare] * 1000
putexcel K2 = `r(estimate)'
putexcel L2 = `r(lb)'
putexcel M2 = `r(ub)'
lincom _b[2.disability#0.lowqualitycare] * 1000
putexcel N2 = `r(estimate)'
putexcel O2 = `r(lb)'
putexcel P2 = `r(ub)'
lincom _b[2.disability#1.lowqualitycare] * 1000
putexcel Q2 = `r(estimate)'
putexcel R2 = `r(lb)'
putexcel S2 = `r(ub)'

// Association of Disability and Low-Quality Care with Distress
svy, subpop(if mainsample == 1): logistic distress i.lowqualitycare##i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance i.office_visits i.er_visits i.hospital i.r1_health i.r1_mental i.high_bp i.heart_disease i.diabetes 
margins i.disability#i.lowqualitycare, post subpop(if mainsample == 1)
putexcel A3 = "Distress"
lincom _b[0.disability#0.lowqualitycare] * 1000
putexcel B3 = `r(estimate)'
putexcel C3 = `r(lb)'
putexcel D3 = `r(ub)'
lincom _b[0.disability#1.lowqualitycare] * 1000
putexcel E3 = `r(estimate)'
putexcel F3 = `r(lb)'
putexcel G3 = `r(ub)'
lincom _b[1.disability#0.lowqualitycare] * 1000
putexcel H3 = `r(estimate)'
putexcel I3 = `r(lb)'
putexcel J3 = `r(ub)'
lincom _b[1.disability#1.lowqualitycare] * 1000
putexcel K3 = `r(estimate)'
putexcel L3 = `r(lb)'
putexcel M3 = `r(ub)'
lincom _b[2.disability#0.lowqualitycare] * 1000
putexcel N3 = `r(estimate)'
putexcel O3 = `r(lb)'
putexcel P3 = `r(ub)'
lincom _b[2.disability#1.lowqualitycare] * 1000
putexcel Q3 = `r(estimate)'
putexcel R3 = `r(lb)'
putexcel S3 = `r(ub)'

// Association of Disability and Low-Quality with Depression
svy, subpop(if mainsample == 1): logistic depressed i.lowqualitycare##i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance i.office_visits i.er_visits i.hospital i.r1_health i.r1_mental i.high_bp i.heart_disease i.diabetes 
margins i.disability#i.lowqualitycare, post subpop(if mainsample == 1)
putexcel A4 = "Depression"
lincom _b[0.disability#0.lowqualitycare] * 1000
putexcel B4 = `r(estimate)'
putexcel C4 = `r(lb)'
putexcel D4 = `r(ub)'
lincom _b[0.disability#1.lowqualitycare] * 1000
putexcel E4 = `r(estimate)'
putexcel F4 = `r(lb)'
putexcel G4 = `r(ub)'
lincom _b[1.disability#0.lowqualitycare] * 1000
putexcel H4 = `r(estimate)'
putexcel I4 = `r(lb)'
putexcel J4 = `r(ub)'
lincom _b[1.disability#1.lowqualitycare] * 1000
putexcel K4 = `r(estimate)'
putexcel L4 = `r(lb)'
putexcel M4 = `r(ub)'
lincom _b[2.disability#0.lowqualitycare] * 1000
putexcel N4 = `r(estimate)'
putexcel O4 = `r(lb)'
putexcel P4 = `r(ub)'
lincom _b[2.disability#1.lowqualitycare] * 1000
putexcel Q4 = `r(estimate)'
putexcel R4 = `r(lb)'
putexcel S4 = `r(ub)'

// Association of Low-Quality Care and Disability with High-Impact Pain
svy, subpop(if mainsample == 1): logistic pain i.lowqualitycare##i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance i.office_visits i.er_visits i.hospital i.r1_health i.r1_mental i.high_bp i.heart_disease i.diabetes
margins i.disability#i.lowqualitycare, post subpop(if mainsample == 1)
putexcel A5 = "Pain"
lincom _b[0.disability#0.lowqualitycare] * 1000
putexcel B5 = `r(estimate)'
putexcel C5 = `r(lb)'
putexcel D5 = `r(ub)'
lincom _b[0.disability#1.lowqualitycare] * 1000
putexcel E5 = `r(estimate)'
putexcel F5 = `r(lb)'
putexcel G5 = `r(ub)'
lincom _b[1.disability#0.lowqualitycare] * 1000
putexcel H5 = `r(estimate)'
putexcel I5 = `r(lb)'
putexcel J5 = `r(ub)'
lincom _b[1.disability#1.lowqualitycare] * 1000
putexcel K5 = `r(estimate)'
putexcel L5 = `r(lb)'
putexcel M5 = `r(ub)'
lincom _b[2.disability#0.lowqualitycare] * 1000
putexcel N5 = `r(estimate)'
putexcel O5 = `r(lb)'
putexcel P5 = `r(ub)'
lincom _b[2.disability#1.lowqualitycare] * 1000
putexcel Q5 = `r(estimate)'
putexcel R5 = `r(lb)'
putexcel S5 = `r(ub)'

*************
** Table 1 **
*************

// Load Data and Set Output
use dataset.dta, clear

// Set Weights (SAQ Survey)
svyset [pweight=LSAQWT], strata(STRA9624) psu(PSU9624) 

// Descriptive Statistics for Main Sample
dtable 1.proxy_r1 1.proxy_r2 1.proxy_r4 1.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance i.office_visits i.er_visits 1.hospital 1.r1_health 1.r1_mental 1.high_bp 1.heart_disease 1.diabetes 1.cancer 1.lowqualitycare 1.gen_health 1.distress 1.depressed 1.pain 1.proxy_r5 1.r5_health 1.r5_mental, svy subpop(if mainsample == 1) by(disability) sample(,statistics(freq percent) place(seplabels)) factor(,statistics(fvrawfreq fvpercent)) nformat(%7.0fc mean) nformat(%7.1fc percent)
collect style header proxy_r1 proxy_r2 proxy_r4 proxy_saq hospital r1_health r1_mental high_bp heart_disease diabetes cancer lowqualitycare gen_health distress depressed pain proxy_r5 r5_health r5_mental, level(hide)
collect preview
collect export "output-file-1.xlsx", sheet("table1") modify
dtable, svy by(disability) sample(,statistics(sumw))
collect export "output-file-1.xlsx", sheet("table1") modify cell(A100)
dtable, svy subpop(if any_visit == 1) by(disability) sample(,statistics(sumw))
collect export "output-file-1.xlsx", sheet("table1") modify cell(A105)
dtable, svy subpop(if mainsample == 1) by(disability) sample(,statistics(sumw))
collect export "output-file-1.xlsx", sheet("table1") modify cell(A110)

*************
** Table 2 **
*************

// Load Data and Set Output
use dataset.dta, clear
putexcel set "output-file-1.xlsx", sheet("table2") modify

// Set Weights (SAQ Survey)
svyset [pweight=LSAQWT], strata(STRA9624) psu(PSU9624) 

// Observed Prevalence (Disabled [Continuous] and Nondisabled)
/* Poor/Fair Health */
svy, subpop(if mainsample == 1): prop gen_health, over(disability)
matrix results = r(table)
matrix results = results'
putexcel A1 = matrix(results)
/* Serious Psychological Distress */
svy, subpop(if mainsample == 1): prop distress, over(disability)
matrix results = r(table)
matrix results = results'
putexcel A11 = matrix(results)
/* Depression */
svy, subpop(if mainsample == 1): prop depressed, over(disability)
matrix results = r(table)
matrix results = results'
putexcel A21 = matrix(results)
/* High-Impact Pain */
svy, subpop(if mainsample == 1): prop pain, over(disability)
matrix results = r(table)
matrix results = results'
putexcel A31 = matrix(results)

// National Estimate of Cases (Disabled [Continuous] and Nondisabled)
/* Population Estimates */
svy,subpop(if any_visits == 1): total i.disability
local nondisabled_pop = _b[0.disability]
local disabled_pop = _b[2.disability]
/* Poor/Fair Health */
svy, subpop(if mainsample == 1): prop gen_health, over(disability)
lincom _b[1.gen_health@0.disability] * `nondisabled_pop'
putexcel A41 = `r(estimate)'
putexcel B41 = `r(lb)'
putexcel C41 = `r(ub)'
lincom _b[1.gen_health@2.disability] * `disabled_pop'
putexcel A42 = `r(estimate)'
putexcel B42 = `r(lb)'
putexcel C42 = `r(ub)'
/* Serious Psychological Distress */
svy, subpop(if mainsample == 1): prop distress, over(disability)
lincom _b[1.distress@0.disability] * `nondisabled_pop'
putexcel A51 = `r(estimate)'
putexcel B51 = `r(lb)'
putexcel C51 = `r(ub)'
lincom _b[1.distress@2.disability] * `disabled_pop'
putexcel A52 = `r(estimate)'
putexcel B52 = `r(lb)'
putexcel C52 = `r(ub)'
/* Depression */
svy, subpop(if mainsample == 1): prop depressed, over(disability)
lincom _b[1.depressed@0.disability] * `nondisabled_pop'
putexcel A61 = `r(estimate)'
putexcel B61 = `r(lb)'
putexcel C61 = `r(ub)'
lincom _b[1.depressed@2.disability] * `disabled_pop'
putexcel A62 = `r(estimate)'
putexcel B62 = `r(lb)'
putexcel C62 = `r(ub)'
/* High-Impact Pain */
svy, subpop(if mainsample == 1): prop pain, over(disability)
lincom _b[1.pain@0.disability] * `nondisabled_pop'
putexcel A71 = `r(estimate)'
putexcel B71 = `r(lb)'
putexcel C71 = `r(ub)'
lincom _b[1.pain@2.disability] * `disabled_pop'
putexcel A72 = `r(estimate)'
putexcel B72 = `r(lb)'
putexcel C72 = `r(ub)'

// Observed Prevalence Difference (Disabled [Continuous] vs. Nondisabled)
/* Poor/Fair Health */
svy, subpop(if mainsample == 1): prop gen_health, over(disability)
lincom _b[1.gen_health@2.disability] - _b[1.gen_health@0.disability]
putexcel A81 = `r(estimate)'
putexcel B81 = `r(lb)'
putexcel C81 = `r(ub)'
/* Serious Psychological Distress */
svy, subpop(if mainsample == 1): prop distress, over(disability)
lincom _b[1.distress@2.disability] - _b[1.distress@0.disability]
putexcel A82 = `r(estimate)'
putexcel B82 = `r(lb)'
putexcel C82 = `r(ub)'
/* Depression */
svy, subpop(if mainsample == 1): prop depressed, over(disability)
lincom _b[1.depressed@2.disability] - _b[1.depressed@0.disability]
putexcel A83 = `r(estimate)'
putexcel B83 = `r(lb)'
putexcel C83 = `r(ub)'
/* High-Impact Pain */
svy, subpop(if mainsample == 1): prop pain, over(disability)
lincom _b[1.pain@2.disability] - _b[1.pain@0.disability]
putexcel A84 = `r(estimate)'
putexcel B84 = `r(lb)'
putexcel C84 = `r(ub)'

// Total Population Estimates (Disabled [Continuous] and Nondisabled)
svy, subpop(if any_visit == 1): total i.disability
matrix results = r(table)
matrix results = results'
putexcel A91 = matrix(results)

**************
** Table S1 **
**************

// Load Data and Set Output
use dataset.dta, clear
putexcel set "output-file-1.xlsx", sheet("tableS1") modify

// Set Weights (SAQ Survey)
svyset [pweight=LSAQWT], strata(STRA9624) psu(PSU9624) 

// Observed Prevalence (Disabled [Intermittent])
/* Poor/Fair Health */
svy, subpop(if mainsample == 1): prop gen_health, over(disability)
matrix results = r(table)
matrix results = results'
putexcel A1 = matrix(results)
/* Serious Psychological Distress */
svy, subpop(if mainsample == 1): prop distress, over(disability)
matrix results = r(table)
matrix results = results'
putexcel A11 = matrix(results)
/* Depression */
svy, subpop(if mainsample == 1): prop depressed, over(disability)
matrix results = r(table)
matrix results = results'
putexcel A21 = matrix(results)
/* High-Impact Pain */
svy, subpop(if mainsample == 1): prop pain, over(disability)
matrix results = r(table)
matrix results = results'
putexcel A31 = matrix(results)

// Observed Prevalence (Disabled [Continuous and Intermittent])
/* Poor/Fair Health */
svy, subpop(if mainsample == 1): prop gen_health, over(disability_alt)
matrix results = r(table)
matrix results = results'
putexcel A41 = matrix(results)
/* Serious Psychological Distress */
svy, subpop(if mainsample == 1): prop distress, over(disability_alt)
matrix results = r(table)
matrix results = results'
putexcel A51 = matrix(results)
/* Depression */
svy, subpop(if mainsample == 1): prop depressed, over(disability_alt)
matrix results = r(table)
matrix results = results'
putexcel A61 = matrix(results)
/* High-Impact Pain */
svy, subpop(if mainsample == 1): prop pain, over(disability_alt)
matrix results = r(table)
matrix results = results'
putexcel A71 = matrix(results)

// National Estimate of Cases (Disabled [Intermittent])
/* Population Estimates */
svy,subpop(if any_visits == 1): total i.disability
local disabled_pop = _b[1.disability]
/* Poor/Fair Health */
svy, subpop(if mainsample == 1): prop gen_health, over(disability)
lincom _b[1.gen_health@1.disability] * `disabled_pop'
putexcel A81 = `r(estimate)'
putexcel B81 = `r(lb)'
putexcel C81 = `r(ub)'
/* Serious Psychological Distress */
svy, subpop(if mainsample == 1): prop distress, over(disability)
lincom _b[1.distress@1.disability] * `disabled_pop'
putexcel A82 = `r(estimate)'
putexcel B82 = `r(lb)'
putexcel C82 = `r(ub)'
/* Depression */
svy, subpop(if mainsample == 1): prop depressed, over(disability)
lincom _b[1.depressed@1.disability] * `disabled_pop'
putexcel A83 = `r(estimate)'
putexcel B83 = `r(lb)'
putexcel C83 = `r(ub)'
/* High-Impact Pain */
svy, subpop(if mainsample == 1): prop pain, over(disability)
lincom _b[1.pain@1.disability] * `disabled_pop'
putexcel A84 = `r(estimate)'
putexcel B84 = `r(lb)'
putexcel C84 = `r(ub)'

// National Estimate of Cases (Disabled [Continuous and Intermittent])
/* Population Estimates */
svy,subpop(if any_visits == 1): total i.disability_alt
local disabled_pop = _b[1.disability_alt]
/* Poor/Fair Health */
svy, subpop(if mainsample == 1): prop gen_health, over(disability_alt)
lincom _b[1.gen_health@1.disability_alt] * `disabled_pop'
putexcel A91 = `r(estimate)'
putexcel B91 = `r(lb)'
putexcel C91 = `r(ub)'
/* Serious Psychological Distress */
svy, subpop(if mainsample == 1): prop distress, over(disability_alt)
lincom _b[1.distress@1.disability_alt] * `disabled_pop'
putexcel A92 = `r(estimate)'
putexcel B92 = `r(lb)'
putexcel C92 = `r(ub)'
/* Depression */
svy, subpop(if mainsample == 1): prop depressed, over(disability_alt)
lincom _b[1.depressed@1.disability_alt] * `disabled_pop'
putexcel A93 = `r(estimate)'
putexcel B93 = `r(lb)'
putexcel C93 = `r(ub)'
/* High-Impact Pain */
svy, subpop(if mainsample == 1): prop pain, over(disability_alt)
lincom _b[1.pain@1.disability_alt] * `disabled_pop'
putexcel A94 = `r(estimate)'
putexcel B94 = `r(lb)'
putexcel C94 = `r(ub)'

// Observed Prevalence Difference (Disabled [Intermittent] vs. Nondisabled)
/* Poor/Fair Health */
svy, subpop(if mainsample == 1): prop gen_health, over(disability)
lincom _b[1.gen_health@1.disability] - _b[1.gen_health@0.disability]
putexcel A101 = `r(estimate)'
putexcel B101 = `r(lb)'
putexcel C101 = `r(ub)'
/* Serious Psychological Distress */
svy, subpop(if mainsample == 1): prop distress, over(disability)
lincom _b[1.distress@1.disability] - _b[1.distress@0.disability]
putexcel A102 = `r(estimate)'
putexcel B102 = `r(lb)'
putexcel C102 = `r(ub)'
/* Depression */
svy, subpop(if mainsample == 1): prop depressed, over(disability)
lincom _b[1.depressed@1.disability] - _b[1.depressed@0.disability]
putexcel A103 = `r(estimate)'
putexcel B103 = `r(lb)'
putexcel C103 = `r(ub)'
/* High-Impact Pain */
svy, subpop(if mainsample == 1): prop pain, over(disability)
lincom _b[1.pain@1.disability] - _b[1.pain@0.disability]
putexcel A104 = `r(estimate)'
putexcel B104 = `r(lb)'
putexcel C104 = `r(ub)'

// Observed Prevalence Difference (Disabled [Continuous and Intermittent] vs. Nondisabled)
/* Poor/Fair Health */
svy, subpop(if mainsample == 1): prop gen_health, over(disability_alt)
lincom _b[1.gen_health@1.disability_alt] - _b[1.gen_health@0.disability_alt]
putexcel A111 = `r(estimate)'
putexcel B111 = `r(lb)'
putexcel C111 = `r(ub)'
/* Serious Psychological Distress */
svy, subpop(if mainsample == 1): prop distress, over(disability_alt)
lincom _b[1.distress@1.disability_alt] - _b[1.distress@0.disability_alt]
putexcel A112 = `r(estimate)'
putexcel B112 = `r(lb)'
putexcel C112 = `r(ub)'
/* Depression */
svy, subpop(if mainsample == 1): prop depressed, over(disability_alt)
lincom _b[1.depressed@1.disability_alt] - _b[1.depressed@0.disability_alt]
putexcel A113 = `r(estimate)'
putexcel B113 = `r(lb)'
putexcel C113 = `r(ub)'
/* High-Impact Pain */
svy, subpop(if mainsample == 1): prop pain, over(disability_alt)
lincom _b[1.pain@1.disability_alt] - _b[1.pain@0.disability_alt]
putexcel A114 = `r(estimate)'
putexcel B114 = `r(lb)'
putexcel C114 = `r(ub)'

// Total Population Estimates (Disabled [Intermittent])
svy, subpop(if any_visit == 1): total i.disability
matrix results = r(table)
matrix results = results'
putexcel A121 = matrix(results)

// Total Population Estimates (Disabled [Continuous and Intermittent])
svy, subpop(if any_visit == 1): total i.disability_alt
matrix results = r(table)
matrix results = results'
putexcel A131 = matrix(results)

****************
** End of File *
****************
