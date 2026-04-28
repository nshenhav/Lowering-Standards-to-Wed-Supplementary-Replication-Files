global homedir ""  // please input your working directory here
global raw "$homedir/raw"
global data "$homedir/data"
global logs "$homedir/logs"

cap log close
log using "$logs/import_1970_2010_census.log" , replace

cd "$raw"
!gunzip usa_00113.dat.gz

set more off

clear
quietly infix                   ///
  int     year         1-4      ///
  long    sample       5-10     ///
  double  serial       11-18    ///
  double  cbserial     19-31    ///
  double  hhwt         32-41    ///
  byte    statefip     42-43    ///
  int     countyicp    44-47    ///
  int     cntygp98     48-50    ///
  long    puma         51-55    ///
  byte    gq           56-56    ///
  byte    gqtype       57-57    ///
  int     gqtyped      58-60    ///
  byte    ownershp     61-61    ///
  byte    ownershpd    62-63    ///
  long    hhincome     64-70    ///
  byte    foodstmp     71-71    ///
  int     pernum       72-75    ///
  double  perwt        76-85    ///
  byte    famunit      86-87    ///
  byte    famsize      88-89    ///
  byte    subfam       90-90    ///
  byte    sftype       91-91    ///
  byte    sfrelate     92-92    ///
  byte    momloc       93-94    ///
  byte    poploc       95-96    ///
  byte    sploc        97-98    ///
  byte    nchild       99-99    ///
  byte    nsibs        100-100  ///
  byte    eldch        101-102  ///
  byte    yngch        103-104  ///
  byte    relate       105-106  ///
  int     related      107-110  ///
  byte    sex          111-111  ///
  int     age          112-114  ///
  byte    marst        115-115  ///
  int     birthyr      116-119  ///
  byte    marrno       120-120  ///
  byte    fertyr       121-121  ///
  byte    race         122-122  ///
  int     raced        123-125  ///
  byte    hispan       126-126  ///
  int     hispand      127-129  ///
  int     bpl          130-132  ///
  long    bpld         133-137  ///
  int     yrimmig      138-141  ///
  byte    hisp1970     142-142  ///
  byte    racesing     143-143  ///
  byte    racesingd    144-145  ///
  byte    school       146-146  ///
  byte    educ         147-148  ///
  int     educd        149-151  ///
  byte    gradeatt     152-152  ///
  byte    gradeattd    153-154  ///
  byte    empstat      155-155  ///
  byte    empstatd     156-157  ///
  byte    labforce     158-158  ///
  int     occ          159-162  ///
  int     occ1950      163-165  ///
  int     occ1990      166-168  ///
  int     ind          169-172  ///
  int     ind1950      173-175  ///
  byte    classwkr     176-176  ///
  byte    classwkrd    177-178  ///
  byte    wkswork1     179-180  ///
  byte    wkswork2     181-181  ///
  byte    hrswork2     182-182  ///
  byte    uhrswork     183-184  ///
  long    inctot       185-191  ///
  long    ftotinc      192-198  ///
  long    incwage      199-204  ///
  long    incss        205-209  ///
  long    incwelfr     210-214  ///
  long    incsupp      215-219  ///
  int     poverty      220-222  ///
  byte    migrate5     223-223  ///
  byte    migrate5d    224-225  ///
  byte    migrate1     226-226  ///
  byte    migrate1d    227-228  ///
  int     migplac5     229-231  ///
  int     migplac1     232-234  ///
  byte    disabwrk     235-235  ///
  byte    vetstat      236-236  ///
  byte    vetstatd     237-238  ///
  byte    qage         239-239  ///
  byte    qsex         240-240  ///
  byte    qhispan      241-241  ///
  byte    qhisp97      242-242  ///
  byte    qrace        243-243  ///
  byte    qrace2       244-244  ///
  byte    qeduc        245-245  ///
  byte    qclasswk     246-246  ///
  byte    qempstat     247-247  ///
  byte    qhrswork     248-248  ///
  byte    quhrswor     249-249  ///
  byte    qwkswork     250-250  ///
  byte    qincwage     251-251  ///
  byte    sex_sp       252-252  ///
  int     age_sp       253-255  ///
  byte    race_mom     256-256  ///
  int     raced_mom    257-259  ///
  byte    hispan_mom   260-260  ///
  int     hispand_mom  261-263  ///
  byte    educ_mom     264-265  ///
  byte    educ_sp      266-267  ///
  int     educd_mom    268-270  ///
  int     educd_sp     271-273  ///
  byte    empstat_sp   274-274  ///
  byte    wkswork1_sp  275-276  ///
  byte    wkswork2_sp  277-277  ///
  byte    hrswork2_sp  278-278  ///
  byte    uhrswork_sp  279-280  ///
  long    incwage_sp   281-286  ///
  using "$raw/usa_00113.dat"

replace hhwt        = hhwt        / 100
replace perwt       = perwt       / 100

format serial      %8.0g
format cbserial    %13.0g
format hhwt        %10.2f
format perwt       %10.2f

label var year        `"Census year"'
label var sample      `"IPUMS sample identifier"'
label var serial      `"Household serial number"'
label var cbserial    `"Original Census Bureau household serial number"'
label var hhwt        `"Household weight"'
label var statefip    `"State (FIPS code)"'
label var countyicp   `"County (ICPSR code)"'
label var cntygp98    `"County group, 1980"'
label var puma        `"Public Use Microdata Area"'
label var gq          `"Group quarters status"'
label var gqtype      `"Group quarters type [general version]"'
label var gqtyped     `"Group quarters type [detailed version]"'
label var ownershp    `"Ownership of dwelling (tenure) [general version]"'
label var ownershpd   `"Ownership of dwelling (tenure) [detailed version]"'
label var hhincome    `"Total household income"'
label var foodstmp    `"Food stamp recipiency"'
label var pernum      `"Person number in sample unit"'
label var perwt       `"Person weight"'
label var famunit     `"Family unit membership"'
label var famsize     `"Number of own family members in household"'
label var subfam      `"Subfamily membership"'
label var sftype      `"Subfamily type"'
label var sfrelate    `"Relationship within subfamily"'
label var momloc      `"Mother's location in the household"'
label var poploc      `"Father's location in the household"'
label var sploc       `"Spouse's location in household"'
label var nchild      `"Number of own children in the household"'
label var nsibs       `"Number of own siblings in household"'
label var eldch       `"Age of eldest own child in household"'
label var yngch       `"Age of youngest own child in household"'
label var relate      `"Relationship to household head [general version]"'
label var related     `"Relationship to household head [detailed version]"'
label var sex         `"Sex"'
label var age         `"Age"'
label var marst       `"Marital status"'
label var birthyr     `"Year of birth"'
label var marrno      `"Times married"'
label var fertyr      `"Children born within the last year"'
label var race        `"Race [general version]"'
label var raced       `"Race [detailed version]"'
label var hispan      `"Hispanic origin [general version]"'
label var hispand     `"Hispanic origin [detailed version]"'
label var bpl         `"Birthplace [general version]"'
label var bpld        `"Birthplace [detailed version]"'
label var yrimmig     `"Year of immigration"'
label var hisp1970    `"Hispanic origin, 1970 alternate version"'
label var racesing    `"Race: Single race identification [general version]"'
label var racesingd   `"Race: Single race identification [detailed version]"'
label var school      `"School attendance"'
label var educ        `"Educational attainment [general version]"'
label var educd       `"Educational attainment [detailed version]"'
label var gradeatt    `"Grade level attending [general version]"'
label var gradeattd   `"Grade level attending [detailed version]"'
label var empstat     `"Employment status [general version]"'
label var empstatd    `"Employment status [detailed version]"'
label var labforce    `"Labor force status"'
label var occ         `"Occupation"'
label var occ1950     `"Occupation, 1950 basis"'
label var occ1990     `"Occupation, 1990 basis"'
label var ind         `"Industry"'
label var ind1950     `"Industry, 1950 basis"'
label var classwkr    `"Class of worker [general version]"'
label var classwkrd   `"Class of worker [detailed version]"'
label var wkswork1    `"Weeks worked last year"'
label var wkswork2    `"Weeks worked last year, intervalled"'
label var hrswork2    `"Hours worked last week, intervalled"'
label var uhrswork    `"Usual hours worked per week"'
label var inctot      `"Total personal income"'
label var ftotinc     `"Total family income"'
label var incwage     `"Wage and salary income"'
label var incss       `"Social Security income"'
label var incwelfr    `"Welfare (public assistance) income"'
label var incsupp     `"Supplementary Security Income"'
label var poverty     `"Poverty status"'
label var migrate5    `"Migration status, 5 years [general version]"'
label var migrate5d   `"Migration status, 5 years [detailed version]"'
label var migrate1    `"Migration status, 1 year [general version]"'
label var migrate1d   `"Migration status, 1 year [detailed version]"'
label var migplac5    `"State or country of residence 5 years ago"'
label var migplac1    `"State or country of residence 1 year ago"'
label var disabwrk    `"Work disability"'
label var vetstat     `"Veteran status [general version]"'
label var vetstatd    `"Veteran status [detailed version]"'
label var qage        `"Flag for Age"'
label var qsex        `"Flag for Sex"'
label var qhispan     `"Flag for Hispan"'
label var qhisp97     `"Flag for Hisp1970"'
label var qrace       `"Flag for Race, Racamind, Racasian, Racblk, Racpais, Racwht, Racoth, Racnum, Race"'
label var qrace2      `"Flag for Race"'
label var qeduc       `"Flag for Educrec, Higrade, Educ99"'
label var qclasswk    `"Flag for Classwkr"'
label var qempstat    `"Flag for Empstat, Labforce"'
label var qhrswork    `"Flag for Hrswork1 Hrswork2"'
label var quhrswor    `"Flag for Uhrswork"'
label var qwkswork    `"Flag for Wkswork1, Wkswork2"'
label var qincwage    `"Flag for Incwage, Inctot, Incearn"'
label var sex_sp      `"Sex [of spouse]"'
label var age_sp      `"Age [of spouse]"'
label var race_mom    `"Race [of mother; general version]"'
label var raced_mom   `"Race [of mother; detailed version]"'
label var hispan_mom  `"Hispanic origin [of mother; general version]"'
label var hispand_mom `"Hispanic origin [of mother; detailed version]"'
label var educ_mom    `"Educational attainment [of mother; general version]"'
label var educ_sp     `"Educational attainment [of spouse; general version]"'
label var educd_mom   `"Educational attainment [of mother; detailed version]"'
label var educd_sp    `"Educational attainment [of spouse; detailed version]"'
label var empstat_sp  `"Employment status [of spouse; general version]"'
label var wkswork1_sp `"Weeks worked last year [of spouse]"'
label var wkswork2_sp `"Weeks worked last year, intervalled [of spouse]"'
label var hrswork2_sp `"Hours worked last week, intervalled [of spouse]"'
label var uhrswork_sp `"Usual hours worked per week [of spouse]"'
label var incwage_sp  `"Wage and salary income [of spouse]"'

label define year_lbl 1850 `"1850"'
label define year_lbl 1860 `"1860"', add
label define year_lbl 1870 `"1870"', add
label define year_lbl 1880 `"1880"', add
label define year_lbl 1900 `"1900"', add
label define year_lbl 1910 `"1910"', add
label define year_lbl 1920 `"1920"', add
label define year_lbl 1930 `"1930"', add
label define year_lbl 1940 `"1940"', add
label define year_lbl 1950 `"1950"', add
label define year_lbl 1960 `"1960"', add
label define year_lbl 1970 `"1970"', add
label define year_lbl 1980 `"1980"', add
label define year_lbl 1990 `"1990"', add
label define year_lbl 2000 `"2000"', add
label define year_lbl 2001 `"2001"', add
label define year_lbl 2002 `"2002"', add
label define year_lbl 2003 `"2003"', add
label define year_lbl 2004 `"2004"', add
label define year_lbl 2005 `"2005"', add
label define year_lbl 2006 `"2006"', add
label define year_lbl 2007 `"2007"', add
label define year_lbl 2008 `"2008"', add
label define year_lbl 2009 `"2009"', add
label define year_lbl 2010 `"2010"', add
label define year_lbl 2011 `"2011"', add
label define year_lbl 2012 `"2012"', add
label define year_lbl 2013 `"2013"', add
label define year_lbl 2014 `"2014"', add
label define year_lbl 2015 `"2015"', add
label define year_lbl 2016 `"2016"', add
label define year_lbl 2017 `"2017"', add
label values year year_lbl

label define sample_lbl 201704 `"2013-2017, PRCS 5-year"'
label define sample_lbl 201703 `"2013-2017, ACS 5-year"', add
label define sample_lbl 201702 `"2017 PRCS"', add
label define sample_lbl 201701 `"2017 ACS"', add
label define sample_lbl 201604 `"2012-2016, PRCS 5-year"', add
label define sample_lbl 201603 `"2012-2016, ACS 5-year"', add
label define sample_lbl 201602 `"2016 PRCS"', add
label define sample_lbl 201601 `"2016 ACS"', add
label define sample_lbl 201504 `"2011-2015, PRCS 5-year"', add
label define sample_lbl 201503 `"2011-2015, ACS 5-year"', add
label define sample_lbl 201502 `"2015 PRCS"', add
label define sample_lbl 201501 `"2015 ACS"', add
label define sample_lbl 201404 `"2010-2014, PRCS 5-year"', add
label define sample_lbl 201403 `"2010-2014, ACS 5-year"', add
label define sample_lbl 201402 `"2014 PRCS"', add
label define sample_lbl 201401 `"2014 ACS"', add
label define sample_lbl 201306 `"2009-2013, PRCS 5-year"', add
label define sample_lbl 201305 `"2009-2013, ACS 5-year"', add
label define sample_lbl 201304 `"2011-2013, PRCS 3-year"', add
label define sample_lbl 201303 `"2011-2013, ACS 3-year"', add
label define sample_lbl 201302 `"2013 PRCS"', add
label define sample_lbl 201301 `"2013 ACS"', add
label define sample_lbl 201206 `"2008-2012, PRCS 5-year"', add
label define sample_lbl 201205 `"2008-2012, ACS 5-year"', add
label define sample_lbl 201204 `"2010-2012, PRCS 3-year"', add
label define sample_lbl 201203 `"2010-2012, ACS 3-year"', add
label define sample_lbl 201202 `"2012 PRCS"', add
label define sample_lbl 201201 `"2012 ACS"', add
label define sample_lbl 201106 `"2007-2011, PRCS 5-year"', add
label define sample_lbl 201105 `"2007-2011, ACS 5-year"', add
label define sample_lbl 201104 `"2009-2011, PRCS 3-year"', add
label define sample_lbl 201103 `"2009-2011, ACS 3-year"', add
label define sample_lbl 201102 `"2011 PRCS"', add
label define sample_lbl 201101 `"2011 ACS"', add
label define sample_lbl 201008 `"2010 Puerto Rico 10%"', add
label define sample_lbl 201007 `"2010 10%"', add
label define sample_lbl 201006 `"2006-2010, PRCS 5-year"', add
label define sample_lbl 201005 `"2006-2010, ACS 5-year"', add
label define sample_lbl 201004 `"2008-2010, PRCS 3-year"', add
label define sample_lbl 201003 `"2008-2010, ACS 3-year"', add
label define sample_lbl 201002 `"2010 PRCS"', add
label define sample_lbl 201001 `"2010 ACS"', add
label define sample_lbl 200906 `"2005-2009, PRCS 5-year"', add
label define sample_lbl 200905 `"2005-2009, ACS 5-year"', add
label define sample_lbl 200904 `"2007-2009, PRCS 3-year"', add
label define sample_lbl 200903 `"2007-2009, ACS 3-year"', add
label define sample_lbl 200902 `"2009 PRCS"', add
label define sample_lbl 200901 `"2009 ACS"', add
label define sample_lbl 200804 `"2006-2008, PRCS 3-year"', add
label define sample_lbl 200803 `"2006-2008, ACS 3-year"', add
label define sample_lbl 200802 `"2008 PRCS"', add
label define sample_lbl 200801 `"2008 ACS"', add
label define sample_lbl 200704 `"2005-2007, PRCS 3-year"', add
label define sample_lbl 200703 `"2005-2007, ACS 3-year"', add
label define sample_lbl 200702 `"2007 PRCS"', add
label define sample_lbl 200701 `"2007 ACS"', add
label define sample_lbl 200602 `"2006 PRCS"', add
label define sample_lbl 200601 `"2006 ACS"', add
label define sample_lbl 200502 `"2005 PRCS"', add
label define sample_lbl 200501 `"2005 ACS"', add
label define sample_lbl 200401 `"2004 ACS"', add
label define sample_lbl 200301 `"2003 ACS"', add
label define sample_lbl 200201 `"2002 ACS"', add
label define sample_lbl 200101 `"2001 ACS"', add
label define sample_lbl 200008 `"2000 Puerto Rico 1%"', add
label define sample_lbl 200007 `"2000 1%"', add
label define sample_lbl 200006 `"2000 Puerto Rico 1% sample (old version)"', add
label define sample_lbl 200005 `"2000 Puerto Rico 5%"', add
label define sample_lbl 200004 `"2000 ACS"', add
label define sample_lbl 200003 `"2000 Unweighted 1%"', add
label define sample_lbl 200002 `"2000 1% sample (old version)"', add
label define sample_lbl 200001 `"2000 5%"', add
label define sample_lbl 199007 `"1990 Puerto Rico 1%"', add
label define sample_lbl 199006 `"1990 Puerto Rico 5%"', add
label define sample_lbl 199005 `"1990 Labor Market Area"', add
label define sample_lbl 199004 `"1990 Elderly"', add
label define sample_lbl 199003 `"1990 Unweighted 1%"', add
label define sample_lbl 199002 `"1990 1%"', add
label define sample_lbl 199001 `"1990 5%"', add
label define sample_lbl 198007 `"1980 Puerto Rico 1%"', add
label define sample_lbl 198006 `"1980 Puerto Rico 5%"', add
label define sample_lbl 198005 `"1980 Detailed metro/non-metro"', add
label define sample_lbl 198004 `"1980 Labor Market Area"', add
label define sample_lbl 198003 `"1980 Urban/Rural"', add
label define sample_lbl 198002 `"1980 1%"', add
label define sample_lbl 198001 `"1980 5%"', add
label define sample_lbl 197009 `"1970 Puerto Rico Neighborhood"', add
label define sample_lbl 197008 `"1970 Puerto Rico Municipio"', add
label define sample_lbl 197007 `"1970 Puerto Rico State"', add
label define sample_lbl 197006 `"1970 Form 2 Neighborhood"', add
label define sample_lbl 197005 `"1970 Form 1 Neighborhood"', add
label define sample_lbl 197004 `"1970 Form 2 Metro"', add
label define sample_lbl 197003 `"1970 Form 1 Metro"', add
label define sample_lbl 197002 `"1970 Form 2 State"', add
label define sample_lbl 197001 `"1970 Form 1 State"', add
label define sample_lbl 196002 `"1960 5%"', add
label define sample_lbl 196001 `"1960 1%"', add
label define sample_lbl 195001 `"1950 1%"', add
label define sample_lbl 194002 `"1940 100% database"', add
label define sample_lbl 194001 `"1940 1%"', add
label define sample_lbl 193004 `"1930 100% database"', add
label define sample_lbl 193003 `"1930 Puerto Rico"', add
label define sample_lbl 193002 `"1930 5%"', add
label define sample_lbl 193001 `"1930 1%"', add
label define sample_lbl 192003 `"1920 100% database"', add
label define sample_lbl 192002 `"1920 Puerto Rico sample"', add
label define sample_lbl 192001 `"1920 1%"', add
label define sample_lbl 191004 `"1910 100% database"', add
label define sample_lbl 191003 `"1910 1.4% sample with oversamples"', add
label define sample_lbl 191002 `"1910 1%"', add
label define sample_lbl 191001 `"1910 Puerto Rico"', add
label define sample_lbl 190004 `"1900 100% database"', add
label define sample_lbl 190003 `"1900 1% sample with oversamples"', add
label define sample_lbl 190002 `"1900 1%"', add
label define sample_lbl 190001 `"1900 5%"', add
label define sample_lbl 188003 `"1880 100% database"', add
label define sample_lbl 188002 `"1880 10%"', add
label define sample_lbl 188001 `"1880 1%"', add
label define sample_lbl 187003 `"1870 100% database"', add
label define sample_lbl 187002 `"1870 1% sample with black oversample"', add
label define sample_lbl 187001 `"1870 1%"', add
label define sample_lbl 186003 `"1860 100% database"', add
label define sample_lbl 186002 `"1860 1% sample with black oversample"', add
label define sample_lbl 186001 `"1860 1%"', add
label define sample_lbl 185002 `"1850 100% database"', add
label define sample_lbl 185001 `"1850 1%"', add
label values sample sample_lbl

label define statefip_lbl 01 `"Alabama"'
label define statefip_lbl 02 `"Alaska"', add
label define statefip_lbl 04 `"Arizona"', add
label define statefip_lbl 05 `"Arkansas"', add
label define statefip_lbl 06 `"California"', add
label define statefip_lbl 08 `"Colorado"', add
label define statefip_lbl 09 `"Connecticut"', add
label define statefip_lbl 10 `"Delaware"', add
label define statefip_lbl 11 `"District of Columbia"', add
label define statefip_lbl 12 `"Florida"', add
label define statefip_lbl 13 `"Georgia"', add
label define statefip_lbl 15 `"Hawaii"', add
label define statefip_lbl 16 `"Idaho"', add
label define statefip_lbl 17 `"Illinois"', add
label define statefip_lbl 18 `"Indiana"', add
label define statefip_lbl 19 `"Iowa"', add
label define statefip_lbl 20 `"Kansas"', add
label define statefip_lbl 21 `"Kentucky"', add
label define statefip_lbl 22 `"Louisiana"', add
label define statefip_lbl 23 `"Maine"', add
label define statefip_lbl 24 `"Maryland"', add
label define statefip_lbl 25 `"Massachusetts"', add
label define statefip_lbl 26 `"Michigan"', add
label define statefip_lbl 27 `"Minnesota"', add
label define statefip_lbl 28 `"Mississippi"', add
label define statefip_lbl 29 `"Missouri"', add
label define statefip_lbl 30 `"Montana"', add
label define statefip_lbl 31 `"Nebraska"', add
label define statefip_lbl 32 `"Nevada"', add
label define statefip_lbl 33 `"New Hampshire"', add
label define statefip_lbl 34 `"New Jersey"', add
label define statefip_lbl 35 `"New Mexico"', add
label define statefip_lbl 36 `"New York"', add
label define statefip_lbl 37 `"North Carolina"', add
label define statefip_lbl 38 `"North Dakota"', add
label define statefip_lbl 39 `"Ohio"', add
label define statefip_lbl 40 `"Oklahoma"', add
label define statefip_lbl 41 `"Oregon"', add
label define statefip_lbl 42 `"Pennsylvania"', add
label define statefip_lbl 44 `"Rhode Island"', add
label define statefip_lbl 45 `"South Carolina"', add
label define statefip_lbl 46 `"South Dakota"', add
label define statefip_lbl 47 `"Tennessee"', add
label define statefip_lbl 48 `"Texas"', add
label define statefip_lbl 49 `"Utah"', add
label define statefip_lbl 50 `"Vermont"', add
label define statefip_lbl 51 `"Virginia"', add
label define statefip_lbl 53 `"Washington"', add
label define statefip_lbl 54 `"West Virginia"', add
label define statefip_lbl 55 `"Wisconsin"', add
label define statefip_lbl 56 `"Wyoming"', add
label define statefip_lbl 61 `"Maine-New Hampshire-Vermont"', add
label define statefip_lbl 62 `"Massachusetts-Rhode Island"', add
label define statefip_lbl 63 `"Minnesota-Iowa-Missouri-Kansas-Nebraska-S.Dakota-N.Dakota"', add
label define statefip_lbl 64 `"Maryland-Delaware"', add
label define statefip_lbl 65 `"Montana-Idaho-Wyoming"', add
label define statefip_lbl 66 `"Utah-Nevada"', add
label define statefip_lbl 67 `"Arizona-New Mexico"', add
label define statefip_lbl 68 `"Alaska-Hawaii"', add
label define statefip_lbl 72 `"Puerto Rico"', add
label define statefip_lbl 97 `"Military/Mil. Reservation"', add
label define statefip_lbl 99 `"State not identified"', add
label values statefip statefip_lbl

label define gq_lbl 0 `"Vacant unit"'
label define gq_lbl 1 `"Households under 1970 definition"', add
label define gq_lbl 2 `"Additional households under 1990 definition"', add
label define gq_lbl 3 `"Group quarters--Institutions"', add
label define gq_lbl 4 `"Other group quarters"', add
label define gq_lbl 5 `"Additional households under 2000 definition"', add
label define gq_lbl 6 `"Fragment"', add
label values gq gq_lbl

label define gqtype_lbl 0 `"NA (non-group quarters households)"'
label define gqtype_lbl 1 `"Institution (1990, 2000, ACS/PRCS)"', add
label define gqtype_lbl 2 `"Correctional institutions"', add
label define gqtype_lbl 3 `"Mental institutions"', add
label define gqtype_lbl 4 `"Institutions for the elderly, handicapped, and poor"', add
label define gqtype_lbl 5 `"Non-institutional GQ"', add
label define gqtype_lbl 6 `"Military"', add
label define gqtype_lbl 7 `"College dormitory"', add
label define gqtype_lbl 8 `"Rooming house"', add
label define gqtype_lbl 9 `"Other non-institutional GQ and unknown"', add
label values gqtype gqtype_lbl

label define gqtyped_lbl 000 `"NA (non-group quarters households)"'
label define gqtyped_lbl 010 `"Family group, someone related to head"', add
label define gqtyped_lbl 020 `"Unrelated individuals, no one related to head"', add
label define gqtyped_lbl 100 `"Institution (1990, 2000, ACS/PRCS)"', add
label define gqtyped_lbl 200 `"Correctional institution"', add
label define gqtyped_lbl 210 `"Federal/state correctional"', add
label define gqtyped_lbl 211 `"Prison"', add
label define gqtyped_lbl 212 `"Penitentiary"', add
label define gqtyped_lbl 213 `"Military prison"', add
label define gqtyped_lbl 220 `"Local correctional"', add
label define gqtyped_lbl 221 `"Jail"', add
label define gqtyped_lbl 230 `"School juvenile delinquents"', add
label define gqtyped_lbl 240 `"Reformatory"', add
label define gqtyped_lbl 250 `"Camp or chain gang"', add
label define gqtyped_lbl 260 `"House of correction"', add
label define gqtyped_lbl 300 `"Mental institutions"', add
label define gqtyped_lbl 400 `"Institutions for the elderly, handicapped, and poor"', add
label define gqtyped_lbl 410 `"Homes for elderly"', add
label define gqtyped_lbl 411 `"Aged, dependent home"', add
label define gqtyped_lbl 412 `"Nursing/convalescent home"', add
label define gqtyped_lbl 413 `"Old soldiers' home"', add
label define gqtyped_lbl 420 `"Other Instits (Not Aged)"', add
label define gqtyped_lbl 421 `"Other Institution nec"', add
label define gqtyped_lbl 430 `"Homes neglected/depend children"', add
label define gqtyped_lbl 431 `"Orphan school"', add
label define gqtyped_lbl 432 `"Orphans' home, asylum"', add
label define gqtyped_lbl 440 `"Other instits for children"', add
label define gqtyped_lbl 441 `"Children's home, asylum"', add
label define gqtyped_lbl 450 `"Homes physically handicapped"', add
label define gqtyped_lbl 451 `"Deaf, blind school"', add
label define gqtyped_lbl 452 `"Deaf, blind, epilepsy"', add
label define gqtyped_lbl 460 `"Mentally handicapped home"', add
label define gqtyped_lbl 461 `"School for feeblemind"', add
label define gqtyped_lbl 470 `"TB and chronic disease hospital"', add
label define gqtyped_lbl 471 `"Chronic hospitals"', add
label define gqtyped_lbl 472 `"Sanatoria"', add
label define gqtyped_lbl 480 `"Poor houses and farms"', add
label define gqtyped_lbl 481 `"Poor house, almshouse"', add
label define gqtyped_lbl 482 `"Poor farm, workhouse"', add
label define gqtyped_lbl 491 `"Maternity homes for unmarried mothers"', add
label define gqtyped_lbl 492 `"Homes for widows, single, fallen women"', add
label define gqtyped_lbl 493 `"Detention homes"', add
label define gqtyped_lbl 494 `"Misc asylums"', add
label define gqtyped_lbl 495 `"Home, other dependent"', add
label define gqtyped_lbl 496 `"Institution combination or unknown"', add
label define gqtyped_lbl 500 `"Non-institutional group quarters"', add
label define gqtyped_lbl 501 `"Family formerly in institutional group quarters"', add
label define gqtyped_lbl 502 `"Unrelated individual residing with family formerly in institutional group quarters"', add
label define gqtyped_lbl 600 `"Military"', add
label define gqtyped_lbl 601 `"U.S. army installation"', add
label define gqtyped_lbl 602 `"Navy, marine installation"', add
label define gqtyped_lbl 603 `"Navy ships"', add
label define gqtyped_lbl 604 `"Air service"', add
label define gqtyped_lbl 700 `"College dormitory"', add
label define gqtyped_lbl 701 `"Military service academies"', add
label define gqtyped_lbl 800 `"Rooming house"', add
label define gqtyped_lbl 801 `"Hotel"', add
label define gqtyped_lbl 802 `"House, lodging apartments"', add
label define gqtyped_lbl 803 `"YMCA, YWCA"', add
label define gqtyped_lbl 804 `"Club"', add
label define gqtyped_lbl 900 `"Other Non-Instit GQ"', add
label define gqtyped_lbl 901 `"Other Non-Instit GQ"', add
label define gqtyped_lbl 910 `"Schools"', add
label define gqtyped_lbl 911 `"Boarding schools"', add
label define gqtyped_lbl 912 `"Academy, institute"', add
label define gqtyped_lbl 913 `"Industrial training"', add
label define gqtyped_lbl 914 `"Indian school"', add
label define gqtyped_lbl 920 `"Hospitals"', add
label define gqtyped_lbl 921 `"Hospital, charity"', add
label define gqtyped_lbl 922 `"Infirmary"', add
label define gqtyped_lbl 923 `"Maternity hospital"', add
label define gqtyped_lbl 924 `"Children's hospital"', add
label define gqtyped_lbl 931 `"Church, Abbey"', add
label define gqtyped_lbl 932 `"Convent"', add
label define gqtyped_lbl 933 `"Monastery"', add
label define gqtyped_lbl 934 `"Mission"', add
label define gqtyped_lbl 935 `"Seminary"', add
label define gqtyped_lbl 936 `"Religious commune"', add
label define gqtyped_lbl 937 `"Other religious"', add
label define gqtyped_lbl 940 `"Work sites"', add
label define gqtyped_lbl 941 `"Construction, except rr"', add
label define gqtyped_lbl 942 `"Lumber"', add
label define gqtyped_lbl 943 `"Mining"', add
label define gqtyped_lbl 944 `"Railroad"', add
label define gqtyped_lbl 945 `"Farms, ranches"', add
label define gqtyped_lbl 946 `"Ships, boats"', add
label define gqtyped_lbl 947 `"Other industrial"', add
label define gqtyped_lbl 948 `"Other worksites"', add
label define gqtyped_lbl 950 `"Nurses home, dorm"', add
label define gqtyped_lbl 955 `"Passenger ships"', add
label define gqtyped_lbl 960 `"Other group quarters"', add
label define gqtyped_lbl 997 `"Unknown"', add
label define gqtyped_lbl 999 `"Fragment (boarders and lodgers, 1900)"', add
label values gqtyped gqtyped_lbl

label define ownershp_lbl 0 `"N/A"'
label define ownershp_lbl 1 `"Owned or being bought (loan)"', add
label define ownershp_lbl 2 `"Rented"', add
label values ownershp ownershp_lbl

label define ownershpd_lbl 00 `"N/A"'
label define ownershpd_lbl 10 `"Owned or being bought"', add
label define ownershpd_lbl 11 `"Check mark (owns?)"', add
label define ownershpd_lbl 12 `"Owned free and clear"', add
label define ownershpd_lbl 13 `"Owned with mortgage or loan"', add
label define ownershpd_lbl 20 `"Rented"', add
label define ownershpd_lbl 21 `"No cash rent"', add
label define ownershpd_lbl 22 `"With cash rent"', add
label values ownershpd ownershpd_lbl

label define foodstmp_lbl 0 `"N/A"'
label define foodstmp_lbl 1 `"No"', add
label define foodstmp_lbl 2 `"Yes"', add
label values foodstmp foodstmp_lbl

label define famunit_lbl 01 `"1st family in household or group quarters"'
label define famunit_lbl 02 `"2nd family in household or group quarters"', add
label define famunit_lbl 03 `"3rd"', add
label define famunit_lbl 04 `"4th"', add
label define famunit_lbl 05 `"5th"', add
label define famunit_lbl 06 `"6th"', add
label define famunit_lbl 07 `"7th"', add
label define famunit_lbl 08 `"8th"', add
label define famunit_lbl 09 `"9th"', add
label define famunit_lbl 10 `"10th"', add
label define famunit_lbl 11 `"11th"', add
label define famunit_lbl 12 `"12th"', add
label define famunit_lbl 13 `"13th"', add
label define famunit_lbl 14 `"14th"', add
label define famunit_lbl 15 `"15th"', add
label define famunit_lbl 16 `"16th"', add
label define famunit_lbl 17 `"17th"', add
label define famunit_lbl 18 `"18th"', add
label define famunit_lbl 19 `"19th"', add
label define famunit_lbl 20 `"20th"', add
label define famunit_lbl 21 `"21th"', add
label define famunit_lbl 22 `"22th"', add
label define famunit_lbl 23 `"23th"', add
label define famunit_lbl 24 `"24th"', add
label define famunit_lbl 25 `"25th"', add
label define famunit_lbl 26 `"26th"', add
label define famunit_lbl 27 `"27th"', add
label define famunit_lbl 28 `"28th"', add
label define famunit_lbl 29 `"29th"', add
label define famunit_lbl 30 `"30th"', add
label values famunit famunit_lbl

label define famsize_lbl 01 `"1 family member present"'
label define famsize_lbl 02 `"2 family members present"', add
label define famsize_lbl 03 `"3"', add
label define famsize_lbl 04 `"4"', add
label define famsize_lbl 05 `"5"', add
label define famsize_lbl 06 `"6"', add
label define famsize_lbl 07 `"7"', add
label define famsize_lbl 08 `"8"', add
label define famsize_lbl 09 `"9"', add
label define famsize_lbl 10 `"10"', add
label define famsize_lbl 11 `"11"', add
label define famsize_lbl 12 `"12"', add
label define famsize_lbl 13 `"13"', add
label define famsize_lbl 14 `"14"', add
label define famsize_lbl 15 `"15"', add
label define famsize_lbl 16 `"16"', add
label define famsize_lbl 17 `"17"', add
label define famsize_lbl 18 `"18"', add
label define famsize_lbl 19 `"19"', add
label define famsize_lbl 20 `"20"', add
label define famsize_lbl 21 `"21"', add
label define famsize_lbl 22 `"22"', add
label define famsize_lbl 23 `"23"', add
label define famsize_lbl 24 `"24"', add
label define famsize_lbl 25 `"25"', add
label define famsize_lbl 26 `"26"', add
label define famsize_lbl 27 `"27"', add
label define famsize_lbl 28 `"28"', add
label define famsize_lbl 29 `"29"', add
label values famsize famsize_lbl

label define subfam_lbl 0 `"Group quarters or not in subfamily"'
label define subfam_lbl 1 `"1st subfamily in household"', add
label define subfam_lbl 2 `"2nd subfamily in household"', add
label define subfam_lbl 3 `"3rd"', add
label define subfam_lbl 4 `"4th"', add
label define subfam_lbl 5 `"5th"', add
label define subfam_lbl 6 `"6th"', add
label define subfam_lbl 7 `"7th"', add
label define subfam_lbl 8 `"8th"', add
label define subfam_lbl 9 `"9th"', add
label values subfam subfam_lbl

label define sftype_lbl 0 `"Group quarters or not in subfamily"'
label define sftype_lbl 1 `"Married-couple related subfamily with children"', add
label define sftype_lbl 2 `"Married-couple related subfamily without children"', add
label define sftype_lbl 3 `"Father-child related subfamily"', add
label define sftype_lbl 4 `"Mother-child related subfamily"', add
label define sftype_lbl 5 `"Married-couple unrelated subfamily with children"', add
label define sftype_lbl 6 `"Married-couple unrelated subfamily without children"', add
label define sftype_lbl 7 `"Father-child unrelated subfamily"', add
label define sftype_lbl 8 `"Mother-child unrelated subfamily"', add
label values sftype sftype_lbl

