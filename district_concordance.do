/******************************************************************************
File: temp_district_concord.do
Author: Bishmay Barik
Purpose: District Concordance
******************************************************************************/

clear all

*********************** 2003 *********************************

use "$output/AIDIS 2003/loan_with_dist_2003.dta", clear

cap keep State District dist_code_2003 state_code_2003

cap rename State state_2003
cap rename District district_2003

cap gen state_2003_upper = strupper(state_2003)
cap gen district_2003_upper = strupper(district_2003)

replace state_2003 = state_2003_upper
replace district_2003 = district_2003_upper

cap drop state_2003_upper district_2003_upper

duplicates drop state_2003 district_2003, force

* There are some districts which are not present in the district code layout as well
* in the NSS documentation. So I will have to drop them. 

* Step 1: Generate an indicator for numeric values in district_2013
gen is_numeric = !missing(real(district_2003))

* Step 2: Drop observations where district_2013 is numeric
drop if is_numeric

* Step 3: Optionally, drop the indicator variable
drop is_numeric

gen state = state_2003
gen district = district_2003

save "$output/temp/dist_2003.dta", replace

*********************** 2013 *********************************

use "$output/AIDIS 2013/loan_with_dist_2013.dta", clear

cap keep state district dist_code_2013 state_code_2013

cap rename state state_2013
cap rename district district_2013

cap gen state_2013_upper = strupper(state_2013)
cap gen district_2013_upper = strupper(district_2013)

replace state_2013 = state_2013_upper
replace district_2013 = district_2013_upper

cap drop state_2013_upper district_2013_upper

duplicates drop state_2013 district_2013, force

* There are some districts which are not present in the district code layout as well
* in the NSS documentation. So I will have to drop them. 

* Step 1: Generate an indicator for numeric values in district_2013
gen is_numeric = !missing(real(district_2013))

* Step 2: Drop observations where district_2013 is numeric
drop if is_numeric

* Step 3: Optionally, drop the indicator variable
drop is_numeric

gen state = state_2013
gen district = district_2013

save "$output/temp/dist_2013.dta", replace



*******************************************************************************
*******************************************************************************
****************** District Concordance starts here ***************************
*******************************************************************************
*******************************************************************************

use "$output/temp/dist_2003.dta", clear

* Delhi

cap drop if district == "EAST" & state == "DELHI"
cap drop if district == "SOUTH" & state == "DELHI"
cap drop if district == "WEST" & state == "DELHI"

* Lahul & Spiti

cap drop if district == "LAHUL & SPITI" & state == "HIMACHAL PRADESH"

* Mahe - Pondicherry

* cap drop if district == "MAHE" & state == "PONDICHERRY"

* Ramnathapuram --> Ramanathapuram

replace district = "RAMANATHAPURAM" if district == "RAMNATHAPURAM" & state == "TAMIL NADU"

* Andhra Telengana

* cap drop if district == "HYDERABAD" & state == "ANDHRA PRADESH"

save "$output/temp/dist_2003.dta", replace

use "$output/temp/dist_2013.dta", clear

* Fixing the states

replace state = "ANDAMAN AND NICOBAR ISLANDS" if state == "ANDAMAN & NICOBAR ISLANDS"
replace state = "UTTARANCHAL" if state == "UTTARAKHAND"
replace state = "ANDHRA PRADESH" if state == "TELENGANA"
replace state = "CHATTISGARH" if state == "CHHATTISGARH"
replace state = "JAMMU & KASHMIR" if state == "JAMMU AND KASHMIR"


* Fixing the districts 

* Andaman and Nicobar Islands

replace district = "ANDAMANS" if district == "NORTH & MIDDLE ANDAMAN" & state == "ANDAMAN AND NICOBAR ISLANDS"
replace district = "ANDAMANS" if district == "SOUTH ANDAMAN" & state == "ANDAMAN AND NICOBAR ISLANDS"
replace district = "NICOBARS" if district == "NICOBAR" & state == "ANDAMAN AND NICOBAR ISLANDS"

* Gujarat 

