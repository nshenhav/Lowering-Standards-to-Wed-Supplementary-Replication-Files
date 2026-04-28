clear all

global homedir ""  // please input your working directory here
global data "$homedir/data"
global raw "$homedir/raw"
global logs "$homedir/logs"

cap log close
log using "$logs/0cleancensus.log" , replace

cd "$data"

!gunzip census7010.dta.gz
use "$data/census7010.dta", clear
!gzip census7010.dta

// Allocated observations:
!gunzip crosswalk_qrace2016.dta.gz
merge 1:1 sample serial pernum using "$data/crosswalk_qrace2016.dta"
!gzip crosswalk_qrace2016.dta
drop _merge

foreach x in qsex qrace_2016 qeduc qwkswork qincwage {
	drop if `x' !=0
}
foreach x in qhrswork {
	drop if `x' !=0 & year<=1990
}



//Education bins
gen educ_clean = "lths" if (educd<60 & educd >1)| educd==61 // lths or 12th no diploma
replace educ_clean = "hs" if educd==62 | educd== 63 | educd== 64| educd==60
replace educ_clean = "scol" if educd>=65 &  educd<100
replace educ_clean = "col" if educd>=100 &  educd<=116
tab year educ_clean, m

// Years education
gen yrsed = 0 if educd ==2|educd==11|educd==12 // 0 ed
replace yrsed = 2 if educd ==10 // nursery to grade 4
replace yrsed = 2.5 if educd ==13 // 1-4
replace yrsed = 1 if educd ==14 // 1
replace yrsed = 2 if educd ==15 // 2
replace yrsed = 3 if educd ==16 // 3
replace yrsed = 4 if educd ==17 // 4
replace yrsed = 6.5 if educd ==20 // 5-8
replace yrsed = 5.5 if educd ==21 // 5-6
replace yrsed = 5 if educd ==22 // 5
replace yrsed = 6 if educd ==23 // 6
replace yrsed = 7.5 if educd ==24 // 7-8
replace yrsed = 7 if educd ==25 // 7
replace yrsed = 8 if educd ==26 // 8
replace yrsed = 9 if educd ==30 // 9
replace yrsed = 10 if educd ==40 // 10
replace yrsed = 11 if educd ==50 // 11
replace yrsed = 12 if educd ==60|educd ==61|educd ==62|educd ==63|educd ==64
replace yrsed = 12.5 if educd ==65 // less than a year of college
replace yrsed = 13 if educd ==70|educd==71 // 13
replace yrsed = 14 if educd ==80|educd ==81|educd ==82|educd ==83 // 14
replace yrsed = 15 if educd ==90 // 15
replace yrsed = 16 if educd ==100|educd ==101 // 16
replace yrsed = 17 if educd ==110 // 17
replace yrsed = 18 if educd ==111|educd ==114 // 18
replace yrsed = 19 if educd ==112|educd==115 // 19
replace yrsed = 21 if educd ==116 // 21

drop educ
ren educd educ_orig
ren educ_clean educ



//Race 
gen race_simp = "wht" if race==1 & (hispan==0 | hispan==9) //not hispanic or do not know or NA
replace  race_simp = "blk" if race==2 & (hispan==0 | hispan==9) //not hispanic or do not know
replace  race_simp = "hisp" if hispan!=0 & hispan != 9 & hispan !=.
replace race_simp = "oth" if race_simp =="" & race !=. 

rename race race_orig
rename race_simp race

// Keep form 1 for 1970, form 1 for 1980
drop if sample == 198002 | sample == 197002	

//Self-employed
gen self_emp = 1 if classwkr==1
replace self_emp = 0 if classwkr ==2

/***********************************************
WAGES
***********************************************/

//Income top Code - replace topcoded observations by 1.5 times topcode (see Notowidgodo 2013)

merge m:1 statefip year using "$raw/2010acs_topcodes.dta"
keep if _m==1|_m==3
drop if statefip>56
drop _m
	