label define sfrelate_lbl 0 `"Group quarters or not in subfamily"'
label define sfrelate_lbl 1 `"Reference person"', add
label define sfrelate_lbl 2 `"Spouse (married-couple subfamily only)"', add
label define sfrelate_lbl 3 `"Child"', add
label values sfrelate sfrelate_lbl

label define nchild_lbl 0 `"0 children present"'
label define nchild_lbl 1 `"1 child present"', add
label define nchild_lbl 2 `"2"', add
label define nchild_lbl 3 `"3"', add
label define nchild_lbl 4 `"4"', add
label define nchild_lbl 5 `"5"', add
label define nchild_lbl 6 `"6"', add
label define nchild_lbl 7 `"7"', add
label define nchild_lbl 8 `"8"', add
label define nchild_lbl 9 `"9+"', add
label values nchild nchild_lbl

label define nsibs_lbl 0 `"0 siblings"'
label define nsibs_lbl 1 `"1 sibling"', add
label define nsibs_lbl 2 `"2 siblings"', add
label define nsibs_lbl 3 `"3 siblings"', add
label define nsibs_lbl 4 `"4 siblings"', add
label define nsibs_lbl 5 `"5 siblings"', add
label define nsibs_lbl 6 `"6 siblings"', add
label define nsibs_lbl 7 `"7 siblings"', add
label define nsibs_lbl 8 `"8 siblings"', add
label define nsibs_lbl 9 `"9 or more siblings"', add
label values nsibs nsibs_lbl

label define eldch_lbl 00 `"Less than 1 year old"'
label define eldch_lbl 01 `"1"', add
label define eldch_lbl 02 `"2"', add
label define eldch_lbl 03 `"3"', add
label define eldch_lbl 04 `"4"', add
label define eldch_lbl 05 `"5"', add
label define eldch_lbl 06 `"6"', add
label define eldch_lbl 07 `"7"', add
label define eldch_lbl 08 `"8"', add
label define eldch_lbl 09 `"9"', add
label define eldch_lbl 10 `"10"', add
label define eldch_lbl 11 `"11"', add
label define eldch_lbl 12 `"12"', add
label define eldch_lbl 13 `"13"', add
label define eldch_lbl 14 `"14"', add
label define eldch_lbl 15 `"15"', add
label define eldch_lbl 16 `"16"', add
label define eldch_lbl 17 `"17"', add
label define eldch_lbl 18 `"18"', add
label define eldch_lbl 19 `"19"', add
label define eldch_lbl 20 `"20"', add
label define eldch_lbl 21 `"21"', add
label define eldch_lbl 22 `"22"', add
label define eldch_lbl 23 `"23"', add
label define eldch_lbl 24 `"24"', add
label define eldch_lbl 25 `"25"', add
label define eldch_lbl 26 `"26"', add
label define eldch_lbl 27 `"27"', add
label define eldch_lbl 28 `"28"', add
label define eldch_lbl 29 `"29"', add
label define eldch_lbl 30 `"30"', add
label define eldch_lbl 31 `"31"', add
label define eldch_lbl 32 `"32"', add
label define eldch_lbl 33 `"33"', add
label define eldch_lbl 34 `"34"', add
label define eldch_lbl 35 `"35"', add
label define eldch_lbl 36 `"36"', add
label define eldch_lbl 37 `"37"', add
label define eldch_lbl 38 `"38"', add
label define eldch_lbl 39 `"39"', add
label define eldch_lbl 40 `"40"', add
label define eldch_lbl 41 `"41"', add
label define eldch_lbl 42 `"42"', add
label define eldch_lbl 43 `"43"', add
label define eldch_lbl 44 `"44"', add
label define eldch_lbl 45 `"45"', add
label define eldch_lbl 46 `"46"', add
label define eldch_lbl 47 `"47"', add
label define eldch_lbl 48 `"48"', add
label define eldch_lbl 49 `"49"', add
label define eldch_lbl 50 `"50"', add
label define eldch_lbl 51 `"51"', add
label define eldch_lbl 52 `"52"', add
label define eldch_lbl 53 `"53"', add
label define eldch_lbl 54 `"54"', add
label define eldch_lbl 55 `"55"', add
label define eldch_lbl 56 `"56"', add
label define eldch_lbl 57 `"57"', add
label define eldch_lbl 58 `"58"', add
label define eldch_lbl 59 `"59"', add
label define eldch_lbl 60 `"60"', add
label define eldch_lbl 61 `"61"', add
label define eldch_lbl 62 `"62"', add
label define eldch_lbl 63 `"63"', add
label define eldch_lbl 64 `"64"', add
label define eldch_lbl 65 `"65"', add
label define eldch_lbl 66 `"66"', add
label define eldch_lbl 67 `"67"', add
label define eldch_lbl 68 `"68"', add
label define eldch_lbl 69 `"69"', add
label define eldch_lbl 70 `"70"', add
label define eldch_lbl 71 `"71"', add
label define eldch_lbl 72 `"72"', add
label define eldch_lbl 73 `"73"', add
label define eldch_lbl 74 `"74"', add
label define eldch_lbl 75 `"75"', add
label define eldch_lbl 76 `"76"', add
label define eldch_lbl 77 `"77"', add
label define eldch_lbl 78 `"78"', add
label define eldch_lbl 79 `"79"', add
label define eldch_lbl 80 `"80"', add
label define eldch_lbl 81 `"81"', add
label define eldch_lbl 82 `"82"', add
label define eldch_lbl 83 `"83"', add
label define eldch_lbl 84 `"84"', add
label define eldch_lbl 85 `"85"', add
label define eldch_lbl 86 `"86"', add
label define eldch_lbl 87 `"87"', add
label define eldch_lbl 88 `"88"', add
label define eldch_lbl 89 `"89"', add
label define eldch_lbl 90 `"90"', add
label define eldch_lbl 91 `"91"', add
label define eldch_lbl 92 `"92"', add
label define eldch_lbl 93 `"93"', add
label define eldch_lbl 94 `"94"', add
label define eldch_lbl 95 `"95"', add
label define eldch_lbl 96 `"96"', add
label define eldch_lbl 97 `"97"', add
label define eldch_lbl 98 `"98"', add
label define eldch_lbl 99 `"N/A"', add
label values eldch eldch_lbl

label define yngch_lbl 00 `"Less than 1 year old"'
label define yngch_lbl 01 `"1"', add
label define yngch_lbl 02 `"2"', add
label define yngch_lbl 03 `"3"', add
label define yngch_lbl 04 `"4"', add
label define yngch_lbl 05 `"5"', add
label define yngch_lbl 06 `"6"', add
label define yngch_lbl 07 `"7"', add
label define yngch_lbl 08 `"8"', add
label define yngch_lbl 09 `"9"', add
label define yngch_lbl 10 `"10"', add
label define yngch_lbl 11 `"11"', add
label define yngch_lbl 12 `"12"', add
label define yngch_lbl 13 `"13"', add
label define yngch_lbl 14 `"14"', add
label define yngch_lbl 15 `"15"', add
label define yngch_lbl 16 `"16"', add
label define yngch_lbl 17 `"17"', add
label define yngch_lbl 18 `"18"', add
label define yngch_lbl 19 `"19"', add
label define yngch_lbl 20 `"20"', add
label define yngch_lbl 21 `"21"', add
label define yngch_lbl 22 `"22"', add
label define yngch_lbl 23 `"23"', add
label define yngch_lbl 24 `"24"', add
label define yngch_lbl 25 `"25"', add
label define yngch_lbl 26 `"26"', add
label define yngch_lbl 27 `"27"', add
label define yngch_lbl 28 `"28"', add
label define yngch_lbl 29 `"29"', add
label define yngch_lbl 30 `"30"', add
label define yngch_lbl 31 `"31"', add
label define yngch_lbl 32 `"32"', add
label define yngch_lbl 33 `"33"', add
label define yngch_lbl 34 `"34"', add
label define yngch_lbl 35 `"35"', add
label define yngch_lbl 36 `"36"', add
label define yngch_lbl 37 `"37"', add
label define yngch_lbl 38 `"38"', add
label define yngch_lbl 39 `"39"', add
label define yngch_lbl 40 `"40"', add
label define yngch_lbl 41 `"41"', add
label define yngch_lbl 42 `"42"', add
label define yngch_lbl 43 `"43"', add
label define yngch_lbl 44 `"44"', add
label define yngch_lbl 45 `"45"', add
label define yngch_lbl 46 `"46"', add
label define yngch_lbl 47 `"47"', add
label define yngch_lbl 48 `"48"', add
label define yngch_lbl 49 `"49"', add
label define yngch_lbl 50 `"50"', add
label define yngch_lbl 51 `"51"', add
label define yngch_lbl 52 `"52"', add
label define yngch_lbl 53 `"53"', add
label define yngch_lbl 54 `"54"', add
label define yngch_lbl 55 `"55"', add
label define yngch_lbl 56 `"56"', add
label define yngch_lbl 57 `"57"', add
label define yngch_lbl 58 `"58"', add
label define yngch_lbl 59 `"59"', add
label define yngch_lbl 60 `"60"', add
label define yngch_lbl 61 `"61"', add
label define yngch_lbl 62 `"62"', add
label define yngch_lbl 63 `"63"', add
label define yngch_lbl 64 `"64"', add
label define yngch_lbl 65 `"65"', add
label define yngch_lbl 66 `"66"', add
label define yngch_lbl 67 `"67"', add
label define yngch_lbl 68 `"68"', add
label define yngch_lbl 69 `"69"', add
label define yngch_lbl 70 `"70"', add
label define yngch_lbl 71 `"71"', add
label define yngch_lbl 72 `"72"', add
label define yngch_lbl 73 `"73"', add
label define yngch_lbl 74 `"74"', add
label define yngch_lbl 75 `"75"', add
label define yngch_lbl 76 `"76"', add
label define yngch_lbl 77 `"77"', add
label define yngch_lbl 78 `"78"', add
label define yngch_lbl 79 `"79"', add
label define yngch_lbl 80 `"80"', add
label define yngch_lbl 81 `"81"', add
label define yngch_lbl 82 `"82"', add
label define yngch_lbl 83 `"83"', add
label define yngch_lbl 84 `"84"', add
label define yngch_lbl 85 `"85"', add
label define yngch_lbl 86 `"86"', add
label define yngch_lbl 87 `"87"', add
label define yngch_lbl 88 `"88"', add
label define yngch_lbl 89 `"89"', add
label define yngch_lbl 90 `"90"', add
label define yngch_lbl 91 `"91"', add
label define yngch_lbl 92 `"92"', add
label define yngch_lbl 93 `"93"', add
label define yngch_lbl 94 `"94"', add
label define yngch_lbl 95 `"95"', add
label define yngch_lbl 96 `"96"', add
label define yngch_lbl 97 `"97"', add
label define yngch_lbl 98 `"98"', add
label define yngch_lbl 99 `"N/A"', add
label values yngch yngch_lbl

label define relate_lbl 01 `"Head/Householder"'
label define relate_lbl 02 `"Spouse"', add
label define relate_lbl 03 `"Child"', add
label define relate_lbl 04 `"Child-in-law"', add
label define relate_lbl 05 `"Parent"', add
label define relate_lbl 06 `"Parent-in-Law"', add
label define relate_lbl 07 `"Sibling"', add
label define relate_lbl 08 `"Sibling-in-Law"', add
label define relate_lbl 09 `"Grandchild"', add
label define relate_lbl 10 `"Other relatives"', add
label define relate_lbl 11 `"Partner, friend, visitor"', add
label define relate_lbl 12 `"Other non-relatives"', add
label define relate_lbl 13 `"Institutional inmates"', add
label values relate relate_lbl

label define related_lbl 0101 `"Head/Householder"'
label define related_lbl 0201 `"Spouse"', add
label define related_lbl 0202 `"2nd/3rd Wife (Polygamous)"', add
label define related_lbl 0301 `"Child"', add
label define related_lbl 0302 `"Adopted Child"', add
label define related_lbl 0303 `"Stepchild"', add
label define related_lbl 0304 `"Adopted, n.s."', add
label define related_lbl 0401 `"Child-in-law"', add
label define related_lbl 0402 `"Step Child-in-law"', add
label define related_lbl 0501 `"Parent"', add
label define related_lbl 0502 `"Stepparent"', add
label define related_lbl 0601 `"Parent-in-Law"', add
label define related_lbl 0602 `"Stepparent-in-law"', add
label define related_lbl 0701 `"Sibling"', add
label define related_lbl 0702 `"Step/Half/Adopted Sibling"', add
label define related_lbl 0801 `"Sibling-in-Law"', add
label define related_lbl 0802 `"Step/Half Sibling-in-law"', add
label define related_lbl 0901 `"Grandchild"', add
label define related_lbl 0902 `"Adopted Grandchild"', add
label define related_lbl 0903 `"Step Grandchild"', add
label define related_lbl 0904 `"Grandchild-in-law"', add
label define related_lbl 1000 `"Other Relatives:"', add
label define related_lbl 1001 `"Other Relatives"', add
label define related_lbl 1011 `"Grandparent"', add
label define related_lbl 1012 `"Step Grandparent"', add
label define related_lbl 1013 `"Grandparent-in-law"', add
label define related_lbl 1021 `"Aunt or Uncle"', add
label define related_lbl 1022 `"Aunt,Uncle-in-law"', add
label define related_lbl 1031 `"Nephew, Niece"', add
label define related_lbl 1032 `"Neph/Niece-in-law"', add
label define related_lbl 1033 `"Step/Adopted Nephew/Niece"', add
label define related_lbl 1034 `"Grand Niece/Nephew"', add
label define related_lbl 1041 `"Cousin"', add
label define related_lbl 1042 `"Cousin-in-law"', add
label define related_lbl 1051 `"Great Grandchild"', add
label define related_lbl 1061 `"Other relatives, nec"', add
label define related_lbl 1100 `"Partner, Friend, Visitor"', add
label define related_lbl 1110 `"Partner/friend"', add
label define related_lbl 1111 `"Friend"', add
label define related_lbl 1112 `"Partner"', add
label define related_lbl 1113 `"Partner/roommate"', add
label define related_lbl 1114 `"Unmarried Partner"', add
label define related_lbl 1115 `"Housemate/Roomate"', add
label define related_lbl 1120 `"Relative of partner"', add
label define related_lbl 1130 `"Concubine/Mistress"', add
label define related_lbl 1131 `"Visitor"', add
label define related_lbl 1132 `"Companion and family of companion"', add
label define related_lbl 1139 `"Allocated partner/friend/visitor"', add
label define related_lbl 1200 `"Other non-relatives"', add
label define related_lbl 1201 `"Roomers/boarders/lodgers"', add
label define related_lbl 1202 `"Boarders"', add
label define related_lbl 1203 `"Lodgers"', add
label define related_lbl 1204 `"Roomer"', add
label define related_lbl 1205 `"Tenant"', add
label define related_lbl 1206 `"Foster child"', add
label define related_lbl 1210 `"Employees:"', add
label define related_lbl 1211 `"Servant"', add
label define related_lbl 1212 `"Housekeeper"', add
label define related_lbl 1213 `"Maid"', add
label define related_lbl 1214 `"Cook"', add
label define related_lbl 1215 `"Nurse"', add
label define related_lbl 1216 `"Other probable domestic employee"', add
label define related_lbl 1217 `"Other employee"', add
label define related_lbl 1219 `"Relative of employee"', add
label define related_lbl 1221 `"Military"', add
label define related_lbl 1222 `"Students"', add
label define related_lbl 1223 `"Members of religious orders"', add
label define related_lbl 1230 `"Other non-relatives"', add
label define related_lbl 1239 `"Allocated other non-relative"', add
label define related_lbl 1240 `"Roomers/boarders/lodgers and foster children"', add
label define related_lbl 1241 `"Roomers/boarders/lodgers"', add
label define related_lbl 1242 `"Foster children"', add
label define related_lbl 1250 `"Employees"', add
label define related_lbl 1251 `"Domestic employees"', add
label define related_lbl 1252 `"Non-domestic employees"', add
label define related_lbl 1253 `"Relative of employee"', add
label define related_lbl 1260 `"Other non-relatives (1990 includes employees)"', add
label define related_lbl 1270 `"Non-inmate 1990"', add
label define related_lbl 1281 `"Head of group quarters"', add
label define related_lbl 1282 `"Employees of group quarters"', add
label define related_lbl 1283 `"Relative of head, staff, or employee group quarters"', add
label define related_lbl 1284 `"Other non-inmate 1940-1959"', add
label define related_lbl 1291 `"Military"', add
label define related_lbl 1292 `"College dormitories"', add
label define related_lbl 1293 `"Residents of rooming houses"', add
label define related_lbl 1294 `"Other non-inmate 1980 (includes employees and non-inmates in"', add
label define related_lbl 1295 `"Other non-inmates 1960-1970 (includes employees)"', add
label define related_lbl 1296 `"Non-inmates in institutions"', add
label define related_lbl 1301 `"Institutional inmates"', add
label define related_lbl 9996 `"Unclassifiable"', add
label define related_lbl 9997 `"Unknown"', add
label define related_lbl 9998 `"Illegible"', add
label define related_lbl 9999 `"Missing"', add
label values related related_lbl

label define sex_lbl 1 `"Male"'
label define sex_lbl 2 `"Female"', add
label values sex sex_lbl

label define age_lbl 000 `"Less than 1 year old"'
label define age_lbl 001 `"1"', add
label define age_lbl 002 `"2"', add
label define age_lbl 003 `"3"', add
label define age_lbl 004 `"4"', add
label define age_lbl 005 `"5"', add
label define age_lbl 006 `"6"', add
label define age_lbl 007 `"7"', add
label define age_lbl 008 `"8"', add
label define age_lbl 009 `"9"', add
label define age_lbl 010 `"10"', add
label define age_lbl 011 `"11"', add
label define age_lbl 012 `"12"', add
label define age_lbl 013 `"13"', add
label define age_lbl 014 `"14"', add
label define age_lbl 015 `"15"', add
label define age_lbl 016 `"16"', add
label define age_lbl 017 `"17"', add
label define age_lbl 018 `"18"', add
label define age_lbl 019 `"19"', add
label define age_lbl 020 `"20"', add
label define age_lbl 021 `"21"', add
label define age_lbl 022 `"22"', add
label define age_lbl 023 `"23"', add
label define age_lbl 024 `"24"', add
label define age_lbl 025 `"25"', add
label define age_lbl 026 `"26"', add
label define age_lbl 027 `"27"', add
label define age_lbl 028 `"28"', add
label define age_lbl 029 `"29"', add
label define age_lbl 030 `"30"', add
label define age_lbl 031 `"31"', add
label define age_lbl 032 `"32"', add
label define age_lbl 033 `"33"', add
label define age_lbl 034 `"34"', add
label define age_lbl 035 `"35"', add
label define age_lbl 036 `"36"', add
label define age_lbl 037 `"37"', add
label define age_lbl 038 `"38"', add
label define age_lbl 039 `"39"', add
label define age_lbl 040 `"40"', add
label define age_lbl 041 `"41"', add
label define age_lbl 042 `"42"', add
label define age_lbl 043 `"43"', add
label define age_lbl 044 `"44"', add
label define age_lbl 045 `"45"', add
label define age_lbl 046 `"46"', add
label define age_lbl 047 `"47"', add
label define age_lbl 048 `"48"', add
label define age_lbl 049 `"49"', add
label define age_lbl 050 `"50"', add
label define age_lbl 051 `"51"', add
label define age_lbl 052 `"52"', add
label define age_lbl 053 `"53"', add
label define age_lbl 054 `"54"', add
label define age_lbl 055 `"55"', add
label define age_lbl 056 `"56"', add
label define age_lbl 057 `"57"', add
label define age_lbl 058 `"58"', add
label define age_lbl 059 `"59"', add
label define age_lbl 060 `"60"', add
label define age_lbl 061 `"61"', add
label define age_lbl 062 `"62"', add
label define age_lbl 063 `"63"', add
label define age_lbl 064 `"64"', add
label define age_lbl 065 `"65"', add
label define age_lbl 066 `"66"', add
label define age_lbl 067 `"67"', add
label define age_lbl 068 `"68"', add
label define age_lbl 069 `"69"', add
label define age_lbl 070 `"70"', add
label define age_lbl 071 `"71"', add
label define age_lbl 072 `"72"', add
label define age_lbl 073 `"73"', add
label define age_lbl 074 `"74"', add
label define age_lbl 075 `"75"', add
label define age_lbl 076 `"76"', add
label define age_lbl 077 `"77"', add
label define age_lbl 078 `"78"', add
label define age_lbl 079 `"79"', add
label define age_lbl 080 `"80"', add
label define age_lbl 081 `"81"', add
label define age_lbl 082 `"82"', add
label define age_lbl 083 `"83"', add
label define age_lbl 084 `"84"', add
label define age_lbl 085 `"85"', add
label define age_lbl 086 `"86"', add
label define age_lbl 087 `"87"', add
label define age_lbl 088 `"88"', add
label define age_lbl 089 `"89"', add
label define age_lbl 090 `"90 (90+ in 1980 and 1990)"', add
label define age_lbl 091 `"91"', add
label define age_lbl 092 `"92"', add
label define age_lbl 093 `"93"', add
label define age_lbl 094 `"94"', add
label define age_lbl 095 `"95"', add
label define age_lbl 096 `"96"', add
label define age_lbl 097 `"97"', add
label define age_lbl 098 `"98"', add
label define age_lbl 099 `"99"', add
label define age_lbl 100 `"100 (100+ in 1960-1970)"', add
label define age_lbl 101 `"101"', add
label define age_lbl 102 `"102"', add
label define age_lbl 103 `"103"', add
label define age_lbl 104 `"104"', add
label define age_lbl 105 `"105"', add
label define age_lbl 106 `"106"', add
label define age_lbl 107 `"107"', add
label define age_lbl 108 `"108"', add
label define age_lbl 109 `"109"', add
label define age_lbl 110 `"110"', add
label define age_lbl 111 `"111"', add
label define age_lbl 112 `"112 (112+ in the 1980 internal data)"', add
label define age_lbl 113 `"113"', add
label define age_lbl 114 `"114"', add
label define age_lbl 115 `"115 (115+ in the 1990 internal data)"', add
label define age_lbl 116 `"116"', add
label define age_lbl 117 `"117"', add
label define age_lbl 118 `"118"', add
label define age_lbl 119 `"119"', add
label define age_lbl 120 `"120"', add
label define age_lbl 121 `"121"', add
label define age_lbl 122 `"122"', add
label define age_lbl 123 `"123"', add
label define age_lbl 124 `"124"', add
label define age_lbl 125 `"125"', add
label define age_lbl 126 `"126"', add
label define age_lbl 129 `"129"', add
label define age_lbl 130 `"130"', add
label define age_lbl 135 `"135"', add
label values age age_lbl

label define marst_lbl 1 `"Married, spouse present"'
label define marst_lbl 2 `"Married, spouse absent"', add
label define marst_lbl 3 `"Separated"', add
label define marst_lbl 4 `"Divorced"', add
label define marst_lbl 5 `"Widowed"', add
label define marst_lbl 6 `"Never married/single"', add
label values marst marst_lbl

label define marrno_lbl 0 `"Not Applicable"'
label define marrno_lbl 1 `"Married once"', add
label define marrno_lbl 2 `"Married twice (or more)"', add
label define marrno_lbl 3 `"Married thrice (or more)"', add
label define marrno_lbl 4 `"Four times"', add
label define marrno_lbl 5 `"Five times"', add
label define marrno_lbl 6 `"Six times"', add
label define marrno_lbl 7 `"Unknown"', add
label define marrno_lbl 8 `"Illegible"', add
label define marrno_lbl 9 `"Missing"', add
label values marrno marrno_lbl

label define fertyr_lbl 0 `"N/A"'
label define fertyr_lbl 1 `"No"', add
label define fertyr_lbl 2 `"Yes"', add
label define fertyr_lbl 8 `"Suppressed"', add
label values fertyr fertyr_lbl

label define race_lbl 1 `"White"'
label define race_lbl 2 `"Black/African American/Negro"', add
label define race_lbl 3 `"American Indian or Alaska Native"', add
label define race_lbl 4 `"Chinese"', add
label define race_lbl 5 `"Japanese"', add
label define race_lbl 6 `"Other Asian or Pacific Islander"', add
label define race_lbl 7 `"Other race, nec"', add
label define race_lbl 8 `"Two major races"', add
label define race_lbl 9 `"Three or more major races"', add
label values race race_lbl

label define raced_lbl 100 `"White"'
label define raced_lbl 110 `"Spanish write_in"', add
label define raced_lbl 120 `"Blank (white) (1850)"', add
label define raced_lbl 130 `"Portuguese"', add
label define raced_lbl 140 `"Mexican (1930)"', add
label define raced_lbl 150 `"Puerto Rican (1910 Hawaii)"', add
label define raced_lbl 200 `"Black/African American/Negro"', add
label define raced_lbl 210 `"Mulatto"', add
label define raced_lbl 300 `"American Indian/Alaska Native"', add
label define raced_lbl 302 `"Apache"', add
label define raced_lbl 303 `"Blackfoot"', add
label define raced_lbl 304 `"Cherokee"', add
label define raced_lbl 305 `"Cheyenne"', add
label define raced_lbl 306 `"Chickasaw"', add
label define raced_lbl 307 `"Chippewa"', add
label define raced_lbl 308 `"Choctaw"', add
label define raced_lbl 309 `"Comanche"', add
label define raced_lbl 310 `"Creek"', add
label define raced_lbl 311 `"Crow"', add
label define raced_lbl 312 `"Iroquois"', add
label define raced_lbl 313 `"Kiowa"', add
label define raced_lbl 314 `"Lumbee"', add
label define raced_lbl 315 `"Navajo"', add
label define raced_lbl 316 `"Osage"', add
label define raced_lbl 317 `"Paiute"', add
label define raced_lbl 318 `"Pima"', add
label define raced_lbl 319 `"Potawatomi"', add
label define raced_lbl 320 `"Pueblo"', add
label define raced_lbl 321 `"Seminole"', add
label define raced_lbl 322 `"Shoshone"', add
label define raced_lbl 323 `"Sioux"', add
label define raced_lbl 324 `"Tlingit (Tlingit_Haida, 2000/ACS)"', add
label define raced_lbl 325 `"Tohono O Odham"', add
label define raced_lbl 326 `"All other tribes (1990)"', add
label define raced_lbl 328 `"Hopi"', add
label define raced_lbl 329 `"Central American Indian"', add
label define raced_lbl 330 `"Spanish American Indian"', add
label define raced_lbl 350 `"Delaware"', add
label define raced_lbl 351 `"Latin American Indian"', add
label define raced_lbl 352 `"Puget Sound Salish"', add
label define raced_lbl 353 `"Yakama"', add
label define raced_lbl 354 `"Yaqui"', add
label define raced_lbl 355 `"Colville"', add
label define raced_lbl 356 `"Houma"', add
label define raced_lbl 357 `"Menominee"', add
label define raced_lbl 358 `"Yuman"', add
label define raced_lbl 359 `"South American Indian"', add
label define raced_lbl 360 `"Mexican American Indian"', add
label define raced_lbl 361 `"Other Amer. Indian tribe (2000,ACS)"', add
label define raced_lbl 362 `"2+ Amer. Indian tribes (2000,ACS)"', add
label define raced_lbl 370 `"Alaskan Athabaskan"', add
label define raced_lbl 371 `"Aleut"', add
label define raced_lbl 372 `"Eskimo"', add
label define raced_lbl 373 `"Alaskan mixed"', add
label define raced_lbl 374 `"Inupiat"', add
label define raced_lbl 375 `"Yup'ik"', add
label define raced_lbl 379 `"Other Alaska Native tribe(s) (2000,ACS)"', add
label define raced_lbl 398 `"Both Am. Ind. and Alaska Native (2000,ACS)"', add
label define raced_lbl 399 `"Tribe not specified"', add
label define raced_lbl 400 `"Chinese"', add
label define raced_lbl 410 `"Taiwanese"', add
label define raced_lbl 420 `"Chinese and Taiwanese"', add
label define raced_lbl 500 `"Japanese"', add
label define raced_lbl 600 `"Filipino"', add
label define raced_lbl 610 `"Asian Indian (Hindu 1920_1940)"', add
label define raced_lbl 620 `"Korean"', add
label define raced_lbl 630 `"Hawaiian"', add
label define raced_lbl 631 `"Hawaiian and Asian (1900,1920)"', add
label define raced_lbl 632 `"Hawaiian and European (1900,1920)"', add
label define raced_lbl 634 `"Hawaiian mixed"', add
label define raced_lbl 640 `"Vietnamese"', add
label define raced_lbl 641 `"Bhutanese"', add
label define raced_lbl 642 `"Mongolian"', add
label define raced_lbl 643 `"Nepalese"', add
label define raced_lbl 650 `"Other Asian or Pacific Islander (1920,1980)"', add
label define raced_lbl 651 `"Asian only (CPS)"', add
label define raced_lbl 652 `"Pacific Islander only (CPS)"', add
label define raced_lbl 653 `"Asian or Pacific Islander, n.s. (1990 Internal Census files)"', add
label define raced_lbl 660 `"Cambodian"', add
label define raced_lbl 661 `"Hmong"', add
label define raced_lbl 662 `"Laotian"', add
label define raced_lbl 663 `"Thai"', add
label define raced_lbl 664 `"Bangladeshi"', add
label define raced_lbl 665 `"Burmese"', add
label define raced_lbl 666 `"Indonesian"', add
label define raced_lbl 667 `"Malaysian"', add
label define raced_lbl 668 `"Okinawan"', add
label define raced_lbl 669 `"Pakistani"', add
label define raced_lbl 670 `"Sri Lankan"', add
label define raced_lbl 671 `"Other Asian, n.e.c."', add
label define raced_lbl 672 `"Asian, not specified"', add
label define raced_lbl 673 `"Chinese and Japanese"', add
label define raced_lbl 674 `"Chinese and Filipino"', add
label define raced_lbl 675 `"Chinese and Vietnamese"', add
label define raced_lbl 676 `"Chinese and Asian write_in"', add
label define raced_lbl 677 `"Japanese and Filipino"', add
label define raced_lbl 678 `"Asian Indian and Asian write_in"', add
label define raced_lbl 679 `"Other Asian race combinations"', add
label define raced_lbl 680 `"Samoan"', add
label define raced_lbl 681 `"Tahitian"', add
label define raced_lbl 682 `"Tongan"', add
label define raced_lbl 683 `"Other Polynesian (1990)"', add
label define raced_lbl 684 `"1+ other Polynesian races (2000,ACS)"', add
label define raced_lbl 685 `"Guamanian/Chamorro"', add
label define raced_lbl 686 `"Northern Mariana Islander"', add
label define raced_lbl 687 `"Palauan"', add
label define raced_lbl 688 `"Other Micronesian (1990)"', add
label define raced_lbl 689 `"1+ other Micronesian races (2000,ACS)"', add
label define raced_lbl 690 `"Fijian"', add
label define raced_lbl 691 `"Other Melanesian (1990)"', add
label define raced_lbl 692 `"1+ other Melanesian races (2000,ACS)"', add
label define raced_lbl 698 `"2+ PI races from 2+ PI regions"', add
label define raced_lbl 699 `"Pacific Islander, n.s."', add
label define raced_lbl 700 `"Other race, n.e.c."', add
label define raced_lbl 801 `"White and Black"', add
label define raced_lbl 802 `"White and AIAN"', add
label define raced_lbl 810 `"White and Asian"', add
label define raced_lbl 811 `"White and Chinese"', add
label define raced_lbl 812 `"White and Japanese"', add
label define raced_lbl 813 `"White and Filipino"', add
label define raced_lbl 814 `"White and Asian Indian"', add
label define raced_lbl 815 `"White and Korean"', add
label define raced_lbl 816 `"White and Vietnamese"', add
label define raced_lbl 817 `"White and Asian write_in"', add
label define raced_lbl 818 `"White and other Asian race(s)"', add
label define raced_lbl 819 `"White and two or more Asian groups"', add
label define raced_lbl 820 `"White and PI"', add
label define raced_lbl 821 `"White and Native Hawaiian"', add
label define raced_lbl 822 `"White and Samoan"', add
label define raced_lbl 823 `"White and Guamanian"', add
label define raced_lbl 824 `"White and PI write_in"', add
label define raced_lbl 825 `"White and other PI race(s)"', add
label define raced_lbl 826 `"White and other race write_in"', add
label define raced_lbl 827 `"White and other race, n.e.c."', add
label define raced_lbl 830 `"Black and AIAN"', add
label define raced_lbl 831 `"Black and Asian"', add
label define raced_lbl 832 `"Black and Chinese"', add
label define raced_lbl 833 `"Black and Japanese"', add
label define raced_lbl 834 `"Black and Filipino"', add
label define raced_lbl 835 `"Black and Asian Indian"', add
label define raced_lbl 836 `"Black and Korean"', add
label define raced_lbl 837 `"Black and Asian write_in"', add
label define raced_lbl 838 `"Black and other Asian race(s)"', add
label define raced_lbl 840 `"Black and PI"', add
label define raced_lbl 841 `"Black and PI write_in"', add
label define raced_lbl 842 `"Black and other PI race(s)"', add
label define raced_lbl 845 `"Black and other race write_in"', add
label define raced_lbl 850 `"AIAN and Asian"', add
label define raced_lbl 851 `"AIAN and Filipino (2000 1%)"', add
label define raced_lbl 852 `"AIAN and Asian Indian"', add
label define raced_lbl 853 `"AIAN and Asian write_in (2000 1%)"', add
label define raced_lbl 854 `"AIAN and other Asian race(s)"', add
label define raced_lbl 855 `"AIAN and PI"', add
label define raced_lbl 856 `"AIAN and other race write_in"', add
label define raced_lbl 860 `"Asian and PI"', add
label define raced_lbl 861 `"Chinese and Hawaiian"', add
label define raced_lbl 862 `"Chinese, Filipino, Hawaiian (2000 1%)"', add
label define raced_lbl 863 `"Japanese and Hawaiian (2000 1%)"', add
label define raced_lbl 864 `"Filipino and Hawaiian"', add
label define raced_lbl 865 `"Filipino and PI write_in"', add
label define raced_lbl 866 `"Asian Indian and PI write_in (2000 1%)"', add
label define raced_lbl 867 `"Asian write_in and PI write_in"', add
label define raced_lbl 868 `"Other Asian race(s) and PI race(s)"', add
label define raced_lbl 869 `"Japanese and Korean (ACS)"', add
label define raced_lbl 880 `"Asian and other race write_in"', add
label define raced_lbl 881 `"Chinese and other race write_in"', add
label define raced_lbl 882 `"Japanese and other race write_in"', add
label define raced_lbl 883 `"Filipino and other race write_in"', add
label define raced_lbl 884 `"Asian Indian and other race write_in"', add
label define raced_lbl 885 `"Asian write_in and other race write_in"', add
label define raced_lbl 886 `"Other Asian race(s) and other race write_in"', add
label define raced_lbl 887 `"Chinese and Korean"', add
label define raced_lbl 890 `"PI and other race write_in:"', add
label define raced_lbl 891 `"PI write_in and other race write_in"', add
label define raced_lbl 892 `"Other PI race(s) and other race write_in"', add
label define raced_lbl 893 `"Native Hawaiian or PI other race(s)"', add
label define raced_lbl 899 `"API and other race write_in"', add
label define raced_lbl 901 `"White, Black, AIAN"', add
label define raced_lbl 902 `"White, Black, Asian"', add
label define raced_lbl 903 `"White, Black, PI"', add
label define raced_lbl 904 `"White, Black, other race write_in"', add
label define raced_lbl 905 `"White, AIAN, Asian"', add
label define raced_lbl 906 `"White, AIAN, PI"', add
label define raced_lbl 907 `"White, AIAN, other race write_in"', add
label define raced_lbl 910 `"White, Asian, PI"', add
label define raced_lbl 911 `"White, Chinese, Hawaiian"', add
label define raced_lbl 912 `"White, Chinese, Filipino, Hawaiian (2000 1%)"', add
label define raced_lbl 913 `"White, Japanese, Hawaiian (2000 1%)"', add
label define raced_lbl 914 `"White, Filipino, Hawaiian"', add
label define raced_lbl 915 `"Other White, Asian race(s), PI race(s)"', add
label define raced_lbl 916 `"White, AIAN and Filipino"', add
label define raced_lbl 917 `"White, Black, and Filipino"', add
label define raced_lbl 920 `"White, Asian, other race write_in"', add
label define raced_lbl 921 `"White, Filipino, other race write_in (2000 1%)"', add
label define raced_lbl 922 `"White, Asian write_in, other race write_in (2000 1%)"', add
label define raced_lbl 923 `"Other White, Asian race(s), other race write_in (2000 1%)"', add
label define raced_lbl 925 `"White, PI, other race write_in"', add
label define raced_lbl 930 `"Black, AIAN, Asian"', add
label define raced_lbl 931 `"Black, AIAN, PI"', add
label define raced_lbl 932 `"Black, AIAN, other race write_in"', add
label define raced_lbl 933 `"Black, Asian, PI"', add
label define raced_lbl 934 `"Black, Asian, other race write_in"', add
label define raced_lbl 935 `"Black, PI, other race write_in"', add
label define raced_lbl 940 `"AIAN, Asian, PI"', add
label define raced_lbl 941 `"AIAN, Asian, other race write_in"', add
label define raced_lbl 942 `"AIAN, PI, other race write_in"', add
label define raced_lbl 943 `"Asian, PI, other race write_in"', add
label define raced_lbl 944 `"Asian (Chinese, Japanese, Korean, Vietnamese); and Native Hawaiian or PI; and Other"', add
label define raced_lbl 949 `"2 or 3 races (CPS)"', add
label define raced_lbl 950 `"White, Black, AIAN, Asian"', add
label define raced_lbl 951 `"White, Black, AIAN, PI"', add
label define raced_lbl 952 `"White, Black, AIAN, other race write_in"', add
label define raced_lbl 953 `"White, Black, Asian, PI"', add
label define raced_lbl 954 `"White, Black, Asian, other race write_in"', add
label define raced_lbl 955 `"White, Black, PI, other race write_in"', add
label define raced_lbl 960 `"White, AIAN, Asian, PI"', add
label define raced_lbl 961 `"White, AIAN, Asian, other race write_in"', add
label define raced_lbl 962 `"White, AIAN, PI, other race write_in"', add
label define raced_lbl 963 `"White, Asian, PI, other race write_in"', add
label define raced_lbl 964 `"White, Chinese, Japanese, Native Hawaiian"', add
label define raced_lbl 970 `"Black, AIAN, Asian, PI"', add
label define raced_lbl 971 `"Black, AIAN, Asian, other race write_in"', add
label define raced_lbl 972 `"Black, AIAN, PI, other race write_in"', add
label define raced_lbl 973 `"Black, Asian, PI, other race write_in"', add
label define raced_lbl 974 `"AIAN, Asian, PI, other race write_in"', add
label define raced_lbl 975 `"AIAN, Asian, PI, Hawaiian other race write_in"', add
label define raced_lbl 976 `"Two specified Asian  (Chinese and other Asian, Chinese and Japanese, Japanese and other Asian, Korean and other Asian); Native Hawaiian/PI; and Other Race"', add
label define raced_lbl 980 `"White, Black, AIAN, Asian, PI"', add
label define raced_lbl 981 `"White, Black, AIAN, Asian, other race write_in"', add
label define raced_lbl 982 `"White, Black, AIAN, PI, other race write_in"', add
label define raced_lbl 983 `"White, Black, Asian, PI, other race write_in"', add
label define raced_lbl 984 `"White, AIAN, Asian, PI, other race write_in"', add
label define raced_lbl 985 `"Black, AIAN, Asian, PI, other race write_in"', add
label define raced_lbl 986 `"Black, AIAN, Asian, PI, Hawaiian, other race write_in"', add
label define raced_lbl 989 `"4 or 5 races (CPS)"', add
label define raced_lbl 990 `"White, Black, AIAN, Asian, PI, other race write_in"', add
label define raced_lbl 991 `"White race; Some other race; Black or African American race and/or American Indian and Alaska Native race and/or Asian groups and/or Native Hawaiian and Other Pacific Islander groups"', add
label define raced_lbl 996 `"2+ races, n.e.c. (CPS)"', add
label values raced raced_lbl

label define hispan_lbl 0 `"Not Hispanic"'
label define hispan_lbl 1 `"Mexican"', add
label define hispan_lbl 2 `"Puerto Rican"', add
label define hispan_lbl 3 `"Cuban"', add
label define hispan_lbl 4 `"Other"', add
label define hispan_lbl 9 `"Not Reported"', add
label values hispan hispan_lbl

label define hispand_lbl 000 `"Not Hispanic"'
label define hispand_lbl 100 `"Mexican"', add
label define hispand_lbl 102 `"Mexican American"', add
label define hispand_lbl 103 `"Mexicano/Mexicana"', add
label define hispand_lbl 104 `"Chicano/Chicana"', add
label define hispand_lbl 105 `"La Raza"', add
label define hispand_lbl 106 `"Mexican American Indian"', add
label define hispand_lbl 107 `"Mexico"', add
label define hispand_lbl 200 `"Puerto Rican"', add
label define hispand_lbl 300 `"Cuban"', add
label define hispand_lbl 401 `"Central American Indian"', add
label define hispand_lbl 402 `"Canal Zone"', add
label define hispand_lbl 411 `"Costa Rican"', add
label define hispand_lbl 412 `"Guatemalan"', add
label define hispand_lbl 413 `"Honduran"', add
label define hispand_lbl 414 `"Nicaraguan"', add
label define hispand_lbl 415 `"Panamanian"', add
label define hispand_lbl 416 `"Salvadoran"', add
label define hispand_lbl 417 `"Central American, n.e.c."', add
label define hispand_lbl 420 `"Argentinean"', add
label define hispand_lbl 421 `"Bolivian"', add
label define hispand_lbl 422 `"Chilean"', add
label define hispand_lbl 423 `"Colombian"', add
label define hispand_lbl 424 `"Ecuadorian"', add
label define hispand_lbl 425 `"Paraguayan"', add
label define hispand_lbl 426 `"Peruvian"', add
label define hispand_lbl 427 `"Uruguayan"', add
label define hispand_lbl 428 `"Venezuelan"', add
label define hispand_lbl 429 `"South American Indian"', add
label define hispand_lbl 430 `"Criollo"', add
label define hispand_lbl 431 `"South American, n.e.c."', add
label define hispand_lbl 450 `"Spaniard"', add
label define hispand_lbl 451 `"Andalusian"', add
label define hispand_lbl 452 `"Asturian"', add
label define hispand_lbl 453 `"Castillian"', add
label define hispand_lbl 454 `"Catalonian"', add
label define hispand_lbl 455 `"Balearic Islander"', add
label define hispand_lbl 456 `"Gallego"', add
label define hispand_lbl 457 `"Valencian"', add
label define hispand_lbl 458 `"Canarian"', add
label define hispand_lbl 459 `"Spanish Basque"', add
label define hispand_lbl 460 `"Dominican"', add
label define hispand_lbl 465 `"Latin American"', add
label define hispand_lbl 470 `"Hispanic"', add
label define hispand_lbl 480 `"Spanish"', add
label define hispand_lbl 490 `"Californio"', add
label define hispand_lbl 491 `"Tejano"', add
label define hispand_lbl 492 `"Nuevo Mexicano"', add
label define hispand_lbl 493 `"Spanish American"', add
label define hispand_lbl 494 `"Spanish American Indian"', add
label define hispand_lbl 495 `"Meso American Indian"', add
label define hispand_lbl 496 `"Mestizo"', add
label define hispand_lbl 498 `"Other, n.s."', add
label define hispand_lbl 499 `"Other, n.e.c."', add
label define hispand_lbl 900 `"Not Reported"', add
label values hispand hispand_lbl

