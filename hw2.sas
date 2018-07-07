*
DONE BY :Robin Baldeo
COURSE: ST556
DATE WRITTEN: 6/28/2018
HOMEWORK #: 1
INPUT FILE: None
;

option mstored sasmstore = robin;
libname robin 'C:\Users\prl90\Desktop\St556';
%let path = C:\Users\prl90\Desktop\St556\;


/*question 1*/
%let nsim = 10000;
/*Macro to perform a proc univariate for both method 1 and method 2. Where the mean, variance , no of obs and the std is outputted. */

%macro pMean(data)/store source;
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
    do i = 1 to &nsim;
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
    do sim=1 to &nsim;
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
    pValue = 2 * (1- cdf("normal", abs(z),0, 1));
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

/*From the histogram both method appear to be producing the same thing. */


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
      /*This gives a blank row, seperating the first put from the thrid put.*/

/*(e) Give the name and type and length of the macro variable created by the 
      first  %LET statement.*/
      %put %sysfunc(length(&candidate1)); 
      /*The let statement would create a user defined macro statement candidate1 which is a char and has length 10 characters.*/


/*(f) Give the name and type and length of the macro variable created by the second %LET statement.*/
      %put %sysfunc(length(&candidate2));
      /*The let statement would create a user defined macro statement candidate2 which is a char and has length 18 characters.*/
      /*18*/

/*question 3*/
/*Provide a single macro statement that will resolve all user-defined macro variables and print their values in the log.*/
    %put _USER_;


/*question 4*/
/*4. Which SAS component will execute the statement you specified in problem 3?*/
    /*(c) The macro processor.*/

/*question 5*/
/*5. When macro triggers send code to the macro processor, the macro processor does its work when?*/
/*   (a)Before compilation and execution of SAS code*/

/*question 6*/
/*6. When a macro trigger directs code to the macro processor, the macro processor continues requesting tokens until what special token is encountered?*/
    /*unitl a ; is encountered*/

/*question 7*/
/*7. What global options can be used to specify whether or not a note will be written to the log each time the value of a macro variable is resolved? (There are two options.) What is the default setting?*/
    /*the global options are symbolgen  and nosymbolgen, the default is nosymbolgen */

/*question 8*/
/*8. True or False:*/
/*(a) A macro variable name must start with a letter.     True*/
/*(b) A macro variable cannot start with a number.        True*/
/*(c) ST556 is a valid name for macro variable.           True*/
     /*year is a valid name for macro variable.                True */
     /*_misc_ is a valid name for macro variable.              True*/
     /*4ever_young is a valid name for macro variable.         False*/
/*(d) SAS stores all macro variables as text, even if quotes are not used to specify the value.     True*/


/*9. A text file is named \records2010.dat". (It is available online if you want to test your code.) Suppose*/
/*you wish to use an infile statement to open this le and read in the data using a DATA step like the*/
/*following*/

/*(a) How must you specify the name of the text le so that it correctly references the macro variable*/
/*year?*/

%let year=2010;

data records&year;
    infile "&path.records&year..dat" firstobs=3 dsd;
    length team $15;
    input team $ w l t wpct pf pa; *w=wins l=losses;
run;


/*(b) Add a %LET statement before the following code so that it prints only those teams that won at*/
/*least 12 games:*/
%let wincut = 12;

proc print data = one ;
    title " teams winning at least & wincut games ";
    where w >= &wincut ;
    var team w l t wpct pf pa;
run ;

/*(c) Using all three of the following macro variable assignments, modify the WHERE statement and*/
/*TITLE statements above so that it produces a report of only those teams winning 4 or fewer*/
/*games, with an an appropriate title*/

%let wincut =4;
%let gverb = winning at most ;
%let direct = <= ;

proc print data = one ;
    title "teams &gverb. &wincut games ";
    where w &direct &wincut ;
    var team w l t wpct pf pa;
run ;


/*(d) At the end of the program, add a macro statement (%PUT) that references an automatic macro*/
/*variable and sends the two-level name of the most recently created SAS data set to the log.*/
%put most recently created data set : &syslast;

/*(e) Use the %scan macro function (twice) to partition this two-level name into its two components*/
/*and write each to a separate line in the log,*/
/*The log from parts (d) and (e) should look something like the following:*/
%put the first component of this two - level name is %scan(&syslast,1);
%put the second component of this two - level name is %scan(&syslast,2);
