

filename txt "C:\Users\u551791\Desktop\per\556\hoops.txt";
libname robin "C:\Users\u551791\Desktop\per\556\classFiles";
options nosymbolgen;


/*Question 1*/

/*(a) Modify the code so that, using a defined macro, you only have to type \proc glm" one time, yet*/
/*you are able to assemble the necessary output to carry out one-way ANOVA for all 4 * 4 = 16/
/*combinations of response and explanatory variables. You should be able to accomplish this with*/
/*only four calls to the defined macro you create. The desired report when selected rows of allanova*/
/*are printed might look like the following:*/

%macro proc_glm(v, prefix);
    proc glm data = pickles ;
        class &v ;
        model Nitrite Nitrate Ascorbic PolyP = &v ;
        ods output modelanova = myanova&prefix ;
    run ;
%mend proc_glm;

%macro append(list);
    %do i = 1 %to %sysfunc(countw(&list));
        %proc_glm(%scan(&list, &i), &i)
        %if(&i > 1) %then
            %do;
                proc append base= myanova1 data = myanova&i ;
                run;
            %end;
    %end;
%mend append;

%let exp = type name product producer;
%append(&exp)
quit;

proc sort data = myanova1  out= allanova ;
    by   source dependent;
run ;

proc print data = allanova ;
    where hypothesistype =1;
run ;

/*(b) What code is required to permanently store the macro and make it portable?*/
options mcompilenote= all mstored sasmstore= robin;


%macro proc_glm(v, prefix)/store source;
    proc glm data = pickles ;
        class &v ;
        model Nitrite Nitrate Ascorbic PolyP = &v ;
        ods output modelanova = myanova&prefix ;
    run ;
%mend proc_glm;


/*proc catalog cat= robin.sasmacr;*/
/*  contents;*/
/*run;*/

/*(c) Write a program which does not directly include the code from part (a), but retrieves it from*/
/*an appropriate macro library where it has been stored and executes the code to obtain the same*/
/*output as in part (a).*/


%macro append(list)/store source;
    %do i = 1 %to %sysfunc(countw(&exp));
        %proc_glm(%scan(&list, &i), &i)
        %if(&i > 1) %then
            %do;
                proc append base= myanova1 data = myanova&i ;
                run;
            %end;
    %end;
%mend append;

%let exp = type name product producer;
call %append(&exp)
quit;

proc sort data = myanova1  out= allanova ;
    by   source dependent;
run ;

proc print data = allanova ;
    where hypothesistype =1;
run ;



/*Question 2*/
/* Consider the finalists of the NCAA Basketball tournaments over the last several years.*/
/*(a) Write a SAS DATA step (arrays and nested loops recommended) to create a dataset called \hoops"*/
/*with variables called team (format $14), gender, finish and year using the following data (online*/
/*as \hoops.txt"):*/

data hoops;
    length  team $ 20 gender $ 14 finish $14;
    *manual entry of status;
    array _fi[2] $ ("RUNNERUP", "WINNER");
    *manual entry of gender;
    array _ge[2] $ ("WOMENS", "MENS");
        infile txt;
            input year $ @;
            If(_n_ > 2  ) then
                do i = 1 to 4;
                    input team $ @;
                    finish =_fi[mod(i, 2)+ 1];
                    gender = _ge[round(mod(i,1.3),1) + 1];
                    output;
                end;
    drop _ge: _fi: i;
run;



/*(b) Create sequences of macro variables and also macro variables called startyear and endyear so*/
/*that when the statement %put user ; is executed by the macro facility, the following values are*/
/*sent to the log*/

proc sort data= hoops;
    by  year;
run;


data _null_;
    set hoops end = eod;
    if (_N_ = 1) then
        call symputx("STARTYEAR", compress(year));
    else if(eod) then
        call symputx("ENDYEAR", compress(year));
    c = cat("", catx("_", gender,ifc(finish = upcase("winner"),"CHAMPION",finish)), year);
    call symputx(c, team);
run;


%put _user_;

/*(c) Write a %put statement so that the macro processor will send the following statement to the log.*/
/*It must be able to accommodate more data in the future.*/

%put years: &STARTYEAR - &ENDYEAR;

/*years: 2012 - 2018*/


/*(d) Write a defined macro called announce that uses an indirect macro variable reference to print*/
/*out the appropriate team. When called properly, the message in the look should look like the*/
/*following (note the outcome is upper case and the gender is \propcase"):*/

%macro announce(gender, position, year);
    %put;
    %put This macro would like to announce that the %upcase(&position) of the %sysfunc(propcase(&gender)) NCAA;
    %put     basketball tournament of the year =&year is ...;
    %put   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!;
    %put !!!!!! &&&gender._&position&year !!!!!!;
    %put !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!;
    %put;
%mend announce;



%announce (mens , runnerup ,2012)

/*This macro would like to announce that the RUNNERUP of the Mens NCAA*/
/*basketball tournament of the year =2012 is ...*/
/*!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!*/
/*!!!!!! Kansas !!!!!!*/
/*!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!*/


%announce ( womens , champion ,2016)

/*This macro would like to announce that the CHAMPION of the Womens NCAA*/
/*basketball tournament of the year =2016 is ...*/
/*!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!*/
/*!!!!!! UConn !!!!!!*/
/*!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!*/