label define bpl_lbl 001 `"Alabama"'
label define bpl_lbl 002 `"Alaska"', add
label define bpl_lbl 004 `"Arizona"', add
label define bpl_lbl 005 `"Arkansas"', add
label define bpl_lbl 006 `"California"', add
label define bpl_lbl 008 `"Colorado"', add
label define bpl_lbl 009 `"Connecticut"', add
label define bpl_lbl 010 `"Delaware"', add
label define bpl_lbl 011 `"District of Columbia"', add
label define bpl_lbl 012 `"Florida"', add
label define bpl_lbl 013 `"Georgia"', add
label define bpl_lbl 015 `"Hawaii"', add
label define bpl_lbl 016 `"Idaho"', add
label define bpl_lbl 017 `"Illinois"', add
label define bpl_lbl 018 `"Indiana"', add
label define bpl_lbl 019 `"Iowa"', add
label define bpl_lbl 020 `"Kansas"', add
label define bpl_lbl 021 `"Kentucky"', add
label define bpl_lbl 022 `"Louisiana"', add
label define bpl_lbl 023 `"Maine"', add
label define bpl_lbl 024 `"Maryland"', add
label define bpl_lbl 025 `"Massachusetts"', add
label define bpl_lbl 026 `"Michigan"', add
label define bpl_lbl 027 `"Minnesota"', add
label define bpl_lbl 028 `"Mississippi"', add
label define bpl_lbl 029 `"Missouri"', add
label define bpl_lbl 030 `"Montana"', add
label define bpl_lbl 031 `"Nebraska"', add
label define bpl_lbl 032 `"Nevada"', add
label define bpl_lbl 033 `"New Hampshire"', add
label define bpl_lbl 034 `"New Jersey"', add
label define bpl_lbl 035 `"New Mexico"', add
label define bpl_lbl 036 `"New York"', add
label define bpl_lbl 037 `"North Carolina"', add
label define bpl_lbl 038 `"North Dakota"', add
label define bpl_lbl 039 `"Ohio"', add
label define bpl_lbl 040 `"Oklahoma"', add
label define bpl_lbl 041 `"Oregon"', add
label define bpl_lbl 042 `"Pennsylvania"', add
label define bpl_lbl 044 `"Rhode Island"', add
label define bpl_lbl 045 `"South Carolina"', add
label define bpl_lbl 046 `"South Dakota"', add
label define bpl_lbl 047 `"Tennessee"', add
label define bpl_lbl 048 `"Texas"', add
label define bpl_lbl 049 `"Utah"', add
label define bpl_lbl 050 `"Vermont"', add
label define bpl_lbl 051 `"Virginia"', add
label define bpl_lbl 053 `"Washington"', add
label define bpl_lbl 054 `"West Virginia"', add
label define bpl_lbl 055 `"Wisconsin"', add
label define bpl_lbl 056 `"Wyoming"', add
label define bpl_lbl 090 `"Native American"', add
label define bpl_lbl 099 `"United States, ns"', add
label define bpl_lbl 100 `"American Samoa"', add
label define bpl_lbl 105 `"Guam"', add
label define bpl_lbl 110 `"Puerto Rico"', add
label define bpl_lbl 115 `"U.S. Virgin Islands"', add
label define bpl_lbl 120 `"Other US Possessions"', add
label define bpl_lbl 150 `"Canada"', add
label define bpl_lbl 155 `"St. Pierre and Miquelon"', add
label define bpl_lbl 160 `"Atlantic Islands"', add
label define bpl_lbl 199 `"North America, ns"', add
label define bpl_lbl 200 `"Mexico"', add
label define bpl_lbl 210 `"Central America"', add
label define bpl_lbl 250 `"Cuba"', add
label define bpl_lbl 260 `"West Indies"', add
label define bpl_lbl 299 `"Americas, n.s."', add
label define bpl_lbl 300 `"SOUTH AMERICA"', add
label define bpl_lbl 400 `"Denmark"', add
label define bpl_lbl 401 `"Finland"', add
label define bpl_lbl 402 `"Iceland"', add
label define bpl_lbl 403 `"Lapland, n.s."', add
label define bpl_lbl 404 `"Norway"', add
label define bpl_lbl 405 `"Sweden"', add
label define bpl_lbl 410 `"England"', add
label define bpl_lbl 411 `"Scotland"', add
label define bpl_lbl 412 `"Wales"', add
label define bpl_lbl 413 `"United Kingdom, ns"', add
label define bpl_lbl 414 `"Ireland"', add
label define bpl_lbl 419 `"Northern Europe, ns"', add
label define bpl_lbl 420 `"Belgium"', add
label define bpl_lbl 421 `"France"', add
label define bpl_lbl 422 `"Liechtenstein"', add
label define bpl_lbl 423 `"Luxembourg"', add
label define bpl_lbl 424 `"Monaco"', add
label define bpl_lbl 425 `"Netherlands"', add
label define bpl_lbl 426 `"Switzerland"', add
label define bpl_lbl 429 `"Western Europe, ns"', add
label define bpl_lbl 430 `"Albania"', add
label define bpl_lbl 431 `"Andorra"', add
label define bpl_lbl 432 `"Gibraltar"', add
label define bpl_lbl 433 `"Greece"', add
label define bpl_lbl 434 `"Italy"', add
label define bpl_lbl 435 `"Malta"', add
label define bpl_lbl 436 `"Portugal"', add
label define bpl_lbl 437 `"San Marino"', add
label define bpl_lbl 438 `"Spain"', add
label define bpl_lbl 439 `"Vatican City"', add
label define bpl_lbl 440 `"Southern Europe, ns"', add
label define bpl_lbl 450 `"Austria"', add
label define bpl_lbl 451 `"Bulgaria"', add
label define bpl_lbl 452 `"Czechoslovakia"', add
label define bpl_lbl 453 `"Germany"', add
label define bpl_lbl 454 `"Hungary"', add
label define bpl_lbl 455 `"Poland"', add
label define bpl_lbl 456 `"Romania"', add
label define bpl_lbl 457 `"Yugoslavia"', add
label define bpl_lbl 458 `"Central Europe, ns"', add
label define bpl_lbl 459 `"Eastern Europe, ns"', add
label define bpl_lbl 460 `"Estonia"', add
label define bpl_lbl 461 `"Latvia"', add
label define bpl_lbl 462 `"Lithuania"', add
label define bpl_lbl 463 `"Baltic States, ns"', add
label define bpl_lbl 465 `"Other USSR/Russia"', add
label define bpl_lbl 499 `"Europe, ns"', add
label define bpl_lbl 500 `"China"', add
label define bpl_lbl 501 `"Japan"', add
label define bpl_lbl 502 `"Korea"', add
label define bpl_lbl 509 `"East Asia, ns"', add
label define bpl_lbl 510 `"Brunei"', add
label define bpl_lbl 511 `"Cambodia (Kampuchea)"', add
label define bpl_lbl 512 `"Indonesia"', add
label define bpl_lbl 513 `"Laos"', add
label define bpl_lbl 514 `"Malaysia"', add
label define bpl_lbl 515 `"Philippines"', add
label define bpl_lbl 516 `"Singapore"', add
label define bpl_lbl 517 `"Thailand"', add
label define bpl_lbl 518 `"Vietnam"', add
label define bpl_lbl 519 `"Southeast Asia, ns"', add
label define bpl_lbl 520 `"Afghanistan"', add
label define bpl_lbl 521 `"India"', add
label define bpl_lbl 522 `"Iran"', add
label define bpl_lbl 523 `"Maldives"', add
label define bpl_lbl 524 `"Nepal"', add
label define bpl_lbl 530 `"Bahrain"', add
label define bpl_lbl 531 `"Cyprus"', add
label define bpl_lbl 532 `"Iraq"', add
label define bpl_lbl 533 `"Iraq/Saudi Arabia"', add
label define bpl_lbl 534 `"Israel/Palestine"', add
label define bpl_lbl 535 `"Jordan"', add
label define bpl_lbl 536 `"Kuwait"', add
label define bpl_lbl 537 `"Lebanon"', add
label define bpl_lbl 538 `"Oman"', add
label define bpl_lbl 539 `"Qatar"', add
label define bpl_lbl 540 `"Saudi Arabia"', add
label define bpl_lbl 541 `"Syria"', add
label define bpl_lbl 542 `"Turkey"', add
label define bpl_lbl 543 `"United Arab Emirates"', add
label define bpl_lbl 544 `"Yemen Arab Republic (North)"', add
label define bpl_lbl 545 `"Yemen, PDR (South)"', add
label define bpl_lbl 546 `"Persian Gulf States, n.s."', add
label define bpl_lbl 547 `"Middle East, ns"', add
label define bpl_lbl 548 `"Southwest Asia, nec/ns"', add
label define bpl_lbl 549 `"Asia Minor, ns"', add
label define bpl_lbl 550 `"South Asia, nec"', add
label define bpl_lbl 599 `"Asia, nec/ns"', add
label define bpl_lbl 600 `"AFRICA"', add
label define bpl_lbl 700 `"Australia and New Zealand"', add
label define bpl_lbl 710 `"Pacific Islands"', add
label define bpl_lbl 800 `"Antarctica, ns/nec"', add
label define bpl_lbl 900 `"Abroad (unknown) or at sea"', add
label define bpl_lbl 950 `"Other n.e.c."', add
label define bpl_lbl 999 `"Missing/blank"', add
label values bpl bpl_lbl

label define bpld_lbl 00100 `"Alabama"'
label define bpld_lbl 00200 `"Alaska"', add
label define bpld_lbl 00400 `"Arizona"', add
label define bpld_lbl 00500 `"Arkansas"', add
label define bpld_lbl 00600 `"California"', add
label define bpld_lbl 00800 `"Colorado"', add
label define bpld_lbl 00900 `"Connecticut"', add
label define bpld_lbl 01000 `"Delaware"', add
label define bpld_lbl 01100 `"District of Columbia"', add
label define bpld_lbl 01200 `"Florida"', add
label define bpld_lbl 01300 `"Georgia"', add
label define bpld_lbl 01500 `"Hawaii"', add
label define bpld_lbl 01600 `"Idaho"', add
label define bpld_lbl 01610 `"Idaho Territory"', add
label define bpld_lbl 01700 `"Illinois"', add
label define bpld_lbl 01800 `"Indiana"', add
label define bpld_lbl 01900 `"Iowa"', add
label define bpld_lbl 02000 `"Kansas"', add
label define bpld_lbl 02100 `"Kentucky"', add
label define bpld_lbl 02200 `"Louisiana"', add
label define bpld_lbl 02300 `"Maine"', add
label define bpld_lbl 02400 `"Maryland"', add
label define bpld_lbl 02500 `"Massachusetts"', add
label define bpld_lbl 02600 `"Michigan"', add
label define bpld_lbl 02700 `"Minnesota"', add
label define bpld_lbl 02800 `"Mississippi"', add
label define bpld_lbl 02900 `"Missouri"', add
label define bpld_lbl 03000 `"Montana"', add
label define bpld_lbl 03100 `"Nebraska"', add
label define bpld_lbl 03200 `"Nevada"', add
label define bpld_lbl 03300 `"New Hampshire"', add
label define bpld_lbl 03400 `"New Jersey"', add
label define bpld_lbl 03500 `"New Mexico"', add
label define bpld_lbl 03510 `"New Mexico Territory"', add
label define bpld_lbl 03600 `"New York"', add
label define bpld_lbl 03700 `"North Carolina"', add
label define bpld_lbl 03800 `"North Dakota"', add
label define bpld_lbl 03900 `"Ohio"', add
label define bpld_lbl 04000 `"Oklahoma"', add
label define bpld_lbl 04010 `"Indian Territory"', add
label define bpld_lbl 04100 `"Oregon"', add
label define bpld_lbl 04200 `"Pennsylvania"', add
label define bpld_lbl 04400 `"Rhode Island"', add
label define bpld_lbl 04500 `"South Carolina"', add
label define bpld_lbl 04600 `"South Dakota"', add
label define bpld_lbl 04610 `"Dakota Territory"', add
label define bpld_lbl 04700 `"Tennessee"', add
label define bpld_lbl 04800 `"Texas"', add
label define bpld_lbl 04900 `"Utah"', add
label define bpld_lbl 04910 `"Utah Territory"', add
label define bpld_lbl 05000 `"Vermont"', add
label define bpld_lbl 05100 `"Virginia"', add
label define bpld_lbl 05300 `"Washington"', add
label define bpld_lbl 05400 `"West Virginia"', add
label define bpld_lbl 05500 `"Wisconsin"', add
label define bpld_lbl 05600 `"Wyoming"', add
label define bpld_lbl 05610 `"Wyoming Territory"', add
label define bpld_lbl 09000 `"Native American"', add
label define bpld_lbl 09900 `"United States, ns"', add
label define bpld_lbl 10000 `"American Samoa"', add
label define bpld_lbl 10010 `"Samoa, 1940-1950"', add
label define bpld_lbl 10500 `"Guam"', add
label define bpld_lbl 11000 `"Puerto Rico"', add
label define bpld_lbl 11500 `"U.S. Virgin Islands"', add
label define bpld_lbl 11510 `"St. Croix"', add
label define bpld_lbl 11520 `"St. John"', add
label define bpld_lbl 11530 `"St. Thomas"', add
label define bpld_lbl 12000 `"Other US Possessions:"', add
label define bpld_lbl 12010 `"Johnston Atoll"', add
label define bpld_lbl 12020 `"Midway Islands"', add
label define bpld_lbl 12030 `"Wake Island"', add
label define bpld_lbl 12040 `"Other US Caribbean Islands"', add
label define bpld_lbl 12041 `"Navassa Island"', add
label define bpld_lbl 12050 `"Other US Pacific Islands"', add
label define bpld_lbl 12051 `"Baker Island"', add
label define bpld_lbl 12052 `"Howland Island"', add
label define bpld_lbl 12053 `"Jarvis Island"', add
label define bpld_lbl 12054 `"Kingman Reef"', add
label define bpld_lbl 12055 `"Palmyra Atoll"', add
label define bpld_lbl 12056 `"Canton and Enderbury Island"', add
label define bpld_lbl 12090 `"US outlying areas, ns"', add
label define bpld_lbl 12091 `"US possessions, ns"', add
label define bpld_lbl 12092 `"US territory, ns"', add
label define bpld_lbl 15000 `"Canada"', add
label define bpld_lbl 15010 `"English Canada"', add
label define bpld_lbl 15011 `"British Columbia"', add
label define bpld_lbl 15013 `"Alberta"', add
label define bpld_lbl 15015 `"Saskatchewan"', add
label define bpld_lbl 15017 `"Northwest"', add
label define bpld_lbl 15019 `"Ruperts Land"', add
label define bpld_lbl 15020 `"Manitoba"', add
label define bpld_lbl 15021 `"Red River"', add
label define bpld_lbl 15030 `"Ontario/Upper Canada"', add
label define bpld_lbl 15031 `"Upper Canada"', add
label define bpld_lbl 15032 `"Canada West"', add
label define bpld_lbl 15040 `"New Brunswick"', add
label define bpld_lbl 15050 `"Nova Scotia"', add
label define bpld_lbl 15051 `"Cape Breton"', add
label define bpld_lbl 15052 `"Halifax"', add
label define bpld_lbl 15060 `"Prince Edward Island"', add
label define bpld_lbl 15070 `"Newfoundland"', add
label define bpld_lbl 15080 `"French Canada"', add
label define bpld_lbl 15081 `"Quebec"', add
label define bpld_lbl 15082 `"Lower Canada"', add
label define bpld_lbl 15083 `"Canada East"', add
label define bpld_lbl 15500 `"St. Pierre and Miquelon"', add
label define bpld_lbl 16000 `"Atlantic Islands"', add
label define bpld_lbl 16010 `"Bermuda"', add
label define bpld_lbl 16020 `"Cape Verde"', add
label define bpld_lbl 16030 `"Falkland Islands"', add
label define bpld_lbl 16040 `"Greenland"', add
label define bpld_lbl 16050 `"St. Helena and Ascension"', add
label define bpld_lbl 16060 `"Canary Islands"', add
label define bpld_lbl 19900 `"North America, ns"', add
label define bpld_lbl 20000 `"Mexico"', add
label define bpld_lbl 21000 `"Central America"', add
label define bpld_lbl 21010 `"Belize/British Honduras"', add
label define bpld_lbl 21020 `"Costa Rica"', add
label define bpld_lbl 21030 `"El Salvador"', add
label define bpld_lbl 21040 `"Guatemala"', add
label define bpld_lbl 21050 `"Honduras"', add
label define bpld_lbl 21060 `"Nicaragua"', add
label define bpld_lbl 21070 `"Panama"', add
label define bpld_lbl 21071 `"Canal Zone"', add
label define bpld_lbl 21090 `"Central America, ns"', add
label define bpld_lbl 25000 `"Cuba"', add
label define bpld_lbl 26000 `"West Indies"', add
label define bpld_lbl 26010 `"Dominican Republic"', add
label define bpld_lbl 26020 `"Haiti"', add
label define bpld_lbl 26030 `"Jamaica"', add
label define bpld_lbl 26040 `"British West Indies"', add
label define bpld_lbl 26041 `"Anguilla"', add
label define bpld_lbl 26042 `"Antigua-Barbuda"', add
label define bpld_lbl 26043 `"Bahamas"', add
label define bpld_lbl 26044 `"Barbados"', add
label define bpld_lbl 26045 `"British Virgin Islands"', add
label define bpld_lbl 26046 `"Anegada"', add
label define bpld_lbl 26047 `"Cooper"', add
label define bpld_lbl 26048 `"Jost Van Dyke"', add
label define bpld_lbl 26049 `"Peter"', add
label define bpld_lbl 26050 `"Tortola"', add
label define bpld_lbl 26051 `"Virgin Gorda"', add
label define bpld_lbl 26052 `"Br. Virgin Islands, ns"', add
label define bpld_lbl 26053 `"Cayman Islands"', add
label define bpld_lbl 26054 `"Dominica"', add
label define bpld_lbl 26055 `"Grenada"', add
label define bpld_lbl 26056 `"Montserrat"', add
label define bpld_lbl 26057 `"St. Kitts-Nevis"', add
label define bpld_lbl 26058 `"St. Lucia"', add
label define bpld_lbl 26059 `"St. Vincent"', add
label define bpld_lbl 26060 `"Trinidad and Tobago"', add
label define bpld_lbl 26061 `"Turks and Caicos"', add
label define bpld_lbl 26069 `"Br. Virgin Islands, ns"', add
label define bpld_lbl 26070 `"Other West Indies"', add
label define bpld_lbl 26071 `"Aruba"', add
label define bpld_lbl 26072 `"Netherlands Antilles"', add
label define bpld_lbl 26073 `"Bonaire"', add
label define bpld_lbl 26074 `"Curacao"', add
label define bpld_lbl 26075 `"Dutch St. Maarten"', add
label define bpld_lbl 26076 `"Saba"', add
label define bpld_lbl 26077 `"St. Eustatius"', add
label define bpld_lbl 26079 `"Dutch Caribbean, ns"', add
label define bpld_lbl 26080 `"French St. Maarten"', add
label define bpld_lbl 26081 `"Guadeloupe"', add
label define bpld_lbl 26082 `"Martinique"', add
label define bpld_lbl 26083 `"St. Barthelemy"', add
label define bpld_lbl 26089 `"French Caribbean, ns"', add
label define bpld_lbl 26090 `"Antilles, ns"', add
label define bpld_lbl 26091 `"Caribbean, ns"', add
label define bpld_lbl 26092 `"Latin America, ns"', add
label define bpld_lbl 26093 `"Leeward Islands, ns"', add
label define bpld_lbl 26094 `"West Indies, ns"', add
label define bpld_lbl 26095 `"Windward Islands, ns"', add
label define bpld_lbl 29900 `"Americas, ns"', add
label define bpld_lbl 30000 `"South America"', add
label define bpld_lbl 30005 `"Argentina"', add
label define bpld_lbl 30010 `"Bolivia"', add
label define bpld_lbl 30015 `"Brazil"', add
label define bpld_lbl 30020 `"Chile"', add
label define bpld_lbl 30025 `"Colombia"', add
label define bpld_lbl 30030 `"Ecuador"', add
label define bpld_lbl 30035 `"French Guiana"', add
label define bpld_lbl 30040 `"Guyana/British Guiana"', add
label define bpld_lbl 30045 `"Paraguay"', add
label define bpld_lbl 30050 `"Peru"', add
label define bpld_lbl 30055 `"Suriname"', add
label define bpld_lbl 30060 `"Uruguay"', add
label define bpld_lbl 30065 `"Venezuela"', add
label define bpld_lbl 30090 `"South America, ns"', add
label define bpld_lbl 30091 `"South and Central America, n.s."', add
label define bpld_lbl 40000 `"Denmark"', add
label define bpld_lbl 40010 `"Faeroe Islands"', add
label define bpld_lbl 40100 `"Finland"', add
label define bpld_lbl 40200 `"Iceland"', add
label define bpld_lbl 40300 `"Lapland, ns"', add
label define bpld_lbl 40400 `"Norway"', add
label define bpld_lbl 40410 `"Svalbard and Jan Meyen"', add
label define bpld_lbl 40411 `"Svalbard"', add
label define bpld_lbl 40412 `"Jan Meyen"', add
label define bpld_lbl 40500 `"Sweden"', add
label define bpld_lbl 41000 `"England"', add
label define bpld_lbl 41010 `"Channel Islands"', add
label define bpld_lbl 41011 `"Guernsey"', add
label define bpld_lbl 41012 `"Jersey"', add
label define bpld_lbl 41020 `"Isle of Man"', add
label define bpld_lbl 41100 `"Scotland"', add
label define bpld_lbl 41200 `"Wales"', add
label define bpld_lbl 41300 `"United Kingdom, ns"', add
label define bpld_lbl 41400 `"Ireland"', add
label define bpld_lbl 41410 `"Northern Ireland"', add
label define bpld_lbl 41900 `"Northern Europe, ns"', add
label define bpld_lbl 42000 `"Belgium"', add
label define bpld_lbl 42100 `"France"', add
label define bpld_lbl 42110 `"Alsace-Lorraine"', add
label define bpld_lbl 42111 `"Alsace"', add
label define bpld_lbl 42112 `"Lorraine"', add
label define bpld_lbl 42200 `"Liechtenstein"', add
label define bpld_lbl 42300 `"Luxembourg"', add
label define bpld_lbl 42400 `"Monaco"', add
label define bpld_lbl 42500 `"Netherlands"', add
label define bpld_lbl 42600 `"Switzerland"', add
label define bpld_lbl 42900 `"Western Europe, ns"', add
label define bpld_lbl 43000 `"Albania"', add
label define bpld_lbl 43100 `"Andorra"', add
label define bpld_lbl 43200 `"Gibraltar"', add
label define bpld_lbl 43300 `"Greece"', add
label define bpld_lbl 43310 `"Dodecanese Islands"', add
label define bpld_lbl 43320 `"Turkey Greece"', add
label define bpld_lbl 43330 `"Macedonia"', add
label define bpld_lbl 43400 `"Italy"', add
label define bpld_lbl 43500 `"Malta"', add
label define bpld_lbl 43600 `"Portugal"', add
label define bpld_lbl 43610 `"Azores"', add
label define bpld_lbl 43620 `"Madeira Islands"', add
label define bpld_lbl 43630 `"Cape Verde Islands"', add
label define bpld_lbl 43640 `"St. Miguel"', add
label define bpld_lbl 43700 `"San Marino"', add
label define bpld_lbl 43800 `"Spain"', add
label define bpld_lbl 43900 `"Vatican City"', add
label define bpld_lbl 44000 `"Southern Europe, ns"', add
label define bpld_lbl 45000 `"Austria"', add
label define bpld_lbl 45010 `"Austria-Hungary"', add
label define bpld_lbl 45020 `"Austria-Graz"', add
label define bpld_lbl 45030 `"Austria-Linz"', add
label define bpld_lbl 45040 `"Austria-Salzburg"', add
label define bpld_lbl 45050 `"Austria-Tyrol"', add
label define bpld_lbl 45060 `"Austria-Vienna"', add
label define bpld_lbl 45070 `"Austria-Kaernsten"', add
label define bpld_lbl 45080 `"Austria-Neustadt"', add
label define bpld_lbl 45100 `"Bulgaria"', add
label define bpld_lbl 45200 `"Czechoslovakia"', add
label define bpld_lbl 45210 `"Bohemia"', add
label define bpld_lbl 45211 `"Bohemia-Moravia"', add
label define bpld_lbl 45212 `"Slovakia"', add
label define bpld_lbl 45213 `"Czech Republic"', add
label define bpld_lbl 45300 `"Germany"', add
label define bpld_lbl 45301 `"Berlin"', add
label define bpld_lbl 45302 `"West Berlin"', add
label define bpld_lbl 45303 `"East Berlin"', add
label define bpld_lbl 45310 `"West Germany"', add
label define bpld_lbl 45311 `"Baden"', add
label define bpld_lbl 45312 `"Bavaria"', add
label define bpld_lbl 45313 `"Braunschweig"', add
label define bpld_lbl 45314 `"Bremen"', add
label define bpld_lbl 45315 `"Hamburg"', add
label define bpld_lbl 45316 `"Hanover"', add
label define bpld_lbl 45317 `"Hessen"', add
label define bpld_lbl 45318 `"Hesse-Nassau"', add
label define bpld_lbl 45319 `"Lippe"', add
label define bpld_lbl 45320 `"Lubeck"', add
label define bpld_lbl 45321 `"Oldenburg"', add
label define bpld_lbl 45322 `"Rheinland"', add
label define bpld_lbl 45323 `"Schaumburg-Lippe"', add
label define bpld_lbl 45324 `"Schleswig"', add
label define bpld_lbl 45325 `"Sigmaringen"', add
label define bpld_lbl 45326 `"Schwarzburg"', add
label define bpld_lbl 45327 `"Westphalia"', add
label define bpld_lbl 45328 `"Wurttemberg"', add
label define bpld_lbl 45329 `"Waldeck"', add
label define bpld_lbl 45330 `"Wittenberg"', add
label define bpld_lbl 45331 `"Frankfurt"', add
label define bpld_lbl 45332 `"Saarland"', add
label define bpld_lbl 45333 `"Nordrhein-Westfalen"', add
label define bpld_lbl 45340 `"East Germany"', add
label define bpld_lbl 45341 `"Anhalt"', add
label define bpld_lbl 45342 `"Brandenburg"', add
label define bpld_lbl 45344 `"Kingdom of Saxony"', add
label define bpld_lbl 45345 `"Mecklenburg"', add
label define bpld_lbl 45346 `"Saxony"', add
label define bpld_lbl 45347 `"Thuringian States"', add
label define bpld_lbl 45348 `"Sachsen-Meiningen"', add
label define bpld_lbl 45349 `"Sachsen-Weimar-Eisenach"', add
label define bpld_lbl 45350 `"Probable Saxony"', add
label define bpld_lbl 45351 `"Schwerin"', add
label define bpld_lbl 45352 `"Strelitz"', add
label define bpld_lbl 45353 `"Probably Thuringian States"', add
label define bpld_lbl 45360 `"Prussia, nec"', add
label define bpld_lbl 45361 `"Hohenzollern"', add
label define bpld_lbl 45362 `"Niedersachsen"', add
label define bpld_lbl 45400 `"Hungary"', add
label define bpld_lbl 45500 `"Poland"', add
label define bpld_lbl 45510 `"Austrian Poland"', add
label define bpld_lbl 45511 `"Galicia"', add
label define bpld_lbl 45520 `"German Poland"', add
label define bpld_lbl 45521 `"East Prussia"', add
label define bpld_lbl 45522 `"Pomerania"', add
label define bpld_lbl 45523 `"Posen"', add
label define bpld_lbl 45524 `"Prussian Poland"', add
label define bpld_lbl 45525 `"Silesia"', add
label define bpld_lbl 45526 `"West Prussia"', add
label define bpld_lbl 45530 `"Russian Poland"', add
label define bpld_lbl 45600 `"Romania"', add
label define bpld_lbl 45610 `"Transylvania"', add
label define bpld_lbl 45700 `"Yugoslavia"', add
label define bpld_lbl 45710 `"Croatia"', add
label define bpld_lbl 45720 `"Montenegro"', add
label define bpld_lbl 45730 `"Serbia"', add
label define bpld_lbl 45740 `"Bosnia"', add
label define bpld_lbl 45750 `"Dalmatia"', add
label define bpld_lbl 45760 `"Slovonia"', add
label define bpld_lbl 45770 `"Carniola"', add
label define bpld_lbl 45780 `"Slovenia"', add
label define bpld_lbl 45790 `"Kosovo"', add
label define bpld_lbl 45800 `"Central Europe, ns"', add
label define bpld_lbl 45900 `"Eastern Europe, ns"', add
label define bpld_lbl 46000 `"Estonia"', add
label define bpld_lbl 46100 `"Latvia"', add
label define bpld_lbl 46200 `"Lithuania"', add
label define bpld_lbl 46300 `"Baltic States, ns"', add
label define bpld_lbl 46500 `"Other USSR/Russia"', add
label define bpld_lbl 46510 `"Byelorussia"', add
label define bpld_lbl 46520 `"Moldavia"', add
label define bpld_lbl 46521 `"Bessarabia"', add
label define bpld_lbl 46530 `"Ukraine"', add
label define bpld_lbl 46540 `"Armenia"', add
label define bpld_lbl 46541 `"Azerbaijan"', add
label define bpld_lbl 46542 `"Republic of Georgia"', add
label define bpld_lbl 46543 `"Kazakhstan"', add
label define bpld_lbl 46544 `"Kirghizia"', add
label define bpld_lbl 46545 `"Tadzhik"', add
label define bpld_lbl 46546 `"Turkmenistan"', add
label define bpld_lbl 46547 `"Uzbekistan"', add
label define bpld_lbl 46548 `"Siberia"', add
label define bpld_lbl 46590 `"USSR, ns"', add
label define bpld_lbl 49900 `"Europe, ns."', add
label define bpld_lbl 50000 `"China"', add
label define bpld_lbl 50010 `"Hong Kong"', add
label define bpld_lbl 50020 `"Macau"', add
label define bpld_lbl 50030 `"Mongolia"', add
label define bpld_lbl 50040 `"Taiwan"', add
label define bpld_lbl 50100 `"Japan"', add
label define bpld_lbl 50200 `"Korea"', add
label define bpld_lbl 50210 `"North Korea"', add
label define bpld_lbl 50220 `"South Korea"', add
label define bpld_lbl 50900 `"East Asia, ns"', add
label define bpld_lbl 51000 `"Brunei"', add
label define bpld_lbl 51100 `"Cambodia (Kampuchea)"', add
label define bpld_lbl 51200 `"Indonesia"', add
label define bpld_lbl 51210 `"East Indies"', add
label define bpld_lbl 51220 `"East Timor"', add
label define bpld_lbl 51300 `"Laos"', add
label define bpld_lbl 51400 `"Malaysia"', add
label define bpld_lbl 51500 `"Philippines"', add
label define bpld_lbl 51600 `"Singapore"', add
label define bpld_lbl 51700 `"Thailand"', add
label define bpld_lbl 51800 `"Vietnam"', add
label define bpld_lbl 51900 `"Southeast Asia, ns"', add
label define bpld_lbl 51910 `"Indochina, ns"', add
label define bpld_lbl 52000 `"Afghanistan"', add
label define bpld_lbl 52100 `"India"', add
label define bpld_lbl 52110 `"Bangladesh"', add
label define bpld_lbl 52120 `"Bhutan"', add
label define bpld_lbl 52130 `"Burma (Myanmar)"', add
label define bpld_lbl 52140 `"Pakistan"', add
label define bpld_lbl 52150 `"Sri Lanka (Ceylon)"', add
label define bpld_lbl 52200 `"Iran"', add
label define bpld_lbl 52300 `"Maldives"', add
label define bpld_lbl 52400 `"Nepal"', add
label define bpld_lbl 53000 `"Bahrain"', add
label define bpld_lbl 53100 `"Cyprus"', add
label define bpld_lbl 53200 `"Iraq"', add
label define bpld_lbl 53210 `"Mesopotamia"', add
label define bpld_lbl 53300 `"Iraq/Saudi Arabia"', add
label define bpld_lbl 53400 `"Israel/Palestine"', add
label define bpld_lbl 53410 `"Gaza Strip"', add
label define bpld_lbl 53420 `"Palestine"', add
label define bpld_lbl 53430 `"West Bank"', add
label define bpld_lbl 53440 `"Israel"', add
label define bpld_lbl 53500 `"Jordan"', add
label define bpld_lbl 53600 `"Kuwait"', add
label define bpld_lbl 53700 `"Lebanon"', add
label define bpld_lbl 53800 `"Oman"', add
label define bpld_lbl 53900 `"Qatar"', add
label define bpld_lbl 54000 `"Saudi Arabia"', add
label define bpld_lbl 54100 `"Syria"', add
label define bpld_lbl 54200 `"Turkey"', add
label define bpld_lbl 54210 `"European Turkey"', add
label define bpld_lbl 54220 `"Asian Turkey"', add
label define bpld_lbl 54300 `"United Arab Emirates"', add
label define bpld_lbl 54400 `"Yemen Arab Republic (North)"', add
label define bpld_lbl 54500 `"Yemen, PDR (South)"', add
label define bpld_lbl 54600 `"Persian Gulf States, ns"', add
label define bpld_lbl 54700 `"Middle East, ns"', add
label define bpld_lbl 54800 `"Southwest Asia, nec/ns"', add
label define bpld_lbl 54900 `"Asia Minor, ns"', add
label define bpld_lbl 55000 `"South Asia, nec"', add
label define bpld_lbl 59900 `"Asia, nec/ns"', add
label define bpld_lbl 60000 `"Africa"', add
label define bpld_lbl 60010 `"Northern Africa"', add
label define bpld_lbl 60011 `"Algeria"', add
label define bpld_lbl 60012 `"Egypt/United Arab Rep."', add
label define bpld_lbl 60013 `"Libya"', add
label define bpld_lbl 60014 `"Morocco"', add
label define bpld_lbl 60015 `"Sudan"', add
label define bpld_lbl 60016 `"Tunisia"', add
label define bpld_lbl 60017 `"Western Sahara"', add
label define bpld_lbl 60019 `"North Africa, ns"', add
label define bpld_lbl 60020 `"Benin"', add
label define bpld_lbl 60021 `"Burkina Faso"', add
label define bpld_lbl 60022 `"Gambia"', add
label define bpld_lbl 60023 `"Ghana"', add
label define bpld_lbl 60024 `"Guinea"', add
label define bpld_lbl 60025 `"Guinea-Bissau"', add
label define bpld_lbl 60026 `"Ivory Coast"', add
label define bpld_lbl 60027 `"Liberia"', add
label define bpld_lbl 60028 `"Mali"', add
label define bpld_lbl 60029 `"Mauritania"', add
label define bpld_lbl 60030 `"Niger"', add
label define bpld_lbl 60031 `"Nigeria"', add
label define bpld_lbl 60032 `"Senegal"', add
label define bpld_lbl 60033 `"Sierra Leone"', add
label define bpld_lbl 60034 `"Togo"', add
label define bpld_lbl 60038 `"Western Africa, ns"', add
label define bpld_lbl 60039 `"French West Africa, ns"', add
label define bpld_lbl 60040 `"British Indian Ocean Territory"', add
label define bpld_lbl 60041 `"Burundi"', add
label define bpld_lbl 60042 `"Comoros"', add
label define bpld_lbl 60043 `"Djibouti"', add
label define bpld_lbl 60044 `"Ethiopia"', add
label define bpld_lbl 60045 `"Kenya"', add
label define bpld_lbl 60046 `"Madagascar"', add
label define bpld_lbl 60047 `"Malawi"', add
label define bpld_lbl 60048 `"Mauritius"', add
label define bpld_lbl 60049 `"Mozambique"', add
label define bpld_lbl 60050 `"Reunion"', add
label define bpld_lbl 60051 `"Rwanda"', add
label define bpld_lbl 60052 `"Seychelles"', add
label define bpld_lbl 60053 `"Somalia"', add
label define bpld_lbl 60054 `"Tanzania"', add
label define bpld_lbl 60055 `"Uganda"', add
label define bpld_lbl 60056 `"Zambia"', add
label define bpld_lbl 60057 `"Zimbabwe"', add
label define bpld_lbl 60058 `"Bassas de India"', add
label define bpld_lbl 60059 `"Europa"', add
label define bpld_lbl 60060 `"Gloriosos"', add
label define bpld_lbl 60061 `"Juan de Nova"', add
label define bpld_lbl 60062 `"Mayotte"', add
label define bpld_lbl 60063 `"Tromelin"', add
label define bpld_lbl 60064 `"Eastern Africa, nec/ns"', add
label define bpld_lbl 60065 `"Eritrea"', add
label define bpld_lbl 60066 `"South Sudan"', add
label define bpld_lbl 60070 `"Central Africa"', add
label define bpld_lbl 60071 `"Angola"', add
label define bpld_lbl 60072 `"Cameroon"', add
label define bpld_lbl 60073 `"Central African Republic"', add
label define bpld_lbl 60074 `"Chad"', add
label define bpld_lbl 60075 `"Congo"', add
label define bpld_lbl 60076 `"Equatorial Guinea"', add
label define bpld_lbl 60077 `"Gabon"', add
label define bpld_lbl 60078 `"Sao Tome and Principe"', add
label define bpld_lbl 60079 `"Zaire"', add
label define bpld_lbl 60080 `"Central Africa, ns"', add
label define bpld_lbl 60081 `"Equatorial Africa, ns"', add
label define bpld_lbl 60082 `"French Equatorial Africa, ns"', add
label define bpld_lbl 60090 `"Southern Africa"', add
label define bpld_lbl 60091 `"Botswana"', add
label define bpld_lbl 60092 `"Lesotho"', add
label define bpld_lbl 60093 `"Namibia"', add
label define bpld_lbl 60094 `"South Africa (Union of)"', add
label define bpld_lbl 60095 `"Swaziland"', add
label define bpld_lbl 60096 `"Southern Africa, ns"', add
label define bpld_lbl 60099 `"Africa, ns/nec"', add
label define bpld_lbl 70000 `"Australia and New Zealand"', add
label define bpld_lbl 70010 `"Australia"', add
label define bpld_lbl 70011 `"Ashmore and Cartier Islands"', add
label define bpld_lbl 70012 `"Coral Sea Islands Territory"', add
label define bpld_lbl 70013 `"Christmas Island"', add
label define bpld_lbl 70014 `"Cocos Islands"', add
label define bpld_lbl 70020 `"New Zealand"', add
label define bpld_lbl 71000 `"Pacific Islands"', add
label define bpld_lbl 71010 `"New Caledonia"', add
label define bpld_lbl 71012 `"Papua New Guinea"', add
label define bpld_lbl 71013 `"Solomon Islands"', add
label define bpld_lbl 71014 `"Vanuatu (New Hebrides)"', add
label define bpld_lbl 71015 `"Fiji"', add
label define bpld_lbl 71016 `"Melanesia, ns"', add
label define bpld_lbl 71017 `"Norfolk Islands"', add
label define bpld_lbl 71018 `"Niue"', add
label define bpld_lbl 71020 `"Cook Islands"', add
label define bpld_lbl 71022 `"French Polynesia"', add
label define bpld_lbl 71023 `"Tonga"', add
label define bpld_lbl 71024 `"Wallis and Futuna Islands"', add
label define bpld_lbl 71025 `"Western Samoa"', add
label define bpld_lbl 71026 `"Pitcairn Island"', add
label define bpld_lbl 71027 `"Tokelau"', add
label define bpld_lbl 71028 `"Tuvalu"', add
label define bpld_lbl 71029 `"Polynesia, ns"', add
label define bpld_lbl 71032 `"Kiribati"', add
label define bpld_lbl 71033 `"Canton and Enderbury"', add
label define bpld_lbl 71034 `"Nauru"', add
label define bpld_lbl 71039 `"Micronesia, ns"', add
label define bpld_lbl 71040 `"US Pacific Trust Territories"', add
label define bpld_lbl 71041 `"Marshall Islands"', add
label define bpld_lbl 71042 `"Micronesia"', add
label define bpld_lbl 71043 `"Kosrae"', add
label define bpld_lbl 71044 `"Pohnpei"', add
label define bpld_lbl 71045 `"Truk"', add
label define bpld_lbl 71046 `"Yap"', add
label define bpld_lbl 71047 `"Northern Mariana Islands"', add
label define bpld_lbl 71048 `"Palau"', add
label define bpld_lbl 71049 `"Pacific Trust Terr, ns"', add
label define bpld_lbl 71050 `"Clipperton Island"', add
label define bpld_lbl 71090 `"Oceania, ns/nec"', add
label define bpld_lbl 80000 `"Antarctica, ns/nec"', add
label define bpld_lbl 80010 `"Bouvet Islands"', add
label define bpld_lbl 80020 `"British Antarctic Terr."', add
label define bpld_lbl 80030 `"Dronning Maud Land"', add
label define bpld_lbl 80040 `"French Southern and Antarctic Lands"', add
label define bpld_lbl 80050 `"Heard and McDonald Islands"', add
label define bpld_lbl 90000 `"Abroad (unknown) or at sea"', add
label define bpld_lbl 90010 `"Abroad, ns"', add
label define bpld_lbl 90011 `"Abroad (US citizen)"', add
label define bpld_lbl 90020 `"At sea"', add
label define bpld_lbl 90021 `"At sea (US citizen)"', add
label define bpld_lbl 90022 `"At sea or abroad (U.S. citizen)"', add
label define bpld_lbl 95000 `"Other n.e.c."', add
label define bpld_lbl 99900 `"Missing/blank"', add
label values bpld bpld_lbl

