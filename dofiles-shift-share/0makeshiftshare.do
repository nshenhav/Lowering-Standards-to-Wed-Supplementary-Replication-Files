
** NEED TO SET THIS TO RUN CODE
global shiftshare_data

clear all

set more off, perm

set matsize 10000
set maxvar 30000

cap log close
log using "$dofiles/0makeshiftshare.log", replace


/******************************************************************************************************************
Step 1. Convert saved employment shares in each industry for education-race-gender-state cells into a saved vector
*****************************************************************************************************************/
	
matrix drop _all	

use "$shiftshare_data/indshare_bymkt_1970.dta", clear
		
sort ind_simp

foreach e in lths scol {
foreach r in wht blk hisp oth{
foreach g in male fem {
foreach s of numlist 1/2 4/6 8/13 15/42 44/51 53/56{
	qui replace share`s'`g'`r'`e' =0 if share`s'`g'`r'`e'==.
	mkmat share`s'`g'`r'`e', matrix(share`s'`g'`r'`e') //SHARE IN INDUSTRY
}
}
}
}

/*****************************************************************
Step 2. Calculate occupation shares by industry in 1970
*****************************************************************/

use $shiftshare_data/census70_forss.dta, clear

keep if age>=18 & age<=64 & incwage>0 & hrswork>0 & incwage !=. & hrswork !=. & ind_simp !=. & occly_simp !=. // keep workers 18-64

tab occly_simp
local maxocc = r(r)

