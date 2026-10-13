************************************************************************************************************
** Disability, ableism in health care settings, and health disparities among US adults: a cross-sectional decomposition analysis
** Code by Dielle J. Lundberg
** Last Updated: October 3, 2026
** Code File 1 of 18: Full Analysis Work Flow
************************************************************************************************************

***********************
**** PART 1:       ****
**** DOWNLOAD DATA ****
***********************

// Note: Data last downloaded on September 16, 2026

// MEPS HC-183: 2014-2015 Full Year Consolidated Data File (ASCII Format, Stata Programming Statement)
**** Link: https://meps.ahrq.gov/mepsweb/data_stats/download_data_files_detail.jsp?cboPufNumber=HC-183

// MEPS HC-193: 2015-2016 Full Year Consolidated Data File (ASCII Format, Stata Programming Statement)
**** Link: https://meps.ahrq.gov/mepsweb/data_stats/download_data_files_detail.jsp?cboPufNumber=HC-193

// MEPS HC-202: 2016-2017 Panel 21 Longitudinal Data File (Stata Format)
**** Link: https://meps.ahrq.gov/mepsweb/data_stats/download_data_files_detail.jsp?cboPufNumber=HC-202

// MEPS HC-217: 2018-2019 Panel 23 Longitudinal Data File (Stata Format)
**** Link: https://meps.ahrq.gov/mepsweb/data_stats/download_data_files_detail.jsp?cboPufNumber=HC-217

// MEPS HC-234: 2020-2021 Panel 25 Longitudinal Data File (Stata Format)
**** Link: https://meps.ahrq.gov/mepsweb/data_stats/download_data_files_detail.jsp?cboPufNumber=HC-234

// MEPS HC-252: 2022-2023 Panel 27 Longitudinal Data File (Stata Format)
**** Link: https://meps.ahrq.gov/mepsweb/data_stats/download_data_files_detail.jsp?cboPufNumber=HC-252

// MEPS HC-036: 1996-2024 Pooled Linkage File for Common Variance Structure
**** Link: https://meps.ahrq.gov/mepsweb/data_stats/download_data_files_detail.jsp?cboPufNumber=HC-036

********************************
**** PART 2:                ****
**** RUN FULL ANALYTIC CODE ****
********************************

// Set Directory to Folder Where Data (and Other Do Files) Are Saved
cd "/Users/djlworkdesktop/Library/Mobile Documents/com~apple~CloudDocs/Independent Research/MEPS-Ableism-PAF-Project/Analysis V3"

// Create Log File for Sample Creation
capture log close
log using "output-file-17.txt", text replace

// Run File 2 of 18: Merge Data, Clean Data, and Create Sample (Figure S1)
do "meps-ableism-PAF-file2.do"

// Create Log File with Results
capture log close
log using "output-file-18.txt", text replace

// Run File 3 of 18: Create output-file-1.xlsx with Figure 2, Tables 1-2, Table S1 (Main Tables and Figure)
do "meps-ableism-PAF-file3.do"

// Run File 4 of 18: Create output-file-2.xlsx with Table 3-4, Tables S2, and Table S4 (Main Tables and Underlying Regression Output)
do "meps-ableism-PAF-file4.do"

// Run File 5 of 18: Create output-file-3.xlsx with Table S3 and Table S5 (Sequential Adjustment for Adjusted Prevalence Estimates)
do "meps-ableism-PAF-file5.do"

// Run File 6 of 18: Create output-file-4.xlsx with Table S6 and Table S7 (PR/PAF, Includes Intermittent Disability)
do "meps-ableism-PAF-file6.do"

// Run File 7 of 18: Create output-file-5.xlsx with Table S8 (PR/PAF, Reduces Low-Quality Health Care to Zero)
do "meps-ableism-PAF-file7.do"

// Run File 8 of 18: Create output-file-6.xlsx with Tables S9 and S10 (PR/PAF, No Adjustment)
do "meps-ableism-PAF-file8.do"

// Run File 9 of 18: Create output-file-7.xlsx with Tables S9 and S10 (PR/PAF, Adjustment for Proxy Report, Survey Year, and Age)
do "meps-ableism-PAF-file9.do"

// Run File 10 of 18: Create output-file-8.xlsx with Tables S9 and S10 (PR/PAF, Additional Adjustment for Sociodemographic Factors and Health Insurance)
do "meps-ableism-PAF-file10.do"

// Run File 11 of 18: Create output-file-9.xlsx with Tables S9 and S10 (PR/PAF, Additional Adjustment for Baseline Number of Health Care Visits in Mediator-Outcome Model)
do "meps-ableism-PAF-file11.do"

// Run File 12 of 18: Create output-file-10.xlsx with Tables S9 and S10 (PR/PAF, Additional Adjustment for Baseline Number of Health Care Visits in Group-Mediator Model)
do "meps-ableism-PAF-file12.do"

// Run File 13 of 18: Create output-file-11.xlsx with Tables S9 and S10 (PR/PAF, Additional Adjustment for Baseline Health in Group-Mediator Model)
do "meps-ableism-PAF-file13.do"

// Run File 14 of 18: Create output-file-12.xlsx with Tables S9 and S10 (PR/PAF, Primary Model, Limited to Ages 18-69)
do "meps-ableism-PAF-file14.do"

// Run File 15 of 18: Create output-file-13.xlsx with Tables S9 and S10 (PR/PAF, Primary Model, Limited to Self-Reported Responses)
do "meps-ableism-PAF-file15.do"

// Run File 16 of 18: Create output-file-14.xlsx with Tables S9 and S10 (PR/PAF, Primary Model, Marginal Standardization Approach)
do "meps-ableism-PAF-file16.do"

// Run File 17 of 18: Create output-file-15.xlsx with Tables S11 and S12 (PR/PAF, Primary Model, Secondary Health Outcomes)
do "meps-ableism-PAF-file17.do"

// Run File 18 of 18: Create output-file-16.xlsx with Figures S2-S4
do "meps-ableism-PAF-file18.do"

// End Log File
capture log close

****************
** End of File *
****************