label define yrimmig_lbl 0000 `"N/A"'
label define yrimmig_lbl 1790 `"1790"', add
label define yrimmig_lbl 1791 `"1791"', add
label define yrimmig_lbl 1792 `"1792"', add
label define yrimmig_lbl 1793 `"1793"', add
label define yrimmig_lbl 1794 `"1794"', add
label define yrimmig_lbl 1795 `"1795"', add
label define yrimmig_lbl 1796 `"1796"', add
label define yrimmig_lbl 1797 `"1797"', add
label define yrimmig_lbl 1798 `"1798"', add
label define yrimmig_lbl 1799 `"1799"', add
label define yrimmig_lbl 1800 `"1800"', add
label define yrimmig_lbl 1801 `"1801"', add
label define yrimmig_lbl 1802 `"1802"', add
label define yrimmig_lbl 1803 `"1803"', add
label define yrimmig_lbl 1804 `"1804"', add
label define yrimmig_lbl 1805 `"1805"', add
label define yrimmig_lbl 1806 `"1806"', add
label define yrimmig_lbl 1807 `"1807"', add
label define yrimmig_lbl 1808 `"1808"', add
label define yrimmig_lbl 1809 `"1809"', add
label define yrimmig_lbl 1810 `"1810"', add
label define yrimmig_lbl 1811 `"1811"', add
label define yrimmig_lbl 1812 `"1812"', add
label define yrimmig_lbl 1813 `"1813"', add
label define yrimmig_lbl 1814 `"1814"', add
label define yrimmig_lbl 1815 `"1815"', add
label define yrimmig_lbl 1816 `"1816"', add
label define yrimmig_lbl 1817 `"1817"', add
label define yrimmig_lbl 1818 `"1818"', add
label define yrimmig_lbl 1819 `"1819"', add
label define yrimmig_lbl 1820 `"1820"', add
label define yrimmig_lbl 1821 `"1821"', add
label define yrimmig_lbl 1822 `"1822"', add
label define yrimmig_lbl 1823 `"1823"', add
label define yrimmig_lbl 1824 `"1824"', add
label define yrimmig_lbl 1825 `"1825"', add
label define yrimmig_lbl 1826 `"1826"', add
label define yrimmig_lbl 1827 `"1827"', add
label define yrimmig_lbl 1828 `"1828"', add
label define yrimmig_lbl 1829 `"1829"', add
label define yrimmig_lbl 1830 `"1830"', add
label define yrimmig_lbl 1831 `"1831"', add
label define yrimmig_lbl 1832 `"1832"', add
label define yrimmig_lbl 1833 `"1833"', add
label define yrimmig_lbl 1834 `"1834"', add
label define yrimmig_lbl 1835 `"1835"', add
label define yrimmig_lbl 1836 `"1836"', add
label define yrimmig_lbl 1837 `"1837"', add
label define yrimmig_lbl 1838 `"1838"', add
label define yrimmig_lbl 1839 `"1839"', add
label define yrimmig_lbl 1840 `"1840"', add
label define yrimmig_lbl 1841 `"1841"', add
label define yrimmig_lbl 1842 `"1842"', add
label define yrimmig_lbl 1843 `"1843"', add
label define yrimmig_lbl 1844 `"1844"', add
label define yrimmig_lbl 1845 `"1845"', add
label define yrimmig_lbl 1846 `"1846"', add
label define yrimmig_lbl 1847 `"1847"', add
label define yrimmig_lbl 1848 `"1848"', add
label define yrimmig_lbl 1849 `"1849"', add
label define yrimmig_lbl 1850 `"1850"', add
label define yrimmig_lbl 1851 `"1851"', add
label define yrimmig_lbl 1852 `"1852"', add
label define yrimmig_lbl 1853 `"1853"', add
label define yrimmig_lbl 1854 `"1854"', add
label define yrimmig_lbl 1855 `"1855"', add
label define yrimmig_lbl 1856 `"1856"', add
label define yrimmig_lbl 1857 `"1857"', add
label define yrimmig_lbl 1858 `"1858"', add
label define yrimmig_lbl 1859 `"1859"', add
label define yrimmig_lbl 1860 `"1860"', add
label define yrimmig_lbl 1861 `"1861"', add
label define yrimmig_lbl 1862 `"1862"', add
label define yrimmig_lbl 1863 `"1863"', add
label define yrimmig_lbl 1864 `"1864"', add
label define yrimmig_lbl 1865 `"1865"', add
label define yrimmig_lbl 1866 `"1866"', add
label define yrimmig_lbl 1867 `"1867"', add
label define yrimmig_lbl 1868 `"1868"', add
label define yrimmig_lbl 1869 `"1869"', add
label define yrimmig_lbl 1870 `"1870"', add
label define yrimmig_lbl 1871 `"1871"', add
label define yrimmig_lbl 1872 `"1872"', add
label define yrimmig_lbl 1873 `"1873"', add
label define yrimmig_lbl 1874 `"1874"', add
label define yrimmig_lbl 1875 `"1875"', add
label define yrimmig_lbl 1876 `"1876"', add
label define yrimmig_lbl 1877 `"1877"', add
label define yrimmig_lbl 1878 `"1878"', add
label define yrimmig_lbl 1879 `"1879"', add
label define yrimmig_lbl 1880 `"1880"', add
label define yrimmig_lbl 1881 `"1881"', add
label define yrimmig_lbl 1882 `"1882"', add
label define yrimmig_lbl 1883 `"1883"', add
label define yrimmig_lbl 1884 `"1884"', add
label define yrimmig_lbl 1885 `"1885"', add
label define yrimmig_lbl 1886 `"1886"', add
label define yrimmig_lbl 1887 `"1887"', add
label define yrimmig_lbl 1888 `"1888"', add
label define yrimmig_lbl 1889 `"1889"', add
label define yrimmig_lbl 1890 `"1890"', add
label define yrimmig_lbl 1891 `"1891"', add
label define yrimmig_lbl 1892 `"1892"', add
label define yrimmig_lbl 1893 `"1893"', add
label define yrimmig_lbl 1894 `"1894"', add
label define yrimmig_lbl 1895 `"1895"', add
label define yrimmig_lbl 1896 `"1896"', add
label define yrimmig_lbl 1897 `"1897"', add
label define yrimmig_lbl 1898 `"1898"', add
label define yrimmig_lbl 1899 `"1899"', add
label define yrimmig_lbl 1900 `"1900"', add
label define yrimmig_lbl 1901 `"1901"', add
label define yrimmig_lbl 1902 `"1902"', add
label define yrimmig_lbl 1903 `"1903"', add
label define yrimmig_lbl 1904 `"1904"', add
label define yrimmig_lbl 1905 `"1905"', add
label define yrimmig_lbl 1906 `"1906"', add
label define yrimmig_lbl 1907 `"1907"', add
label define yrimmig_lbl 1908 `"1908"', add
label define yrimmig_lbl 1909 `"1909"', add
label define yrimmig_lbl 1910 `"1910 (2000-onward: 1910 or earlier)"', add
label define yrimmig_lbl 1911 `"1911"', add
label define yrimmig_lbl 1912 `"1912"', add
label define yrimmig_lbl 1913 `"1913"', add
label define yrimmig_lbl 1914 `"1914 (1970 PUMS, 2000 5%/1%: 1911-1914)"', add
label define yrimmig_lbl 1915 `"1915"', add
label define yrimmig_lbl 1916 `"1916"', add
label define yrimmig_lbl 1917 `"1917"', add
label define yrimmig_lbl 1918 `"1918"', add
label define yrimmig_lbl 1919 `"1919 (2000 5%/1%: 1915-1919; pre 2012 ACS: 1919 or earlier)"', add
label define yrimmig_lbl 1920 `"1920"', add
label define yrimmig_lbl 1921 `"1921 (1921 or earlier 2012 ACS)"', add
label define yrimmig_lbl 1922 `"1922 (1922-1923 2012 ACS)"', add
label define yrimmig_lbl 1923 `"1923"', add
label define yrimmig_lbl 1924 `"1924 (1970 PUMS: 1915-1924, 2012 ACS: 1924-1925)"', add
label define yrimmig_lbl 1925 `"1925"', add
label define yrimmig_lbl 1926 `"1926 (1926-1927 2012 ACS)"', add
label define yrimmig_lbl 1927 `"1927"', add
label define yrimmig_lbl 1928 `"1928 (1928-1929 2012 ACS)"', add
label define yrimmig_lbl 1929 `"1929"', add
label define yrimmig_lbl 1930 `"1930 (1930-1931 2012 ACS)"', add
label define yrimmig_lbl 1931 `"1931"', add
label define yrimmig_lbl 1932 `"1932: (2005-onward pre 2012 ACS: 1931-1932, 2012 ACS: 1932-1934)"', add
label define yrimmig_lbl 1933 `"1933"', add
label define yrimmig_lbl 1934 `"1934 (1970 PUMS: 1925-1934; 2000 5%/1%: 1930-1934; 2005-onward ACS: 1933-1934)"', add
label define yrimmig_lbl 1935 `"1935 (1935-1936 2012 ACS)"', add
label define yrimmig_lbl 1936 `"1936"', add
label define yrimmig_lbl 1937 `"1937 (1937-1938 2012 ACS)"', add
label define yrimmig_lbl 1938 `"1938"', add
label define yrimmig_lbl 1939 `"1939"', add
label define yrimmig_lbl 1940 `"1940"', add
label define yrimmig_lbl 1941 `"1941"', add
label define yrimmig_lbl 1942 `"1942"', add
label define yrimmig_lbl 1943 `"1943 (1943-1944 2012 ACS)"', add
label define yrimmig_lbl 1944 `"1944 (1970 PUMS: 1935-1944)"', add
label define yrimmig_lbl 1945 `"1945"', add
label define yrimmig_lbl 1946 `"1946"', add
label define yrimmig_lbl 1947 `"1947"', add
label define yrimmig_lbl 1948 `"1948"', add
label define yrimmig_lbl 1949 `"1949 (1970 PUMS: 1945-1949; 1980-1990 PUMS: 1949 or earlier)"', add
label define yrimmig_lbl 1950 `"1950"', add
label define yrimmig_lbl 1951 `"1951"', add
label define yrimmig_lbl 1952 `"1952"', add
label define yrimmig_lbl 1953 `"1953"', add
label define yrimmig_lbl 1954 `"1954 (1970 PUMS: 1950-1954)"', add
label define yrimmig_lbl 1955 `"1955"', add
label define yrimmig_lbl 1956 `"1956"', add
label define yrimmig_lbl 1957 `"1957"', add
label define yrimmig_lbl 1958 `"1958"', add
label define yrimmig_lbl 1959 `"1959 (1970 PUMS: 1955-1959; 1980-1990 PUMS: 1950-1959)"', add
label define yrimmig_lbl 1960 `"1960"', add
label define yrimmig_lbl 1961 `"1961"', add
label define yrimmig_lbl 1962 `"1962"', add
label define yrimmig_lbl 1963 `"1963"', add
label define yrimmig_lbl 1964 `"1964 (1970-1990 PUMS: 1960-1964)"', add
label define yrimmig_lbl 1965 `"1965"', add
label define yrimmig_lbl 1966 `"1966"', add
label define yrimmig_lbl 1967 `"1967"', add
label define yrimmig_lbl 1968 `"1968"', add
label define yrimmig_lbl 1969 `"1969 (1980-1990 PUMS: 1965-1969)"', add
label define yrimmig_lbl 1970 `"1970 (1970 PUMS: 1965-1970)"', add
label define yrimmig_lbl 1971 `"1971"', add
label define yrimmig_lbl 1972 `"1972"', add
label define yrimmig_lbl 1973 `"1973"', add
label define yrimmig_lbl 1974 `"1974 (1980-1990 PUMS: 1970-1974)"', add
label define yrimmig_lbl 1975 `"1975"', add
label define yrimmig_lbl 1976 `"1976"', add
label define yrimmig_lbl 1977 `"1977"', add
label define yrimmig_lbl 1978 `"1978"', add
label define yrimmig_lbl 1979 `"1979 (1990 PUMS: 1975-1979)"', add
label define yrimmig_lbl 1980 `"1980 (1980 PUMS: 1975-1980)"', add
label define yrimmig_lbl 1981 `"1981 (1990 PUMS: 1980-1981)"', add
label define yrimmig_lbl 1982 `"1982"', add
label define yrimmig_lbl 1983 `"1983"', add
label define yrimmig_lbl 1984 `"1984 (1990 PUMS: 1982-1984)"', add
label define yrimmig_lbl 1985 `"1985"', add
label define yrimmig_lbl 1986 `"1986 (1990 PUMS: 1985-1986)"', add
label define yrimmig_lbl 1987 `"1987"', add
label define yrimmig_lbl 1988 `"1988"', add
label define yrimmig_lbl 1989 `"1989"', add
label define yrimmig_lbl 1990 `"1990 (1990 PUMS: 1987-1990)"', add
label define yrimmig_lbl 1991 `"1991"', add
label define yrimmig_lbl 1992 `"1992"', add
label define yrimmig_lbl 1993 `"1993"', add
label define yrimmig_lbl 1994 `"1994"', add
label define yrimmig_lbl 1995 `"1995"', add
label define yrimmig_lbl 1996 `"1996"', add
label define yrimmig_lbl 1997 `"1997"', add
label define yrimmig_lbl 1998 `"1998"', add
label define yrimmig_lbl 1999 `"1999"', add
label define yrimmig_lbl 2000 `"2000"', add
label define yrimmig_lbl 2001 `"2001"', add
label define yrimmig_lbl 2002 `"2002"', add
label define yrimmig_lbl 2003 `"2003"', add
label define yrimmig_lbl 2004 `"2004"', add
label define yrimmig_lbl 2005 `"2005"', add
label define yrimmig_lbl 2006 `"2006"', add
label define yrimmig_lbl 2007 `"2007"', add
label define yrimmig_lbl 2008 `"2008"', add
label define yrimmig_lbl 2009 `"2009"', add
label define yrimmig_lbl 2010 `"2010"', add
label define yrimmig_lbl 2011 `"2011"', add
label define yrimmig_lbl 2012 `"2012"', add
label define yrimmig_lbl 2013 `"2013"', add
label define yrimmig_lbl 2014 `"2014"', add
label define yrimmig_lbl 2015 `"2015"', add
label define yrimmig_lbl 0996 `"Not reported"', add
label values yrimmig yrimmig_lbl

label define hisp1970_lbl 0 `"Not Hispanic"'
label define hisp1970_lbl 1 `"Mexican"', add
label define hisp1970_lbl 2 `"Puerto Rican"', add
label define hisp1970_lbl 3 `"Cuban"', add
label define hisp1970_lbl 4 `"Central/South American"', add
label define hisp1970_lbl 5 `"Other Spanish"', add
label define hisp1970_lbl 9 `"Not Reported"', add
label values hisp1970 hisp1970_lbl

label define racesing_lbl 1 `"White"'
label define racesing_lbl 2 `"Black"', add
label define racesing_lbl 3 `"American Indian/Alaska Native"', add
label define racesing_lbl 4 `"Asian and/or Pacific Islander"', add
label define racesing_lbl 5 `"Other race, non-Hispanic"', add
label values racesing racesing_lbl

label define racesingd_lbl 10 `"White"'
label define racesingd_lbl 12 `""Other race", Hispanic"', add
label define racesingd_lbl 20 `"Black"', add
label define racesingd_lbl 21 `"Mulatto"', add
label define racesingd_lbl 30 `"AI (American Indian)"', add
label define racesingd_lbl 31 `"AN (Alaskan Native)"', add
label define racesingd_lbl 32 `"AI/AN (American Indian/Alaskan Native)"', add
label define racesingd_lbl 40 `"Asian Indian"', add
label define racesingd_lbl 41 `"Chinese"', add
label define racesingd_lbl 42 `"Filipino"', add
label define racesingd_lbl 43 `"Japanese"', add
label define racesingd_lbl 44 `"Korean"', add
label define racesingd_lbl 45 `"Asian"', add
label define racesingd_lbl 46 `"Hawaiian"', add
label define racesingd_lbl 47 `"PI (Pacific Islander)"', add
label define racesingd_lbl 48 `"Asian and PI (Pacific Islander)"', add
label define racesingd_lbl 50 `"Other race, non-Hispanic"', add
label define racesingd_lbl 51 `"Other race"', add
label values racesingd racesingd_lbl

label define school_lbl 0 `"N/A"'
label define school_lbl 1 `"No, not in school"', add
label define school_lbl 2 `"Yes, in school"', add
label define school_lbl 9 `"Missing"', add
label values school school_lbl

label define educ_lbl 00 `"N/A or no schooling"'
label define educ_lbl 01 `"Nursery school to grade 4"', add
label define educ_lbl 02 `"Grade 5, 6, 7, or 8"', add
label define educ_lbl 03 `"Grade 9"', add
label define educ_lbl 04 `"Grade 10"', add
label define educ_lbl 05 `"Grade 11"', add
label define educ_lbl 06 `"Grade 12"', add
label define educ_lbl 07 `"1 year of college"', add
label define educ_lbl 08 `"2 years of college"', add
label define educ_lbl 09 `"3 years of college"', add
label define educ_lbl 10 `"4 years of college"', add
label define educ_lbl 11 `"5+ years of college"', add
label values educ educ_lbl

label define educd_lbl 000 `"N/A or no schooling"'
label define educd_lbl 001 `"N/A"', add
label define educd_lbl 002 `"No schooling completed"', add
label define educd_lbl 010 `"Nursery school to grade 4"', add
label define educd_lbl 011 `"Nursery school, preschool"', add
label define educd_lbl 012 `"Kindergarten"', add
label define educd_lbl 013 `"Grade 1, 2, 3, or 4"', add
label define educd_lbl 014 `"Grade 1"', add
label define educd_lbl 015 `"Grade 2"', add
label define educd_lbl 016 `"Grade 3"', add
label define educd_lbl 017 `"Grade 4"', add
label define educd_lbl 020 `"Grade 5, 6, 7, or 8"', add
label define educd_lbl 021 `"Grade 5 or 6"', add
label define educd_lbl 022 `"Grade 5"', add
label define educd_lbl 023 `"Grade 6"', add
label define educd_lbl 024 `"Grade 7 or 8"', add
label define educd_lbl 025 `"Grade 7"', add
label define educd_lbl 026 `"Grade 8"', add
label define educd_lbl 030 `"Grade 9"', add
label define educd_lbl 040 `"Grade 10"', add
label define educd_lbl 050 `"Grade 11"', add
label define educd_lbl 060 `"Grade 12"', add
label define educd_lbl 061 `"12th grade, no diploma"', add
label define educd_lbl 062 `"High school graduate or GED"', add
label define educd_lbl 063 `"Regular high school diploma"', add
label define educd_lbl 064 `"GED or alternative credential"', add
label define educd_lbl 065 `"Some college, but less than 1 year"', add
label define educd_lbl 070 `"1 year of college"', add
label define educd_lbl 071 `"1 or more years of college credit, no degree"', add
label define educd_lbl 080 `"2 years of college"', add
label define educd_lbl 081 `"Associate's degree, type not specified"', add
label define educd_lbl 082 `"Associate's degree, occupational program"', add
label define educd_lbl 083 `"Associate's degree, academic program"', add
label define educd_lbl 090 `"3 years of college"', add
label define educd_lbl 100 `"4 years of college"', add
label define educd_lbl 101 `"Bachelor's degree"', add
label define educd_lbl 110 `"5+ years of college"', add
label define educd_lbl 111 `"6 years of college (6+ in 1960-1970)"', add
label define educd_lbl 112 `"7 years of college"', add
label define educd_lbl 113 `"8+ years of college"', add
label define educd_lbl 114 `"Master's degree"', add
label define educd_lbl 115 `"Professional degree beyond a bachelor's degree"', add
label define educd_lbl 116 `"Doctoral degree"', add
label define educd_lbl 999 `"Missing"', add
label values educd educd_lbl

label define gradeatt_lbl 0 `"N/A"'
label define gradeatt_lbl 1 `"Nursery school/preschool"', add
label define gradeatt_lbl 2 `"Kindergarten"', add
label define gradeatt_lbl 3 `"Grade 1 to grade 4"', add
label define gradeatt_lbl 4 `"Grade 5 to grade 8"', add
label define gradeatt_lbl 5 `"Grade 9 to grade 12"', add
label define gradeatt_lbl 6 `"College undergraduate"', add
label define gradeatt_lbl 7 `"Graduate or professional school"', add
label values gradeatt gradeatt_lbl

label define gradeattd_lbl 00 `"N/A"'
label define gradeattd_lbl 10 `"Nursery school/preschool"', add
label define gradeattd_lbl 20 `"Kindergarten"', add
label define gradeattd_lbl 30 `"Grade 1 to grade 4"', add
label define gradeattd_lbl 31 `"Grade 1"', add
label define gradeattd_lbl 32 `"Grade 2"', add
label define gradeattd_lbl 33 `"Grade 3"', add
label define gradeattd_lbl 34 `"Grade 4"', add
label define gradeattd_lbl 40 `"Grade 5 to grade 8"', add
label define gradeattd_lbl 41 `"Grade 5"', add
label define gradeattd_lbl 42 `"Grade 6"', add
label define gradeattd_lbl 43 `"Grade 7"', add
label define gradeattd_lbl 44 `"Grade 8"', add
label define gradeattd_lbl 50 `"Grade 9 to grade 12"', add
label define gradeattd_lbl 51 `"Grade 9"', add
label define gradeattd_lbl 52 `"Grade 10"', add
label define gradeattd_lbl 53 `"Grade 11"', add
label define gradeattd_lbl 54 `"Grade 12"', add
label define gradeattd_lbl 60 `"College undergraduate"', add
label define gradeattd_lbl 61 `"First year of college"', add
label define gradeattd_lbl 62 `"Second year of college"', add
label define gradeattd_lbl 63 `"Third year of college"', add
label define gradeattd_lbl 64 `"Fourth year of college"', add
label define gradeattd_lbl 70 `"Graduate or professional school"', add
label define gradeattd_lbl 71 `"Fifth year of college"', add
label define gradeattd_lbl 72 `"Sixth year of college"', add
label define gradeattd_lbl 73 `"Seventh year of college"', add
label define gradeattd_lbl 74 `"Eighth year of college"', add
label values gradeattd gradeattd_lbl