foreach s of numlist 0 1/2 4/6 8/13 15/42 44/51 53/56 {  // need to do separately for each state because need to exclude that state from wages. NOTE: 0 includes ALL states

	preserve
	
	keep if statefip != `s'

	collapse (count) emp = incwage [pweight = perwt], by(occly_simp ind_simp) // workers by occupation and industry

	bysort ind_simp: egen totind = total(emp) // total workers by industry
	egen natlemp1970 = total(emp) // total workers
	bysort occly_simp: egen totocc = total(emp) // total workers by occupation

	gen  share1970_`s' = totocc/natlemp1970 // occupation share of all employment in 1970
	replace share1970_`s' = 0 if share1970_`s' ==.

	gen shareind1970_`s' = emp/totind // occupation share of each industry in 1970
	replace shareind1970_`s' = 0 if shareind1970_`s' ==.

	gen shareindrelnatl1970_`s' = shareind1970_`s'/share1970_`s' // occupation share of industry relative to in all employment
	replace shareindrelnatl1970_`s' = 0 if shareindrelnatl1970_`s' ==. 

	keep share* ind_simp occly_simp tot* natl* emp*
	
	** Reshape data so have one column of industry shares for each occupation (each row is an industry and each variable is the employment/shares of each occupation in the industry)
	reshape wide share* tot* natl* emp*, i(occly_simp) j(ind_simp)

	sort occly_simp

	** Save vector of shares
	forvalues i= 1/17 {
	
		qui replace shareindrelnatl1970_`s'`i' = 0 if shareindrelnatl1970_`s'`i'==.
		mkmat  shareindrelnatl1970_`s'`i', matrix(share1970occind_`s'_`i') // (E_oj, 1970/E_j, 1970)/ (E_o, 1970/E_1970)  [(share of industry in occupation)/ (share of total employment in occupation) in 1970]

	}


	restore

}


/******************************************************************************************************
STEP 3. ESTIMATE SHARE IN EACH INDUSTRY-OCCUPATION USING NATIONAL SHARES IN EACH OCCUPATION
******************************************************************************************************/

preserve

	keep if occly_simp ! = . & ind_simp !=. // drop unemployed and unknown occupation/industry

	collapse (count) emp = age [pweight=perwt], by(educ race sexname occly_simp ind_simp) 
		
	bysort sex race educ ind_simp: egen pop_bysexraceedind = total(emp) // employment by race-education-sex-industry

	rename emp totworkers_bysexraceed
	gen share = totworkers_bysexraceed/pop_bysexraceedind // share of workers in each race-education-sex-industry employed in each occupation
	
	** Reshape data so have one column of occupation shares by industry for each group
	keep share* educ race sexname occly_simp ind_simp // 
	qui reshape wide share*, i(educ race occly_simp  ind_simp) j(sexname, string)	
	qui reshape wide share*, i(educ occly_simp  ind_simp) j(race, string)		
	qui reshape wide share*, i(occly_simp  ind_simp) j(educ, string)

	qui reshape wide share*, i(occly_simp) j(ind_simp)	

	sort occly_simp 

	** Save vector of shares
	forvalues j = 1/17 {
	foreach g in fem male {
	foreach r in wht blk hisp oth{
	foreach e in scol lths {
		qui replace  share`g'`r'`e'`j'=0 if  share`g'`r'`e'`j'==. 
		mkmat share`g'`r'`e'`j', matrix(shareocc`g'`r'`e'`j') //share of demographic group in industry/occupation cell

		}
		}
		}
		}


restore		


/******************************************************************************************************
STEP 4. CALCULATE WAGES IN CPS
******************************************************************************************************/

use $shiftshare_data/cps_forss.dta, clear
cap drop _m


// Full time workers, 18-64, not self-employed
keep if age>=18 & age<=64 & newhrwage>0 & tothours>0 & newhrwage!=. & tothours !=. & incwage>0 // workers 18-64
drop if classwkr == 10| classwkr == 13|classwkr == 14 // drop self employed 

//suggested weight for average wages from Autor, Katz, and Kearney (2008)
gen hourswt = wtsupp*(tothours/wkswork1)

gen lnnewhrwage = ln(newhrwage) // follow Diamond (2016) and take average of log wage 
			
keep if ind_simp != . & occly_simp != .

/***********************************************************************************************************
STEP 5. CALCULATE ANNUAL SHOCKS TO EMPLOYMENT SHARES FOR UPDATING 
************************************************************************************************************/
		
foreach s of numlist 0 1/2 4/6 8/13 15/42 44/51 53/56 {  // need to do separately for each state because need to exclude that state from wages - NOTE: 0 includes ALL states purely to look at national shares

	preserve
	
		keep if statefip !=`s'
		collapse (count) emp = lnnewhrwage [pweight=wtsupp], by(occly_simp ind_simp year) 

		qui reshape wide emp*, i(occly_simp ind_simp) j(year)
		
		foreach y of numlist 1976/2011 { 

			egen tot_emp`y' = total(emp`y') // total US employment
			qui bysort ind_simp: egen ind_emp`y' = total(emp`y') // employment by industry			
			qui bysort occly_simp: egen occ_emp`y' = total(emp`y') // employment by occupation 
			
			qui gen natoccshare`y' = occ_emp`y'/tot_emp`y' //share of all employment in occupation

			qui gen shareind`y' = emp`y'/ind_emp`y' //share of industry in occupation
			qui replace shareind`y' = 0 if shareind`y' ==.

			qui gen shareindrelnatl`y' = shareind`y'/natoccshare`y' // (E_ojt/E_jt)/ (E_ot/E_t)  [(share of industry in occupation)/ (share of total employment in occupation) in each year]
			qui replace shareindrelnatl`y' = 0 if shareindrelnatl`y' ==.
		}

		
			** Reshape data so each column is the shocks to the shares in one occupation, and the rows are industries
			keep share* ind_simp occly_simp natocc* emp* ind_emp* tot* occ_emp*
			qui reshape wide share* natocc* emp* ind_emp* tot* occ_emp*, i(occly_simp) j(ind_simp)
			
			sort occly_simp
			
			forvalues y = 1976/2011 { 
			forvalues i = 1/17 {
			
				mkmat  shareindrelnatl`y'`i', matrix(shareind`y'`i'_`s')
			
				
			}
			}					
				
	restore	
}
		

/***********************************************************************************************************
STEP 6. CALCULATE ANNUAL WAGES BY OCCUPATION AND INDUSTRY OUTSIDE OF THE STATE
************************************************************************************************************/