replace district = "AHMEDABAD" if district == "AHMADABAD" & state == "GUJARAT"
replace district = "ANAND" if district == "ANAND *" & state == "GUJARAT"
replace district = "BANS KANTHA" if district == "BANAS KANTHA" & state == "GUJARAT"
replace district = "DAHOD" if district == "DOHAD *" & state == "GUJARAT"
replace district = "NARMADA" if district == "NARMADA *" & state == "GUJARAT"
replace district = "NAVSARI" if district == "NAVSARI *" & state == "GUJARAT"
replace district = "PANCHMAHAL" if district == "PANCH MAHALS" & state == "GUJARAT"
replace district = "PATAN" if district == "PATAN *" & state == "GUJARAT"
replace district = "PORBANDER" if district == "PORBANDAR *" & state == "GUJARAT"
replace district = "SURAT" if district == "TAPI" & state == "GUJARAT"

* Mizoram

replace district = "AIZWAL" if district == "AIZAWL" & state == "MIZORAM"
replace district = "CHAMPHAI" if district == "CHAMPHAI *" & state == "MIZORAM"
replace district = "KOLASIB" if district == "KOLASIB *" & state == "MIZORAM"
replace district = "MAMIT" if district == "MAMIT *" & state == "MIZORAM"
replace district = "SAIHA" if district == "SAIHA *" & state == "MIZORAM"
replace district = "SERCHIP" if district == "SERCHHIP *" & state == "MIZORAM"

* Madhya Pradesh

replace district = "JHABUA" if district == "ALIRAJPUR" & state == "MADHYA PRADESH"
replace district = "SHAHDOL" if district == "ANUPPUR" & state == "MADHYA PRADESH"
replace district = "GUNA" if district == "ASHOKNAGAR" & state == "MADHYA PRADESH"
replace district = "BARWANI" if district == "BARWANI *" & state == "MADHYA PRADESH"
replace district = "KHANDWA (EAST NIMAR)" if district == "BURHANPUR" & state == "MADHYA PRADESH"
replace district = "DINDORI" if district == "DINDORI *" & state == "MADHYA PRADESH"
replace district = "KHANDWA (EAST NIMAR)" if district == "EAST NIMAR" & state == "MADHYA PRADESH"
replace district = "HARDA" if district == "HARDA *" & state == "MADHYA PRADESH"
replace district = "KATNI" if district == "KATNI *" & state == "MADHYA PRADESH"
replace district = "NEEMUCH" if district == "NEEMUCH *" & state == "MADHYA PRADESH"
replace district = "SHEOPUR" if district == "SHEOPUR *" & state == "MADHYA PRADESH"
replace district = "SIDHI" if district == "SINGRAULI" & state == "MADHYA PRADESH"
replace district = "UMERIA" if district == "UMARIA *" & state == "MADHYA PRADESH"
replace district = "KHARGOAN (WEST NIMAR)" if district == "WEST NIMAR" & state == "MADHYA PRADESH"

* Uttar Pradesh 

replace district = "AMBEDKAR NAGAR" if district == "AMBEDKAR NAGAR *" & state == "UTTAR PRADESH"
replace district = "AURAIYA" if district == "AURAIYA *" & state == "UTTAR PRADESH"
replace district = "BAGHPAT" if district == "BAGHPAT *" & state == "UTTAR PRADESH"
replace district = "BALRAMPUR" if district == "BALRAMPUR *" & state == "UTTAR PRADESH"
replace district = "CHANDAULI" if district == "CHANDAULI *" & state == "UTTAR PRADESH"
replace district = "CHITRAKOOT" if district == "CHITRAKOOT *" & state == "UTTAR PRADESH"
replace district = "G BUDDHA NAGAR" if district == "GAUTAM BUDDHA NAGAR *" & state == "UTTAR PRADESH"
replace district = "HATHRAS" if district == "HATHRAS *" & state == "UTTAR PRADESH"
replace district = "J PHULE NAGAR" if district == "JYOTIBA PHULE NAGAR *" & state == "UTTAR PRADESH"
replace district = "KANNAUJ" if district == "KANNAUJ *" & state == "UTTAR PRADESH"
replace district = "ALIGARH" if district == "KASHIRAMNAGAR" & state == "UTTAR PRADESH"
replace district = "KAUSHAMBI" if district == "KAUSHAMBI *" & state == "UTTAR PRADESH"
replace district = "KUSHI NAGAR" if district == "KUSHINAGAR *" & state == "UTTAR PRADESH"
replace district = "MAHOBA" if district == "MAHOBA *" & state == "UTTAR PRADESH"
replace district = "MAHARAJGANJ" if district == "MAHRAJGANJ" & state == "UTTAR PRADESH"
replace district = "RAI BARELI" if district == "RAE BARELI" & state == "UTTAR PRADESH"
replace district = "S KABIR NAGAR" if district == "SANT KABIR NAGAR *" & state == "UTTAR PRADESH"
replace district = "ST. RAVIDAS NAGAR" if district == "SANT RAVIDAS NAGAR BHADOHI *" & state == "UTTAR PRADESH"
replace district = "SHRAWASTI" if district == "SHRAWASTI *" & state == "UTTAR PRADESH"
replace district = "SIDDHARTHA NAGAR" if district == "SIDDHARTHNAGAR" & state == "UTTAR PRADESH"
replace district = "SIRTAPUR" if district == "SITAPUR" & state == "UTTAR PRADESH"
replace district = "SHONBHADRA" if district == "SONBHADRA" & state == "UTTAR PRADESH"