label define empstat_lbl 0 `"N/A"'
label define empstat_lbl 1 `"Employed"', add
label define empstat_lbl 2 `"Unemployed"', add
label define empstat_lbl 3 `"Not in labor force"', add
label values empstat empstat_lbl

label define empstatd_lbl 00 `"N/A"'
label define empstatd_lbl 10 `"At work"', add
label define empstatd_lbl 11 `"At work, public emerg"', add
label define empstatd_lbl 12 `"Has job, not working"', add
label define empstatd_lbl 13 `"Armed forces"', add
label define empstatd_lbl 14 `"Armed forces--at work"', add
label define empstatd_lbl 15 `"Armed forces--not at work but with job"', add
label define empstatd_lbl 20 `"Unemployed"', add
label define empstatd_lbl 21 `"Unemp, exper worker"', add
label define empstatd_lbl 22 `"Unemp, new worker"', add
label define empstatd_lbl 30 `"Not in Labor Force"', add
label define empstatd_lbl 31 `"NILF, housework"', add
label define empstatd_lbl 32 `"NILF, unable to work"', add
label define empstatd_lbl 33 `"NILF, school"', add
label define empstatd_lbl 34 `"NILF, other"', add
label values empstatd empstatd_lbl

label define labforce_lbl 0 `"N/A"'
label define labforce_lbl 1 `"No, not in the labor force"', add
label define labforce_lbl 2 `"Yes, in the labor force"', add
label values labforce labforce_lbl

label define occ1950_lbl 000 `"Accountants and auditors"'
label define occ1950_lbl 001 `"Actors and actresses"', add
label define occ1950_lbl 002 `"Airplane pilots and navigators"', add
label define occ1950_lbl 003 `"Architects"', add
label define occ1950_lbl 004 `"Artists and art teachers"', add
label define occ1950_lbl 005 `"Athletes"', add
label define occ1950_lbl 006 `"Authors"', add
label define occ1950_lbl 007 `"Chemists"', add
label define occ1950_lbl 008 `"Chiropractors"', add
label define occ1950_lbl 009 `"Clergymen"', add
label define occ1950_lbl 010 `"College presidents and deans"', add
label define occ1950_lbl 012 `"Agricultural sciences-Professors and instructors"', add
label define occ1950_lbl 013 `"Biological sciences-Professors and instructors"', add
label define occ1950_lbl 014 `"Chemistry-Professors and instructors"', add
label define occ1950_lbl 015 `"Economics-Professors and instructors"', add
label define occ1950_lbl 016 `"Engineering-Professors and instructors"', add
label define occ1950_lbl 017 `"Geology and geophysics-Professors and instructors"', add
label define occ1950_lbl 018 `"Mathematics-Professors and instructors"', add
label define occ1950_lbl 019 `"Medical Sciences-Professors and instructors"', add
label define occ1950_lbl 023 `"Physics-Professors and instructors"', add
label define occ1950_lbl 024 `"Psychology-Professors and instructors"', add
label define occ1950_lbl 025 `"Statistics-Professors and instructors"', add
label define occ1950_lbl 026 `"Natural science (nec)-Professors and instructors"', add
label define occ1950_lbl 027 `"Social sciences (nec)-Professors and instructors"', add
label define occ1950_lbl 028 `"Non-scientific subjects-Professors and instructors"', add
label define occ1950_lbl 029 `"Subject not specified-Professors and instructors"', add
label define occ1950_lbl 031 `"Dancers and dancing teachers"', add
label define occ1950_lbl 032 `"Dentists"', add
label define occ1950_lbl 033 `"Designers"', add
label define occ1950_lbl 034 `"Dietitians and nutritionists"', add
label define occ1950_lbl 035 `"Draftsmen"', add
label define occ1950_lbl 036 `"Editors and reporters"', add
label define occ1950_lbl 041 `"Aeronautical-Engineers"', add
label define occ1950_lbl 042 `"Chemical-Engineers"', add
label define occ1950_lbl 043 `"Civil-Engineers"', add
label define occ1950_lbl 044 `"Electrical-Engineers"', add
label define occ1950_lbl 045 `"Industrial-Engineers"', add
label define occ1950_lbl 046 `"Mechanical-Engineers"', add
label define occ1950_lbl 047 `"Metallurgical, metallurgists-Engineers"', add
label define occ1950_lbl 048 `"Mining-Engineers"', add
label define occ1950_lbl 049 `"Engineers (nec)"', add
label define occ1950_lbl 051 `"Entertainers (nec)"', add
label define occ1950_lbl 052 `"Farm and home management advisors"', add
label define occ1950_lbl 053 `"Foresters and conservationists"', add
label define occ1950_lbl 054 `"Funeral directors and embalmers"', add
label define occ1950_lbl 055 `"Lawyers and judges"', add
label define occ1950_lbl 056 `"Librarians"', add
label define occ1950_lbl 057 `"Musicians and music teachers"', add
label define occ1950_lbl 058 `"Nurses, professional"', add
label define occ1950_lbl 059 `"Nurses, student professional"', add
label define occ1950_lbl 061 `"Agricultural scientists"', add
label define occ1950_lbl 062 `"Biological scientists"', add
label define occ1950_lbl 063 `"Geologists and geophysicists"', add
label define occ1950_lbl 067 `"Mathematicians"', add
label define occ1950_lbl 068 `"Physicists"', add
label define occ1950_lbl 069 `"Misc. natural scientists"', add
label define occ1950_lbl 070 `"Optometrists"', add
label define occ1950_lbl 071 `"Osteopaths"', add
label define occ1950_lbl 072 `"Personnel and labor relations workers"', add
label define occ1950_lbl 073 `"Pharmacists"', add
label define occ1950_lbl 074 `"Photographers"', add
label define occ1950_lbl 075 `"Physicians and surgeons"', add
label define occ1950_lbl 076 `"Radio operators"', add
label define occ1950_lbl 077 `"Recreation and group workers"', add
label define occ1950_lbl 078 `"Religious workers"', add
label define occ1950_lbl 079 `"Social and welfare workers, except group"', add
label define occ1950_lbl 081 `"Economists"', add
label define occ1950_lbl 082 `"Psychologists"', add
label define occ1950_lbl 083 `"Statisticians and actuaries"', add
label define occ1950_lbl 084 `"Misc social scientists"', add
label define occ1950_lbl 091 `"Sports instructors and officials"', add
label define occ1950_lbl 092 `"Surveyors"', add
label define occ1950_lbl 093 `"Teachers (n.e.c.)"', add
label define occ1950_lbl 094 `"Medical and dental-technicians"', add
label define occ1950_lbl 095 `"Testing-technicians"', add
label define occ1950_lbl 096 `"Technicians (nec)"', add
label define occ1950_lbl 097 `"Therapists and healers (nec)"', add
label define occ1950_lbl 098 `"Veterinarians"', add
label define occ1950_lbl 099 `"Professional, technical and kindred workers (nec)"', add
label define occ1950_lbl 100 `"Farmers (owners and tenants)"', add
label define occ1950_lbl 123 `"Farm managers"', add
label define occ1950_lbl 200 `"Buyers and dept heads, store"', add
label define occ1950_lbl 201 `"Buyers and shippers, farm products"', add
label define occ1950_lbl 203 `"Conductors, railroad"', add
label define occ1950_lbl 204 `"Credit men"', add
label define occ1950_lbl 205 `"Floormen and floor managers, store"', add
label define occ1950_lbl 210 `"Inspectors, public administration"', add
label define occ1950_lbl 230 `"Managers and superintendants, building"', add
label define occ1950_lbl 240 `"Officers, pilots, pursers and engineers, ship"', add
label define occ1950_lbl 250 `"Officials and administratators (nec), public administration"', add
label define occ1950_lbl 260 `"Officials, lodge, society, union, etc."', add
label define occ1950_lbl 270 `"Postmasters"', add
label define occ1950_lbl 280 `"Purchasing agents and buyers (nec)"', add
label define occ1950_lbl 290 `"Managers, officials, and proprietors (nec)"', add
label define occ1950_lbl 300 `"Agents (nec)"', add
label define occ1950_lbl 301 `"Attendants and assistants, library"', add
label define occ1950_lbl 302 `"Attendants, physicians and dentists office"', add
label define occ1950_lbl 304 `"Baggagemen, transportation"', add
label define occ1950_lbl 305 `"Bank tellers"', add
label define occ1950_lbl 310 `"Bookkeepers"', add
label define occ1950_lbl 320 `"Cashiers"', add
label define occ1950_lbl 321 `"Collectors, bill and account"', add
label define occ1950_lbl 322 `"Dispatchers and starters, vehicle"', add
label define occ1950_lbl 325 `"Express messengers and railway mail clerks"', add
label define occ1950_lbl 335 `"Mail carriers"', add
label define occ1950_lbl 340 `"Messengers and office boys"', add
label define occ1950_lbl 341 `"Office machine operators"', add
label define occ1950_lbl 342 `"Shipping and receiving clerks"', add
label define occ1950_lbl 350 `"Stenographers, typists, and secretaries"', add
label define occ1950_lbl 360 `"Telegraph messengers"', add
label define occ1950_lbl 365 `"Telegraph operators"', add
label define occ1950_lbl 370 `"Telephone operators"', add
label define occ1950_lbl 380 `"Ticket, station, and express agents"', add
label define occ1950_lbl 390 `"Clerical and kindred workers (n.e.c.)"', add
label define occ1950_lbl 400 `"Advertising agents and salesmen"', add
label define occ1950_lbl 410 `"Auctioneers"', add
label define occ1950_lbl 420 `"Demonstrators"', add
label define occ1950_lbl 430 `"Hucksters and peddlers"', add
label define occ1950_lbl 450 `"Insurance agents and brokers"', add
label define occ1950_lbl 460 `"Newsboys"', add
label define occ1950_lbl 470 `"Real estate agents and brokers"', add
label define occ1950_lbl 480 `"Stock and bond salesmen"', add
label define occ1950_lbl 490 `"Salesmen and sales clerks (nec)"', add
label define occ1950_lbl 500 `"Bakers"', add
label define occ1950_lbl 501 `"Blacksmiths"', add
label define occ1950_lbl 502 `"Bookbinders"', add
label define occ1950_lbl 503 `"Boilermakers"', add
label define occ1950_lbl 504 `"Brickmasons,stonemasons, and tile setters"', add
label define occ1950_lbl 505 `"Cabinetmakers"', add
label define occ1950_lbl 510 `"Carpenters"', add
label define occ1950_lbl 511 `"Cement and concrete finishers"', add
label define occ1950_lbl 512 `"Compositors and typesetters"', add
label define occ1950_lbl 513 `"Cranemen,derrickmen, and hoistmen"', add
label define occ1950_lbl 514 `"Decorators and window dressers"', add
label define occ1950_lbl 515 `"Electricians"', add
label define occ1950_lbl 520 `"Electrotypers and stereotypers"', add
label define occ1950_lbl 521 `"Engravers, except photoengravers"', add
label define occ1950_lbl 522 `"Excavating, grading, and road machinery operators"', add
label define occ1950_lbl 523 `"Foremen (nec)"', add
label define occ1950_lbl 524 `"Forgemen and hammermen"', add
label define occ1950_lbl 525 `"Furriers"', add
label define occ1950_lbl 530 `"Glaziers"', add
label define occ1950_lbl 531 `"Heat treaters, annealers, temperers"', add
label define occ1950_lbl 532 `"Inspectors, scalers, and graders log and lumber"', add
label define occ1950_lbl 533 `"Inspectors (nec)"', add
label define occ1950_lbl 534 `"Jewelers, watchmakers, goldsmiths, and silversmiths"', add
label define occ1950_lbl 535 `"Job setters, metal"', add
label define occ1950_lbl 540 `"Linemen and servicemen, telegraph, telephone, and power"', add
label define occ1950_lbl 541 `"Locomotive engineers"', add
label define occ1950_lbl 542 `"Locomotive firemen"', add
label define occ1950_lbl 543 `"Loom fixers"', add
label define occ1950_lbl 544 `"Machinists"', add
label define occ1950_lbl 545 `"Airplane-mechanics and repairmen"', add
label define occ1950_lbl 550 `"Automobile-mechanics and repairmen"', add
label define occ1950_lbl 551 `"Office machine-mechanics and repairmen"', add
label define occ1950_lbl 552 `"Radio and television-mechanics and repairmen"', add
label define occ1950_lbl 553 `"Railroad and car shop-mechanics and repairmen"', add
label define occ1950_lbl 554 `"Mechanics and repairmen (nec)"', add
label define occ1950_lbl 555 `"Millers, grain, flour, feed, etc"', add
label define occ1950_lbl 560 `"Millwrights"', add
label define occ1950_lbl 561 `"Molders, metal"', add
label define occ1950_lbl 562 `"Motion picture projectionists"', add
label define occ1950_lbl 563 `"Opticians and lens grinders and polishers"', add
label define occ1950_lbl 564 `"Painters, construction and maintenance"', add
label define occ1950_lbl 565 `"Paperhangers"', add
label define occ1950_lbl 570 `"Pattern and model makers, except paper"', add
label define occ1950_lbl 571 `"Photoengravers and lithographers"', add
label define occ1950_lbl 572 `"Piano and organ tuners and repairmen"', add
label define occ1950_lbl 573 `"Plasterers"', add
label define occ1950_lbl 574 `"Plumbers and pipe fitters"', add
label define occ1950_lbl 575 `"Pressmen and plate printers, printing"', add
label define occ1950_lbl 580 `"Rollers and roll hands, metal"', add
label define occ1950_lbl 581 `"Roofers and slaters"', add
label define occ1950_lbl 582 `"Shoemakers and repairers, except factory"', add
label define occ1950_lbl 583 `"Stationary engineers"', add
label define occ1950_lbl 584 `"Stone cutters and stone carvers"', add
label define occ1950_lbl 585 `"Structural metal workers"', add
label define occ1950_lbl 590 `"Tailors and tailoresses"', add
label define occ1950_lbl 591 `"Tinsmiths, coppersmiths, and sheet metal workers"', add
label define occ1950_lbl 592 `"Tool makers, and die makers and setters"', add
label define occ1950_lbl 593 `"Upholsterers"', add
label define occ1950_lbl 594 `"Craftsmen and kindred workers (nec)"', add
label define occ1950_lbl 595 `"Members of the armed services"', add
label define occ1950_lbl 600 `"Auto mechanics apprentice"', add
label define occ1950_lbl 601 `"Bricklayers and masons apprentice"', add
label define occ1950_lbl 602 `"Carpenters apprentice"', add
label define occ1950_lbl 603 `"Electricians apprentice"', add
label define occ1950_lbl 604 `"Machinists and toolmakers apprentice"', add
label define occ1950_lbl 605 `"Mechanics, except auto apprentice"', add
label define occ1950_lbl 610 `"Plumbers and pipe fitters apprentice"', add
label define occ1950_lbl 611 `"Apprentices, building trades (nec)"', add
label define occ1950_lbl 612 `"Apprentices, metalworking trades (nec)"', add
label define occ1950_lbl 613 `"Apprentices, printing  trades"', add
label define occ1950_lbl 614 `"Apprentices, other specified trades"', add
label define occ1950_lbl 615 `"Apprentices, trade not specified"', add
label define occ1950_lbl 620 `"Asbestos and insulation workers"', add
label define occ1950_lbl 621 `"Attendants, auto service and parking"', add
label define occ1950_lbl 622 `"Blasters and powdermen"', add
label define occ1950_lbl 623 `"Boatmen, canalmen, and lock keepers"', add
label define occ1950_lbl 624 `"Brakemen, railroad"', add
label define occ1950_lbl 625 `"Bus drivers"', add
label define occ1950_lbl 630 `"Chainmen, rodmen, and axmen, surveying"', add
label define occ1950_lbl 631 `"Conductors, bus and street railway"', add
label define occ1950_lbl 632 `"Deliverymen and routemen"', add
label define occ1950_lbl 633 `"Dressmakers and seamstresses, except factory"', add
label define occ1950_lbl 634 `"Dyers"', add
label define occ1950_lbl 635 `"Filers, grinders, and polishers, metal"', add
label define occ1950_lbl 640 `"Fruit, nut, and vegetable graders, and packers, except facto"', add
label define occ1950_lbl 641 `"Furnacemen, smeltermen and pourers"', add
label define occ1950_lbl 642 `"Heaters, metal"', add
label define occ1950_lbl 643 `"Laundry and dry cleaning Operatives"', add
label define occ1950_lbl 644 `"Meat cutters, except slaughter and packing house"', add
label define occ1950_lbl 645 `"Milliners"', add
label define occ1950_lbl 650 `"Mine operatives and laborers"', add
label define occ1950_lbl 660 `"Motormen, mine, factory, logging camp, etc"', add
label define occ1950_lbl 661 `"Motormen, street, subway, and elevated railway"', add
label define occ1950_lbl 662 `"Oilers and greaser, except auto"', add
label define occ1950_lbl 670 `"Painters, except construction or maintenance"', add
label define occ1950_lbl 671 `"Photographic process workers"', add
label define occ1950_lbl 672 `"Power station operators"', add
label define occ1950_lbl 673 `"Sailors and deck hands"', add
label define occ1950_lbl 674 `"Sawyers"', add
label define occ1950_lbl 675 `"Spinners, textile"', add
label define occ1950_lbl 680 `"Stationary firemen"', add
label define occ1950_lbl 681 `"Switchmen, railroad"', add
label define occ1950_lbl 682 `"Taxicab drivers and chauffeurs"', add
label define occ1950_lbl 683 `"Truck and tractor drivers"', add
label define occ1950_lbl 684 `"Weavers, textile"', add
label define occ1950_lbl 685 `"Welders and flame cutters"', add
label define occ1950_lbl 690 `"Operative and kindred workers (nec)"', add
label define occ1950_lbl 700 `"Housekeepers, private household"', add
label define occ1950_lbl 710 `"Laundresses, private household"', add
label define occ1950_lbl 720 `"Private household workers (nec)"', add
label define occ1950_lbl 730 `"Attendants, hospital and other institution"', add
label define occ1950_lbl 731 `"Attendants, professional and personal service (nec)"', add
label define occ1950_lbl 732 `"Attendants, recreation and amusement"', add
label define occ1950_lbl 740 `"Barbers, beauticians, and manicurists"', add
label define occ1950_lbl 750 `"Bartenders"', add
label define occ1950_lbl 751 `"Bootblacks"', add
label define occ1950_lbl 752 `"Boarding and lodging house keepers"', add
label define occ1950_lbl 753 `"Charwomen and cleaners"', add
label define occ1950_lbl 754 `"Cooks, except private household"', add
label define occ1950_lbl 760 `"Counter and fountain workers"', add
label define occ1950_lbl 761 `"Elevator operators"', add
label define occ1950_lbl 762 `"Firemen, fire protection"', add
label define occ1950_lbl 763 `"Guards, watchmen, and doorkeepers"', add
label define occ1950_lbl 764 `"Housekeepers and stewards, except private household"', add
label define occ1950_lbl 770 `"Janitors and sextons"', add
label define occ1950_lbl 771 `"Marshals and constables"', add
label define occ1950_lbl 772 `"Midwives"', add
label define occ1950_lbl 773 `"Policemen and detectives"', add
label define occ1950_lbl 780 `"Porters"', add
label define occ1950_lbl 781 `"Practical nurses"', add
label define occ1950_lbl 782 `"Sheriffs and bailiffs"', add
label define occ1950_lbl 783 `"Ushers, recreation and amusement"', add
label define occ1950_lbl 784 `"Waiters and waitresses"', add
label define occ1950_lbl 785 `"Watchmen (crossing) and bridge tenders"', add
label define occ1950_lbl 790 `"Service workers, except private household (nec)"', add
label define occ1950_lbl 810 `"Farm foremen"', add
label define occ1950_lbl 820 `"Farm laborers, wage workers"', add
label define occ1950_lbl 830 `"Farm laborers, unpaid family workers"', add
label define occ1950_lbl 840 `"Farm service laborers, self-employed"', add
label define occ1950_lbl 910 `"Fishermen and oystermen"', add
label define occ1950_lbl 920 `"Garage laborers and car washers and greasers"', add
label define occ1950_lbl 930 `"Gardeners, except farm and groundskeepers"', add
label define occ1950_lbl 940 `"Longshoremen and stevedores"', add
label define occ1950_lbl 950 `"Lumbermen, raftsmen, and woodchoppers"', add
label define occ1950_lbl 960 `"Teamsters"', add
label define occ1950_lbl 970 `"Laborers (nec)"', add
label define occ1950_lbl 979 `"Not yet classified"', add
label define occ1950_lbl 980 `"Keeps house/housekeeping at home/housewife"', add
label define occ1950_lbl 981 `"Imputed keeping house (1850-1900)"', add
label define occ1950_lbl 982 `"Helping at home/helps parents/housework"', add
label define occ1950_lbl 983 `"At school/student"', add
label define occ1950_lbl 984 `"Retired"', add
label define occ1950_lbl 985 `"Unemployed/without occupation"', add
label define occ1950_lbl 986 `"Invalid/disabled w/ no occupation reported"', add
label define occ1950_lbl 987 `"Inmate"', add
label define occ1950_lbl 990 `"New Worker"', add
label define occ1950_lbl 991 `"Gentleman/lady/at leisure"', add
label define occ1950_lbl 995 `"Other non-occupation"', add
label define occ1950_lbl 997 `"Occupation missing/unknown"', add
label define occ1950_lbl 999 `"N/A (blank)"', add
label values occ1950 occ1950_lbl

label define occ1990_lbl 003 `"Legislators"'
label define occ1990_lbl 004 `"Chief executives and public administrators"', add
label define occ1990_lbl 007 `"Financial managers"', add
label define occ1990_lbl 008 `"Human resources and labor relations managers"', add
label define occ1990_lbl 013 `"Managers and specialists in marketing, advertising, and public relations"', add
label define occ1990_lbl 014 `"Managers in education and related fields"', add
label define occ1990_lbl 015 `"Managers of medicine and health occupations"', add
label define occ1990_lbl 016 `"Postmasters and mail superintendents"', add
label define occ1990_lbl 017 `"Managers of food-serving and lodging establishments"', add
label define occ1990_lbl 018 `"Managers of properties and real estate"', add
label define occ1990_lbl 019 `"Funeral directors"', add
label define occ1990_lbl 021 `"Managers of service organizations, n.e.c."', add
label define occ1990_lbl 022 `"Managers and administrators, n.e.c."', add
label define occ1990_lbl 023 `"Accountants and auditors"', add
label define occ1990_lbl 024 `"Insurance underwriters"', add
label define occ1990_lbl 025 `"Other financial specialists"', add
label define occ1990_lbl 026 `"Management analysts"', add
label define occ1990_lbl 027 `"Personnel, HR, training, and labor relations specialists"', add
label define occ1990_lbl 028 `"Purchasing agents and buyers, of farm products"', add
label define occ1990_lbl 029 `"Buyers, wholesale and retail trade"', add
label define occ1990_lbl 033 `"Purchasing managers, agents and buyers, n.e.c."', add
label define occ1990_lbl 034 `"Business and promotion agents"', add
label define occ1990_lbl 035 `"Construction inspectors"', add
label define occ1990_lbl 036 `"Inspectors and compliance officers, outside construction"', add
label define occ1990_lbl 037 `"Management support occupations"', add
label define occ1990_lbl 043 `"Architects"', add
label define occ1990_lbl 044 `"Aerospace engineer"', add
label define occ1990_lbl 045 `"Metallurgical and materials engineers, variously phrased"', add
label define occ1990_lbl 047 `"Petroleum, mining, and geological engineers"', add
label define occ1990_lbl 048 `"Chemical engineers"', add
label define occ1990_lbl 053 `"Civil engineers"', add
label define occ1990_lbl 055 `"Electrical engineer"', add
label define occ1990_lbl 056 `"Industrial engineers"', add
label define occ1990_lbl 057 `"Mechanical engineers"', add
label define occ1990_lbl 059 `"Not-elsewhere-classified engineers"', add
label define occ1990_lbl 064 `"Computer systems analysts and computer scientists"', add
label define occ1990_lbl 065 `"Operations and systems researchers and analysts"', add
label define occ1990_lbl 066 `"Actuaries"', add
label define occ1990_lbl 067 `"Statisticians"', add
label define occ1990_lbl 068 `"Mathematicians and mathematical scientists"', add
label define occ1990_lbl 069 `"Physicists and astronomers"', add
label define occ1990_lbl 073 `"Chemists"', add
label define occ1990_lbl 074 `"Atmospheric and space scientists"', add
label define occ1990_lbl 075 `"Geologists"', add
label define occ1990_lbl 076 `"Physical scientists, n.e.c."', add
label define occ1990_lbl 077 `"Agricultural and food scientists"', add
label define occ1990_lbl 078 `"Biological scientists"', add
label define occ1990_lbl 079 `"Foresters and conservation scientists"', add
label define occ1990_lbl 083 `"Medical scientists"', add
label define occ1990_lbl 084 `"Physicians"', add
label define occ1990_lbl 085 `"Dentists"', add
label define occ1990_lbl 086 `"Veterinarians"', add
label define occ1990_lbl 087 `"Optometrists"', add
label define occ1990_lbl 088 `"Podiatrists"', add
label define occ1990_lbl 089 `"Other health and therapy"', add
label define occ1990_lbl 095 `"Registered nurses"', add
label define occ1990_lbl 096 `"Pharmacists"', add
label define occ1990_lbl 097 `"Dietitians and nutritionists"', add
label define occ1990_lbl 098 `"Respiratory therapists"', add
label define occ1990_lbl 099 `"Occupational therapists"', add
label define occ1990_lbl 103 `"Physical therapists"', add
label define occ1990_lbl 104 `"Speech therapists"', add
label define occ1990_lbl 105 `"Therapists, n.e.c."', add
label define occ1990_lbl 106 `"Physicians' assistants"', add
label define occ1990_lbl 113 `"Earth, environmental, and marine science instructors"', add
label define occ1990_lbl 114 `"Biological science instructors"', add
label define occ1990_lbl 115 `"Chemistry instructors"', add
label define occ1990_lbl 116 `"Physics instructors"', add
label define occ1990_lbl 118 `"Psychology instructors"', add
label define occ1990_lbl 119 `"Economics instructors"', add
label define occ1990_lbl 123 `"History instructors"', add
label define occ1990_lbl 125 `"Sociology instructors"', add
label define occ1990_lbl 127 `"Engineering instructors"', add
label define occ1990_lbl 128 `"Math instructors"', add
label define occ1990_lbl 139 `"Education instructors"', add
label define occ1990_lbl 145 `"Law instructors"', add
label define occ1990_lbl 147 `"Theology instructors"', add
label define occ1990_lbl 149 `"Home economics instructors"', add
label define occ1990_lbl 150 `"Humanities profs/instructors, college, nec"', add
label define occ1990_lbl 154 `"Subject instructors (HS/college)"', add
label define occ1990_lbl 155 `"Kindergarten and earlier school teachers"', add
label define occ1990_lbl 156 `"Primary school teachers"', add
label define occ1990_lbl 157 `"Secondary school teachers"', add
label define occ1990_lbl 158 `"Special education teachers"', add
label define occ1990_lbl 159 `"Teachers , n.e.c."', add
label define occ1990_lbl 163 `"Vocational and educational counselors"', add
label define occ1990_lbl 164 `"Librarians"', add
label define occ1990_lbl 165 `"Archivists and curators"', add
label define occ1990_lbl 166 `"Economists, market researchers, and survey researchers"', add
label define occ1990_lbl 167 `"Psychologists"', add
label define occ1990_lbl 168 `"Sociologists"', add
label define occ1990_lbl 169 `"Social scientists, n.e.c."', add
label define occ1990_lbl 173 `"Urban and regional planners"', add
label define occ1990_lbl 174 `"Social workers"', add
label define occ1990_lbl 175 `"Recreation workers"', add
label define occ1990_lbl 176 `"Clergy and religious workers"', add
label define occ1990_lbl 178 `"Lawyers"', add
label define occ1990_lbl 179 `"Judges"', add
label define occ1990_lbl 183 `"Writers and authors"', add
label define occ1990_lbl 184 `"Technical writers"', add
label define occ1990_lbl 185 `"Designers"', add
label define occ1990_lbl 186 `"Musician or composer"', add
label define occ1990_lbl 187 `"Actors, directors, producers"', add
label define occ1990_lbl 188 `"Art makers: painters, sculptors, craft-artists, and print-makers"', add
label define occ1990_lbl 189 `"Photographers"', add
label define occ1990_lbl 193 `"Dancers"', add
label define occ1990_lbl 194 `"Art/entertainment performers and related"', add
label define occ1990_lbl 195 `"Editors and reporters"', add
label define occ1990_lbl 198 `"Announcers"', add
label define occ1990_lbl 199 `"Athletes, sports instructors, and officials"', add
label define occ1990_lbl 200 `"Professionals, n.e.c."', add
label define occ1990_lbl 203 `"Clinical laboratory technologies and technicians"', add
label define occ1990_lbl 204 `"Dental hygenists"', add
label define occ1990_lbl 205 `"Health record tech specialists"', add
label define occ1990_lbl 206 `"Radiologic tech specialists"', add
label define occ1990_lbl 207 `"Licensed practical nurses"', add
label define occ1990_lbl 208 `"Health technologists and technicians, n.e.c."', add
label define occ1990_lbl 213 `"Electrical and electronic (engineering) technicians"', add
label define occ1990_lbl 214 `"Engineering technicians, n.e.c."', add
label define occ1990_lbl 215 `"Mechanical engineering technicians"', add
label define occ1990_lbl 217 `"Drafters"', add
label define occ1990_lbl 218 `"Surveyors, cartographers, mapping scientists and technicians"', add
label define occ1990_lbl 223 `"Biological technicians"', add
label define occ1990_lbl 224 `"Chemical technicians"', add
label define occ1990_lbl 225 `"Other science technicians"', add
label define occ1990_lbl 226 `"Airplane pilots and navigators"', add
label define occ1990_lbl 227 `"Air traffic controllers"', add
label define occ1990_lbl 228 `"Broadcast equipment operators"', add
label define occ1990_lbl 229 `"Computer software developers"', add
label define occ1990_lbl 233 `"Programmers of numerically controlled machine tools"', add
label define occ1990_lbl 234 `"Legal assistants, paralegals, legal support, etc"', add
label define occ1990_lbl 235 `"Technicians, n.e.c."', add
label define occ1990_lbl 243 `"Supervisors and proprietors of sales jobs"', add
label define occ1990_lbl 253 `"Insurance sales occupations"', add
label define occ1990_lbl 254 `"Real estate sales occupations"', add
label define occ1990_lbl 255 `"Financial services sales occupations"', add
label define occ1990_lbl 256 `"Advertising and related sales jobs"', add
label define occ1990_lbl 258 `"Sales engineers"', add
label define occ1990_lbl 274 `"Salespersons, n.e.c."', add
label define occ1990_lbl 275 `"Retail sales clerks"', add
label define occ1990_lbl 276 `"Cashiers"', add
label define occ1990_lbl 277 `"Door-to-door sales, street sales, and news vendors"', add
label define occ1990_lbl 283 `"Sales demonstrators / promoters / models"', add
label define occ1990_lbl 303 `"Office supervisors"', add
label define occ1990_lbl 308 `"Computer and peripheral equipment operators"', add
label define occ1990_lbl 313 `"Secretaries"', add
label define occ1990_lbl 314 `"Stenographers"', add
label define occ1990_lbl 315 `"Typists"', add
label define occ1990_lbl 316 `"Interviewers, enumerators, and surveyors"', add
label define occ1990_lbl 317 `"Hotel clerks"', add
label define occ1990_lbl 318 `"Transportation ticket and reservation agents"', add
label define occ1990_lbl 319 `"Receptionists"', add
label define occ1990_lbl 323 `"Information clerks, nec"', add
label define occ1990_lbl 326 `"Correspondence and order clerks"', add
label define occ1990_lbl 328 `"Human resources clerks, except payroll and timekeeping"', add
label define occ1990_lbl 329 `"Library assistants"', add
label define occ1990_lbl 335 `"File clerks"', add
label define occ1990_lbl 336 `"Records clerks"', add
label define occ1990_lbl 337 `"Bookkeepers and accounting and auditing clerks"', add
label define occ1990_lbl 338 `"Payroll and timekeeping clerks"', add
label define occ1990_lbl 343 `"Cost and rate clerks (financial records processing)"', add
label define occ1990_lbl 344 `"Billing clerks and related financial records processing"', add
label define occ1990_lbl 345 `"Duplication machine operators / office machine operators"', add
label define occ1990_lbl 346 `"Mail and paper handlers"', add
label define occ1990_lbl 347 `"Office machine operators, n.e.c."', add
label define occ1990_lbl 348 `"Telephone operators"', add
label define occ1990_lbl 349 `"Other telecom operators"', add
label define occ1990_lbl 354 `"Postal clerks, excluding mail carriers"', add
label define occ1990_lbl 355 `"Mail carriers for postal service"', add
label define occ1990_lbl 356 `"Mail clerks, outside of post office"', add
label define occ1990_lbl 357 `"Messengers"', add
label define occ1990_lbl 359 `"Dispatchers"', add
label define occ1990_lbl 361 `"Inspectors, n.e.c."', add
label define occ1990_lbl 364 `"Shipping and receiving clerks"', add
label define occ1990_lbl 365 `"Stock and inventory clerks"', add
label define occ1990_lbl 366 `"Meter readers"', add
label define occ1990_lbl 368 `"Weighers, measurers, and checkers"', add
label define occ1990_lbl 373 `"Material recording, scheduling, production, planning, and expediting clerks"', add
label define occ1990_lbl 375 `"Insurance adjusters, examiners, and investigators"', add
label define occ1990_lbl 376 `"Customer service reps, investigators and adjusters, except insurance"', add
label define occ1990_lbl 377 `"Eligibility clerks for government programs; social welfare"', add
label define occ1990_lbl 378 `"Bill and account collectors"', add
label define occ1990_lbl 379 `"General office clerks"', add
label define occ1990_lbl 383 `"Bank tellers"', add
label define occ1990_lbl 384 `"Proofreaders"', add
label define occ1990_lbl 385 `"Data entry keyers"', add
label define occ1990_lbl 386 `"Statistical clerks"', add
label define occ1990_lbl 387 `"Teacher's aides"', add
label define occ1990_lbl 389 `"Administrative support jobs, n.e.c."', add
label define occ1990_lbl 405 `"Housekeepers, maids, butlers, stewards, and lodging quarters cleaners"', add
label define occ1990_lbl 407 `"Private household cleaners and servants"', add
label define occ1990_lbl 415 `"Supervisors of guards"', add
label define occ1990_lbl 417 `"Fire fighting, prevention, and inspection"', add
label define occ1990_lbl 418 `"Police, detectives, and private investigators"', add
label define occ1990_lbl 423 `"Other law enforcement: sheriffs, bailiffs, correctional institution officers"', add
label define occ1990_lbl 425 `"Crossing guards and bridge tenders"', add
label define occ1990_lbl 426 `"Guards, watchmen, doorkeepers"', add
label define occ1990_lbl 427 `"Protective services, n.e.c."', add
label define occ1990_lbl 434 `"Bartenders"', add
label define occ1990_lbl 435 `"Waiter/waitress"', add
label define occ1990_lbl 436 `"Cooks, variously defined"', add
label define occ1990_lbl 438 `"Food counter and fountain workers"', add
label define occ1990_lbl 439 `"Kitchen workers"', add
label define occ1990_lbl 443 `"Waiter's assistant"', add
label define occ1990_lbl 444 `"Misc food prep workers"', add
label define occ1990_lbl 445 `"Dental assistants"', add
label define occ1990_lbl 446 `"Health aides, except nursing"', add
label define occ1990_lbl 447 `"Nursing aides, orderlies, and attendants"', add
label define occ1990_lbl 448 `"Supervisors of cleaning and building service"', add
label define occ1990_lbl 453 `"Janitors"', add
label define occ1990_lbl 454 `"Elevator operators"', add
label define occ1990_lbl 455 `"Pest control occupations"', add
label define occ1990_lbl 456 `"Supervisors of personal service jobs, n.e.c."', add
label define occ1990_lbl 457 `"Barbers"', add
label define occ1990_lbl 458 `"Hairdressers and cosmetologists"', add
label define occ1990_lbl 459 `"Recreation facility attendants"', add
label define occ1990_lbl 461 `"Guides"', add
label define occ1990_lbl 462 `"Ushers"', add
label define occ1990_lbl 463 `"Public transportation attendants and inspectors"', add
label define occ1990_lbl 464 `"Baggage porters"', add
label define occ1990_lbl 465 `"Welfare service aides"', add
label define occ1990_lbl 468 `"Child care workers"', add
label define occ1990_lbl 469 `"Personal service occupations, nec"', add
label define occ1990_lbl 473 `"Farmers (owners and tenants)"', add
label define occ1990_lbl 474 `"Horticultural specialty farmers"', add
label define occ1990_lbl 475 `"Farm managers, except for horticultural farms"', add
label define occ1990_lbl 476 `"Managers of horticultural specialty farms"', add
label define occ1990_lbl 479 `"Farm workers"', add
label define occ1990_lbl 483 `"Marine life cultivation workers"', add
label define occ1990_lbl 484 `"Nursery farming workers"', add
label define occ1990_lbl 485 `"Supervisors of agricultural occupations"', add
label define occ1990_lbl 486 `"Gardeners and groundskeepers"', add
label define occ1990_lbl 487 `"Animal caretakers except on farms"', add
label define occ1990_lbl 488 `"Graders and sorters of agricultural products"', add
label define occ1990_lbl 489 `"Inspectors of agricultural products"', add
label define occ1990_lbl 496 `"Timber, logging, and forestry workers"', add
label define occ1990_lbl 498 `"Fishers, hunters, and kindred"', add
label define occ1990_lbl 503 `"Supervisors of mechanics and repairers"', add
label define occ1990_lbl 505 `"Automobile mechanics"', add
label define occ1990_lbl 507 `"Bus, truck, and stationary engine mechanics"', add
label define occ1990_lbl 508 `"Aircraft mechanics"', add
label define occ1990_lbl 509 `"Small engine repairers"', add
label define occ1990_lbl 514 `"Auto body repairers"', add
label define occ1990_lbl 516 `"Heavy equipment and farm equipment mechanics"', add
label define occ1990_lbl 518 `"Industrial machinery repairers"', add
label define occ1990_lbl 519 `"Machinery maintenance occupations"', add
label define occ1990_lbl 523 `"Repairers of industrial electrical equipment"', add
label define occ1990_lbl 525 `"Repairers of data processing equipment"', add
label define occ1990_lbl 526 `"Repairers of household appliances and power tools"', add
label define occ1990_lbl 527 `"Telecom and line installers and repairers"', add
label define occ1990_lbl 533 `"Repairers of electrical equipment, n.e.c."', add
label define occ1990_lbl 534 `"Heating, air conditioning, and refigeration mechanics"', add
label define occ1990_lbl 535 `"Precision makers, repairers, and smiths"', add
label define occ1990_lbl 536 `"Locksmiths and safe repairers"', add
label define occ1990_lbl 538 `"Office machine repairers and mechanics"', add
label define occ1990_lbl 539 `"Repairers of mechanical controls and valves"', add
label define occ1990_lbl 543 `"Elevator installers and repairers"', add
label define occ1990_lbl 544 `"Millwrights"', add
label define occ1990_lbl 549 `"Mechanics and repairers, n.e.c."', add
label define occ1990_lbl 558 `"Supervisors of construction work"', add
label define occ1990_lbl 563 `"Masons, tilers, and carpet installers"', add
label define occ1990_lbl 567 `"Carpenters"', add
label define occ1990_lbl 573 `"Drywall installers"', add
label define occ1990_lbl 575 `"Electricians"', add
label define occ1990_lbl 577 `"Electric power installers and repairers"', add
label define occ1990_lbl 579 `"Painters, construction and maintenance"', add
label define occ1990_lbl 583 `"Paperhangers"', add
label define occ1990_lbl 584 `"Plasterers"', add
label define occ1990_lbl 585 `"Plumbers, pipe fitters, and steamfitters"', add
label define occ1990_lbl 588 `"Concrete and cement workers"', add
label define occ1990_lbl 589 `"Glaziers"', add
label define occ1990_lbl 593 `"Insulation workers"', add
label define occ1990_lbl 594 `"Paving, surfacing, and tamping equipment operators"', add
label define occ1990_lbl 595 `"Roofers and slaters"', add
label define occ1990_lbl 596 `"Sheet metal duct installers"', add
label define occ1990_lbl 597 `"Structural metal workers"', add
label define occ1990_lbl 598 `"Drillers of earth"', add
label define occ1990_lbl 599 `"Construction trades, n.e.c."', add
label define occ1990_lbl 614 `"Drillers of oil wells"', add
label define occ1990_lbl 615 `"Explosives workers"', add
label define occ1990_lbl 616 `"Miners"', add
label define occ1990_lbl 617 `"Other mining occupations"', add
label define occ1990_lbl 628 `"Production supervisors or foremen"', add
label define occ1990_lbl 634 `"Tool and die makers and die setters"', add
label define occ1990_lbl 637 `"Machinists"', add
label define occ1990_lbl 643 `"Boilermakers"', add
label define occ1990_lbl 644 `"Precision grinders and filers"', add
label define occ1990_lbl 645 `"Patternmakers and model makers"', add
label define occ1990_lbl 646 `"Lay-out workers"', add
label define occ1990_lbl 649 `"Engravers"', add
label define occ1990_lbl 653 `"Tinsmiths, coppersmiths, and sheet metal workers"', add
label define occ1990_lbl 657 `"Cabinetmakers and bench carpenters"', add
label define occ1990_lbl 658 `"Furniture and wood finishers"', add
label define occ1990_lbl 659 `"Other precision woodworkers"', add
label define occ1990_lbl 666 `"Dressmakers and seamstresses"', add
label define occ1990_lbl 667 `"Tailors"', add
label define occ1990_lbl 668 `"Upholsterers"', add
label define occ1990_lbl 669 `"Shoe repairers"', add
label define occ1990_lbl 674 `"Other precision apparel and fabric workers"', add
label define occ1990_lbl 675 `"Hand molders and shapers, except jewelers"', add
label define occ1990_lbl 677 `"Optical goods workers"', add
label define occ1990_lbl 678 `"Dental laboratory and medical appliance technicians"', add
label define occ1990_lbl 679 `"Bookbinders"', add
label define occ1990_lbl 684 `"Other precision and craft workers"', add
label define occ1990_lbl 686 `"Butchers and meat cutters"', add
label define occ1990_lbl 687 `"Bakers"', add
label define occ1990_lbl 688 `"Batch food makers"', add
label define occ1990_lbl 693 `"Adjusters and calibrators"', add
label define occ1990_lbl 694 `"Water and sewage treatment plant operators"', add
label define occ1990_lbl 695 `"Power plant operators"', add
label define occ1990_lbl 696 `"Plant and system operators, stationary engineers"', add
label define occ1990_lbl 699 `"Other plant and system operators"', add
label define occ1990_lbl 703 `"Lathe, milling, and turning machine operatives"', add
label define occ1990_lbl 706 `"Punching and stamping press operatives"', add
label define occ1990_lbl 707 `"Rollers, roll hands, and finishers of metal"', add
label define occ1990_lbl 708 `"Drilling and boring machine operators"', add
label define occ1990_lbl 709 `"Grinding, abrading, buffing, and polishing workers"', add
label define occ1990_lbl 713 `"Forge and hammer operators"', add
label define occ1990_lbl 717 `"Fabricating machine operators, n.e.c."', add
label define occ1990_lbl 719 `"Molders, and casting machine operators"', add
label define occ1990_lbl 723 `"Metal platers"', add
label define occ1990_lbl 724 `"Heat treating equipment operators"', add
label define occ1990_lbl 726 `"Wood lathe, routing, and planing machine operators"', add
label define occ1990_lbl 727 `"Sawing machine operators and sawyers"', add
label define occ1990_lbl 728 `"Shaping and joining machine operator (woodworking)"', add
label define occ1990_lbl 729 `"Nail and tacking machine operators  (woodworking)"', add
label define occ1990_lbl 733 `"Other woodworking machine operators"', add
label define occ1990_lbl 734 `"Printing machine operators, n.e.c."', add
label define occ1990_lbl 735 `"Photoengravers and lithographers"', add
label define occ1990_lbl 736 `"Typesetters and compositors"', add
label define occ1990_lbl 738 `"Winding and twisting textile/apparel operatives"', add
label define occ1990_lbl 739 `"Knitters, loopers, and toppers textile operatives"', add
label define occ1990_lbl 743 `"Textile cutting machine operators"', add
label define occ1990_lbl 744 `"Textile sewing machine operators"', add
label define occ1990_lbl 745 `"Shoemaking machine operators"', add
label define occ1990_lbl 747 `"Pressing machine operators (clothing)"', add
label define occ1990_lbl 748 `"Laundry workers"', add
label define occ1990_lbl 749 `"Misc textile machine operators"', add
label define occ1990_lbl 753 `"Cementing and gluing maching operators"', add
label define occ1990_lbl 754 `"Packers, fillers, and wrappers"', add
label define occ1990_lbl 755 `"Extruding and forming machine operators"', add
label define occ1990_lbl 756 `"Mixing and blending machine operatives"', add
label define occ1990_lbl 757 `"Separating, filtering, and clarifying machine operators"', add
label define occ1990_lbl 759 `"Painting machine operators"', add
label define occ1990_lbl 763 `"Roasting and baking machine operators (food)"', add
label define occ1990_lbl 764 `"Washing, cleaning, and pickling machine operators"', add
label define occ1990_lbl 765 `"Paper folding machine operators"', add
label define occ1990_lbl 766 `"Furnace, kiln, and oven operators, apart from food"', add
label define occ1990_lbl 768 `"Crushing and grinding machine operators"', add
label define occ1990_lbl 769 `"Slicing and cutting machine operators"', add
label define occ1990_lbl 773 `"Motion picture projectionists"', add
label define occ1990_lbl 774 `"Photographic process workers"', add
label define occ1990_lbl 779 `"Machine operators, n.e.c."', add
label define occ1990_lbl 783 `"Welders and metal cutters"', add
label define occ1990_lbl 784 `"Solderers"', add
label define occ1990_lbl 785 `"Assemblers of electrical equipment"', add
label define occ1990_lbl 789 `"Hand painting, coating, and decorating occupations"', add
label define occ1990_lbl 796 `"Production checkers and inspectors"', add
label define occ1990_lbl 799 `"Graders and sorters in manufacturing"', add
label define occ1990_lbl 803 `"Supervisors of motor vehicle transportation"', add
label define occ1990_lbl 804 `"Truck, delivery, and tractor drivers"', add
label define occ1990_lbl 808 `"Bus drivers"', add
label define occ1990_lbl 809 `"Taxi cab drivers and chauffeurs"', add
label define occ1990_lbl 813 `"Parking lot attendants"', add
label define occ1990_lbl 823 `"Railroad conductors and yardmasters"', add
label define occ1990_lbl 824 `"Locomotive operators (engineers and firemen)"', add
label define occ1990_lbl 825 `"Railroad brake, coupler, and switch operators"', add
label define occ1990_lbl 829 `"Ship crews and marine engineers"', add
label define occ1990_lbl 834 `"Water transport infrastructure tenders and crossing guards"', add
label define occ1990_lbl 844 `"Operating engineers of construction equipment"', add
label define occ1990_lbl 848 `"Crane, derrick, winch, and hoist operators"', add
label define occ1990_lbl 853 `"Excavating and loading machine operators"', add
label define occ1990_lbl 859 `"Misc material moving occupations"', add
label define occ1990_lbl 865 `"Helpers, constructions"', add
label define occ1990_lbl 866 `"Helpers, surveyors"', add
label define occ1990_lbl 869 `"Construction laborers"', add
label define occ1990_lbl 874 `"Production helpers"', add
label define occ1990_lbl 875 `"Garbage and recyclable material collectors"', add
label define occ1990_lbl 876 `"Materials movers: stevedores and longshore workers"', add
label define occ1990_lbl 877 `"Stock handlers"', add
label define occ1990_lbl 878 `"Machine feeders and offbearers"', add
label define occ1990_lbl 883 `"Freight, stock, and materials handlers"', add
label define occ1990_lbl 885 `"Garage and service station related occupations"', add
label define occ1990_lbl 887 `"Vehicle washers and equipment cleaners"', add
label define occ1990_lbl 888 `"Packers and packagers by hand"', add
label define occ1990_lbl 889 `"Laborers outside construction"', add
label define occ1990_lbl 905 `"Military"', add
label define occ1990_lbl 991 `"Unemployed"', add
label define occ1990_lbl 999 `"Unknown"', add
label values occ1990 occ1990_lbl