//take turns leaving each state out
foreach s of numlist 0 1/2 4/6 8/13 15/42 44/51 53/56  {  // need to do separately for each state because need to exclude that state from wages. Add in state "0" for the rotemberg weights when we want to keep all states

	preserve
		qui gen wagetemp = lnnewhrwage if statefip != `s'
		
		collapse (mean) wagetemp [pweight=hourswt], by(ind_simp occly_simp year) 
		
		reshape wide wagetemp , i(occly_simp year) j(ind_simp)
		reshape long wagetemp, i(occly_simp year) j(ind_simp)

		** Reshape so each column is a year of wages by occupation and industry
		qui reshape wide wagetemp* , i(ind_simp occly_simp) j(year)
		sort ind_simp occly_simp

		
		foreach y of numlist 1976/2011 { 	
			qui replace wagetemp`y'=0 if wagetemp`y'==.
			sort ind_simp occly_simp
			mkmat wagetemp`y', matrix(wage`y'`s')

		}
		
		qui drop wagetemp*
	restore

}


/***********************************************************************************************************
STEP 7. ESTIMATE EMPLOYMENT SHARES USING UPDATING
************************************************************************************************************/

qui tab ind_simp
local maxind = r(r)
local maxindocc = `maxocc'*`maxind'

foreach e in lths scol {
foreach r in wht blk hisp /*oth*/{
foreach g in fem male{
foreach y of numlist 1976/2011 {
foreach s of numlist 1/2 4/6 8/13 15/42 44/51 53/56 {	

	matrix share`y'`s'`g'`r'`e'  = J(`maxindocc',1,0) // vector of 0's to be filled in	
	matrix sharetot`y'`s'`g'`r'`e'  = J(`maxindocc',1,0) // vector of 0's to be filled in
	
	** First, calculate occupation share for each year and industry:
	
	** Here "group" refers to education-race-sex cells
	** = (excess share of occupation in industry in t)*(excess share of occupation in industry in 1970)*(1970 natl. share of group in occupation)*(1970 share of group-state in industry)
	** = (shock to occupation in industry)*(1970 natl. share of group in occupation)*(1970 share of group-state in industry)
	** = (shock to occupation in industry)*1970 share in occupation and industry
	
	** Note: shock to occupation = [(E_ojt/E_jt)/(E_ot/E_t)]/[(E_oj,1970/E_j,1970)/(E_o,1970/E_1970)]
	**							 =  [(E_ojt/E_jt)/(E_ot/E_t)]*[(E_o,1970/E_1970)/(E_oj,1970/E_j,1970)]
	**							 = [(E_ojt/E_jt)/(E_oj,1970/E_j,1970)]*[(E_o,1970/E_1970)/(E_ot/E_t)]
	**							= [(E_ojt/E_jt)/(E_oj,1970/E_j,1970)]/[(E_ot/E_t)/(E_o,1970/E_1970)] // this is the updating term in the paper

	forvalues j = 1/17 {		
		matrix sharetmp`y'`s'`g'`r'`e'`j'  = J(`maxocc',1,0) // vector of 0's to be filled in
		
		forvalues i = 1/`maxocc' {		
			matrix sharetmp`y'`s'`g'`r'`e'`j'[`i',1] =  (shareind`y'`j'_`s'[`i',1]/share1970occind_`s'_`j'[`i',1])*shareocc`g'`r'`e'`j'[`i',1]*share`s'`g'`r'`e'[`j',1]
			
			if sharetmp`y'`s'`g'`r'`e'`j'[`i',1] == . {
				matrix sharetmp`y'`s'`g'`r'`e'`j'[`i',1] = 0
			}		
		}
	}

	** Then, stack industries
	matrix sharetmp`y'`s'`g'`r'`e' = sharetmp`y'`s'`g'`r'`e'1
	
	forvalues j = 2/17 {
		matrix sharetmp`y'`s'`g'`r'`e' = sharetmp`y'`s'`g'`r'`e'\sharetmp`y'`s'`g'`r'`e'`j'
	}
	
	
	** Then, normalize so shares sum to 1
	
	* Add up total temp shares

	forvalues j = 1/`maxindocc' {
			matrix sharetot`y'`s'`g'`r'`e'[1,1] = sharetot`y'`s'`g'`r'`e'[1,1] + sharetmp`y'`s'`g'`r'`e'[`j',1]
	}
			
	* Divide by total to normalize
	forvalues i = 1/`maxindocc' {
		matrix share`y'`s'`g'`r'`e'[`i',1] = sharetmp`y'`s'`g'`r'`e'[`i',1]/sharetot`y'`s'`g'`r'`e'[1,1]

		if share`y'`s'`g'`r'`e'[`i',1] == . {
			matrix share`y'`s'`g'`r'`e'[`i',1] = 0
		}	
	}
		

}
}
}
}
}

