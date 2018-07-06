option mstored sasmstore = robin;
libname robin 'C:\Users\prl90\Desktop\St556';


/*Macro to perform a proc univariate for both method 1 and method 2. Where the mean, variance , no of obs and the std is outputted. */

%macro pMean(data);
    proc univariate data = work.&&data noprint;
    var y;
    output out = work.&&data.sum
            mean = &&data._mean
            std =  &&data._std
            var = &&data._var
            nobs = n
    ;
    run;
%mend pMean;

/*Method 1: Using the \quantile function" method of random number generation, generate a ran-*/
/*dom sample of size n = 10000 from the target distribution. Use the CALL STREAMINIT routine to*/
/*set a seed of 234. */

data work.m1;
    call streaminit(234);
    rngmethod=1;
    do i = 1 to 100000;
        do;
            zOne = rand('uniform');
                if ( zone > 0 & zone <=.5)then
                    y = 2* zone;
                else if(zone> 0.5 & zone <1) then
                    y = 1-log(2* (1-zone));
                else
                    y = 0;
                ;
            output;
        end;
    end;
run;

/*Use PROC UNIVARIATE to report the mean and variance of your sample.*/
%pMean(m1)



/*Method 2: This distribution is also called a \mixture" distribution of a uniform random variable*/
/*and a shifted exponential random variable. It can be sampled using code like the following:*/

data work.M2;
    call streaminit(123);
    rngmethod=2;
    do sim=1 to 100000;
        u=rand('unif');
        if u < .5 then 
                y=rand('unif'); *a new call to RAND();
            else 
                y=1+rand('exponential');
        output;
    end;
run;


/*Use this new method to generate a sample from the target distribution. Report the mean and*/
/*variance of your sample.*/
%pMean(m2)


/*Use the summary statistics you reported (mean and variance for samples 1 and 2) to conduct a*/
/*z-test for the hypothesis that both samples come from populations with the same mean.*/

data work.zValue;
    merge work.m1sum(rename =(n = n1));
    merge work.m2sum(rename =(n = n2));
    z = ((m1_mean - m2_mean) - 0)/sqrt((m1_std**2/n1)+ (m1_std**2/n1));
    pValue = 2 * (1- cdf("normal", z,0, 1));
    drop n:;
run;


/*Generate two histograms on the same graph and comment on the similarity of their shapes. Does*/
/*it look like both methods are doing the same thing?*/

/*merget wo datasets for univariate step*/
data work.merge;
    set m1 m2;
    keep rngmethod y;
run;

proc univariate data = work.merge;
    title "combines methods";
    class rngmethod;
    var y;
    histogram y/midpoints=0.1 to 15 by .2;
run;

/*TODO come back and coomment*/
title;

/*question 2*/

%let candidate1 = Matt Damon ;
%let candidate2 =" Bryan Cranston ";
%put the #1 candidate is ( drumroll ) ... &candidate1 ;
%put ;
%put the #2 candidate is ( drumroll ) ... &candidate2 ;


/*(a) What will the text in the log that this code produces look like, precisely? Please take care to*/
/*indicate extra spaces, if any.*/

/*LOG message*/
/*1    %let candidate1 = Matt Damon ;*/
/*2    %let candidate2 =" Bryan Cranston ";*/
/*3    %put the #1 candidate is ( drumroll ) ... &candidate1 ;*/
/*the #1 candidate is ( drumroll ) ... Matt Damon*/
/*4    %put ;*/
/**/
/*5    %put the #2 candidate is ( drumroll ) ... &candidate2 ;*/
/*the #2 candidate is ( drumroll ) ... " Bryan Cranston "*/


/*(b) In which column number does the text produced by the frst %PUT statement begin?*/
/*column 1*/

/*(c) In which column number does the text produced by the third %PUT statement begin?*/
/*column 1*/

/*(d) What does the second %PUT statement do?*/
/*This put statement includes all the empty space the value of candidate2.*/

/*(e) Give the name and type and length of the macro variable created by the rst %LET statement.*/
%put %sysfunc(length(&candidate1)); 
/*The let statement would create a user defined macro statement candidate1 which is a char and has length 10 characters.*/
/*10*/

/*(f) Give the name and type and length of the macro variable created by the second %LET statement.*/
%put %sysfunc(length(&candidate2));
/*The let statement would create a user defined macro statement candidate2 which is a char and has length 18 characters.*/
/*18*/

/*question 3*/
/*Provide a single macro statement that will resolve all user-dened macro variables and print their*/
/*values in the log.*/
%put _USER_;



/*4. Which SAS component will execute the statement you specied in problem 3?*/
/*(c) The macro processor.*/


/*5. When macro triggers send code to the macro processor, the macro processor does its work when?*/
/*(b) After compilation and before execution of SAS code*/


