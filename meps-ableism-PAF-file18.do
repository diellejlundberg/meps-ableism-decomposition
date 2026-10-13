************************************************************************************************************
** Disability, ableism in health care settings, and health disparities among US adults: a cross-sectional decomposition analysis
** Code by Dielle J. Lundberg
** Last Updated: October 3, 2026
** Code File 18 of 18: Figures S2-S4 (create output-file-16.xlsx)
************************************************************************************************************

****************
** Figure S2. **
****************

// Load Data and Set Output
use dataset.dta, clear
putexcel set "output-file-16.xlsx", sheet("figureS2") replace

// Set Weights (SAQ Survey)
svyset [pweight=LSAQWT], strata(STRA9624) psu(PSU9624) 

// Association of Disability Types with Low-Quality Health Care
/* Ambulation Disability */
svy, subpop(if mainsample == 1): logistic lowqualitycare i.disability_ambulation i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance
margins i.disability_ambulation, post subpop(if mainsample == 1)
putexcel A1 = "Ambulation Disability"
lincom _b[0.disability_ambulation] * 1000
putexcel B1 = `r(estimate)'
putexcel C1 = `r(lb)'
putexcel D1 = `r(ub)'
lincom _b[2.disability_ambulation] * 1000
putexcel E1 = `r(estimate)'
putexcel F1 = `r(lb)'
putexcel G1 = `r(ub)'
/* Cognition Disability */
svy, subpop(if mainsample == 1): logistic lowqualitycare i.disability_cognition i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance
margins i.disability_cognition, post subpop(if mainsample == 1)
putexcel A2 = "Cognition Disability"
lincom _b[0.disability_cognition] * 1000
putexcel B2 = `r(estimate)'
putexcel C2 = `r(lb)'
putexcel D2 = `r(ub)'
lincom _b[2.disability_cognition] * 1000
putexcel E2 = `r(estimate)'
putexcel F2 = `r(lb)'
putexcel G2 = `r(ub)'
/* Hearing Disability */
svy, subpop(if mainsample == 1): logistic lowqualitycare i.disability_hearing i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance
margins i.disability_hearing, post subpop(if mainsample == 1)
putexcel A3 = "Hearing Disability"
lincom _b[0.disability_hearing] * 1000
putexcel B3 = `r(estimate)'
putexcel C3 = `r(lb)'
putexcel D3 = `r(ub)'
lincom _b[2.disability_hearing] * 1000
putexcel E3 = `r(estimate)'
putexcel F3 = `r(lb)'
putexcel G3 = `r(ub)'
/* Independent Living Disability */
svy, subpop(if mainsample == 1): logistic lowqualitycare i.disability_independent i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance
margins i.disability_independent, post subpop(if mainsample == 1)
putexcel A4 = "Independent Living Disability"
lincom _b[0.disability_independent] * 1000
putexcel B4 = `r(estimate)'
putexcel C4 = `r(lb)'
putexcel D4 = `r(ub)'
lincom _b[2.disability_independent] * 1000
putexcel E4 = `r(estimate)'
putexcel F4 = `r(lb)'
putexcel G4 = `r(ub)'
/* Seeing Disability */
svy, subpop(if mainsample == 1): logistic lowqualitycare i.disability_seeing i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance
margins i.disability_seeing, post subpop(if mainsample == 1)
putexcel A5 = "Seeing Disability"
lincom _b[0.disability_seeing] * 1000
putexcel B5 = `r(estimate)'
putexcel C5 = `r(lb)'
putexcel D5 = `r(ub)'
lincom _b[2.disability_seeing] * 1000
putexcel E5 = `r(estimate)'
putexcel F5 = `r(lb)'
putexcel G5 = `r(ub)'
/* Self-Care Disability */
svy, subpop(if mainsample == 1): logistic lowqualitycare i.disability_selfcare i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance
margins i.disability_selfcare, post subpop(if mainsample == 1)
putexcel A6 = "Self-Care Disability"
lincom _b[0.disability_selfcare] * 1000
putexcel B6 = `r(estimate)'
putexcel C6 = `r(lb)'
putexcel D6 = `r(ub)'
lincom _b[2.disability_selfcare] * 1000
putexcel E6 = `r(estimate)'
putexcel F6 = `r(lb)'
putexcel G6 = `r(ub)'

// Association of Number of Disability Types with Low-Quality Health Care
svy, subpop(if mainsample == 1): logistic lowqualitycare i.disability_type_count i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance
margins i.disability_type_count, post subpop(if mainsample == 1)
putexcel A7 = "Nondisabled"
lincom _b[0.disability_type_count] * 1000
putexcel B7 = `r(estimate)'
putexcel C7 = `r(lb)'
putexcel D7 = `r(ub)'
putexcel A8 = "1 Disability Type"
lincom _b[1.disability_type_count] * 1000
putexcel B8 = `r(estimate)'
putexcel C8 = `r(lb)'
putexcel D8 = `r(ub)'
putexcel A9 = "2 Disability Types"
lincom _b[2.disability_type_count] * 1000
putexcel B9 = `r(estimate)'
putexcel C9 = `r(lb)'
putexcel D9 = `r(ub)'
putexcel A10 = "3 Disability Types"
lincom _b[3.disability_type_count] * 1000
putexcel B10 = `r(estimate)'
putexcel C10 = `r(lb)'
putexcel D10 = `r(ub)'
putexcel A11 = "4-6 Disability Types"
lincom _b[4.disability_type_count] * 1000
putexcel B11 = `r(estimate)'
putexcel C11 = `r(lb)'
putexcel D11 = `r(ub)'

****************
** Figure S3. **
****************

// Load Data and Set Output
use dataset.dta, clear
putexcel set "output-file-16.xlsx", sheet("figureS3") modify

// Set Weights (SAQ Survey)
svyset [pweight=LSAQWT], strata(STRA9624) psu(PSU9624) 

// Association of Disability with Each Dimension of Low-Quality Health Care
/* Did Not Listen Carefully */
svy, subpop(if mainsample == 1): logistic listening i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance
margins i.disability, post subpop(if mainsample == 1)
putexcel A1 = "Did Not Listen Carefully"
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
/* Did Not Communicate Clearly */
svy, subpop(if mainsample == 1): logistic explain i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance
margins i.disability, post subpop(if mainsample == 1)
putexcel A2 = "Did Not Communicate Clearly"
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
/* Did Not Show Respect */
svy, subpop(if mainsample == 1): logistic respect i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance
margins i.disability, post subpop(if mainsample == 1)
putexcel A3 = "Did Not Show Respect"
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
/* Did Not Spend Enough Time */
svy, subpop(if mainsample == 1): logistic time i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance
margins i.disability, post subpop(if mainsample == 1)
putexcel A4 = "Did Not Spend Enough Time"
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
/* Dissatisfaction with Health Care */
svy, subpop(if mainsample == 1): logistic satisfaction i.disability i.proxy_r1 i.proxy_r2 i.proxy_r4 i.proxy_saq i.survey_year i.age i.sex i.race i.ethnicity i.education i.income i.insurance
margins i.disability, post subpop(if mainsample == 1)
putexcel A5 = "Dissatisfied with Health Care"
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

****************
** End of File *
****************