label define ind1950_lbl 000 `"N/A or none reported"'
label define ind1950_lbl 105 `"Agriculture"', add
label define ind1950_lbl 116 `"Forestry"', add
label define ind1950_lbl 126 `"Fisheries"', add
label define ind1950_lbl 206 `"Metal mining"', add
label define ind1950_lbl 216 `"Coal mining"', add
label define ind1950_lbl 226 `"Crude petroleum and natural gas extraction"', add
label define ind1950_lbl 236 `"Nonmettalic  mining and quarrying, except fuel"', add
label define ind1950_lbl 239 `"Mining, not specified"', add
label define ind1950_lbl 246 `"Construction"', add
label define ind1950_lbl 306 `"Logging"', add
label define ind1950_lbl 307 `"Sawmills, planing mills, and mill work"', add
label define ind1950_lbl 308 `"Misc wood products"', add
label define ind1950_lbl 309 `"Furniture and fixtures"', add
label define ind1950_lbl 316 `"Glass and glass products"', add
label define ind1950_lbl 317 `"Cement, concrete, gypsum and plaster products"', add
label define ind1950_lbl 318 `"Structural clay products"', add
label define ind1950_lbl 319 `"Pottery and related prods"', add
label define ind1950_lbl 326 `"Misc nonmetallic mineral and stone products"', add
label define ind1950_lbl 336 `"Blast furnaces, steel works, and rolling mills"', add
label define ind1950_lbl 337 `"Other primary iron and steel industries"', add
label define ind1950_lbl 338 `"Primary nonferrous industries"', add
label define ind1950_lbl 346 `"Fabricated steel products"', add
label define ind1950_lbl 347 `"Fabricated nonferrous metal products"', add
label define ind1950_lbl 348 `"Not specified metal industries"', add
label define ind1950_lbl 356 `"Agricultural machinery and tractors"', add
label define ind1950_lbl 357 `"Office and store machines"', add
label define ind1950_lbl 358 `"Misc machinery"', add
label define ind1950_lbl 367 `"Electrical machinery, equipment and supplies"', add
label define ind1950_lbl 376 `"Motor vehicles and motor vehicle equipment"', add
label define ind1950_lbl 377 `"Aircraft and parts"', add
label define ind1950_lbl 378 `"Ship and boat building and repairing"', add
label define ind1950_lbl 379 `"Railroad and misc transportation equipment"', add
label define ind1950_lbl 386 `"Professional equipment"', add
label define ind1950_lbl 387 `"Photographic equipment and supplies"', add
label define ind1950_lbl 388 `"Watches, clocks, and clockwork-operated devices"', add
label define ind1950_lbl 399 `"Misc manufacturing industries"', add
label define ind1950_lbl 406 `"Meat products"', add
label define ind1950_lbl 407 `"Dairy products"', add
label define ind1950_lbl 408 `"Canning and preserving fruits, vegetables, and seafoods"', add
label define ind1950_lbl 409 `"Grain-mill products"', add
label define ind1950_lbl 416 `"Bakery products"', add
label define ind1950_lbl 417 `"Confectionery and related products"', add
label define ind1950_lbl 418 `"Beverage industries"', add
label define ind1950_lbl 419 `"Misc food preparations and kindred products"', add
label define ind1950_lbl 426 `"Not specified food industries"', add
label define ind1950_lbl 429 `"Tobacco manufactures"', add
label define ind1950_lbl 436 `"Knitting mills"', add
label define ind1950_lbl 437 `"Dyeing and finishing textiles, except knit goods"', add
label define ind1950_lbl 438 `"Carpets, rugs, and other floor coverings"', add
label define ind1950_lbl 439 `"Yarn, thread, and fabric"', add
label define ind1950_lbl 446 `"Misc textile mill products"', add
label define ind1950_lbl 448 `"Apparel and accessories"', add
label define ind1950_lbl 449 `"Misc fabricated textile products"', add
label define ind1950_lbl 456 `"Pulp, paper, and paper-board mills"', add
label define ind1950_lbl 457 `"Paperboard containers and boxes"', add
label define ind1950_lbl 458 `"Misc paper and pulp products"', add
label define ind1950_lbl 459 `"Printing, publishing, and allied industries"', add
label define ind1950_lbl 466 `"Synthetic fibers"', add
label define ind1950_lbl 467 `"Drugs and medicines"', add
label define ind1950_lbl 468 `"Paints, varnishes, and related products"', add
label define ind1950_lbl 469 `"Misc chemicals and allied products"', add
label define ind1950_lbl 476 `"Petroleum refining"', add
label define ind1950_lbl 477 `"Misc petroleum and coal products"', add
label define ind1950_lbl 478 `"Rubber products"', add
label define ind1950_lbl 487 `"Leather: tanned, curried, and finished"', add
label define ind1950_lbl 488 `"Footwear, except rubber"', add
label define ind1950_lbl 489 `"Leather products, except footwear"', add
label define ind1950_lbl 499 `"Not specified manufacturing industries"', add
label define ind1950_lbl 506 `"Railroads and railway"', add
label define ind1950_lbl 516 `"Street railways and bus lines"', add
label define ind1950_lbl 526 `"Trucking service"', add
label define ind1950_lbl 527 `"Warehousing and storage"', add
label define ind1950_lbl 536 `"Taxicab service"', add
label define ind1950_lbl 546 `"Water transportation"', add
label define ind1950_lbl 556 `"Air transportation"', add
label define ind1950_lbl 567 `"Petroleum and gasoline pipe lines"', add
label define ind1950_lbl 568 `"Services incidental to transportation"', add
label define ind1950_lbl 578 `"Telephone"', add
label define ind1950_lbl 579 `"Telegraph"', add
label define ind1950_lbl 586 `"Electric light and power"', add
label define ind1950_lbl 587 `"Gas and steam supply systems"', add
label define ind1950_lbl 588 `"Electric-gas utilities"', add
label define ind1950_lbl 596 `"Water supply"', add
label define ind1950_lbl 597 `"Sanitary services"', add
label define ind1950_lbl 598 `"Other and not specified utilities"', add
label define ind1950_lbl 606 `"Motor vehicles and equipment"', add
label define ind1950_lbl 607 `"Drugs, chemicals, and allied products"', add
label define ind1950_lbl 608 `"Dry goods apparel"', add
label define ind1950_lbl 609 `"Food and related products"', add
label define ind1950_lbl 616 `"Electrical goods, hardware, and plumbing equipment"', add
label define ind1950_lbl 617 `"Machinery, equipment, and supplies"', add
label define ind1950_lbl 618 `"Petroleum products"', add
label define ind1950_lbl 619 `"Farm prods--raw materials"', add
label define ind1950_lbl 626 `"Misc wholesale trade"', add
label define ind1950_lbl 627 `"Not specified wholesale trade"', add
label define ind1950_lbl 636 `"Food stores, except dairy"', add
label define ind1950_lbl 637 `"Dairy prods stores and milk retailing"', add
label define ind1950_lbl 646 `"General merchandise"', add
label define ind1950_lbl 647 `"Five and ten cent stores"', add
label define ind1950_lbl 656 `"Apparel and accessories stores, except shoe"', add
label define ind1950_lbl 657 `"Shoe stores"', add
label define ind1950_lbl 658 `"Furniture and house furnishings stores"', add
label define ind1950_lbl 659 `"Household appliance and radio stores"', add
label define ind1950_lbl 667 `"Motor vehicles and accessories retailing"', add
label define ind1950_lbl 668 `"Gasoline service stations"', add
label define ind1950_lbl 669 `"Drug stores"', add
label define ind1950_lbl 679 `"Eating and drinking  places"', add
label define ind1950_lbl 686 `"Hardware and farm implement stores"', add
label define ind1950_lbl 687 `"Lumber and building material retailing"', add
label define ind1950_lbl 688 `"Liquor stores"', add
label define ind1950_lbl 689 `"Retail florists"', add
label define ind1950_lbl 696 `"Jewelry stores"', add
label define ind1950_lbl 697 `"Fuel and ice retailing"', add
label define ind1950_lbl 698 `"Misc retail stores"', add
label define ind1950_lbl 699 `"Not specified retail trade"', add
label define ind1950_lbl 716 `"Banking and credit"', add
label define ind1950_lbl 726 `"Security and commodity brokerage and invest companies"', add
label define ind1950_lbl 736 `"Insurance"', add
label define ind1950_lbl 746 `"Real estate"', add
label define ind1950_lbl 756 `"Real estate-insurance-law  offices"', add
label define ind1950_lbl 806 `"Advertising"', add
label define ind1950_lbl 807 `"Accounting, auditing, and bookkeeping services"', add
label define ind1950_lbl 808 `"Misc business services"', add
label define ind1950_lbl 816 `"Auto repair services and garages"', add
label define ind1950_lbl 817 `"Misc repair services"', add
label define ind1950_lbl 826 `"Private households"', add
label define ind1950_lbl 836 `"Hotels and lodging places"', add
label define ind1950_lbl 846 `"Laundering, cleaning, and dyeing"', add
label define ind1950_lbl 847 `"Dressmaking shops"', add
label define ind1950_lbl 848 `"Shoe repair shops"', add
label define ind1950_lbl 849 `"Misc personal services"', add
label define ind1950_lbl 856 `"Radio broadcasting and television"', add
label define ind1950_lbl 857 `"Theaters and motion pictures"', add
label define ind1950_lbl 858 `"Bowling alleys, and billiard and pool parlors"', add
label define ind1950_lbl 859 `"Misc entertainment and recreation services"', add
label define ind1950_lbl 868 `"Medical and other health services, except hospitals"', add
label define ind1950_lbl 869 `"Hospitals"', add
label define ind1950_lbl 879 `"Legal services"', add
label define ind1950_lbl 888 `"Educational services"', add
label define ind1950_lbl 896 `"Welfare and religious services"', add
label define ind1950_lbl 897 `"Nonprofit membership organizs."', add
label define ind1950_lbl 898 `"Engineering and architectural services"', add
label define ind1950_lbl 899 `"Misc professional and related"', add
label define ind1950_lbl 906 `"Postal service"', add
label define ind1950_lbl 916 `"Federal public administration"', add
label define ind1950_lbl 926 `"State public administration"', add
label define ind1950_lbl 936 `"Local public administration"', add
label define ind1950_lbl 946 `"Public Administration, level not specified"', add
label define ind1950_lbl 976 `"Common or general laborer"', add
label define ind1950_lbl 979 `"Not yet specified"', add
label define ind1950_lbl 980 `"Unpaid domestic work"', add
label define ind1950_lbl 982 `"Housework at home"', add
label define ind1950_lbl 983 `"School response (students, etc.)"', add
label define ind1950_lbl 984 `"Retired"', add
label define ind1950_lbl 986 `"Sick/disabled"', add
label define ind1950_lbl 987 `"Institution response"', add
label define ind1950_lbl 991 `"Lady/Man of leisure"', add
label define ind1950_lbl 995 `"Non-industrial response"', add
label define ind1950_lbl 997 `"Nonclassifiable"', add
label define ind1950_lbl 998 `"Industry not reported"', add
label define ind1950_lbl 999 `"Blank or blank equivalent"', add
label values ind1950 ind1950_lbl

label define classwkr_lbl 0 `"N/A"'
label define classwkr_lbl 1 `"Self-employed"', add
label define classwkr_lbl 2 `"Works for wages"', add
label values classwkr classwkr_lbl

label define classwkrd_lbl 00 `"N/A"'
label define classwkrd_lbl 10 `"Self-employed"', add
label define classwkrd_lbl 11 `"Employer"', add
label define classwkrd_lbl 12 `"Working on own account"', add
label define classwkrd_lbl 13 `"Self-employed, not incorporated"', add
label define classwkrd_lbl 14 `"Self-employed, incorporated"', add
label define classwkrd_lbl 20 `"Works for wages"', add
label define classwkrd_lbl 21 `"Works on salary (1920)"', add
label define classwkrd_lbl 22 `"Wage/salary, private"', add
label define classwkrd_lbl 23 `"Wage/salary at non-profit"', add
label define classwkrd_lbl 24 `"Wage/salary, government"', add
label define classwkrd_lbl 25 `"Federal govt employee"', add
label define classwkrd_lbl 26 `"Armed forces"', add
label define classwkrd_lbl 27 `"State govt employee"', add
label define classwkrd_lbl 28 `"Local govt employee"', add
label define classwkrd_lbl 29 `"Unpaid family worker"', add
label values classwkrd classwkrd_lbl

label define wkswork2_lbl 0 `"N/A"'
label define wkswork2_lbl 1 `"1-13 weeks"', add
label define wkswork2_lbl 2 `"14-26 weeks"', add
label define wkswork2_lbl 3 `"27-39 weeks"', add
label define wkswork2_lbl 4 `"40-47 weeks"', add
label define wkswork2_lbl 5 `"48-49 weeks"', add
label define wkswork2_lbl 6 `"50-52 weeks"', add
label values wkswork2 wkswork2_lbl

label define hrswork2_lbl 0 `"N/A"'
label define hrswork2_lbl 1 `"1-14 hours"', add
label define hrswork2_lbl 2 `"15-29 hours"', add
label define hrswork2_lbl 3 `"30-34 hours"', add
label define hrswork2_lbl 4 `"35-39 hours"', add
label define hrswork2_lbl 5 `"40 hours"', add
label define hrswork2_lbl 6 `"41-48 hours"', add
label define hrswork2_lbl 7 `"49-59 hours"', add
label define hrswork2_lbl 8 `"60+ hours"', add
label values hrswork2 hrswork2_lbl

label define uhrswork_lbl 00 `"N/A"'
label define uhrswork_lbl 01 `"1"', add
label define uhrswork_lbl 02 `"2"', add
label define uhrswork_lbl 03 `"3"', add
label define uhrswork_lbl 04 `"4"', add
label define uhrswork_lbl 05 `"5"', add
label define uhrswork_lbl 06 `"6"', add
label define uhrswork_lbl 07 `"7"', add
label define uhrswork_lbl 08 `"8"', add
label define uhrswork_lbl 09 `"9"', add
label define uhrswork_lbl 10 `"10"', add
label define uhrswork_lbl 11 `"11"', add
label define uhrswork_lbl 12 `"12"', add
label define uhrswork_lbl 13 `"13"', add
label define uhrswork_lbl 14 `"14"', add
label define uhrswork_lbl 15 `"15"', add
label define uhrswork_lbl 16 `"16"', add
label define uhrswork_lbl 17 `"17"', add
label define uhrswork_lbl 18 `"18"', add
label define uhrswork_lbl 19 `"19"', add
label define uhrswork_lbl 20 `"20"', add
label define uhrswork_lbl 21 `"21"', add
label define uhrswork_lbl 22 `"22"', add
label define uhrswork_lbl 23 `"23"', add
label define uhrswork_lbl 24 `"24"', add
label define uhrswork_lbl 25 `"25"', add
label define uhrswork_lbl 26 `"26"', add
label define uhrswork_lbl 27 `"27"', add
label define uhrswork_lbl 28 `"28"', add
label define uhrswork_lbl 29 `"29"', add
label define uhrswork_lbl 30 `"30"', add
label define uhrswork_lbl 31 `"31"', add
label define uhrswork_lbl 32 `"32"', add
label define uhrswork_lbl 33 `"33"', add
label define uhrswork_lbl 34 `"34"', add
label define uhrswork_lbl 35 `"35"', add
label define uhrswork_lbl 36 `"36"', add
label define uhrswork_lbl 37 `"37"', add
label define uhrswork_lbl 38 `"38"', add
label define uhrswork_lbl 39 `"39"', add
label define uhrswork_lbl 40 `"40"', add
label define uhrswork_lbl 41 `"41"', add
label define uhrswork_lbl 42 `"42"', add
label define uhrswork_lbl 43 `"43"', add
label define uhrswork_lbl 44 `"44"', add
label define uhrswork_lbl 45 `"45"', add
label define uhrswork_lbl 46 `"46"', add
label define uhrswork_lbl 47 `"47"', add
label define uhrswork_lbl 48 `"48"', add
label define uhrswork_lbl 49 `"49"', add
label define uhrswork_lbl 50 `"50"', add
label define uhrswork_lbl 51 `"51"', add
label define uhrswork_lbl 52 `"52"', add
label define uhrswork_lbl 53 `"53"', add
label define uhrswork_lbl 54 `"54"', add
label define uhrswork_lbl 55 `"55"', add
label define uhrswork_lbl 56 `"56"', add
label define uhrswork_lbl 57 `"57"', add
label define uhrswork_lbl 58 `"58"', add
label define uhrswork_lbl 59 `"59"', add
label define uhrswork_lbl 60 `"60"', add
label define uhrswork_lbl 61 `"61"', add
label define uhrswork_lbl 62 `"62"', add
label define uhrswork_lbl 63 `"63"', add
label define uhrswork_lbl 64 `"64"', add
label define uhrswork_lbl 65 `"65"', add
label define uhrswork_lbl 66 `"66"', add
label define uhrswork_lbl 67 `"67"', add
label define uhrswork_lbl 68 `"68"', add
label define uhrswork_lbl 69 `"69"', add
label define uhrswork_lbl 70 `"70"', add
label define uhrswork_lbl 71 `"71"', add
label define uhrswork_lbl 72 `"72"', add
label define uhrswork_lbl 73 `"73"', add
label define uhrswork_lbl 74 `"74"', add
label define uhrswork_lbl 75 `"75"', add
label define uhrswork_lbl 76 `"76"', add
label define uhrswork_lbl 77 `"77"', add
label define uhrswork_lbl 78 `"78"', add
label define uhrswork_lbl 79 `"79"', add
label define uhrswork_lbl 80 `"80"', add
label define uhrswork_lbl 81 `"81"', add
label define uhrswork_lbl 82 `"82"', add
label define uhrswork_lbl 83 `"83"', add
label define uhrswork_lbl 84 `"84"', add
label define uhrswork_lbl 85 `"85"', add
label define uhrswork_lbl 86 `"86"', add
label define uhrswork_lbl 87 `"87"', add
label define uhrswork_lbl 88 `"88"', add
label define uhrswork_lbl 89 `"89"', add
label define uhrswork_lbl 90 `"90"', add
label define uhrswork_lbl 91 `"91"', add
label define uhrswork_lbl 92 `"92"', add
label define uhrswork_lbl 93 `"93"', add
label define uhrswork_lbl 94 `"94"', add
label define uhrswork_lbl 95 `"95"', add
label define uhrswork_lbl 96 `"96"', add
label define uhrswork_lbl 97 `"97"', add
label define uhrswork_lbl 98 `"98"', add
label define uhrswork_lbl 99 `"99 (Topcode)"', add
label values uhrswork uhrswork_lbl

label define migrate5_lbl 0 `"N/A"'
label define migrate5_lbl 1 `"Same house"', add
label define migrate5_lbl 2 `"Moved within state"', add
label define migrate5_lbl 3 `"Moved between states"', add
label define migrate5_lbl 4 `"Abroad five years ago"', add
label define migrate5_lbl 8 `"Moved (place not reported)"', add
label define migrate5_lbl 9 `"Unknown"', add
label values migrate5 migrate5_lbl

label define migrate5d_lbl 00 `"N/A"'
label define migrate5d_lbl 10 `"Same house"', add
label define migrate5d_lbl 20 `"Same state (migration status within state unknown)"', add
label define migrate5d_lbl 21 `"Different house, moved within county"', add
label define migrate5d_lbl 22 `"Different house, moved within state, between counties"', add
label define migrate5d_lbl 23 `"Different house, moved within state, within PUMA"', add
label define migrate5d_lbl 24 `"Different house, moved within state, between PUMAs"', add
label define migrate5d_lbl 25 `"Different house, unknown within state"', add
label define migrate5d_lbl 30 `"Different state (general)"', add
label define migrate5d_lbl 31 `"Moved between contiguous states"', add
label define migrate5d_lbl 32 `"Moved between non-contiguous states"', add
label define migrate5d_lbl 33 `"Unknown between states"', add
label define migrate5d_lbl 40 `"Abroad five years ago"', add
label define migrate5d_lbl 80 `"Moved, but place was not reported"', add
label define migrate5d_lbl 90 `"Unknown"', add
label values migrate5d migrate5d_lbl

label define migrate1_lbl 0 `"N/A"'
label define migrate1_lbl 1 `"Same house"', add
label define migrate1_lbl 2 `"Moved within state"', add
label define migrate1_lbl 3 `"Moved between states"', add
label define migrate1_lbl 4 `"Abroad one year ago"', add
label define migrate1_lbl 9 `"Unknown"', add
label values migrate1 migrate1_lbl

label define migrate1d_lbl 00 `"N/A"'
label define migrate1d_lbl 10 `"Same house"', add
label define migrate1d_lbl 20 `"Same state (migration status within state unknown)"', add
label define migrate1d_lbl 21 `"Different house, moved within county"', add
label define migrate1d_lbl 22 `"Different house, moved within state, between counties"', add
label define migrate1d_lbl 23 `"Different house, moved within state, within PUMA"', add
label define migrate1d_lbl 24 `"Different house, moved within state, between PUMAs"', add
label define migrate1d_lbl 25 `"Different house, unknown within state"', add
label define migrate1d_lbl 30 `"Different state (general)"', add
label define migrate1d_lbl 31 `"Moved between contigious states"', add
label define migrate1d_lbl 32 `"Moved between non-contiguous states"', add
label define migrate1d_lbl 40 `"Abroad one year ago"', add
label define migrate1d_lbl 90 `"Unknown"', add
label values migrate1d migrate1d_lbl

