clear all

global homedir ""  // please input your working directory here
global logs "$homedir/logs"
global data "$homedir/data"
global raw "$homedir/raw"

cap log close
log using "$logs/0censuscounts.log", replace

!gunzip "$data/census7010_clean.dta"
use "$data/census7010_clean.dta", clear
!gzip "$data/census7010_clean.dta"

keep if age>=18 & age<=64 

replace educ = "scol" if educ =="col"
replace educ = "lths" if educ == "hs"

//Hourly wage by education*race*state*sex
keep if incwage>0 & hrswork>0 & incwage !=. & hrswork !=.
keep if sexname !="" & educ !="" & race !="" & statefip !=.

drop if self_emp==1 // self employed 

//suggested weight from Autor et al
gen hourswt = perwt*hrswork
gen lnhrly_wage = ln(hrly_wage)
gen lnincwage = ln(incwage)

collapse (mean) lnhrly_wage hrly_wage [pweight=hourswt], by(educ year race sexname statefip) 
reshape wide lnhrly_wage hrly_wage, i(educ year race statefip) j(sexname, string)
saveold "$data/census_actualwage", replace




