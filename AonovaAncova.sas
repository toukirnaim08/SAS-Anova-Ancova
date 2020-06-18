 
/*  proc glm data=mydata.daily; */
/* 	class season; */
/* 	model casual=season; */
/* 	means season/hovtest welch; */
/* 	run; */
/* 	 */
/* 	fa sp sm wn */
/* 	 */
/* 	e n s w */
/* 	hypothesis  s = e w n */
/* 	estimate 'South vs others' Region -1 -1 3 -1; */
/* 	hypothesis w = e n */
/* 	estimate 'West vs east & north' Region -1 -1 0 2; */
	

proc glm data=mydata.daily plots=diagnostics;
	class season;
	model casual=season / solution;
	means season/hovtest welch tukey;
	/*hypothesis  s = e w n*/
	estimate 'Summer vs others' season -1 -1 3 -1;
	estimate 'Winter vs fall & spring' season -1 -1 0 2;
	lsmeans season/pdiff adjust=tukey;
	run;
	
	
proc glm data=mydata.daily;
	class season workingday;
	model casual = season | workingday /solution;
	lsmeans season | workingday/ pdiff adjust=tukey;
	run;
	
proc npar1way data=mydata.daily wilcoxon dscf;
	var casual;
	class season;
	run;
	
/* summer winter*/
data summerWinter;
 set mydata.daily;
 if season='spring' then delete;
 if season='fall' then delete;
 run;
	
proc npar1way data=summerWinter wilcoxon dscf;
	var casual;
	class season;
	run;

/* summer spring*/
data summerSpring;
 set mydata.daily;
 if season='winter' then delete;
 if season='fall' then delete;
 run;
	
proc npar1way data=summerSpring wilcoxon dscf;
	var casual;
	class season;
	run;
	
/* summer autumn*/
data summerAutumn;
 set mydata.daily;
 if season='spring' then delete;
 if season='winter' then delete;
 run;
	
proc npar1way data=summerAutumn wilcoxon dscf;
	var casual;
	class season;
	run;
	
/*2nd*/
data daily1;
	set mydata.daily;
	where not(season='summer');
run;
	
proc corr data=daily1 plots=scatter;
	var count atemp;
	run;
	
proc glm data=daily1;
	class season;
	model atemp=season;
	run;
	
proc glm data=daily1;
	class season;
	model count=season atemp/ solution ss3;
	lsmeans season/ adjust=tukey;
	run;
	
	
proc glm data=daily1;
	class season;
	model count=season|atemp/ solution ss3;
	lsmeans season/ adjust=tukey;
	run;
	
/* 3rd */
	
proc glm data=mydata.daily;
	class season;
	model count=season atemp/ solution ss3;
	lsmeans season/ adjust=tukey;
	run;
	
	
proc glm data=mydata.daily;
	class season;
	model count=season|atemp/ solution ss3;
	lsmeans season/ adjust=tukey;
	run;
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	