label define migplac5_lbl 000 `"N/A"'
label define migplac5_lbl 001 `"Alabama"', add
label define migplac5_lbl 002 `"Alaska"', add
label define migplac5_lbl 004 `"Arizona"', add
label define migplac5_lbl 005 `"Arkansas"', add
label define migplac5_lbl 006 `"California"', add
label define migplac5_lbl 008 `"Colorado"', add
label define migplac5_lbl 009 `"Connecticut"', add
label define migplac5_lbl 010 `"Delaware"', add
label define migplac5_lbl 011 `"District of Columbia"', add
label define migplac5_lbl 012 `"Florida"', add
label define migplac5_lbl 013 `"Georgia"', add
label define migplac5_lbl 015 `"Hawaii"', add
label define migplac5_lbl 016 `"Idaho"', add
label define migplac5_lbl 017 `"Illinois"', add
label define migplac5_lbl 018 `"Indiana"', add
label define migplac5_lbl 019 `"Iowa"', add
label define migplac5_lbl 020 `"Kansas"', add
label define migplac5_lbl 021 `"Kentucky"', add
label define migplac5_lbl 022 `"Louisiana"', add
label define migplac5_lbl 023 `"Maine"', add
label define migplac5_lbl 024 `"Maryland"', add
label define migplac5_lbl 025 `"Massachusetts"', add
label define migplac5_lbl 026 `"Michigan"', add
label define migplac5_lbl 027 `"Minnesota"', add
label define migplac5_lbl 028 `"Mississippi"', add
label define migplac5_lbl 029 `"Missouri"', add
label define migplac5_lbl 030 `"Montana"', add
label define migplac5_lbl 031 `"Nebraska"', add
label define migplac5_lbl 032 `"Nevada"', add
label define migplac5_lbl 033 `"New Hampshire"', add
label define migplac5_lbl 034 `"New Jersey"', add
label define migplac5_lbl 035 `"New Mexico"', add
label define migplac5_lbl 036 `"New York"', add
label define migplac5_lbl 037 `"North Carolina"', add
label define migplac5_lbl 038 `"North Dakota"', add
label define migplac5_lbl 039 `"Ohio"', add
label define migplac5_lbl 040 `"Oklahoma"', add
label define migplac5_lbl 041 `"Oregon"', add
label define migplac5_lbl 042 `"Pennsylvania"', add
label define migplac5_lbl 044 `"Rhode Island"', add
label define migplac5_lbl 045 `"South Carolina"', add
label define migplac5_lbl 046 `"South Dakota"', add
label define migplac5_lbl 047 `"Tennessee"', add
label define migplac5_lbl 048 `"Texas"', add
label define migplac5_lbl 049 `"Utah"', add
label define migplac5_lbl 050 `"Vermont"', add
label define migplac5_lbl 051 `"Virginia"', add
label define migplac5_lbl 053 `"Washington"', add
label define migplac5_lbl 054 `"West Virginia"', add
label define migplac5_lbl 055 `"Wisconsin"', add
label define migplac5_lbl 056 `"Wyoming"', add
label define migplac5_lbl 061 `"Maine-New Hampshire-Vermont"', add
label define migplac5_lbl 062 `"Massachussetts-Rhode Island"', add
label define migplac5_lbl 063 `"Minnesota-Iowa-Missouri-Kansas-Nebraska-Dakotas"', add
label define migplac5_lbl 064 `"Maryland-Delaware"', add
label define migplac5_lbl 065 `"Montana-Idaho-Wyoming"', add
label define migplac5_lbl 066 `"Utah-Nevada"', add
label define migplac5_lbl 067 `"Arizona-New Mexico"', add
label define migplac5_lbl 068 `"Alaska-Hawaii"', add
label define migplac5_lbl 099 `"United States, not specified or state confidential"', add
label define migplac5_lbl 100 `"Samoa"', add
label define migplac5_lbl 105 `"Guam"', add
label define migplac5_lbl 110 `"Puerto Rico"', add
label define migplac5_lbl 115 `"Virgin Islands"', add
label define migplac5_lbl 119 `"US outlying area (1980)"', add
label define migplac5_lbl 120 `"Other US Possessions"', add
label define migplac5_lbl 150 `"Canada"', add
label define migplac5_lbl 151 `"English Canada"', add
label define migplac5_lbl 152 `"French Canada"', add
label define migplac5_lbl 155 `"St Pierre and Miquelon"', add
label define migplac5_lbl 160 `"Atlantic Islands"', add
label define migplac5_lbl 199 `"North America"', add
label define migplac5_lbl 200 `"Mexico"', add
label define migplac5_lbl 211 `"Belize/British Honduras"', add
label define migplac5_lbl 212 `"Costa Rica"', add
label define migplac5_lbl 213 `"El Salvador"', add
label define migplac5_lbl 214 `"Guatemala"', add
label define migplac5_lbl 215 `"Honduras"', add
label define migplac5_lbl 216 `"Nicaragua"', add
label define migplac5_lbl 217 `"Panama"', add
label define migplac5_lbl 218 `"Canal Zone"', add
label define migplac5_lbl 219 `"Central America, nec"', add
label define migplac5_lbl 250 `"Cuba"', add
label define migplac5_lbl 260 `"West Indies"', add
label define migplac5_lbl 261 `"Dominican Republic"', add
label define migplac5_lbl 262 `"Haita"', add
label define migplac5_lbl 263 `"Jamaica"', add
label define migplac5_lbl 264 `"British West Indies"', add
label define migplac5_lbl 266 `"Trinidad and Tobago"', add
label define migplac5_lbl 267 `"Other West Indies"', add
label define migplac5_lbl 305 `"Argentina"', add
label define migplac5_lbl 310 `"Bolivia"', add
label define migplac5_lbl 315 `"Brazil"', add
label define migplac5_lbl 320 `"Chile"', add
label define migplac5_lbl 325 `"Colombia"', add
label define migplac5_lbl 330 `"Ecuador"', add
label define migplac5_lbl 345 `"Paraguay"', add
label define migplac5_lbl 350 `"Peru"', add
label define migplac5_lbl 360 `"Uruguay"', add
label define migplac5_lbl 365 `"Venezuela"', add
label define migplac5_lbl 370 `"North or Central America, n.s. (2000 5%)"', add
label define migplac5_lbl 390 `"South America, nec"', add
label define migplac5_lbl 400 `"Denmark"', add
label define migplac5_lbl 401 `"Finland"', add
label define migplac5_lbl 402 `"Iceland"', add
label define migplac5_lbl 404 `"Norway"', add
label define migplac5_lbl 405 `"Sweden"', add
label define migplac5_lbl 410 `"England"', add
label define migplac5_lbl 411 `"Scotland"', add
label define migplac5_lbl 412 `"Wales"', add
label define migplac5_lbl 413 `"United Kingdom"', add
label define migplac5_lbl 414 `"Ireland"', add
label define migplac5_lbl 415 `"Northern Ireland"', add
label define migplac5_lbl 420 `"Belgium"', add
label define migplac5_lbl 421 `"France"', add
label define migplac5_lbl 422 `"Liechtenstein"', add
label define migplac5_lbl 423 `"Luxembourg"', add
label define migplac5_lbl 424 `"Monaco"', add
label define migplac5_lbl 425 `"Netherlands"', add
label define migplac5_lbl 426 `"Switzerland"', add
label define migplac5_lbl 430 `"Albania"', add
label define migplac5_lbl 431 `"Andorra"', add
label define migplac5_lbl 432 `"Gibraltar"', add
label define migplac5_lbl 433 `"Greece"', add
label define migplac5_lbl 434 `"Dodecanese Islands"', add
label define migplac5_lbl 435 `"Italy"', add
label define migplac5_lbl 436 `"Portugal"', add
label define migplac5_lbl 437 `"Azores"', add
label define migplac5_lbl 438 `"Spain"', add
label define migplac5_lbl 439 `"Vatican City"', add
label define migplac5_lbl 440 `"Malta"', add
label define migplac5_lbl 450 `"Austria"', add
label define migplac5_lbl 451 `"Bulgaria"', add
label define migplac5_lbl 452 `"Czechoslovakia"', add
label define migplac5_lbl 453 `"Germany"', add
label define migplac5_lbl 454 `"Hungary"', add
label define migplac5_lbl 455 `"Poland"', add
label define migplac5_lbl 456 `"Romania"', add
label define migplac5_lbl 457 `"Yugoslavia"', add
label define migplac5_lbl 460 `"Estonia"', add
label define migplac5_lbl 461 `"Latvia"', add
label define migplac5_lbl 462 `"Lithuania"', add
label define migplac5_lbl 465 `"USSR"', add
label define migplac5_lbl 496 `"Byelorussia"', add
label define migplac5_lbl 498 `"Ukraine"', add
label define migplac5_lbl 499 `"Europe, n.s."', add
label define migplac5_lbl 500 `"China"', add
label define migplac5_lbl 501 `"Japan"', add
label define migplac5_lbl 502 `"Korea"', add
label define migplac5_lbl 510 `"Brunei"', add
label define migplac5_lbl 511 `"Cambodia"', add
label define migplac5_lbl 512 `"Indonesia"', add
label define migplac5_lbl 513 `"Laos"', add
label define migplac5_lbl 514 `"Malaysia"', add
label define migplac5_lbl 515 `"Philippines"', add
label define migplac5_lbl 516 `"Singapore"', add
label define migplac5_lbl 517 `"Thailand"', add
label define migplac5_lbl 518 `"Vietnam"', add
label define migplac5_lbl 520 `"Afghanistan"', add
label define migplac5_lbl 521 `"India"', add
label define migplac5_lbl 525 `"Pakistan"', add
label define migplac5_lbl 522 `"Iran"', add
label define migplac5_lbl 523 `"Maldives"', add
label define migplac5_lbl 524 `"Nepal"', add
label define migplac5_lbl 530 `"Bahrain"', add
label define migplac5_lbl 531 `"Cyprus"', add
label define migplac5_lbl 532 `"Iraq"', add
label define migplac5_lbl 534 `"Israel"', add
label define migplac5_lbl 535 `"Jordan"', add
label define migplac5_lbl 536 `"Kuwait"', add
label define migplac5_lbl 537 `"Lebanon"', add
label define migplac5_lbl 538 `"Oman"', add
label define migplac5_lbl 539 `"Qatar"', add
label define migplac5_lbl 540 `"Saudi Arabia"', add
label define migplac5_lbl 541 `"Syria"', add
label define migplac5_lbl 542 `"Turkey"', add
label define migplac5_lbl 543 `"United Arab Emirates"', add
label define migplac5_lbl 544 `"Yemen"', add
label define migplac5_lbl 548 `"Southwest Asia, nec/ns"', add
label define migplac5_lbl 599 `"Asia, nec/ns"', add
label define migplac5_lbl 600 `"Africa"', add
label define migplac5_lbl 610 `"Northern Africa"', add
label define migplac5_lbl 612 `"Egypt/United Arab Rep."', add
label define migplac5_lbl 670 `"Central Africa"', add
label define migplac5_lbl 690 `"Southern Africa"', add
label define migplac5_lbl 694 `"South Africa (Union of)"', add
label define migplac5_lbl 699 `"Africa, nec"', add
label define migplac5_lbl 700 `"Coral Sea Islands"', add
label define migplac5_lbl 701 `"Australia"', add
label define migplac5_lbl 702 `"New Zealand"', add
label define migplac5_lbl 710 `"Pacific Islands"', add
label define migplac5_lbl 715 `"US Pacific Trust Territories"', add
label define migplac5_lbl 800 `"Heard and McDonald Islands"', add
label define migplac5_lbl 900 `"Abroad (unknown) or at sea"', add
label define migplac5_lbl 911 `"Abroad, ns"', add
label define migplac5_lbl 912 `"At sea"', add
label define migplac5_lbl 990 `"Same house"', add
label define migplac5_lbl 999 `"Missing/unknown"', add
label values migplac5 migplac5_lbl

label define migplac1_lbl 000 `"N/A"'
label define migplac1_lbl 001 `"Alabama"', add
label define migplac1_lbl 002 `"Alaska"', add
label define migplac1_lbl 004 `"Arizona"', add
label define migplac1_lbl 005 `"Arkansas"', add
label define migplac1_lbl 006 `"California"', add
label define migplac1_lbl 008 `"Colorado"', add
label define migplac1_lbl 009 `"Connecticut"', add
label define migplac1_lbl 010 `"Delaware"', add
label define migplac1_lbl 011 `"District of Columbia"', add
label define migplac1_lbl 012 `"Florida"', add
label define migplac1_lbl 013 `"Georgia"', add
label define migplac1_lbl 015 `"Hawaii"', add
label define migplac1_lbl 016 `"Idaho"', add
label define migplac1_lbl 017 `"Illinois"', add
label define migplac1_lbl 018 `"Indiana"', add
label define migplac1_lbl 019 `"Iowa"', add
label define migplac1_lbl 020 `"Kansas"', add
label define migplac1_lbl 021 `"Kentucky"', add
label define migplac1_lbl 022 `"Louisiana"', add
label define migplac1_lbl 023 `"Maine"', add
label define migplac1_lbl 024 `"Maryland"', add
label define migplac1_lbl 025 `"Massachusetts"', add
label define migplac1_lbl 026 `"Michigan"', add
label define migplac1_lbl 027 `"Minnesota"', add
label define migplac1_lbl 028 `"Mississippi"', add
label define migplac1_lbl 029 `"Missouri"', add
label define migplac1_lbl 030 `"Montana"', add
label define migplac1_lbl 031 `"Nebraska"', add
label define migplac1_lbl 032 `"Nevada"', add
label define migplac1_lbl 033 `"New Hampshire"', add
label define migplac1_lbl 034 `"New Jersey"', add
label define migplac1_lbl 035 `"New Mexico"', add
label define migplac1_lbl 036 `"New York"', add
label define migplac1_lbl 037 `"North Carolina"', add
label define migplac1_lbl 038 `"North Dakota"', add
label define migplac1_lbl 039 `"Ohio"', add
label define migplac1_lbl 040 `"Oklahoma"', add
label define migplac1_lbl 041 `"Oregon"', add
label define migplac1_lbl 042 `"Pennsylvania"', add
label define migplac1_lbl 044 `"Rhode Island"', add
label define migplac1_lbl 045 `"South Carolina"', add
label define migplac1_lbl 046 `"South Dakota"', add
label define migplac1_lbl 047 `"Tennessee"', add
label define migplac1_lbl 048 `"Texas"', add
label define migplac1_lbl 049 `"Utah"', add
label define migplac1_lbl 050 `"Vermont"', add
label define migplac1_lbl 051 `"Virginia"', add
label define migplac1_lbl 053 `"Washington"', add
label define migplac1_lbl 054 `"West Virginia"', add
label define migplac1_lbl 055 `"Wisconsin"', add
label define migplac1_lbl 056 `"Wyoming"', add
label define migplac1_lbl 099 `"United States, ns"', add
label define migplac1_lbl 100 `"Samoa, 1950"', add
label define migplac1_lbl 105 `"Guam"', add
label define migplac1_lbl 110 `"Puerto Rico"', add
label define migplac1_lbl 115 `"Virgin Islands"', add
label define migplac1_lbl 120 `"Other US Possessions"', add
label define migplac1_lbl 150 `"Canada"', add
label define migplac1_lbl 151 `"English Canada"', add
label define migplac1_lbl 152 `"French Canada"', add
label define migplac1_lbl 160 `"Atlantic Islands"', add
label define migplac1_lbl 200 `"Mexico"', add
label define migplac1_lbl 211 `"Belize/British Honduras"', add
label define migplac1_lbl 212 `"Costa Rica"', add
label define migplac1_lbl 213 `"El Salvador"', add
label define migplac1_lbl 214 `"Guatemala"', add
label define migplac1_lbl 215 `"Honduras"', add
label define migplac1_lbl 216 `"Nicaragua"', add
label define migplac1_lbl 217 `"Panama"', add
label define migplac1_lbl 218 `"Canal Zone"', add
label define migplac1_lbl 219 `"Central America, nec"', add
label define migplac1_lbl 250 `"Cuba"', add
label define migplac1_lbl 261 `"Dominican Republic"', add
label define migplac1_lbl 262 `"Haiti"', add
label define migplac1_lbl 263 `"Jamaica"', add
label define migplac1_lbl 264 `"British West Indies"', add
label define migplac1_lbl 267 `"Other West Indies"', add
label define migplac1_lbl 290 `"Other Caribbean and North America"', add
label define migplac1_lbl 305 `"Argentina"', add
label define migplac1_lbl 310 `"Bolivia"', add
label define migplac1_lbl 315 `"Brazil"', add
label define migplac1_lbl 320 `"Chile"', add
label define migplac1_lbl 325 `"Colombia"', add
label define migplac1_lbl 330 `"Ecuador"', add
label define migplac1_lbl 345 `"Paraguay"', add
label define migplac1_lbl 350 `"Peru"', add
label define migplac1_lbl 360 `"Uruguay"', add
label define migplac1_lbl 365 `"Venezuela"', add
label define migplac1_lbl 390 `"South America, nec"', add
label define migplac1_lbl 400 `"Denmark"', add
label define migplac1_lbl 401 `"Finland"', add
label define migplac1_lbl 402 `"Iceland"', add
label define migplac1_lbl 404 `"Norway"', add
label define migplac1_lbl 405 `"Sweden"', add
label define migplac1_lbl 410 `"England"', add
label define migplac1_lbl 411 `"Scotland"', add
label define migplac1_lbl 412 `"Wales"', add
label define migplac1_lbl 413 `"United Kingdom (excluding England: 2005ACS)"', add
label define migplac1_lbl 414 `"Ireland"', add
label define migplac1_lbl 415 `"Northern Ireland"', add
label define migplac1_lbl 419 `"Other Northern Europe"', add
label define migplac1_lbl 420 `"Belgium"', add
label define migplac1_lbl 421 `"France"', add
label define migplac1_lbl 422 `"Luxembourg"', add
label define migplac1_lbl 425 `"Netherlands"', add
label define migplac1_lbl 426 `"Switzerland"', add
label define migplac1_lbl 429 `"Other Western Europe"', add
label define migplac1_lbl 430 `"Albania"', add
label define migplac1_lbl 433 `"Greece"', add
label define migplac1_lbl 434 `"Dodecanese Islands"', add
label define migplac1_lbl 435 `"Italy"', add
label define migplac1_lbl 436 `"Portugal"', add
label define migplac1_lbl 437 `"Azores"', add
label define migplac1_lbl 438 `"Spain"', add
label define migplac1_lbl 450 `"Austria"', add
label define migplac1_lbl 451 `"Bulgaria"', add
label define migplac1_lbl 452 `"Czechoslovakia"', add
label define migplac1_lbl 453 `"Germany"', add
label define migplac1_lbl 454 `"Hungary"', add
label define migplac1_lbl 455 `"Poland"', add
label define migplac1_lbl 456 `"Romania"', add
label define migplac1_lbl 457 `"Yugoslavia"', add
label define migplac1_lbl 458 `"Bosnia and Herzegovinia"', add
label define migplac1_lbl 459 `"Other Eastern Europe"', add
label define migplac1_lbl 460 `"Estonia"', add
label define migplac1_lbl 461 `"Latvia"', add
label define migplac1_lbl 462 `"Lithuania"', add
label define migplac1_lbl 463 `"Other Northern or Eastern Europe"', add
label define migplac1_lbl 465 `"USSR"', add
label define migplac1_lbl 498 `"Ukraine"', add
label define migplac1_lbl 499 `"Europe, ns"', add
label define migplac1_lbl 500 `"China"', add
label define migplac1_lbl 501 `"Japan"', add
label define migplac1_lbl 502 `"Korea"', add
label define migplac1_lbl 503 `"Taiwan"', add
label define migplac1_lbl 515 `"Philippines"', add
label define migplac1_lbl 517 `"Thailand"', add
label define migplac1_lbl 518 `"Vietnam"', add
label define migplac1_lbl 519 `"Other South East Asia"', add
label define migplac1_lbl 520 `"Nepal"', add
label define migplac1_lbl 521 `"India"', add
label define migplac1_lbl 522 `"Iran"', add
label define migplac1_lbl 523 `"Iraq"', add
label define migplac1_lbl 525 `"Pakistan"', add
label define migplac1_lbl 534 `"Israel/Palestine"', add
label define migplac1_lbl 535 `"Jordan"', add
label define migplac1_lbl 537 `"Lebanon"', add
label define migplac1_lbl 539 `"United Arab Emirates"', add
label define migplac1_lbl 540 `"Saudi Arabia"', add
label define migplac1_lbl 541 `"Syria"', add
label define migplac1_lbl 542 `"Turkey"', add
label define migplac1_lbl 543 `"Afghanistan"', add
label define migplac1_lbl 551 `"Other Western Asia"', add
label define migplac1_lbl 599 `"Asia, nec"', add
label define migplac1_lbl 600 `"Africa"', add
label define migplac1_lbl 610 `"Northern Africa"', add
label define migplac1_lbl 611 `"Egypt"', add
label define migplac1_lbl 619 `"Nigeria"', add
label define migplac1_lbl 620 `"Western Africa"', add
label define migplac1_lbl 621 `"Eastern Africa"', add
label define migplac1_lbl 622 `"Ethiopia"', add
label define migplac1_lbl 623 `"Kenya"', add
label define migplac1_lbl 694 `"South Africa (Union of)"', add
label define migplac1_lbl 699 `"Africa, nec"', add
label define migplac1_lbl 701 `"Australia"', add
label define migplac1_lbl 702 `"New Zealand"', add
label define migplac1_lbl 710 `"Pacific Islands (Australia and New Zealand Subregions, not specified, Oceania and at Sea: ACS)"', add
label define migplac1_lbl 900 `"Abroad (unknown) or at sea"', add
label define migplac1_lbl 997 `"Unknown value"', add
label define migplac1_lbl 999 `"Missing"', add
label values migplac1 migplac1_lbl

label define disabwrk_lbl 0 `"N/A"'
label define disabwrk_lbl 1 `"No disability that affects work"', add
label define disabwrk_lbl 2 `"Disability limits but does not prevent work"', add
label define disabwrk_lbl 3 `"Disability prevents work"', add
label define disabwrk_lbl 4 `"Difficulty working"', add
label values disabwrk disabwrk_lbl

label define vetstat_lbl 0 `"N/A"'
label define vetstat_lbl 1 `"Not a veteran"', add
label define vetstat_lbl 2 `"Veteran"', add
label define vetstat_lbl 9 `"Unknown"', add
label values vetstat vetstat_lbl

label define vetstatd_lbl 00 `"N/A"'
label define vetstatd_lbl 10 `"Not a veteran"', add
label define vetstatd_lbl 11 `"No military service"', add
label define vetstatd_lbl 12 `"Currently on active duty"', add
label define vetstatd_lbl 13 `"Training for Reserves or National Guard only"', add
label define vetstatd_lbl 20 `"Veteran"', add
label define vetstatd_lbl 21 `"Veteran, on active duty prior to past year"', add
label define vetstatd_lbl 22 `"Veteran, on active duty in past year"', add
label define vetstatd_lbl 23 `"Veteran, on active duty in Reserves or National Guard only"', add
label define vetstatd_lbl 99 `"Unknown"', add
label values vetstatd vetstatd_lbl

label define qage_lbl 0 `"Entered as written"'
label define qage_lbl 1 `"Failed edit"', add
label define qage_lbl 2 `"Illegible"', add
label define qage_lbl 3 `"Missing"', add
label define qage_lbl 4 `"Allocated"', add
label define qage_lbl 5 `"Illegible"', add
label define qage_lbl 6 `"Missing"', add
label define qage_lbl 7 `"Original entry illegible"', add
label define qage_lbl 8 `"Original entry missing or failed edit"', add
label values qage qage_lbl

label define qsex_lbl 0 `"Entered as written"'
label define qsex_lbl 1 `"Failed edit"', add
label define qsex_lbl 2 `"Illegible"', add
label define qsex_lbl 3 `"Missing"', add
label define qsex_lbl 4 `"Allocated"', add
label define qsex_lbl 5 `"Illegible"', add
label define qsex_lbl 6 `"Missing"', add
label define qsex_lbl 7 `"Original entry illegible"', add
label define qsex_lbl 8 `"Original entry missing or failed edit"', add
label values qsex qsex_lbl

label define qhispan_lbl 0 `"Not allocated"'
label define qhispan_lbl 1 `"Allocated from information for this person or from relative, this household"', add
label define qhispan_lbl 2 `"Allocated from nonrelative, this household"', add
label define qhispan_lbl 4 `"Allocated"', add
label values qhispan qhispan_lbl

label define qrace_lbl 0 `"Entered as written"'
label define qrace_lbl 1 `"Failed edit"', add
label define qrace_lbl 2 `"Illegible"', add
label define qrace_lbl 3 `"Missing"', add
label define qrace_lbl 4 `"Allocated"', add
label define qrace_lbl 5 `"Allocated, hot deck"', add
label define qrace_lbl 6 `"Missing"', add
label define qrace_lbl 7 `"Original entry illegible"', add
label define qrace_lbl 8 `"Original entry missing or failed edit"', add
label values qrace qrace_lbl

label define qeduc_lbl 0 `"Original entry or Inapplicable (not in universe)"'
label define qeduc_lbl 1 `"Failed edit"', add
label define qeduc_lbl 2 `"Failed edit/illegible"', add
label define qeduc_lbl 3 `"Failed edit/missing"', add
label define qeduc_lbl 4 `"Consistency edit"', add
label define qeduc_lbl 5 `"Consistency edit/allocated, hot deck"', add
label define qeduc_lbl 6 `"Failed edit/missing"', add
label define qeduc_lbl 7 `"Illegible"', add
label define qeduc_lbl 8 `"Illegible/missing or failed edit"', add
label values qeduc qeduc_lbl

label define qclasswk_lbl 0 `"Original entry or Inapplicable (not in universe)"'
label define qclasswk_lbl 1 `"Failed edit"', add
label define qclasswk_lbl 2 `"Illegible"', add
label define qclasswk_lbl 3 `"Missing"', add
label define qclasswk_lbl 4 `"Allocated"', add
label define qclasswk_lbl 5 `"Illegible"', add
label define qclasswk_lbl 6 `"Missing"', add
label define qclasswk_lbl 7 `"Original entry illegible"', add
label define qclasswk_lbl 8 `"Original entry missing or failed edit"', add
label values qclasswk qclasswk_lbl

label define qempstat_lbl 0 `"Original entry or Inapplicable (not in universe)"'
label define qempstat_lbl 1 `"Failed edit"', add
label define qempstat_lbl 2 `"Illegible"', add
label define qempstat_lbl 3 `"Missing"', add
label define qempstat_lbl 4 `"Allocated"', add
label define qempstat_lbl 5 `"Illegible"', add
label define qempstat_lbl 6 `"Missing"', add
label define qempstat_lbl 7 `"Original entry illegible"', add
label define qempstat_lbl 8 `"Original entry missing or failed edit"', add
label values qempstat qempstat_lbl

label define qhrswork_lbl 0 `"Original entry or Inapplicable (not in universe)"'
label define qhrswork_lbl 1 `"Failed edit"', add
label define qhrswork_lbl 2 `"Illegible"', add
label define qhrswork_lbl 3 `"Missing"', add
label define qhrswork_lbl 4 `"Allocated"', add
label define qhrswork_lbl 5 `"Illegible"', add
label define qhrswork_lbl 6 `"Missing"', add
label define qhrswork_lbl 7 `"Original entry illegible"', add
label define qhrswork_lbl 8 `"Original entry missing or failed edit"', add
label values qhrswork qhrswork_lbl

label define quhrswor_lbl 0 `"Not allocated"'
label define quhrswor_lbl 3 `"Allocated, direct"', add
label define quhrswor_lbl 4 `"Allocated"', add
label define quhrswor_lbl 5 `"Allocated, indirect"', add
label define quhrswor_lbl 9 `"Allocated, direct/indirect"', add
label values quhrswor quhrswor_lbl

label define qwkswork_lbl 0 `"Original entry or Inapplicable (not in universe)"'
label define qwkswork_lbl 1 `"Failed edit"', add
label define qwkswork_lbl 2 `"Illegible"', add
label define qwkswork_lbl 3 `"Missing"', add
label define qwkswork_lbl 4 `"Allocated, pre-edit"', add
label define qwkswork_lbl 5 `"Allocated, hot deck"', add
label define qwkswork_lbl 6 `"Missing"', add
label define qwkswork_lbl 7 `"Original entry illegible"', add
label define qwkswork_lbl 8 `"Original entry missing or failed edit"', add
label values qwkswork qwkswork_lbl

label define qincwage_lbl 0 `"Original entry or Inapplicable (not in universe)"'
label define qincwage_lbl 1 `"Failed edit"', add
label define qincwage_lbl 2 `"Illegible"', add
label define qincwage_lbl 3 `"Missing"', add
label define qincwage_lbl 4 `"Allocated"', add
label define qincwage_lbl 5 `"Illegible"', add
label define qincwage_lbl 6 `"Missing"', add
label define qincwage_lbl 7 `"Original entry illegible"', add
label define qincwage_lbl 8 `"Original entry missing or failed edit"', add
label values qincwage qincwage_lbl

label define sex_sp_lbl 1 `"Male"'
label define sex_sp_lbl 2 `"Female"', add
label values sex_sp sex_sp_lbl

label define age_sp_lbl 000 `"Less than 1 year old"'
label define age_sp_lbl 001 `"1"', add
label define age_sp_lbl 002 `"2"', add
label define age_sp_lbl 003 `"3"', add
label define age_sp_lbl 004 `"4"', add
label define age_sp_lbl 005 `"5"', add
label define age_sp_lbl 006 `"6"', add
label define age_sp_lbl 007 `"7"', add
label define age_sp_lbl 008 `"8"', add
label define age_sp_lbl 009 `"9"', add
label define age_sp_lbl 010 `"10"', add
label define age_sp_lbl 011 `"11"', add
label define age_sp_lbl 012 `"12"', add
label define age_sp_lbl 013 `"13"', add
label define age_sp_lbl 014 `"14"', add
label define age_sp_lbl 015 `"15"', add
label define age_sp_lbl 016 `"16"', add
label define age_sp_lbl 017 `"17"', add
label define age_sp_lbl 018 `"18"', add
label define age_sp_lbl 019 `"19"', add
label define age_sp_lbl 020 `"20"', add
label define age_sp_lbl 021 `"21"', add
label define age_sp_lbl 022 `"22"', add
label define age_sp_lbl 023 `"23"', add
label define age_sp_lbl 024 `"24"', add
label define age_sp_lbl 025 `"25"', add
label define age_sp_lbl 026 `"26"', add
label define age_sp_lbl 027 `"27"', add
label define age_sp_lbl 028 `"28"', add
label define age_sp_lbl 029 `"29"', add
label define age_sp_lbl 030 `"30"', add
label define age_sp_lbl 031 `"31"', add
label define age_sp_lbl 032 `"32"', add
label define age_sp_lbl 033 `"33"', add
label define age_sp_lbl 034 `"34"', add
label define age_sp_lbl 035 `"35"', add
label define age_sp_lbl 036 `"36"', add
label define age_sp_lbl 037 `"37"', add
label define age_sp_lbl 038 `"38"', add
label define age_sp_lbl 039 `"39"', add
label define age_sp_lbl 040 `"40"', add
label define age_sp_lbl 041 `"41"', add
label define age_sp_lbl 042 `"42"', add
label define age_sp_lbl 043 `"43"', add
label define age_sp_lbl 044 `"44"', add
label define age_sp_lbl 045 `"45"', add
label define age_sp_lbl 046 `"46"', add
label define age_sp_lbl 047 `"47"', add
label define age_sp_lbl 048 `"48"', add
label define age_sp_lbl 049 `"49"', add
label define age_sp_lbl 050 `"50"', add
label define age_sp_lbl 051 `"51"', add
label define age_sp_lbl 052 `"52"', add
label define age_sp_lbl 053 `"53"', add
label define age_sp_lbl 054 `"54"', add
label define age_sp_lbl 055 `"55"', add
label define age_sp_lbl 056 `"56"', add
label define age_sp_lbl 057 `"57"', add
label define age_sp_lbl 058 `"58"', add
label define age_sp_lbl 059 `"59"', add
label define age_sp_lbl 060 `"60"', add
label define age_sp_lbl 061 `"61"', add
label define age_sp_lbl 062 `"62"', add
label define age_sp_lbl 063 `"63"', add
label define age_sp_lbl 064 `"64"', add
label define age_sp_lbl 065 `"65"', add
label define age_sp_lbl 066 `"66"', add
label define age_sp_lbl 067 `"67"', add
label define age_sp_lbl 068 `"68"', add
label define age_sp_lbl 069 `"69"', add
label define age_sp_lbl 070 `"70"', add
label define age_sp_lbl 071 `"71"', add
label define age_sp_lbl 072 `"72"', add
label define age_sp_lbl 073 `"73"', add
label define age_sp_lbl 074 `"74"', add
label define age_sp_lbl 075 `"75"', add
label define age_sp_lbl 076 `"76"', add
label define age_sp_lbl 077 `"77"', add
label define age_sp_lbl 078 `"78"', add
label define age_sp_lbl 079 `"79"', add
label define age_sp_lbl 080 `"80"', add
label define age_sp_lbl 081 `"81"', add
label define age_sp_lbl 082 `"82"', add
label define age_sp_lbl 083 `"83"', add
label define age_sp_lbl 084 `"84"', add
label define age_sp_lbl 085 `"85"', add
label define age_sp_lbl 086 `"86"', add
label define age_sp_lbl 087 `"87"', add
label define age_sp_lbl 088 `"88"', add
label define age_sp_lbl 089 `"89"', add
label define age_sp_lbl 090 `"90 (90+ in 1980 and 1990)"', add
label define age_sp_lbl 091 `"91"', add
label define age_sp_lbl 092 `"92"', add
label define age_sp_lbl 093 `"93"', add
label define age_sp_lbl 094 `"94"', add
label define age_sp_lbl 095 `"95"', add
label define age_sp_lbl 096 `"96"', add
label define age_sp_lbl 097 `"97"', add
label define age_sp_lbl 098 `"98"', add
label define age_sp_lbl 099 `"99"', add
label define age_sp_lbl 100 `"100 (100+ in 1960-1970)"', add
label define age_sp_lbl 101 `"101"', add
label define age_sp_lbl 102 `"102"', add
label define age_sp_lbl 103 `"103"', add
label define age_sp_lbl 104 `"104"', add
label define age_sp_lbl 105 `"105"', add
label define age_sp_lbl 106 `"106"', add
label define age_sp_lbl 107 `"107"', add
label define age_sp_lbl 108 `"108"', add
label define age_sp_lbl 109 `"109"', add
label define age_sp_lbl 110 `"110"', add
label define age_sp_lbl 111 `"111"', add
label define age_sp_lbl 112 `"112 (112+ in the 1980 internal data)"', add
label define age_sp_lbl 113 `"113"', add
label define age_sp_lbl 114 `"114"', add
label define age_sp_lbl 115 `"115 (115+ in the 1990 internal data)"', add
label define age_sp_lbl 116 `"116"', add
label define age_sp_lbl 117 `"117"', add
label define age_sp_lbl 118 `"118"', add
label define age_sp_lbl 119 `"119"', add
label define age_sp_lbl 120 `"120"', add
label define age_sp_lbl 121 `"121"', add
label define age_sp_lbl 122 `"122"', add
label define age_sp_lbl 123 `"123"', add
label define age_sp_lbl 124 `"124"', add
label define age_sp_lbl 125 `"125"', add
label define age_sp_lbl 126 `"126"', add
label define age_sp_lbl 129 `"129"', add
label define age_sp_lbl 130 `"130"', add
label define age_sp_lbl 135 `"135"', add
label values age_sp age_sp_lbl

label define race_mom_lbl 1 `"White"'
label define race_mom_lbl 2 `"Black/African American/Negro"', add
label define race_mom_lbl 3 `"American Indian or Alaska Native"', add
label define race_mom_lbl 4 `"Chinese"', add
label define race_mom_lbl 5 `"Japanese"', add
label define race_mom_lbl 6 `"Other Asian or Pacific Islander"', add
label define race_mom_lbl 7 `"Other race, nec"', add
label define race_mom_lbl 8 `"Two major races"', add
label define race_mom_lbl 9 `"Three or more major races"', add
label values race_mom race_mom_lbl