* Arunachal Pradesh
replace district = "LOHIT" if district == "ANJAW" & state == "ARUNACHAL PRADESH"
replace district = "TAWANG" if district == "KURUNGKUMEY" & state == "ARUNACHAL PRADESH"
replace district = "DIBANG VALLEY" if district == "LOWER DIBANG VALLEY" & state == "ARUNACHAL PRADESH"
replace district = "PAPUM PARE" if district == "PAPUM PARE *" & state == "ARUNACHAL PRADESH"
replace district = "UPPER SIANG" if district == "UPPER SIANG *" & state == "ARUNACHAL PRADESH"


* Orissa
replace district = "ANUGUL" if district == "ANUGUL *" & state == "ORISSA"
replace district = "BARGARH" if district == "BARGARH *" & state == "ORISSA"
replace district = "BAUDH" if district == "BAUDH *" & state == "ORISSA"
replace district = "BHADRAK" if district == "BHADRAK *" & state == "ORISSA"
replace district = "DEBAGARH" if district == "DEBAGARH *" & state == "ORISSA"
replace district = "GAJAPATI" if district == "GAJAPATI *" & state == "ORISSA"
replace district = "JAGATSINGHAPUR" if district == "JAGATSINGHAPUR *" & state == "ORISSA"
replace district = "JAJAPUR" if district == "JAJAPUR *" & state == "ORISSA"
replace district = "JHARSUGUDA" if district == "JHARSUGUDA *" & state == "ORISSA"
replace district = "KENDRAPARA" if district == "KENDRAPARA *" & state == "ORISSA"
replace district = "KHORDHA" if district == "KHORDHA *" & state == "ORISSA"
replace district = "MALKANGIRI" if district == "MALKANGIRI *" & state == "ORISSA"
replace district = "NABARANGAPUR" if district == "NABARANGAPUR *" & state == "ORISSA"
replace district = "NAYAGARH" if district == "NAYAGARH *" & state == "ORISSA"
replace district = "NUAPADA" if district == "NUAPADA *" & state == "ORISSA"
replace district = "RAYAGADA" if district == "RAYAGADA *" & state == "ORISSA"
replace district = "SONAPUR" if district == "SONAPUR *" & state == "ORISSA"

* Tamil Nadu

replace district = "ARIYALUR" if district == "ARIYALUR *" & state == "TAMIL NADU"
replace district = "KARUR" if district == "KARUR *" & state == "TAMIL NADU"
replace district = "DHARMAPURI" if district == "KRISHNAGIRI" & state == "TAMIL NADU"
replace district = "NAGAPATTINAM" if district == "NAGAPATTINAM *" & state == "TAMIL NADU"
replace district = "NAMAKKAL" if district == "NAMAKKAL  *" & state == "TAMIL NADU"
replace district = "PERAMBALUR" if district == "PERAMBALUR *" & state == "TAMIL NADU"
* replace district = "MADURAI" if district == "RAMANATHAPURAM" & state == "TAMIL NADU"
replace district = "THENI" if district == "THENI *" & state == "TAMIL NADU"
replace district = "TOOTHUKUDI" if district == "THOOTHUKKUDI" & state == "TAMIL NADU"
replace district = "COIMBATORE" if district == "TIRUPPUR" & state == "TAMIL NADU"
replace district = "TIRUVANAMALAI" if district == "TIRUVANNAMALAI" & state == "TAMIL NADU"

