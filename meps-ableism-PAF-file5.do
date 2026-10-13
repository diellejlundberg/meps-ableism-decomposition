************************************************************************************************************
** Disability, ableism in health care settings, and health disparities among US adults: a cross-sectional decomposition analysis
** Code by Dielle J. Lundberg
** Last Updated: October 3, 2026
** Code File 5 of 18: Table S3 and Table S5 (Sequential Adjustment for Adjusted Prevalence Estimates) (create output-file-3.xlsx)
************************************************************************************************************

// Set Working Directory
cd "/Users/djlworkdesktop/Library/Mobile Documents/com~apple~CloudDocs/Independent Research/MEPS-Ableism-PAF-Project/Analysis V3"

***************
** Table S3. **
***************

// Load Data and Set Output
use dataset.dta, clear
putexcel set "output-file-3.xlsx", sheet("tableS3") replace

// Set Weights (SAQ Survey)
svyset [pweight=LSAQWT], strata(STRA9624) psu(PSU9624) 

// No Adjustment
putexcel A1 = "No Adjustment"
svy, subpop(if mainsample == 1): logistic lowqualitycare i.disability
margins i.disability, post subpop(if mainsample == 1)
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
nlcom ((_b[2.disability] / _b[0.disability]) - 1) * 100
putexcel K1 = mat(r(table)[1,1])
putexcel L1 = mat(r(table)[5,1])
putexcel M1 = mat(r(table)[6,1])

// Adjustment for Proxy Report, Survey Year, and Age
putexcel A2 = "Adjustment for Proxy Report, Survey Year, and Age"
svy, subpop(if mainsample == 1): logistic lowqualitycare i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age
margins i.disability, post subpop(if mainsample == 1)
lincom _b[0.disability] * 1000
putexcel B2 = `r(estimate)'
putexcel C2 = `r(lb)'
putexcel D2 = `r(ub)'
lincom _b[1.disability] * 1000
putexcel E2 = `r(estimate)'
putexcel F2 = `r(lb)'
putexcel G2 = `r(ub)'
lincom _b[2.disability] * 1000
putexcel H2 = `r(estimate)'
putexcel I2 = `r(lb)'
putexcel J2 = `r(ub)'
nlcom ((_b[2.disability] / _b[0.disability]) - 1) * 100
putexcel K2 = mat(r(table)[1,1])
putexcel L2 = mat(r(table)[5,1])
putexcel M2 = mat(r(table)[6,1])

// Additional Adjustment for Sociodemographic Factors and Health Insurance (Primary Model)
putexcel A3 = "Additional Adjustment for Sociodemographic Factors and Health Insurance (Primary Model)"
svy, subpop(if mainsample == 1): logistic lowqualitycare i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance
margins i.disability, post subpop(if mainsample == 1)
lincom _b[0.disability] * 1000
putexcel B3 = `r(estimate)'
putexcel C3 = `r(lb)'
putexcel D3 = `r(ub)'
lincom _b[1.disability] * 1000
putexcel E3 = `r(estimate)'
putexcel F3 = `r(lb)'
putexcel G3 = `r(ub)'
lincom _b[2.disability] * 1000
putexcel H3 = `r(estimate)'
putexcel I3 = `r(lb)'
putexcel J3 = `r(ub)'
nlcom ((_b[2.disability] / _b[0.disability]) - 1) * 100
putexcel K3 = mat(r(table)[1,1])
putexcel L3 = mat(r(table)[5,1])
putexcel M3 = mat(r(table)[6,1])

// Primary Model, Additional Adjustment for Baseline Number of Health Care Visits
putexcel A4 = "Primary Model, Additional Adjustment for Baseline Number of Health Care Visits"
svy, subpop(if mainsample == 1): logistic lowqualitycare i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance i.office_visits i.er_visits i.hospital
margins i.disability, post subpop(if mainsample == 1)
lincom _b[0.disability] * 1000
putexcel B4 = `r(estimate)'
putexcel C4 = `r(lb)'
putexcel D4 = `r(ub)'
lincom _b[1.disability] * 1000
putexcel E4 = `r(estimate)'
putexcel F4 = `r(lb)'
putexcel G4 = `r(ub)'
lincom _b[2.disability] * 1000
putexcel H4 = `r(estimate)'
putexcel I4 = `r(lb)'
putexcel J4 = `r(ub)'
nlcom ((_b[2.disability] / _b[0.disability]) - 1) * 100
putexcel K4 = mat(r(table)[1,1])
putexcel L4 = mat(r(table)[5,1])
putexcel M4 = mat(r(table)[6,1])

// Primary Model, Additional Adjustment for Baseline Health
putexcel A5 = "Primary Model, Additional Adjustment for Baseline Health"
svy, subpop(if mainsample == 1): logistic lowqualitycare i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance i.office_visits i.er_visits i.hospital i.r1_health i.r1_mental i.high_bp i.heart_disease i.diabetes 
margins i.disability, post subpop(if mainsample == 1)
lincom _b[0.disability] * 1000
putexcel B5 = `r(estimate)'
putexcel C5 = `r(lb)'
putexcel D5 = `r(ub)'
lincom _b[1.disability] * 1000
putexcel E5 = `r(estimate)'
putexcel F5 = `r(lb)'
putexcel G5 = `r(ub)'
lincom _b[2.disability] * 1000
putexcel H5 = `r(estimate)'
putexcel I5 = `r(lb)'
putexcel J5 = `r(ub)'
nlcom ((_b[2.disability] / _b[0.disability]) - 1) * 100
putexcel K5 = mat(r(table)[1,1])
putexcel L5 = mat(r(table)[5,1])
putexcel M5 = mat(r(table)[6,1])