gen incwage_orig=incwage
bysort year: sum incwage

replace incwage = . if incwage==999999
bysort year: sum incwage

replace incwage = 50000*1.5 if year==1970 & incwage>=50000 & incwage !=.
replace incwage = 75000*1.5 if year==1980 & incwage>=75000 & incwage !=.
replace incwage = 140000*1.5 if year==1990 & incwage>=140000 & incwage !=.
replace incwage = 175000*1.5 if year==2000 & incwage>=175000 & incwage !=.
replace incwage = incwage_topcode_2010*1.5 ///
if year==2010 & incwage>=incwage_topcode_2010 & incwage !=.

//Hours - 1970 have binned hours (hrs lw)
gen 	hrswork = . 	if hrswork2 == 0 & year ==1970 // NA
replace hrswork = 7.5 	if hrswork2 == 1 & year ==1970 // 1-14 hrs
replace hrswork = 17 	if hrswork2 == 2 & year ==1970 // 15-29 hr
replace hrswork = 32 	if hrswork2 == 3 & year ==1970 // 30-34 hr
replace hrswork = 37 	if hrswork2 == 4 & year ==1970 // 35-39 hr
replace hrswork = 40 	if hrswork2 == 5 & year ==1970 // 40 hr
replace hrswork = 44.5 	if hrswork2 == 6 & year ==1970 // 41-48 hr
replace hrswork = 54 	if hrswork2 == 7 & year ==1970 // 49-59 hr
replace hrswork = 60 	if hrswork2 == 8 & year ==1970 // 60

replace hrswork = uhrswork 	if year >1970 
replace hrswork = . 	if uhrswork == 0 & year >1970 

//Weeks worked - 1970 & 1980 have binned weeks worked
gen wkswork = . 		if wkswork2 == 0 & (year <=1980|year==2010) // NA
replace wkswork = 7 	if wkswork2 == 1 & (year <=1980|year==2010) // 1-13
replace wkswork = 20 	if wkswork2 == 2 & (year <=1980|year==2010) // 14-26
replace wkswork = 33 	if wkswork2 == 3 & (year <=1980|year==2010) // 27-39
replace wkswork = 43.5 	if wkswork2 == 4 & (year <=1980|year==2010) // 40-47
replace wkswork = 48.5 	if wkswork2 == 5 & (year <=1980|year==2010) // 48-49
replace wkswork = 51 	if wkswork2 == 6 & (year <=1980|year==2010) // 50-52

replace wkswork = wkswork1 	if year >1980 & year != 2010
replace wkswork = . 	if wkswork1 == 0 & year >1980 & year != 2010

//Hourly wage
gen hrly_wage = incwage/(wkswork*hrswork)




/******************************************
Hourly topcode- hourly wages cannot exceed topcode/50*35 
***************************************/
replace hrly_wage = (50000*1.5)/(50*35) if year==1970 & hrly_wage>=(50000*1.5)/(50*35) & hrly_wage !=.
replace hrly_wage = (75000*1.5)/(50*35) if year==1980 & hrly_wage>=(75000*1.5)/(50*35) & hrly_wage !=.
replace hrly_wage = (140000*1.5)/(50*35) if year==1990 & hrly_wage>=(140000*1.5)/(50*35) & hrly_wage !=.
replace hrly_wage = (175000*1.5)/(50*35) if year==2000 & hrly_wage>=(175000*1.5)/(50*35) & hrly_wage !=.
replace hrly_wage = (incwage_topcode_2010*1.5)/(50*35) /// 
		if year==2010 & hrly_wage>=(incwage_topcode_2010*1.5)/(50*35) & hrly_wage !=.

* Other indicators
gen sexname = "male" if sex==1
replace sexname = "fem"  if sex==2

keep sample serial pernum perwt year age incwage hrswork sexname educ race statefip self_emp hrly_wage


compress
saveold "$data/census7010_clean.dta" , replace
cd $data
!gzip "$data/census7010_clean.dta" 

cd $logs
log close