* Bihar

replace district = "JEHANABAD" if district == "ARWAL" & state == "BIHAR"
replace district = "BANKA" if district == "BANKA *" & state == "BIHAR"
replace district = "BUXAR" if district == "BUXAR *" & state == "BIHAR"
replace district = "JAMUI" if district == "JAMUI *" & state == "BIHAR"
replace district = "BHABUA KAIMUR" if district == "KAIMUR (BHABUA)*" & state == "BIHAR"
replace district = "LAKHISARAI" if district == "LAKHISARAI *" & state == "BIHAR"
replace district = "WEST CHAMPARAN" if district == "PASHCHIM CHAMPARAN" & state == "BIHAR"
replace district = "EAST CHAMPARAN" if district == "PURBA CHAMPARAN" & state == "BIHAR"
replace district = "SHEKHPURA" if district == "SHEIKHPURA *" & state == "BIHAR"
replace district = "SHEOHAR" if district == "SHEOHAR *" & state == "BIHAR"
replace district = "SUPAUL" if district == "SUPAUL *" & state == "BIHAR"

* Karnataka

replace district = "BAGALKOT" if district == "BAGALKOT *" & state == "KARNATAKA"
replace district = "CHAMARAJNAGAR" if district == "CHAMARAJANAGAR *" & state == "KARNATAKA"
replace district = "KOLAR" if district == "CHIKKABALLAPURA" & state == "KARNATAKA"
replace district = "DAKSHIN KANNADA" if district == "DAKSHINA KANNADA" & state == "KARNATAKA"
replace district = "GADAG" if district == "GADAG *" & state == "KARNATAKA"
replace district = "HAVERI" if district == "HAVERI *" & state == "KARNATAKA"
replace district = "BANGALORE RURAL" if district == "RAMANAGAR" & state == "KARNATAKA"
replace district = "UDUPI" if district == "UDUPI *" & state == "KARNATAKA"
replace district = "UTTAR KANNAD" if district == "UTTARA KANNADA" & state == "KARNATAKA"
replace district = "RAICHUR" if district == "YADGIR" & state == "KARNATAKA"



* Assam

replace district = "KAMRUP" if district == "BAKSA" & state == "ASSAM"
replace district = "BARPETA" if district == "BARPETA" & state == "ASSAM" 
replace district = "BONGAIGAON" if district == "CHIRAG" & state == "ASSAM" 
replace district = "KAMRUP" if district == "GUWAHATI" & state == "ASSAM" 
replace district = "DARRANG" if district == "UDALGURI" & state == "ASSAM" 

* Jammu and Kashmir
replace district = "BARAMULA" if district == "BANDIPORA" & state == "JAMMU & KASHMIR"
replace district = "SRINAGAR" if district == "GANDERBAL" & state == "JAMMU & KASHMIR"
replace district = "KARGIL*" if district == "KARGIL" & state == "JAMMU & KASHMIR"
replace district = "DODA" if district == "KISHTWAR" & state == "JAMMU & KASHMIR"
replace district = "ANANTNAG" if district == "KULGAM" & state == "JAMMU & KASHMIR"
replace district = "LEH* (LADAKH)" if district == "LEH (LADAKH)" & state == "JAMMU & KASHMIR"
replace district = "PUNCH" if district == "PUNCH" & state == "JAMMU & KASHMIR"
replace district = "PUNCH" if district == "RAJAURI" & state == "JAMMU & KASHMIR"
replace district = "DODA" if district == "RAMBAN" & state == "JAMMU & KASHMIR"
replace district = "UDHAMPUR" if district == "REASI" & state == "JAMMU & KASHMIR"
replace district = "KATHUA" if district == "SAMBA" & state == "JAMMU & KASHMIR"
replace district = "ANANTNAG" if district == "SHOPIAN" & state == "JAMMU & KASHMIR"

* Rajasthan

replace district = "BARAN" if district == "BARAN *" & state == "RAJASTHAN"
replace district = "DAUSA" if district == "DAUSA *" & state == "RAJASTHAN"
replace district = "HANUMANGARH" if district == "HANUMANGARH *" & state == "RAJASTHAN"
replace district = "KARAULI" if district == "KARAULI *" & state == "RAJASTHAN"
replace district = "CHITTAURGARH" if district == "PRATAPGARH" & state == "RAJASTHAN"
replace district = "RAJSAMAND" if district == "RAJSAMAND *" & state == "RAJASTHAN"