// Primary Model, Limited to Ages 18-69
putexcel A6 = "Primary Model, Limited to Ages 18-69"
svy, subpop(if subsample_age == 1): logistic lowqualitycare i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance
margins i.disability, post subpop(if subsample_age == 1)
lincom _b[0.disability] * 1000
putexcel B6 = `r(estimate)'
putexcel C6 = `r(lb)'
putexcel D6 = `r(ub)'
lincom _b[1.disability] * 1000
putexcel E6 = `r(estimate)'
putexcel F6 = `r(lb)'
putexcel G6 = `r(ub)'
lincom _b[2.disability] * 1000
putexcel H6 = `r(estimate)'
putexcel I6 = `r(lb)'
putexcel J6 = `r(ub)'
nlcom ((_b[2.disability] / _b[0.disability]) - 1) * 100
putexcel K6 = mat(r(table)[1,1])
putexcel L6 = mat(r(table)[5,1])
putexcel M6 = mat(r(table)[6,1])

// Primary Model, Limited to Self-Reported Responses
putexcel A7 = "Primary Model, Limited to Self-Reported Responses"
svy, subpop(if subsample_selfreport == 1): logistic lowqualitycare i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance
margins i.disability, post subpop(if subsample_selfreport == 1)
lincom _b[0.disability] * 1000
putexcel B7 = `r(estimate)'
putexcel C7 = `r(lb)'
putexcel D7 = `r(ub)'
lincom _b[1.disability] * 1000
putexcel E7 = `r(estimate)'
putexcel F7 = `r(lb)'
putexcel G7 = `r(ub)'
lincom _b[2.disability] * 1000
putexcel H7 = `r(estimate)'
putexcel I7 = `r(lb)'
putexcel J7 = `r(ub)'
nlcom ((_b[2.disability] / _b[0.disability]) - 1) * 100
putexcel K7 = mat(r(table)[1,1])
putexcel L7 = mat(r(table)[5,1])
putexcel M7 = mat(r(table)[6,1])

***********************************************************************************************************************
***********************************************************************************************************************

***********************************************************************************************************
** Table S5. Sensitivity analyses for the adjusted prevalence estimates from the mediator-outcome models **
** for self-reported poor/fair health, serious psychological distress, depression, and high-impact pain  **
***********************************************************************************************************

// Load Data
use dataset.dta, clear

// Set Weights (SAQ Survey)
svyset [pweight=LSAQWT], strata(STRA9624) psu(PSU9624) 

**********************
** Poor/Fair Health **
**********************

// Set Output
putexcel set "output-file-3.xlsx", sheet("tableS5a") modify