label define raced_mom_lbl 100 `"White"'
label define raced_mom_lbl 110 `"Spanish write_in"', add
label define raced_mom_lbl 120 `"Blank (white) (1850)"', add
label define raced_mom_lbl 130 `"Portuguese"', add
label define raced_mom_lbl 140 `"Mexican (1930)"', add
label define raced_mom_lbl 150 `"Puerto Rican (1910 Hawaii)"', add
label define raced_mom_lbl 200 `"Black/African American/Negro"', add
label define raced_mom_lbl 210 `"Mulatto"', add
label define raced_mom_lbl 300 `"American Indian/Alaska Native"', add
label define raced_mom_lbl 302 `"Apache"', add
label define raced_mom_lbl 303 `"Blackfoot"', add
label define raced_mom_lbl 304 `"Cherokee"', add
label define raced_mom_lbl 305 `"Cheyenne"', add
label define raced_mom_lbl 306 `"Chickasaw"', add
label define raced_mom_lbl 307 `"Chippewa"', add
label define raced_mom_lbl 308 `"Choctaw"', add
label define raced_mom_lbl 309 `"Comanche"', add
label define raced_mom_lbl 310 `"Creek"', add
label define raced_mom_lbl 311 `"Crow"', add
label define raced_mom_lbl 312 `"Iroquois"', add
label define raced_mom_lbl 313 `"Kiowa"', add
label define raced_mom_lbl 314 `"Lumbee"', add
label define raced_mom_lbl 315 `"Navajo"', add
label define raced_mom_lbl 316 `"Osage"', add
label define raced_mom_lbl 317 `"Paiute"', add
label define raced_mom_lbl 318 `"Pima"', add
label define raced_mom_lbl 319 `"Potawatomi"', add
label define raced_mom_lbl 320 `"Pueblo"', add
label define raced_mom_lbl 321 `"Seminole"', add
label define raced_mom_lbl 322 `"Shoshone"', add
label define raced_mom_lbl 323 `"Sioux"', add
label define raced_mom_lbl 324 `"Tlingit (Tlingit_Haida, 2000/ACS)"', add
label define raced_mom_lbl 325 `"Tohono O Odham"', add
label define raced_mom_lbl 326 `"All other tribes (1990)"', add
label define raced_mom_lbl 328 `"Hopi"', add
label define raced_mom_lbl 329 `"Central American Indian"', add
label define raced_mom_lbl 330 `"Spanish American Indian"', add
label define raced_mom_lbl 350 `"Delaware"', add
label define raced_mom_lbl 351 `"Latin American Indian"', add
label define raced_mom_lbl 352 `"Puget Sound Salish"', add
label define raced_mom_lbl 353 `"Yakama"', add
label define raced_mom_lbl 354 `"Yaqui"', add
label define raced_mom_lbl 355 `"Colville"', add
label define raced_mom_lbl 356 `"Houma"', add
label define raced_mom_lbl 357 `"Menominee"', add
label define raced_mom_lbl 358 `"Yuman"', add
label define raced_mom_lbl 359 `"South American Indian"', add
label define raced_mom_lbl 360 `"Mexican American Indian"', add
label define raced_mom_lbl 361 `"Other Amer. Indian tribe (2000,ACS)"', add
label define raced_mom_lbl 362 `"2+ Amer. Indian tribes (2000,ACS)"', add
label define raced_mom_lbl 370 `"Alaskan Athabaskan"', add
label define raced_mom_lbl 371 `"Aleut"', add
label define raced_mom_lbl 372 `"Eskimo"', add
label define raced_mom_lbl 373 `"Alaskan mixed"', add
label define raced_mom_lbl 374 `"Inupiat"', add
label define raced_mom_lbl 375 `"Yup'ik"', add
label define raced_mom_lbl 379 `"Other Alaska Native tribe(s) (2000,ACS)"', add
label define raced_mom_lbl 398 `"Both Am. Ind. and Alaska Native (2000,ACS)"', add
label define raced_mom_lbl 399 `"Tribe not specified"', add
label define raced_mom_lbl 400 `"Chinese"', add
label define raced_mom_lbl 410 `"Taiwanese"', add
label define raced_mom_lbl 420 `"Chinese and Taiwanese"', add
label define raced_mom_lbl 500 `"Japanese"', add
label define raced_mom_lbl 600 `"Filipino"', add
label define raced_mom_lbl 610 `"Asian Indian (Hindu 1920_1940)"', add
label define raced_mom_lbl 620 `"Korean"', add
label define raced_mom_lbl 630 `"Hawaiian"', add
label define raced_mom_lbl 631 `"Hawaiian and Asian (1900,1920)"', add
label define raced_mom_lbl 632 `"Hawaiian and European (1900,1920)"', add
label define raced_mom_lbl 634 `"Hawaiian mixed"', add
label define raced_mom_lbl 640 `"Vietnamese"', add
label define raced_mom_lbl 641 `"Bhutanese"', add
label define raced_mom_lbl 642 `"Mongolian"', add
label define raced_mom_lbl 643 `"Nepalese"', add
label define raced_mom_lbl 650 `"Other Asian or Pacific Islander (1920,1980)"', add
label define raced_mom_lbl 651 `"Asian only (CPS)"', add
label define raced_mom_lbl 652 `"Pacific Islander only (CPS)"', add
label define raced_mom_lbl 653 `"Asian or Pacific Islander, n.s. (1990 Internal Census files)"', add
label define raced_mom_lbl 660 `"Cambodian"', add
label define raced_mom_lbl 661 `"Hmong"', add
label define raced_mom_lbl 662 `"Laotian"', add
label define raced_mom_lbl 663 `"Thai"', add
label define raced_mom_lbl 664 `"Bangladeshi"', add
label define raced_mom_lbl 665 `"Burmese"', add
label define raced_mom_lbl 666 `"Indonesian"', add
label define raced_mom_lbl 667 `"Malaysian"', add
label define raced_mom_lbl 668 `"Okinawan"', add
label define raced_mom_lbl 669 `"Pakistani"', add
label define raced_mom_lbl 670 `"Sri Lankan"', add
label define raced_mom_lbl 671 `"Other Asian, n.e.c."', add
label define raced_mom_lbl 672 `"Asian, not specified"', add
label define raced_mom_lbl 673 `"Chinese and Japanese"', add
label define raced_mom_lbl 674 `"Chinese and Filipino"', add
label define raced_mom_lbl 675 `"Chinese and Vietnamese"', add
label define raced_mom_lbl 676 `"Chinese and Asian write_in"', add
label define raced_mom_lbl 677 `"Japanese and Filipino"', add
label define raced_mom_lbl 678 `"Asian Indian and Asian write_in"', add
label define raced_mom_lbl 679 `"Other Asian race combinations"', add
label define raced_mom_lbl 680 `"Samoan"', add
label define raced_mom_lbl 681 `"Tahitian"', add
label define raced_mom_lbl 682 `"Tongan"', add
label define raced_mom_lbl 683 `"Other Polynesian (1990)"', add
label define raced_mom_lbl 684 `"1+ other Polynesian races (2000,ACS)"', add
label define raced_mom_lbl 685 `"Guamanian/Chamorro"', add
label define raced_mom_lbl 686 `"Northern Mariana Islander"', add
label define raced_mom_lbl 687 `"Palauan"', add
label define raced_mom_lbl 688 `"Other Micronesian (1990)"', add
label define raced_mom_lbl 689 `"1+ other Micronesian races (2000,ACS)"', add
label define raced_mom_lbl 690 `"Fijian"', add
label define raced_mom_lbl 691 `"Other Melanesian (1990)"', add
label define raced_mom_lbl 692 `"1+ other Melanesian races (2000,ACS)"', add
label define raced_mom_lbl 698 `"2+ PI races from 2+ PI regions"', add
label define raced_mom_lbl 699 `"Pacific Islander, n.s."', add
label define raced_mom_lbl 700 `"Other race, n.e.c."', add
label define raced_mom_lbl 801 `"White and Black"', add
label define raced_mom_lbl 802 `"White and AIAN"', add
label define raced_mom_lbl 810 `"White and Asian"', add
label define raced_mom_lbl 811 `"White and Chinese"', add
label define raced_mom_lbl 812 `"White and Japanese"', add
label define raced_mom_lbl 813 `"White and Filipino"', add
label define raced_mom_lbl 814 `"White and Asian Indian"', add
label define raced_mom_lbl 815 `"White and Korean"', add
label define raced_mom_lbl 816 `"White and Vietnamese"', add
label define raced_mom_lbl 817 `"White and Asian write_in"', add
label define raced_mom_lbl 818 `"White and other Asian race(s)"', add
label define raced_mom_lbl 819 `"White and two or more Asian groups"', add
label define raced_mom_lbl 820 `"White and PI"', add
label define raced_mom_lbl 821 `"White and Native Hawaiian"', add
label define raced_mom_lbl 822 `"White and Samoan"', add
label define raced_mom_lbl 823 `"White and Guamanian"', add
label define raced_mom_lbl 824 `"White and PI write_in"', add
label define raced_mom_lbl 825 `"White and other PI race(s)"', add
label define raced_mom_lbl 826 `"White and other race write_in"', add
label define raced_mom_lbl 827 `"White and other race, n.e.c."', add
label define raced_mom_lbl 830 `"Black and AIAN"', add
label define raced_mom_lbl 831 `"Black and Asian"', add
label define raced_mom_lbl 832 `"Black and Chinese"', add
label define raced_mom_lbl 833 `"Black and Japanese"', add
label define raced_mom_lbl 834 `"Black and Filipino"', add
label define raced_mom_lbl 835 `"Black and Asian Indian"', add
label define raced_mom_lbl 836 `"Black and Korean"', add
label define raced_mom_lbl 837 `"Black and Asian write_in"', add
label define raced_mom_lbl 838 `"Black and other Asian race(s)"', add
label define raced_mom_lbl 840 `"Black and PI"', add
label define raced_mom_lbl 841 `"Black and PI write_in"', add
label define raced_mom_lbl 842 `"Black and other PI race(s)"', add
label define raced_mom_lbl 845 `"Black and other race write_in"', add
label define raced_mom_lbl 850 `"AIAN and Asian"', add
label define raced_mom_lbl 851 `"AIAN and Filipino (2000 1%)"', add
label define raced_mom_lbl 852 `"AIAN and Asian Indian"', add
label define raced_mom_lbl 853 `"AIAN and Asian write_in (2000 1%)"', add
label define raced_mom_lbl 854 `"AIAN and other Asian race(s)"', add
label define raced_mom_lbl 855 `"AIAN and PI"', add
label define raced_mom_lbl 856 `"AIAN and other race write_in"', add
label define raced_mom_lbl 860 `"Asian and PI"', add
label define raced_mom_lbl 861 `"Chinese and Hawaiian"', add
label define raced_mom_lbl 862 `"Chinese, Filipino, Hawaiian (2000 1%)"', add
label define raced_mom_lbl 863 `"Japanese and Hawaiian (2000 1%)"', add
label define raced_mom_lbl 864 `"Filipino and Hawaiian"', add
label define raced_mom_lbl 865 `"Filipino and PI write_in"', add
label define raced_mom_lbl 866 `"Asian Indian and PI write_in (2000 1%)"', add
label define raced_mom_lbl 867 `"Asian write_in and PI write_in"', add
label define raced_mom_lbl 868 `"Other Asian race(s) and PI race(s)"', add
label define raced_mom_lbl 869 `"Japanese and Korean (ACS)"', add
label define raced_mom_lbl 880 `"Asian and other race write_in"', add
label define raced_mom_lbl 881 `"Chinese and other race write_in"', add
label define raced_mom_lbl 882 `"Japanese and other race write_in"', add
label define raced_mom_lbl 883 `"Filipino and other race write_in"', add
label define raced_mom_lbl 884 `"Asian Indian and other race write_in"', add
label define raced_mom_lbl 885 `"Asian write_in and other race write_in"', add
label define raced_mom_lbl 886 `"Other Asian race(s) and other race write_in"', add
label define raced_mom_lbl 887 `"Chinese and Korean"', add
label define raced_mom_lbl 890 `"PI and other race write_in:"', add
label define raced_mom_lbl 891 `"PI write_in and other race write_in"', add
label define raced_mom_lbl 892 `"Other PI race(s) and other race write_in"', add
label define raced_mom_lbl 893 `"Native Hawaiian or PI other race(s)"', add
label define raced_mom_lbl 899 `"API and other race write_in"', add
label define raced_mom_lbl 901 `"White, Black, AIAN"', add
label define raced_mom_lbl 902 `"White, Black, Asian"', add
label define raced_mom_lbl 903 `"White, Black, PI"', add
label define raced_mom_lbl 904 `"White, Black, other race write_in"', add
label define raced_mom_lbl 905 `"White, AIAN, Asian"', add
label define raced_mom_lbl 906 `"White, AIAN, PI"', add
label define raced_mom_lbl 907 `"White, AIAN, other race write_in"', add
label define raced_mom_lbl 910 `"White, Asian, PI"', add
label define raced_mom_lbl 911 `"White, Chinese, Hawaiian"', add
label define raced_mom_lbl 912 `"White, Chinese, Filipino, Hawaiian (2000 1%)"', add
label define raced_mom_lbl 913 `"White, Japanese, Hawaiian (2000 1%)"', add
label define raced_mom_lbl 914 `"White, Filipino, Hawaiian"', add
label define raced_mom_lbl 915 `"Other White, Asian race(s), PI race(s)"', add
label define raced_mom_lbl 916 `"White, AIAN and Filipino"', add
label define raced_mom_lbl 917 `"White, Black, and Filipino"', add
label define raced_mom_lbl 920 `"White, Asian, other race write_in"', add
label define raced_mom_lbl 921 `"White, Filipino, other race write_in (2000 1%)"', add
label define raced_mom_lbl 922 `"White, Asian write_in, other race write_in (2000 1%)"', add
label define raced_mom_lbl 923 `"Other White, Asian race(s), other race write_in (2000 1%)"', add
label define raced_mom_lbl 925 `"White, PI, other race write_in"', add
label define raced_mom_lbl 930 `"Black, AIAN, Asian"', add
label define raced_mom_lbl 931 `"Black, AIAN, PI"', add
label define raced_mom_lbl 932 `"Black, AIAN, other race write_in"', add
label define raced_mom_lbl 933 `"Black, Asian, PI"', add
label define raced_mom_lbl 934 `"Black, Asian, other race write_in"', add
label define raced_mom_lbl 935 `"Black, PI, other race write_in"', add
label define raced_mom_lbl 940 `"AIAN, Asian, PI"', add
label define raced_mom_lbl 941 `"AIAN, Asian, other race write_in"', add
label define raced_mom_lbl 942 `"AIAN, PI, other race write_in"', add
label define raced_mom_lbl 943 `"Asian, PI, other race write_in"', add
label define raced_mom_lbl 944 `"Asian (Chinese, Japanese, Korean, Vietnamese); and Native Hawaiian or PI; and Other"', add
label define raced_mom_lbl 949 `"2 or 3 races (CPS)"', add
label define raced_mom_lbl 950 `"White, Black, AIAN, Asian"', add
label define raced_mom_lbl 951 `"White, Black, AIAN, PI"', add
label define raced_mom_lbl 952 `"White, Black, AIAN, other race write_in"', add
label define raced_mom_lbl 953 `"White, Black, Asian, PI"', add
label define raced_mom_lbl 954 `"White, Black, Asian, other race write_in"', add
label define raced_mom_lbl 955 `"White, Black, PI, other race write_in"', add
label define raced_mom_lbl 960 `"White, AIAN, Asian, PI"', add
label define raced_mom_lbl 961 `"White, AIAN, Asian, other race write_in"', add
label define raced_mom_lbl 962 `"White, AIAN, PI, other race write_in"', add
label define raced_mom_lbl 963 `"White, Asian, PI, other race write_in"', add
label define raced_mom_lbl 964 `"White, Chinese, Japanese, Native Hawaiian"', add
label define raced_mom_lbl 970 `"Black, AIAN, Asian, PI"', add
label define raced_mom_lbl 971 `"Black, AIAN, Asian, other race write_in"', add
label define raced_mom_lbl 972 `"Black, AIAN, PI, other race write_in"', add
label define raced_mom_lbl 973 `"Black, Asian, PI, other race write_in"', add
label define raced_mom_lbl 974 `"AIAN, Asian, PI, other race write_in"', add
label define raced_mom_lbl 975 `"AIAN, Asian, PI, Hawaiian other race write_in"', add
label define raced_mom_lbl 976 `"Two specified Asian  (Chinese and other Asian, Chinese and Japanese, Japanese and other Asian, Korean and other Asian); Native Hawaiian/PI; and Other Race"', add
label define raced_mom_lbl 980 `"White, Black, AIAN, Asian, PI"', add
label define raced_mom_lbl 981 `"White, Black, AIAN, Asian, other race write_in"', add
label define raced_mom_lbl 982 `"White, Black, AIAN, PI, other race write_in"', add
label define raced_mom_lbl 983 `"White, Black, Asian, PI, other race write_in"', add
label define raced_mom_lbl 984 `"White, AIAN, Asian, PI, other race write_in"', add
label define raced_mom_lbl 985 `"Black, AIAN, Asian, PI, other race write_in"', add
label define raced_mom_lbl 986 `"Black, AIAN, Asian, PI, Hawaiian, other race write_in"', add
label define raced_mom_lbl 989 `"4 or 5 races (CPS)"', add
label define raced_mom_lbl 990 `"White, Black, AIAN, Asian, PI, other race write_in"', add
label define raced_mom_lbl 991 `"White race; Some other race; Black or African American race and/or American Indian and Alaska Native race and/or Asian groups and/or Native Hawaiian and Other Pacific Islander groups"', add
label define raced_mom_lbl 996 `"2+ races, n.e.c. (CPS)"', add
label values raced_mom raced_mom_lbl

label define hispan_mom_lbl 0 `"Not Hispanic"'
label define hispan_mom_lbl 1 `"Mexican"', add
label define hispan_mom_lbl 2 `"Puerto Rican"', add
label define hispan_mom_lbl 3 `"Cuban"', add
label define hispan_mom_lbl 4 `"Other"', add
label define hispan_mom_lbl 9 `"Not Reported"', add
label values hispan_mom hispan_mom_lbl

label define hispand_mom_lbl 000 `"Not Hispanic"'
label define hispand_mom_lbl 100 `"Mexican"', add
label define hispand_mom_lbl 102 `"Mexican American"', add
label define hispand_mom_lbl 103 `"Mexicano/Mexicana"', add
label define hispand_mom_lbl 104 `"Chicano/Chicana"', add
label define hispand_mom_lbl 105 `"La Raza"', add
label define hispand_mom_lbl 106 `"Mexican American Indian"', add
label define hispand_mom_lbl 107 `"Mexico"', add
label define hispand_mom_lbl 200 `"Puerto Rican"', add
label define hispand_mom_lbl 300 `"Cuban"', add
label define hispand_mom_lbl 401 `"Central American Indian"', add
label define hispand_mom_lbl 402 `"Canal Zone"', add
label define hispand_mom_lbl 411 `"Costa Rican"', add
label define hispand_mom_lbl 412 `"Guatemalan"', add
label define hispand_mom_lbl 413 `"Honduran"', add
label define hispand_mom_lbl 414 `"Nicaraguan"', add
label define hispand_mom_lbl 415 `"Panamanian"', add
label define hispand_mom_lbl 416 `"Salvadoran"', add
label define hispand_mom_lbl 417 `"Central American, n.e.c."', add
label define hispand_mom_lbl 420 `"Argentinean"', add
label define hispand_mom_lbl 421 `"Bolivian"', add
label define hispand_mom_lbl 422 `"Chilean"', add
label define hispand_mom_lbl 423 `"Colombian"', add
label define hispand_mom_lbl 424 `"Ecuadorian"', add
label define hispand_mom_lbl 425 `"Paraguayan"', add
label define hispand_mom_lbl 426 `"Peruvian"', add
label define hispand_mom_lbl 427 `"Uruguayan"', add
label define hispand_mom_lbl 428 `"Venezuelan"', add
label define hispand_mom_lbl 429 `"South American Indian"', add
label define hispand_mom_lbl 430 `"Criollo"', add
label define hispand_mom_lbl 431 `"South American, n.e.c."', add
label define hispand_mom_lbl 450 `"Spaniard"', add
label define hispand_mom_lbl 451 `"Andalusian"', add
label define hispand_mom_lbl 452 `"Asturian"', add
label define hispand_mom_lbl 453 `"Castillian"', add
label define hispand_mom_lbl 454 `"Catalonian"', add
label define hispand_mom_lbl 455 `"Balearic Islander"', add
label define hispand_mom_lbl 456 `"Gallego"', add
label define hispand_mom_lbl 457 `"Valencian"', add
label define hispand_mom_lbl 458 `"Canarian"', add
label define hispand_mom_lbl 459 `"Spanish Basque"', add
label define hispand_mom_lbl 460 `"Dominican"', add
label define hispand_mom_lbl 465 `"Latin American"', add
label define hispand_mom_lbl 470 `"Hispanic"', add
label define hispand_mom_lbl 480 `"Spanish"', add
label define hispand_mom_lbl 490 `"Californio"', add
label define hispand_mom_lbl 491 `"Tejano"', add
label define hispand_mom_lbl 492 `"Nuevo Mexicano"', add
label define hispand_mom_lbl 493 `"Spanish American"', add
label define hispand_mom_lbl 494 `"Spanish American Indian"', add
label define hispand_mom_lbl 495 `"Meso American Indian"', add
label define hispand_mom_lbl 496 `"Mestizo"', add
label define hispand_mom_lbl 498 `"Other, n.s."', add
label define hispand_mom_lbl 499 `"Other, n.e.c."', add
label define hispand_mom_lbl 900 `"Not Reported"', add
label values hispand_mom hispand_mom_lbl

label define educ_mom_lbl 00 `"N/A or no schooling"'
label define educ_mom_lbl 01 `"Nursery school to grade 4"', add
label define educ_mom_lbl 02 `"Grade 5, 6, 7, or 8"', add
label define educ_mom_lbl 03 `"Grade 9"', add
label define educ_mom_lbl 04 `"Grade 10"', add
label define educ_mom_lbl 05 `"Grade 11"', add
label define educ_mom_lbl 06 `"Grade 12"', add
label define educ_mom_lbl 07 `"1 year of college"', add
label define educ_mom_lbl 08 `"2 years of college"', add
label define educ_mom_lbl 09 `"3 years of college"', add
label define educ_mom_lbl 10 `"4 years of college"', add
label define educ_mom_lbl 11 `"5+ years of college"', add
label values educ_mom educ_mom_lbl

label define educ_sp_lbl 00 `"N/A or no schooling"'
label define educ_sp_lbl 01 `"Nursery school to grade 4"', add
label define educ_sp_lbl 02 `"Grade 5, 6, 7, or 8"', add
label define educ_sp_lbl 03 `"Grade 9"', add
label define educ_sp_lbl 04 `"Grade 10"', add
label define educ_sp_lbl 05 `"Grade 11"', add
label define educ_sp_lbl 06 `"Grade 12"', add
label define educ_sp_lbl 07 `"1 year of college"', add
label define educ_sp_lbl 08 `"2 years of college"', add
label define educ_sp_lbl 09 `"3 years of college"', add
label define educ_sp_lbl 10 `"4 years of college"', add
label define educ_sp_lbl 11 `"5+ years of college"', add
label values educ_sp educ_sp_lbl

label define educd_mom_lbl 000 `"N/A or no schooling"'
label define educd_mom_lbl 001 `"N/A"', add
label define educd_mom_lbl 002 `"No schooling completed"', add
label define educd_mom_lbl 010 `"Nursery school to grade 4"', add
label define educd_mom_lbl 011 `"Nursery school, preschool"', add
label define educd_mom_lbl 012 `"Kindergarten"', add
label define educd_mom_lbl 013 `"Grade 1, 2, 3, or 4"', add
label define educd_mom_lbl 014 `"Grade 1"', add
label define educd_mom_lbl 015 `"Grade 2"', add
label define educd_mom_lbl 016 `"Grade 3"', add
label define educd_mom_lbl 017 `"Grade 4"', add
label define educd_mom_lbl 020 `"Grade 5, 6, 7, or 8"', add
label define educd_mom_lbl 021 `"Grade 5 or 6"', add
label define educd_mom_lbl 022 `"Grade 5"', add
label define educd_mom_lbl 023 `"Grade 6"', add
label define educd_mom_lbl 024 `"Grade 7 or 8"', add
label define educd_mom_lbl 025 `"Grade 7"', add
label define educd_mom_lbl 026 `"Grade 8"', add
label define educd_mom_lbl 030 `"Grade 9"', add
label define educd_mom_lbl 040 `"Grade 10"', add
label define educd_mom_lbl 050 `"Grade 11"', add
label define educd_mom_lbl 060 `"Grade 12"', add
label define educd_mom_lbl 061 `"12th grade, no diploma"', add
label define educd_mom_lbl 062 `"High school graduate or GED"', add
label define educd_mom_lbl 063 `"Regular high school diploma"', add
label define educd_mom_lbl 064 `"GED or alternative credential"', add
label define educd_mom_lbl 065 `"Some college, but less than 1 year"', add
label define educd_mom_lbl 070 `"1 year of college"', add
label define educd_mom_lbl 071 `"1 or more years of college credit, no degree"', add
label define educd_mom_lbl 080 `"2 years of college"', add
label define educd_mom_lbl 081 `"Associate's degree, type not specified"', add
label define educd_mom_lbl 082 `"Associate's degree, occupational program"', add
label define educd_mom_lbl 083 `"Associate's degree, academic program"', add
label define educd_mom_lbl 090 `"3 years of college"', add
label define educd_mom_lbl 100 `"4 years of college"', add
label define educd_mom_lbl 101 `"Bachelor's degree"', add
label define educd_mom_lbl 110 `"5+ years of college"', add
label define educd_mom_lbl 111 `"6 years of college (6+ in 1960-1970)"', add
label define educd_mom_lbl 112 `"7 years of college"', add
label define educd_mom_lbl 113 `"8+ years of college"', add
label define educd_mom_lbl 114 `"Master's degree"', add
label define educd_mom_lbl 115 `"Professional degree beyond a bachelor's degree"', add
label define educd_mom_lbl 116 `"Doctoral degree"', add
label define educd_mom_lbl 999 `"Missing"', add
label values educd_mom educd_mom_lbl

label define educd_sp_lbl 000 `"N/A or no schooling"'
label define educd_sp_lbl 001 `"N/A"', add
label define educd_sp_lbl 002 `"No schooling completed"', add
label define educd_sp_lbl 010 `"Nursery school to grade 4"', add
label define educd_sp_lbl 011 `"Nursery school, preschool"', add
label define educd_sp_lbl 012 `"Kindergarten"', add
label define educd_sp_lbl 013 `"Grade 1, 2, 3, or 4"', add
label define educd_sp_lbl 014 `"Grade 1"', add
label define educd_sp_lbl 015 `"Grade 2"', add
label define educd_sp_lbl 016 `"Grade 3"', add
label define educd_sp_lbl 017 `"Grade 4"', add
label define educd_sp_lbl 020 `"Grade 5, 6, 7, or 8"', add
label define educd_sp_lbl 021 `"Grade 5 or 6"', add
label define educd_sp_lbl 022 `"Grade 5"', add
label define educd_sp_lbl 023 `"Grade 6"', add
label define educd_sp_lbl 024 `"Grade 7 or 8"', add
label define educd_sp_lbl 025 `"Grade 7"', add
label define educd_sp_lbl 026 `"Grade 8"', add
label define educd_sp_lbl 030 `"Grade 9"', add
label define educd_sp_lbl 040 `"Grade 10"', add
label define educd_sp_lbl 050 `"Grade 11"', add
label define educd_sp_lbl 060 `"Grade 12"', add
label define educd_sp_lbl 061 `"12th grade, no diploma"', add
label define educd_sp_lbl 062 `"High school graduate or GED"', add
label define educd_sp_lbl 063 `"Regular high school diploma"', add
label define educd_sp_lbl 064 `"GED or alternative credential"', add
label define educd_sp_lbl 065 `"Some college, but less than 1 year"', add
label define educd_sp_lbl 070 `"1 year of college"', add
label define educd_sp_lbl 071 `"1 or more years of college credit, no degree"', add
label define educd_sp_lbl 080 `"2 years of college"', add
label define educd_sp_lbl 081 `"Associate's degree, type not specified"', add
label define educd_sp_lbl 082 `"Associate's degree, occupational program"', add
label define educd_sp_lbl 083 `"Associate's degree, academic program"', add
label define educd_sp_lbl 090 `"3 years of college"', add
label define educd_sp_lbl 100 `"4 years of college"', add
label define educd_sp_lbl 101 `"Bachelor's degree"', add
label define educd_sp_lbl 110 `"5+ years of college"', add
label define educd_sp_lbl 111 `"6 years of college (6+ in 1960-1970)"', add
label define educd_sp_lbl 112 `"7 years of college"', add
label define educd_sp_lbl 113 `"8+ years of college"', add
label define educd_sp_lbl 114 `"Master's degree"', add
label define educd_sp_lbl 115 `"Professional degree beyond a bachelor's degree"', add
label define educd_sp_lbl 116 `"Doctoral degree"', add
label define educd_sp_lbl 999 `"Missing"', add
label values educd_sp educd_sp_lbl

label define empstat_sp_lbl 0 `"N/A"'
label define empstat_sp_lbl 1 `"Employed"', add
label define empstat_sp_lbl 2 `"Unemployed"', add
label define empstat_sp_lbl 3 `"Not in labor force"', add
label values empstat_sp empstat_sp_lbl

label define wkswork2_sp_lbl 0 `"N/A"'
label define wkswork2_sp_lbl 1 `"1-13 weeks"', add
label define wkswork2_sp_lbl 2 `"14-26 weeks"', add
label define wkswork2_sp_lbl 3 `"27-39 weeks"', add
label define wkswork2_sp_lbl 4 `"40-47 weeks"', add
label define wkswork2_sp_lbl 5 `"48-49 weeks"', add
label define wkswork2_sp_lbl 6 `"50-52 weeks"', add
label values wkswork2_sp wkswork2_sp_lbl

label define hrswork2_sp_lbl 0 `"N/A"'
label define hrswork2_sp_lbl 1 `"1-14 hours"', add
label define hrswork2_sp_lbl 2 `"15-29 hours"', add
label define hrswork2_sp_lbl 3 `"30-34 hours"', add
label define hrswork2_sp_lbl 4 `"35-39 hours"', add
label define hrswork2_sp_lbl 5 `"40 hours"', add
label define hrswork2_sp_lbl 6 `"41-48 hours"', add
label define hrswork2_sp_lbl 7 `"49-59 hours"', add
label define hrswork2_sp_lbl 8 `"60+ hours"', add
label values hrswork2_sp hrswork2_sp_lbl

label define uhrswork_sp_lbl 00 `"N/A"'
label define uhrswork_sp_lbl 01 `"1"', add
label define uhrswork_sp_lbl 02 `"2"', add
label define uhrswork_sp_lbl 03 `"3"', add
label define uhrswork_sp_lbl 04 `"4"', add
label define uhrswork_sp_lbl 05 `"5"', add
label define uhrswork_sp_lbl 06 `"6"', add
label define uhrswork_sp_lbl 07 `"7"', add
label define uhrswork_sp_lbl 08 `"8"', add
label define uhrswork_sp_lbl 09 `"9"', add
label define uhrswork_sp_lbl 10 `"10"', add
label define uhrswork_sp_lbl 11 `"11"', add
label define uhrswork_sp_lbl 12 `"12"', add
label define uhrswork_sp_lbl 13 `"13"', add
label define uhrswork_sp_lbl 14 `"14"', add
label define uhrswork_sp_lbl 15 `"15"', add
label define uhrswork_sp_lbl 16 `"16"', add
label define uhrswork_sp_lbl 17 `"17"', add
label define uhrswork_sp_lbl 18 `"18"', add
label define uhrswork_sp_lbl 19 `"19"', add
label define uhrswork_sp_lbl 20 `"20"', add
label define uhrswork_sp_lbl 21 `"21"', add
label define uhrswork_sp_lbl 22 `"22"', add
label define uhrswork_sp_lbl 23 `"23"', add
label define uhrswork_sp_lbl 24 `"24"', add
label define uhrswork_sp_lbl 25 `"25"', add
label define uhrswork_sp_lbl 26 `"26"', add
label define uhrswork_sp_lbl 27 `"27"', add
label define uhrswork_sp_lbl 28 `"28"', add
label define uhrswork_sp_lbl 29 `"29"', add
label define uhrswork_sp_lbl 30 `"30"', add
label define uhrswork_sp_lbl 31 `"31"', add
label define uhrswork_sp_lbl 32 `"32"', add
label define uhrswork_sp_lbl 33 `"33"', add
label define uhrswork_sp_lbl 34 `"34"', add
label define uhrswork_sp_lbl 35 `"35"', add
label define uhrswork_sp_lbl 36 `"36"', add
label define uhrswork_sp_lbl 37 `"37"', add
label define uhrswork_sp_lbl 38 `"38"', add
label define uhrswork_sp_lbl 39 `"39"', add
label define uhrswork_sp_lbl 40 `"40"', add
label define uhrswork_sp_lbl 41 `"41"', add
label define uhrswork_sp_lbl 42 `"42"', add
label define uhrswork_sp_lbl 43 `"43"', add
label define uhrswork_sp_lbl 44 `"44"', add
label define uhrswork_sp_lbl 45 `"45"', add
label define uhrswork_sp_lbl 46 `"46"', add
label define uhrswork_sp_lbl 47 `"47"', add
label define uhrswork_sp_lbl 48 `"48"', add
label define uhrswork_sp_lbl 49 `"49"', add
label define uhrswork_sp_lbl 50 `"50"', add
label define uhrswork_sp_lbl 51 `"51"', add
label define uhrswork_sp_lbl 52 `"52"', add
label define uhrswork_sp_lbl 53 `"53"', add
label define uhrswork_sp_lbl 54 `"54"', add
label define uhrswork_sp_lbl 55 `"55"', add
label define uhrswork_sp_lbl 56 `"56"', add
label define uhrswork_sp_lbl 57 `"57"', add
label define uhrswork_sp_lbl 58 `"58"', add
label define uhrswork_sp_lbl 59 `"59"', add
label define uhrswork_sp_lbl 60 `"60"', add
label define uhrswork_sp_lbl 61 `"61"', add
label define uhrswork_sp_lbl 62 `"62"', add
label define uhrswork_sp_lbl 63 `"63"', add
label define uhrswork_sp_lbl 64 `"64"', add
label define uhrswork_sp_lbl 65 `"65"', add
label define uhrswork_sp_lbl 66 `"66"', add
label define uhrswork_sp_lbl 67 `"67"', add
label define uhrswork_sp_lbl 68 `"68"', add
label define uhrswork_sp_lbl 69 `"69"', add
label define uhrswork_sp_lbl 70 `"70"', add
label define uhrswork_sp_lbl 71 `"71"', add
label define uhrswork_sp_lbl 72 `"72"', add
label define uhrswork_sp_lbl 73 `"73"', add
label define uhrswork_sp_lbl 74 `"74"', add
label define uhrswork_sp_lbl 75 `"75"', add
label define uhrswork_sp_lbl 76 `"76"', add
label define uhrswork_sp_lbl 77 `"77"', add
label define uhrswork_sp_lbl 78 `"78"', add
label define uhrswork_sp_lbl 79 `"79"', add
label define uhrswork_sp_lbl 80 `"80"', add
label define uhrswork_sp_lbl 81 `"81"', add
label define uhrswork_sp_lbl 82 `"82"', add
label define uhrswork_sp_lbl 83 `"83"', add
label define uhrswork_sp_lbl 84 `"84"', add
label define uhrswork_sp_lbl 85 `"85"', add
label define uhrswork_sp_lbl 86 `"86"', add
label define uhrswork_sp_lbl 87 `"87"', add
label define uhrswork_sp_lbl 88 `"88"', add
label define uhrswork_sp_lbl 89 `"89"', add
label define uhrswork_sp_lbl 90 `"90"', add
label define uhrswork_sp_lbl 91 `"91"', add
label define uhrswork_sp_lbl 92 `"92"', add
label define uhrswork_sp_lbl 93 `"93"', add
label define uhrswork_sp_lbl 94 `"94"', add
label define uhrswork_sp_lbl 95 `"95"', add
label define uhrswork_sp_lbl 96 `"96"', add
label define uhrswork_sp_lbl 97 `"97"', add
label define uhrswork_sp_lbl 98 `"98"', add
label define uhrswork_sp_lbl 99 `"99 (Topcode)"', add
label values uhrswork_sp uhrswork_sp_lbl




!gzip usa_00113.dat

compress
saveold "$data/census7010.dta" , replace

log close