* Punjab

replace district = "SANGRUR" if district == "BARNALA" & state == "PUNJAB"
replace district = "FATEHGARH SAHIB" if district == "FATEHGARH SAHIB *" & state == "PUNJAB"
replace district = "MANSA" if district == "MANSA *" & state == "PUNJAB"
replace district = "MOGA" if district == "MOGA *" & state == "PUNJAB"
replace district = "MUKTSANG" if district == "MUKTSANG *" & state == "PUNJAB"
replace district = "MUKTSAR" if district == "MUKTSAR *" & state == "PUNJAB"
replace district = "NAWANSHAHR" if district == "NAWANSHAHR *" & state == "PUNJAB"
replace district = "PATIALA" if district == "S J A S NAGAR (MOHALI)" & state == "PUNJAB"
replace district = "AMRITSAR" if district == "TARN TARAN" & state == "PUNJAB"

* Chattisgarh

replace district = "BASTER" if district == "BASTAR" & state == "CHATTISGARH" 
replace district = "DANTEWADA" if district == "BIJAPUR" & state == "CHATTISGARH" 
replace district = "DANTEWADA" if district == "DANTEWADA*" & state == "CHATTISGARH"
replace district = "DHAMTARI" if district == "DHAMTARI *" & state == "CHATTISGARH" 
replace district = "JANJGIR-CHAMPA" if district == "JANJGIR - CHAMPA*" & state == "CHATTISGARH" 
replace district = "JASHPUR" if district == "JASHPUR *" & state == "CHATTISGARH" 
replace district = "KANKE" if district == "KANKER *" & state == "CHATTISGARH" 
replace district = "KAWARDHA" if district == "KAWARDHA *" & state == "CHATTISGARH" 
replace district = "KORBA" if district == "KORBA *" & state == "CHATTISGARH" 
replace district = "KORIYA" if district == "KORIYA *" & state == "CHATTISGARH" 
replace district = "MAHASAMUND" if district == "MAHASAMUND *" & state == "CHATTISGARH"
replace district = "BASTER" if district == "NARAYANPUR" & state == "CHATTISGARH"  


* Jharkhand
replace district = "BOKARO" if district == "BOKARO *" & state == "JHARKHAND"
replace district = "CHATRA" if district == "CHATRA *" & state == "JHARKHAND"
replace district = "DEOGARH" if district == "DEOGHAR" & state == "JHARKHAND"
replace district = "DUMKA" if district == "JAMTARA" & state == "JHARKHAND"
replace district = "RANCHI" if district == "KHUNTI" & state == "JHARKHAND"
replace district = "KODARMA" if district == "KODARMA *" & state == "JHARKHAND"
replace district = "PALAMAU" if district == "LATEHAR" & state == "JHARKHAND"
replace district = "PAKAUR" if district == "PAKAUR *" & state == "JHARKHAND"
replace district = "PALAMAU" if district == "PALAMU" & state == "JHARKHAND"
replace district = "WEST SINGHBHUM" if district == "PASHCHIMI SINGHBHUM" & state == "JHARKHAND"
replace district = "EAST SINGHBHUM" if district == "PURBI SINGHBHUM" & state == "JHARKHAND"
replace district = "HAZARIBAGH" if district == "RAMGARH" & state == "JHARKHAND"
replace district = "WEST SINGHBHUM" if district == "SERAIKELA-KHARSAWAN" & state == "JHARKHAND"
replace district = "GUMLA" if district == "SIMDEGA" & state == "JHARKHAND"

* Uttarakhand/Uttaranchal
replace district = "CHAMPAVAT" if district == "CHAMPAWAT" & state == "UTTARANCHAL"
replace district = "PITHORAGARH" if district == "PITHORAGARH" & state == "UTTARANCHAL"
replace district = "RUDRAPRAYAG" if district == "RUDRAPRAYAG *" & state == "UTTARANCHAL"
replace district = "UDHAMSINGH NAGAR" if district == "UDHAM SINGH NAGAR *" & state == "UTTARANCHAL"
replace district = "UTTAR KASHI" if district == "UTTARKASHI" & state == "UTTARANCHAL"