// No Adjustment
putexcel A1 = "No Adjustment"
svy, subpop(if mainsample == 1): logistic gen_health i.disability##i.lowqualitycare
margins i.disability#i.lowqualitycare, post subpop(if mainsample == 1)
lincom _b[0.disability#0.lowqualitycare] * 1000
putexcel B1 = `r(estimate)'
putexcel C1 = `r(lb)'
putexcel D1 = `r(ub)'
lincom _b[0.disability#1.lowqualitycare] * 1000
putexcel E1 = `r(estimate)'
putexcel F1 = `r(lb)'
putexcel G1 = `r(ub)'
lincom _b[1.disability#0.lowqualitycare] * 1000
putexcel H1 = `r(estimate)'
putexcel I1 = `r(lb)'
putexcel J1 = `r(ub)'
lincom _b[1.disability#1.lowqualitycare] * 1000
putexcel K1 = `r(estimate)'
putexcel L1 = `r(lb)'
putexcel M1 = `r(ub)'
lincom _b[2.disability#0.lowqualitycare] * 1000
putexcel N1 = `r(estimate)'
putexcel O1 = `r(lb)'
putexcel P1 = `r(ub)'
lincom _b[2.disability#1.lowqualitycare] * 1000
putexcel Q1 = `r(estimate)'
putexcel R1 = `r(lb)'
putexcel S1 = `r(ub)'
nlcom ((_b[2.disability#1.lowqualitycare] / _b[2.disability#0.lowqualitycare]) - 1) * 100
putexcel T1 = mat(r(table)[1,1])
putexcel U1 = mat(r(table)[5,1])
putexcel V1 = mat(r(table)[6,1])

// Adjustment for Proxy Report, Survey Year, and Age
putexcel A2 = "Adjustment for Proxy Report, Survey Year, and Age"
svy, subpop(if mainsample == 1): logistic gen_health i.disability##i.lowqualitycare i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age
margins i.disability#i.lowqualitycare, post subpop(if mainsample == 1)
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
nlcom ((_b[2.disability#1.lowqualitycare] / _b[2.disability#0.lowqualitycare]) - 1) * 100
putexcel T2 = mat(r(table)[1,1])
putexcel U2 = mat(r(table)[5,1])
putexcel V2 = mat(r(table)[6,1])

// Additional Adjustment for Sociodemographic Factors and Health Insurance
putexcel A3 = "Additional Adjustment for Sociodemographic Factors and Health Insurance"
svy, subpop(if mainsample == 1): logistic gen_health i.disability##i.lowqualitycare i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance
margins i.disability#i.lowqualitycare, post subpop(if mainsample == 1)
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
nlcom ((_b[2.disability#1.lowqualitycare] / _b[2.disability#0.lowqualitycare]) - 1) * 100
putexcel T3 = mat(r(table)[1,1])
putexcel U3 = mat(r(table)[5,1])
putexcel V3 = mat(r(table)[6,1])

// Additional Adjustment for Baseline Number of Health Care Visits
putexcel A4 = "Additional Adjustment for Baseline Number of Health Care Visits"
svy, subpop(if mainsample == 1): logistic gen_health i.disability##i.lowqualitycare i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance i.office_visits i.er_visits i.hospital
margins i.disability#i.lowqualitycare, post subpop(if mainsample == 1)
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
nlcom ((_b[2.disability#1.lowqualitycare] / _b[2.disability#0.lowqualitycare]) - 1) * 100
putexcel T4 = mat(r(table)[1,1])
putexcel U4 = mat(r(table)[5,1])
putexcel V4 = mat(r(table)[6,1])

// Additional Adjustment for Baseline Health (Primary Model)
putexcel A5 = "Additional Adjustment for Baseline Health (Primary Model)"
svy, subpop(if mainsample == 1): logistic gen_health i.disability##i.lowqualitycare i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance i.office_visits i.er_visits i.hospital i.r1_health i.r1_mental i.high_bp i.heart_disease i.diabetes 
margins i.disability#i.lowqualitycare, post subpop(if mainsample == 1)
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
nlcom ((_b[2.disability#1.lowqualitycare] / _b[2.disability#0.lowqualitycare]) - 1) * 100
putexcel T5 = mat(r(table)[1,1])
putexcel U5 = mat(r(table)[5,1])
putexcel V5 = mat(r(table)[6,1])

// Primary Model, Limited to Ages 18-69
putexcel A6 = "Primary Model, Limited to Ages 18-69"
svy, subpop(if subsample_age == 1): logistic gen_health i.disability##i.lowqualitycare i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance
margins i.disability#i.lowqualitycare, post subpop(if subsample_age == 1)
lincom _b[0.disability#0.lowqualitycare] * 1000
putexcel B6 = `r(estimate)'
putexcel C6 = `r(lb)'
putexcel D6 = `r(ub)'
lincom _b[0.disability#1.lowqualitycare] * 1000
putexcel E6 = `r(estimate)'
putexcel F6 = `r(lb)'
putexcel G6 = `r(ub)'
lincom _b[1.disability#0.lowqualitycare] * 1000
putexcel H6 = `r(estimate)'
putexcel I6 = `r(lb)'
putexcel J6 = `r(ub)'
lincom _b[1.disability#1.lowqualitycare] * 1000
putexcel K6 = `r(estimate)'
putexcel L6 = `r(lb)'
putexcel M6 = `r(ub)'
lincom _b[2.disability#0.lowqualitycare] * 1000
putexcel N6 = `r(estimate)'
putexcel O6 = `r(lb)'
putexcel P6 = `r(ub)'
lincom _b[2.disability#1.lowqualitycare] * 1000
putexcel Q6 = `r(estimate)'
putexcel R6 = `r(lb)'
putexcel S6 = `r(ub)'
nlcom ((_b[2.disability#1.lowqualitycare] / _b[2.disability#0.lowqualitycare]) - 1) * 100
putexcel T6 = mat(r(table)[1,1])
putexcel U6 = mat(r(table)[5,1])
putexcel V6 = mat(r(table)[6,1])

// Primary Model, Limited to Self-Reported Responses
putexcel A7 = "Primary Model, Limited to Self-Reported Responses"
svy, subpop(if subsample_selfreport == 1): logistic gen_health i.disability##i.lowqualitycare i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance
margins i.disability#i.lowqualitycare, post subpop(if subsample_selfreport == 1)
lincom _b[0.disability#0.lowqualitycare] * 1000
putexcel B7 = `r(estimate)'
putexcel C7 = `r(lb)'
putexcel D7 = `r(ub)'
lincom _b[0.disability#1.lowqualitycare] * 1000
putexcel E7 = `r(estimate)'
putexcel F7 = `r(lb)'
putexcel G7 = `r(ub)'
lincom _b[1.disability#0.lowqualitycare] * 1000
putexcel H7 = `r(estimate)'
putexcel I7 = `r(lb)'
putexcel J7 = `r(ub)'
lincom _b[1.disability#1.lowqualitycare] * 1000
putexcel K7 = `r(estimate)'
putexcel L7 = `r(lb)'
putexcel M7 = `r(ub)'
lincom _b[2.disability#0.lowqualitycare] * 1000
putexcel N7 = `r(estimate)'
putexcel O7 = `r(lb)'
putexcel P7 = `r(ub)'
lincom _b[2.disability#1.lowqualitycare] * 1000
putexcel Q7 = `r(estimate)'
putexcel R7 = `r(lb)'
putexcel S7 = `r(ub)'
nlcom ((_b[2.disability#1.lowqualitycare] / _b[2.disability#0.lowqualitycare]) - 1) * 100
putexcel T7 = mat(r(table)[1,1])
putexcel U7 = mat(r(table)[5,1])
putexcel V7 = mat(r(table)[6,1])

************************************
** Serious Psychological Distress **
************************************

// Set Output
putexcel set "output-file-3.xlsx", sheet("tableS5b") modify

// No Adjustment
putexcel A1 = "No Adjustment"
svy, subpop(if mainsample == 1): logistic distress i.disability##i.lowqualitycare
margins i.disability#i.lowqualitycare, post subpop(if mainsample == 1)
lincom _b[0.disability#0.lowqualitycare] * 1000
putexcel B1 = `r(estimate)'
putexcel C1 = `r(lb)'
putexcel D1 = `r(ub)'
lincom _b[0.disability#1.lowqualitycare] * 1000
putexcel E1 = `r(estimate)'
putexcel F1 = `r(lb)'
putexcel G1 = `r(ub)'
lincom _b[1.disability#0.lowqualitycare] * 1000
putexcel H1 = `r(estimate)'
putexcel I1 = `r(lb)'
putexcel J1 = `r(ub)'
lincom _b[1.disability#1.lowqualitycare] * 1000
putexcel K1 = `r(estimate)'
putexcel L1 = `r(lb)'
putexcel M1 = `r(ub)'
lincom _b[2.disability#0.lowqualitycare] * 1000
putexcel N1 = `r(estimate)'
putexcel O1 = `r(lb)'
putexcel P1 = `r(ub)'
lincom _b[2.disability#1.lowqualitycare] * 1000
putexcel Q1 = `r(estimate)'
putexcel R1 = `r(lb)'
putexcel S1 = `r(ub)'
nlcom ((_b[2.disability#1.lowqualitycare] / _b[2.disability#0.lowqualitycare]) - 1) * 100
putexcel T1 = mat(r(table)[1,1])
putexcel U1 = mat(r(table)[5,1])
putexcel V1 = mat(r(table)[6,1])

// Adjustment for Proxy Report, Survey Year, and Age
putexcel A2 = "Adjustment for Proxy Report, Survey Year, and Age"
svy, subpop(if mainsample == 1): logistic distress i.disability##i.lowqualitycare i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age
margins i.disability#i.lowqualitycare, post subpop(if mainsample == 1)
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
nlcom ((_b[2.disability#1.lowqualitycare] / _b[2.disability#0.lowqualitycare]) - 1) * 100
putexcel T2 = mat(r(table)[1,1])
putexcel U2 = mat(r(table)[5,1])
putexcel V2 = mat(r(table)[6,1])

// Additional Adjustment for Sociodemographic Factors and Health Insurance 
putexcel A3 = "Additional Adjustment for Sociodemographic Factors and Health Insurance"
svy, subpop(if mainsample == 1): logistic distress i.disability##i.lowqualitycare i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance
margins i.disability#i.lowqualitycare, post subpop(if mainsample == 1)
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
nlcom ((_b[2.disability#1.lowqualitycare] / _b[2.disability#0.lowqualitycare]) - 1) * 100
putexcel T3 = mat(r(table)[1,1])
putexcel U3 = mat(r(table)[5,1])
putexcel V3 = mat(r(table)[6,1])

// Additional Adjustment for Baseline Number of Health Care Visits
putexcel A4 = "Additional Adjustment for Baseline Number of Health Care Visits"
svy, subpop(if mainsample == 1): logistic distress i.disability##i.lowqualitycare i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance i.office_visits i.er_visits i.hospital
margins i.disability#i.lowqualitycare, post subpop(if mainsample == 1)
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
nlcom ((_b[2.disability#1.lowqualitycare] / _b[2.disability#0.lowqualitycare]) - 1) * 100
putexcel T4 = mat(r(table)[1,1])
putexcel U4 = mat(r(table)[5,1])
putexcel V4 = mat(r(table)[6,1])

// Additional Adjustment for Baseline Health
putexcel A5 = "Additional Adjustment for Baseline Health (Primary Model)"
svy, subpop(if mainsample == 1): logistic distress i.disability##i.lowqualitycare i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance i.office_visits i.er_visits i.hospital i.r1_health i.r1_mental i.high_bp i.heart_disease i.diabetes 
margins i.disability#i.lowqualitycare, post subpop(if mainsample == 1)
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
nlcom ((_b[2.disability#1.lowqualitycare] / _b[2.disability#0.lowqualitycare]) - 1) * 100
putexcel T5 = mat(r(table)[1,1])
putexcel U5 = mat(r(table)[5,1])
putexcel V5 = mat(r(table)[6,1])

// Primary Model, Limited to Ages 18-69
putexcel A6 = "Primary Model, Limited to Ages 18-69"
svy, subpop(if subsample_age == 1): logistic distress i.disability##i.lowqualitycare i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance
margins i.disability#i.lowqualitycare, post subpop(if subsample_age == 1)
lincom _b[0.disability#0.lowqualitycare] * 1000
putexcel B6 = `r(estimate)'
putexcel C6 = `r(lb)'
putexcel D6 = `r(ub)'
lincom _b[0.disability#1.lowqualitycare] * 1000
putexcel E6 = `r(estimate)'
putexcel F6 = `r(lb)'
putexcel G6 = `r(ub)'
lincom _b[1.disability#0.lowqualitycare] * 1000
putexcel H6 = `r(estimate)'
putexcel I6 = `r(lb)'
putexcel J6 = `r(ub)'
lincom _b[1.disability#1.lowqualitycare] * 1000
putexcel K6 = `r(estimate)'
putexcel L6 = `r(lb)'
putexcel M6 = `r(ub)'
lincom _b[2.disability#0.lowqualitycare] * 1000
putexcel N6 = `r(estimate)'
putexcel O6 = `r(lb)'
putexcel P6 = `r(ub)'
lincom _b[2.disability#1.lowqualitycare] * 1000
putexcel Q6 = `r(estimate)'
putexcel R6 = `r(lb)'
putexcel S6 = `r(ub)'
nlcom ((_b[2.disability#1.lowqualitycare] / _b[2.disability#0.lowqualitycare]) - 1) * 100
putexcel T6 = mat(r(table)[1,1])
putexcel U6 = mat(r(table)[5,1])
putexcel V6 = mat(r(table)[6,1])

// Primary Model, Limited to Self-Reported Responses
putexcel A7 = "Primary Model, Limited to Self-Reported Responses"
svy, subpop(if subsample_selfreport == 1): logistic distress i.disability##i.lowqualitycare i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance
margins i.disability#i.lowqualitycare, post subpop(if subsample_selfreport == 1)
lincom _b[0.disability#0.lowqualitycare] * 1000
putexcel B7 = `r(estimate)'
putexcel C7 = `r(lb)'
putexcel D7 = `r(ub)'
lincom _b[0.disability#1.lowqualitycare] * 1000
putexcel E7 = `r(estimate)'
putexcel F7 = `r(lb)'
putexcel G7 = `r(ub)'
lincom _b[1.disability#0.lowqualitycare] * 1000
putexcel H7 = `r(estimate)'
putexcel I7 = `r(lb)'
putexcel J7 = `r(ub)'
lincom _b[1.disability#1.lowqualitycare] * 1000
putexcel K7 = `r(estimate)'
putexcel L7 = `r(lb)'
putexcel M7 = `r(ub)'
lincom _b[2.disability#0.lowqualitycare] * 1000
putexcel N7 = `r(estimate)'
putexcel O7 = `r(lb)'
putexcel P7 = `r(ub)'
lincom _b[2.disability#1.lowqualitycare] * 1000
putexcel Q7 = `r(estimate)'
putexcel R7 = `r(lb)'
putexcel S7 = `r(ub)'
nlcom ((_b[2.disability#1.lowqualitycare] / _b[2.disability#0.lowqualitycare]) - 1) * 100
putexcel T7 = mat(r(table)[1,1])
putexcel U7 = mat(r(table)[5,1])
putexcel V7 = mat(r(table)[6,1])

****************
** Depression **
****************

// Set Output
putexcel set "output-file-3.xlsx", sheet("tableS5c") modify

// No Adjustment
putexcel A1 = "No Adjustment"
svy, subpop(if mainsample == 1): logistic depressed i.disability##i.lowqualitycare
margins i.disability#i.lowqualitycare, post subpop(if mainsample == 1)
lincom _b[0.disability#0.lowqualitycare] * 1000
putexcel B1 = `r(estimate)'
putexcel C1 = `r(lb)'
putexcel D1 = `r(ub)'
lincom _b[0.disability#1.lowqualitycare] * 1000
putexcel E1 = `r(estimate)'
putexcel F1 = `r(lb)'
putexcel G1 = `r(ub)'
lincom _b[1.disability#0.lowqualitycare] * 1000
putexcel H1 = `r(estimate)'
putexcel I1 = `r(lb)'
putexcel J1 = `r(ub)'
lincom _b[1.disability#1.lowqualitycare] * 1000
putexcel K1 = `r(estimate)'
putexcel L1 = `r(lb)'
putexcel M1 = `r(ub)'
lincom _b[2.disability#0.lowqualitycare] * 1000
putexcel N1 = `r(estimate)'
putexcel O1 = `r(lb)'
putexcel P1 = `r(ub)'
lincom _b[2.disability#1.lowqualitycare] * 1000
putexcel Q1 = `r(estimate)'
putexcel R1 = `r(lb)'
putexcel S1 = `r(ub)'
nlcom ((_b[2.disability#1.lowqualitycare] / _b[2.disability#0.lowqualitycare]) - 1) * 100
putexcel T1 = mat(r(table)[1,1])
putexcel U1 = mat(r(table)[5,1])
putexcel V1 = mat(r(table)[6,1])

// Adjustment for Proxy Report, Survey Year, and Age
putexcel A2 = "Adjustment for Proxy Report, Survey Year, and Age"
svy, subpop(if mainsample == 1): logistic depressed i.disability##i.lowqualitycare i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age
margins i.disability#i.lowqualitycare, post subpop(if mainsample == 1)
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
nlcom ((_b[2.disability#1.lowqualitycare] / _b[2.disability#0.lowqualitycare]) - 1) * 100
putexcel T2 = mat(r(table)[1,1])
putexcel U2 = mat(r(table)[5,1])
putexcel V2 = mat(r(table)[6,1])

// Additional Adjustment for Sociodemographic Factors and Health Insurance
putexcel A3 = "Additional Adjustment for Sociodemographic Factors and Health Insurance"
svy, subpop(if mainsample == 1): logistic depressed i.disability##i.lowqualitycare i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance
margins i.disability#i.lowqualitycare, post subpop(if mainsample == 1)
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
nlcom ((_b[2.disability#1.lowqualitycare] / _b[2.disability#0.lowqualitycare]) - 1) * 100
putexcel T3 = mat(r(table)[1,1])
putexcel U3 = mat(r(table)[5,1])
putexcel V3 = mat(r(table)[6,1])

// Additional Adjustment for Baseline Number of Health Care Visits
putexcel A4 = "Additional Adjustment for Baseline Number of Health Care Visits"
svy, subpop(if mainsample == 1): logistic depressed i.disability##i.lowqualitycare i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance i.office_visits i.er_visits i.hospital
margins i.disability#i.lowqualitycare, post subpop(if mainsample == 1)
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
nlcom ((_b[2.disability#1.lowqualitycare] / _b[2.disability#0.lowqualitycare]) - 1) * 100
putexcel T4 = mat(r(table)[1,1])
putexcel U4 = mat(r(table)[5,1])
putexcel V4 = mat(r(table)[6,1])

// Additional Adjustment for Baseline Health (Primary Model)
putexcel A5 = "Additional Adjustment for Baseline Health (Primary Model)"
svy, subpop(if mainsample == 1): logistic depressed i.disability##i.lowqualitycare i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance i.office_visits i.er_visits i.hospital i.r1_health i.r1_mental i.high_bp i.heart_disease i.diabetes 
margins i.disability#i.lowqualitycare, post subpop(if mainsample == 1)
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
nlcom ((_b[2.disability#1.lowqualitycare] / _b[2.disability#0.lowqualitycare]) - 1) * 100
putexcel T5 = mat(r(table)[1,1])
putexcel U5 = mat(r(table)[5,1])
putexcel V5 = mat(r(table)[6,1])

// Primary Model, Limited to Ages 18-69
putexcel A6 = "Primary Model, Limited to Ages 18-69"
svy, subpop(if subsample_age == 1): logistic depressed i.disability##i.lowqualitycare i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance
margins i.disability#i.lowqualitycare, post subpop(if subsample_age == 1)
lincom _b[0.disability#0.lowqualitycare] * 1000
putexcel B6 = `r(estimate)'
putexcel C6 = `r(lb)'
putexcel D6 = `r(ub)'
lincom _b[0.disability#1.lowqualitycare] * 1000
putexcel E6 = `r(estimate)'
putexcel F6 = `r(lb)'
putexcel G6 = `r(ub)'
lincom _b[1.disability#0.lowqualitycare] * 1000
putexcel H6 = `r(estimate)'
putexcel I6 = `r(lb)'
putexcel J6 = `r(ub)'
lincom _b[1.disability#1.lowqualitycare] * 1000
putexcel K6 = `r(estimate)'
putexcel L6 = `r(lb)'
putexcel M6 = `r(ub)'
lincom _b[2.disability#0.lowqualitycare] * 1000
putexcel N6 = `r(estimate)'
putexcel O6 = `r(lb)'
putexcel P6 = `r(ub)'
lincom _b[2.disability#1.lowqualitycare] * 1000
putexcel Q6 = `r(estimate)'
putexcel R6 = `r(lb)'
putexcel S6 = `r(ub)'
nlcom ((_b[2.disability#1.lowqualitycare] / _b[2.disability#0.lowqualitycare]) - 1) * 100
putexcel T6 = mat(r(table)[1,1])
putexcel U6 = mat(r(table)[5,1])
putexcel V6 = mat(r(table)[6,1])

// Primary Model, Limited to Self-Reported Responses
putexcel A7 = "Primary Model, Limited to Self-Reported Responses"
svy, subpop(if subsample_selfreport == 1): logistic depressed i.disability##i.lowqualitycare i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance
margins i.disability#i.lowqualitycare, post subpop(if subsample_selfreport == 1)
lincom _b[0.disability#0.lowqualitycare] * 1000
putexcel B7 = `r(estimate)'
putexcel C7 = `r(lb)'
putexcel D7 = `r(ub)'
lincom _b[0.disability#1.lowqualitycare] * 1000
putexcel E7 = `r(estimate)'
putexcel F7 = `r(lb)'
putexcel G7 = `r(ub)'
lincom _b[1.disability#0.lowqualitycare] * 1000
putexcel H7 = `r(estimate)'
putexcel I7 = `r(lb)'
putexcel J7 = `r(ub)'
lincom _b[1.disability#1.lowqualitycare] * 1000
putexcel K7 = `r(estimate)'
putexcel L7 = `r(lb)'
putexcel M7 = `r(ub)'
lincom _b[2.disability#0.lowqualitycare] * 1000
putexcel N7 = `r(estimate)'
putexcel O7 = `r(lb)'
putexcel P7 = `r(ub)'
lincom _b[2.disability#1.lowqualitycare] * 1000
putexcel Q7 = `r(estimate)'
putexcel R7 = `r(lb)'
putexcel S7 = `r(ub)'
nlcom ((_b[2.disability#1.lowqualitycare] / _b[2.disability#0.lowqualitycare]) - 1) * 100
putexcel T7 = mat(r(table)[1,1])
putexcel U7 = mat(r(table)[5,1])
putexcel V7 = mat(r(table)[6,1])

**********************
** High-Impact Pain **
**********************

// Set Output
putexcel set "output-file-3.xlsx", sheet("tableS5d") modify

// No Adjustment
putexcel A1 = "No Adjustment"
svy, subpop(if mainsample == 1): logistic pain i.disability##i.lowqualitycare
margins i.disability#i.lowqualitycare, post subpop(if mainsample == 1)
lincom _b[0.disability#0.lowqualitycare] * 1000
putexcel B1 = `r(estimate)'
putexcel C1 = `r(lb)'
putexcel D1 = `r(ub)'
lincom _b[0.disability#1.lowqualitycare] * 1000
putexcel E1 = `r(estimate)'
putexcel F1 = `r(lb)'
putexcel G1 = `r(ub)'
lincom _b[1.disability#0.lowqualitycare] * 1000
putexcel H1 = `r(estimate)'
putexcel I1 = `r(lb)'
putexcel J1 = `r(ub)'
lincom _b[1.disability#1.lowqualitycare] * 1000
putexcel K1 = `r(estimate)'
putexcel L1 = `r(lb)'
putexcel M1 = `r(ub)'
lincom _b[2.disability#0.lowqualitycare] * 1000
putexcel N1 = `r(estimate)'
putexcel O1 = `r(lb)'
putexcel P1 = `r(ub)'
lincom _b[2.disability#1.lowqualitycare] * 1000
putexcel Q1 = `r(estimate)'
putexcel R1 = `r(lb)'
putexcel S1 = `r(ub)'
nlcom ((_b[2.disability#1.lowqualitycare] / _b[2.disability#0.lowqualitycare]) - 1) * 100
putexcel T1 = mat(r(table)[1,1])
putexcel U1 = mat(r(table)[5,1])
putexcel V1 = mat(r(table)[6,1])

// Adjustment for Proxy Report, Survey Year, and Age
putexcel A2 = "Adjustment for Proxy Report, Survey Year, and Age"
svy, subpop(if mainsample == 1): logistic pain i.disability##i.lowqualitycare i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age
margins i.disability#i.lowqualitycare, post subpop(if mainsample == 1)
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
nlcom ((_b[2.disability#1.lowqualitycare] / _b[2.disability#0.lowqualitycare]) - 1) * 100
putexcel T2 = mat(r(table)[1,1])
putexcel U2 = mat(r(table)[5,1])
putexcel V2 = mat(r(table)[6,1])

// Additional Adjustment for Sociodemographic Factors and Health Insurance
putexcel A3 = "Additional Adjustment for Sociodemographic Factors and Health Insurance"
svy, subpop(if mainsample == 1): logistic pain i.disability##i.lowqualitycare i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance
margins i.disability#i.lowqualitycare, post subpop(if mainsample == 1)
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
nlcom ((_b[2.disability#1.lowqualitycare] / _b[2.disability#0.lowqualitycare]) - 1) * 100
putexcel T3 = mat(r(table)[1,1])
putexcel U3 = mat(r(table)[5,1])
putexcel V3 = mat(r(table)[6,1])

// Additional Adjustment for Baseline Number of Health Care Visits
putexcel A4 = "Additional Adjustment for Baseline Number of Health Care Visits"
svy, subpop(if mainsample == 1): logistic pain i.disability##i.lowqualitycare i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance i.office_visits i.er_visits i.hospital
margins i.disability#i.lowqualitycare, post subpop(if mainsample == 1)
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
nlcom ((_b[2.disability#1.lowqualitycare] / _b[2.disability#0.lowqualitycare]) - 1) * 100
putexcel T4 = mat(r(table)[1,1])
putexcel U4 = mat(r(table)[5,1])
putexcel V4 = mat(r(table)[6,1])

// Additional Adjustment for Baseline Health (Primary Model)
putexcel A5 = "Additional Adjustment for Baseline Health (Primary Model)"
svy, subpop(if mainsample == 1): logistic pain i.disability##i.lowqualitycare i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance i.office_visits i.er_visits i.hospital i.r1_health i.r1_mental i.high_bp i.heart_disease i.diabetes 
margins i.disability#i.lowqualitycare, post subpop(if mainsample == 1)
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
nlcom ((_b[2.disability#1.lowqualitycare] / _b[2.disability#0.lowqualitycare]) - 1) * 100
putexcel T5 = mat(r(table)[1,1])
putexcel U5 = mat(r(table)[5,1])
putexcel V5 = mat(r(table)[6,1])

// Primary Model, Limited to Ages 18-69
putexcel A6 = "Primary Model, Limited to Ages 18-69"
svy, subpop(if subsample_age == 1): logistic pain i.disability##i.lowqualitycare i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance
margins i.disability#i.lowqualitycare, post subpop(if subsample_age == 1)
lincom _b[0.disability#0.lowqualitycare] * 1000
putexcel B6 = `r(estimate)'
putexcel C6 = `r(lb)'
putexcel D6 = `r(ub)'
lincom _b[0.disability#1.lowqualitycare] * 1000
putexcel E6 = `r(estimate)'
putexcel F6 = `r(lb)'
putexcel G6 = `r(ub)'
lincom _b[1.disability#0.lowqualitycare] * 1000
putexcel H6 = `r(estimate)'
putexcel I6 = `r(lb)'
putexcel J6 = `r(ub)'
lincom _b[1.disability#1.lowqualitycare] * 1000
putexcel K6 = `r(estimate)'
putexcel L6 = `r(lb)'
putexcel M6 = `r(ub)'
lincom _b[2.disability#0.lowqualitycare] * 1000
putexcel N6 = `r(estimate)'
putexcel O6 = `r(lb)'
putexcel P6 = `r(ub)'
lincom _b[2.disability#1.lowqualitycare] * 1000
putexcel Q6 = `r(estimate)'
putexcel R6 = `r(lb)'
putexcel S6 = `r(ub)'
nlcom ((_b[2.disability#1.lowqualitycare] / _b[2.disability#0.lowqualitycare]) - 1) * 100
putexcel T6 = mat(r(table)[1,1])
putexcel U6 = mat(r(table)[5,1])
putexcel V6 = mat(r(table)[6,1])

// Primary Model, Limited to Self-Reported Responses
putexcel A7 = "Primary Model, Limited to Self-Reported Responses"
svy, subpop(if subsample_selfreport == 1): logistic pain i.disability##i.lowqualitycare i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance
margins i.disability#i.lowqualitycare, post subpop(if subsample_selfreport == 1)
lincom _b[0.disability#0.lowqualitycare] * 1000
putexcel B7 = `r(estimate)'
putexcel C7 = `r(lb)'
putexcel D7 = `r(ub)'
lincom _b[0.disability#1.lowqualitycare] * 1000
putexcel E7 = `r(estimate)'
putexcel F7 = `r(lb)'
putexcel G7 = `r(ub)'
lincom _b[1.disability#0.lowqualitycare] * 1000
putexcel H7 = `r(estimate)'
putexcel I7 = `r(lb)'
putexcel J7 = `r(ub)'
lincom _b[1.disability#1.lowqualitycare] * 1000
putexcel K7 = `r(estimate)'
putexcel L7 = `r(lb)'
putexcel M7 = `r(ub)'
lincom _b[2.disability#0.lowqualitycare] * 1000
putexcel N7 = `r(estimate)'
putexcel O7 = `r(lb)'
putexcel P7 = `r(ub)'
lincom _b[2.disability#1.lowqualitycare] * 1000
putexcel Q7 = `r(estimate)'
putexcel R7 = `r(lb)'
putexcel S7 = `r(ub)'
nlcom ((_b[2.disability#1.lowqualitycare] / _b[2.disability#0.lowqualitycare]) - 1) * 100
putexcel T7 = mat(r(table)[1,1])
putexcel U7 = mat(r(table)[5,1])
putexcel V7 = mat(r(table)[6,1])

***********************************************************************************************************************
***********************************************************************************************************************

****************
** End of File *
****************