/***********************************************************************************************************
STEP 8. CREATE PREDICTED WAGE FOR EACH GROUP (AVERAGING OVER INDUSTRIES)
************************************************************************************************************/

** Multiply occupation-industry share by occupation-industry wage, then sum up

foreach e in lths scol {
foreach r in wht blk hisp /*oth*/{
foreach g in fem male{
foreach y of numlist 1976/2011 {
foreach s of numlist 1/2 4/6 8/13 15/42 44/51 53/56 {

	if `y' ==1976 matrix w`g'`y'`s'`r'`e' = [`s',share`y'`s'`g'`r'`e''*wage`y'`s'] // shift-share wage for year y, state s, gender g, race r, educ e
	if `y' >1976 matrix w`g'`y'`s'`r'`e' = [share`y'`s'`g'`r'`e''*wage`y'`s'] // shift-share wage for year y, state s, gender g, race r, educ e
	if `s'==1 matrix y`g'`y'`r'`e' = w`g'`y'`s'`r'`e'
	if `s'>1 matrix y`g'`y'`r'`e' = y`g'`y'`r'`e'\w`g'`y'`s'`r'`e'				// stack the shift shares for each state for the same year and race and gender
	if `s'==56 & `y'==1976 matrix z`g'`r'`e' = y`g'`y'`r'`e' //final matrix
	if `s'==56 & `y'>1976 matrix z`g'`r'`e' = z`g'`r'`e', y`g'`y'`r'`e' // join the various years of shift share wages


}
}
}
}
}

** Save shares to a dataset

clear
foreach e in lths scol {
foreach r in wht blk hisp /*oth*/{
foreach g in fem male{
svmat z`g'`r'`e', names(matcol)
*desc
rename z`g'`r'`e'wagetemp* `g'`r'`e'*


}
}
}

rename zfemwhtlthsc1 fipstate
drop z*

foreach x of numlist 1976/2011{
	rename *`x'* *`x'
}

** Reshape data so each row is a marriage market-year (education-race-state-year)

reshape long femblklths femblkscol maleblklths maleblkscol femwhtlths femwhtscol malewhtlths malewhtscol femhisplths femhispscol malehisplths malehispscol , i(fipstate) j(year)
reshape long femblk maleblk femwht malewht femhisp malehisp , i(fipstate year) j(educ, string)
reshape long fem male, i(fipstate year educ) j(race, string)

saveold "$shiftshare_data/shiftshares.dta", replace

drop if fipstate ==11 //DC

replace fem = . if fem == 0
replace male = . if male == 0
gen relwage = fem - male

rename (male fem relwage) (lncpsmaleshiftwage lncpsfemshiftwage lncpsshiftrelwage)

saveold "$shiftshare_data/shiftshares.dta", replace


/*
For merging to Census wages, keep only decadal wages that line up with Census. 
Prior to 2000, census income corresponded to prior year income (i.e. 1979 in 1980 census), while after 2000 it corresponded to income over the prior 12 months 
*/
use "$shiftshare_data/shiftshares.dta"
keep if year==1979| year==1989|year==1999|year==2010
replace year = year+ 1 if year<=1999
keep if lncpsshiftrelwage !=.
saveold "$shiftshare_data/shiftshares_foranalysis.dta", replace



log close