* West Bengal
replace district = "DAKSHIN DINAJPUR" if district == "DAKSHIN DINAJPUR *" & state == "WEST BENGAL"
replace district = "HOWRAH" if district == "HAORA" & state == "WEST BENGAL"
replace district = "NORTH 24 PARGANAS" if district == "NORTH TWENTY FOUR PARGANAS" & state == "WEST BENGAL"
replace district = "MEDINIPUR" if district == "PASHIM MIDNAPUR" & state == "WEST BENGAL"
replace district = "MEDINIPUR" if district == "PURBA MIDNAPUR" & state == "WEST BENGAL"
replace district = "SOUTH 24 PARGANAS" if district == "SOUTH TWENTY FOUR PARGANAS" & state == "WEST BENGAL"


* Tripura

replace district = "DHALAI" if district == "DHALAI *" & state == "TRIPURA"

* Nagaland

replace district = "DIMAPUR" if district == "DIMAPUR *" & state == "NAGALAND" 
replace district = "TUENSANG" if district == "KIPHIRE" & state == "NAGALAND" 
replace district = "TUENSANG" if district == "LONGLENG" & state == "NAGALAND" 
replace district = "MOKOKCHING" if district == "MOKOKCHUNG" & state == "NAGALAND"
replace district = "KOHIMA" if district == "PEREN" & state == "NAGALAND"

* Sikkim

replace district = "NIMACHAI EAST GANGTOK" if district == "EAST" & state == "SIKKIM"
replace district = "NORTH MONGAM" if district == "NORTH" & state == "SIKKIM"
replace district = "SOUTH GARO HILLS" if district == "SOUTH" & state == "SIKKIM"
replace district = "WEST GYALSHING" if district == "WEST" & state == "SIKKIM"

* Haryana

replace district = "FATEHABAD" if district == "FATEHABAD *" & state == "HARYANA"
replace district = "JHAJJAR" if district == "JHAJJAR *" & state == "HARYANA"
replace district = "GURGAON" if district == "MEWAT" & state == "HARYANA"
replace district = "GURGAON" if district == "PALWAL" & state == "HARYANA"
replace district = "PANCHKULA" if district == "PANCHKULA *" & state == "HARYANA"
replace district = "YAMUNA NAGAR" if district == "YAMUNANAGAR" & state == "HARYANA"

* Maharashtra

replace district = "GONDIYA" if district == "GONDIYA *" & state == "MAHARASHTRA"
replace district = "HINGOLI" if district == "HINGOLI *" & state == "MAHARASHTRA"
replace district = "NANDURBAR" if district == "NANDURBAR *" & state == "MAHARASHTRA"
replace district = "WASHIM" if district == "WASHIM *" & state == "MAHARASHTRA"

* Manipur

replace district = "IMPHAL EAST" if district == "IMPHAL EAST *" & state == "MANIPUR"
replace district = "SENAPATI" if district == "SENAPATI (EXCLUDING 3 SUB-DIVISIONS)" & state == "MANIPUR"

* Meghalaya

replace district = "RI BHOI" if district == "RI BHOI *" & state == "MEGHALAYA"
replace district = "SOUTH GARO HILLS" if district == "SOUTH GARO HILLS *" & state == "MEGHALAYA"

* Kerala

replace district = "SOUTHERN THRISSUR" if district == "THRISSUR" & state == "KERALA"


* Dropping the variables whose data is not there in the 2003 dataset

cap drop if district == "DODA" & state == "JAMMU & KASHMIR"
cap drop if district == "KARGIL*" & state == "JAMMU & KASHMIR"
cap drop if district == "LEH* (LADAKH)"
cap drop if district == "LOWER SUBANSIRI"
cap drop if district == "NICOBARS"
cap drop if district == "PITHORAGARH" 
cap drop if district == "PUNCH" & state == "JAMMU & KASHMIR"
* cap drop if district == "RAJAURI" & state == "JAMMU & KASHMIR"
cap drop if district == "RUDRAPRAYAG"
cap drop if district == "UPPER SIANG"

* Now, these are some of the districts present in 2003 but not in 2013

cap drop if district == "EAST" & state == "DELHI"

* Finally, merging the datasets

merge m:1 district state using "$output/temp/dist_2003.dta"

cap drop _merge

save "$output/district_concordance/dist_concord.dta", replace

cap keep state_code_* dist_code_*

save "$output/district_concordance/dist_concord_sd_code_change.dta", replace
