
*
DONE BY :Robin Baldeo
COURSE: ST556
DATE WRITTEN: 7/14/2018
HOMEWORK #: 3
INPUT FILE: records2010.dat
;


/*%let path= C:\Users\u551791\Desktop\per\556\classFiles\;*/
/*%include "&path.setup.sas";*/

/*libname robin "C:\Users\u551791\Desktop\per\556";*/
/*option mstored sasmstore=robin;*/




/*(a) There are three values of the variable Customer Group. Use PROC FREQ or any other technique*/
/*to determine which group is the least abundant (has the smallest count) in the dataset?*/

proc freq data = orion.customer_dim;
    tables Customer_Group/nocum;
run;

/*Internet/Catalog Customers with a count of 8*/

/*                     Internet/Catalog Customers     14:31 Friday, July 13, 2018   5*/
/**/
/*                                        The FREQ Procedure*/
/**/
/*                                       Customer Group Name*/
/**/
/*                       Customer_Group                Frequency     Percent*/
/*                       ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ*/
/*                       Internet/Catalog Customers           8       10.39*/
/*                       Orion Club Gold members             21       27.27*/
/*                       Orion Club members                  48       62.34*/


/*(b) Modify the PROC PRINT code to print names, genders and ages only of customers in the*/
/*group that you identifed in part (a). Do not use macro variables to do this.*/

proc print data=orion.customer_dim;
    var Customer_Name Customer_Gender Customer_Age;
    where Customer_Group contains 'Internet/Catalog';
    title 'Internet/Catalog Customers';
run;

/*                  Internet/Catalog Customers     14:31 Friday, July 13, 2018   4*/
/**/
/*                                                   Customer_    Customer_*/
/*                        Obs    Customer_Name        Gender         Age*/
/**/
/*                          8    Ulrich Heyde            M            68*/
/*                         13    Tulio Devereaux         M            58*/
/*                         14    Robyn Klem              F            48*/
/*                         15    Cynthia Mccluney        F            38*/
/*                         16    Candy Kinsey            F            73*/
/*                         20    Phenix Hill             M            43*/
/*                         59    Avinoam Zweig           M            48*/
/*                         67    Lauren Marx             F            38*/




/*(c) Precede the PROC PRINT you used for part(b) with the following statement*/
/*%let group=Internet;*/
/*and modify the code so that it prints only those observations in which the customer group variable*/
/*contains the value of the newly created macro variable, \group".*/

%let group=Internet;

proc print data=orion.customer_dim;
    var Customer_Name Customer_Gender Customer_Age;
    where Customer_Group contains "&group";
    title 'Internet/Catalog Customers';
run;


/*                        Internet/Catalog Customers     14:31 Friday, July 13, 2018   6*/
/**/
/*                                                   Customer_    Customer_*/
/*                        Obs    Customer_Name        Gender         Age*/
/**/
/*                          8    Ulrich Heyde            M            68*/
/*                         13    Tulio Devereaux         M            58*/
/*                         14    Robyn Klem              F            48*/
/*                         15    Cynthia Mccluney        F            38*/
/*                         16    Candy Kinsey            F            73*/
/*                         20    Phenix Hill             M            43*/
/*                         59    Avinoam Zweig           M            48*/
/*                         67    Lauren Marx             F            38*/






/*(d) Is the value of the macro variable \group" case-sensitive? Try to rerun the program you wrote*/
/*for part (d) using*/
/*%let group=internet;*/
/*Does it print the desired group?*/

%let group=internet;

proc print data=orion.customer_dim;
    var Customer_Name Customer_Gender Customer_Age;
    where Customer_Group contains "&group";
    title 'Internet/Catalog Customers';
run;


/*6414  %let group=internet;*/
/*6415*/
/*6416  proc print data=orion.customer_dim;*/
/*6417      var Customer_Name Customer_Gender Customer_Age;*/
/*6418      where Customer_Group contains "&group";*/
/*6419      title 'Internet/Catalog Customers';*/
/*6420  run;*/
/**/
/*NOTE: No observations were selected from data set ORION.CUSTOMER_DIM.*/
/*NOTE: There were 0 observations read from the data set ORION.CUSTOMER_DIM.*/
/*      WHERE Customer_Group contains 'internet';*/
/*NOTE: PROCEDURE PRINT used (Total process time):*/
/*      real time           0.78 seconds*/
/*      cpu time            0.04 seconds*/



/*(e) Modify the report in part (b) so that, within the displayed title, every letter of the least abundant*/
/*group is capitalized,*/

/*i. using the %upcase function.*/
proc print data=orion.customer_dim;
    var Customer_Name Customer_Gender Customer_Age;
    where Customer_Group contains 'Internet/Catalog';
    title %upcase('Internet/Catalog Customers');
run;

title;


/*                 INTERNET/CATALOG CUSTOMERS     14:31 Friday, July 13, 2018   7*/
/**/
/*                                                   Customer_    Customer_*/
/*                        Obs    Customer_Name        Gender         Age*/
/**/
/*                          8    Ulrich Heyde            M            68*/
/*                         13    Tulio Devereaux         M            58*/
/*                         14    Robyn Klem              F            48*/
/*                         15    Cynthia Mccluney        F            38*/
/*                         16    Candy Kinsey            F            73*/
/*                         20    Phenix Hill             M            43*/
/*                         59    Avinoam Zweig           M            48*/
/*                         67    Lauren Marx             F            38*/


/*ii. using the upcase function but not the %upcase macro function.*/
proc print data=orion.customer_dim;
    var Customer_Name Customer_Gender Customer_Age;
    where Customer_Group contains 'Internet/Catalog';
    title %sysfunc(upcase(Internet/Catalog Customers));
run;

title;


/*                 INTERNET/CATALOG CUSTOMERS     14:31 Friday, July 13, 2018   8*/
/**/
/*                                                   Customer_    Customer_*/
/*                        Obs    Customer_Name        Gender         Age*/
/**/
/*                          8    Ulrich Heyde            M            68*/
/*                         13    Tulio Devereaux         M            58*/
/*                         14    Robyn Klem              F            48*/
/*                         15    Cynthia Mccluney        F            38*/
/*                         16    Candy Kinsey            F            73*/
/*                         20    Phenix Hill             M            43*/
/*                         59    Avinoam Zweig           M            48*/
/*                         67    Lauren Marx             F            38*/


/*(f) Consider the frequencies of men and women in the three customer groups.*/

/*i. Use PROC FREQ to generate a frequency table with frequencies of all 32 = 6 combinations*/
/*of customer group (rows) and customer gender (columns):*/

proc freq data=orion.customer_dim ;
    tables customer_group* customer_gender;
run;


/*                  INTERNET/CATALOG CUSTOMERS     14:31 Friday, July 13, 2018   9*/
/**/
/*                                        The FREQ Procedure*/
/**/
/*                            Table of Customer_Group by Customer_Gender*/
/**/
/*                           Customer_Group(Customer Group Name)*/
/*                                             Customer_Gender(Customer Gender)*/
/**/
/*                           Frequency        ‚*/
/*                           Percent          ‚*/
/*                           Row Pct          ‚*/
/*                           Col Pct          ‚F       ‚M       ‚  Total*/
/*                           ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒˆƒƒƒƒƒƒƒƒˆƒƒƒƒƒƒƒƒˆ*/
/*                           Internet/Catalog ‚      4 ‚      4 ‚      8*/
/*                            Customers       ‚   5.19 ‚   5.19 ‚  10.39*/
/*                                            ‚  50.00 ‚  50.00 ‚*/
/*                                            ‚  13.33 ‚   8.51 ‚*/
/*                           ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒˆƒƒƒƒƒƒƒƒˆƒƒƒƒƒƒƒƒˆ*/
/*                           Orion Club Gold  ‚     11 ‚     10 ‚     21*/
/*                           members          ‚  14.29 ‚  12.99 ‚  27.27*/
/*                                            ‚  52.38 ‚  47.62 ‚*/
/*                                            ‚  36.67 ‚  21.28 ‚*/
/*                           ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒˆƒƒƒƒƒƒƒƒˆƒƒƒƒƒƒƒƒˆ*/
/*                           Orion Club membe ‚     15 ‚     33 ‚     48*/
/*                           rs               ‚  19.48 ‚  42.86 ‚  62.34*/
/*                                            ‚  31.25 ‚  68.75 ‚*/
/*                                            ‚  50.00 ‚  70.21 ‚*/
/*                           ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒˆƒƒƒƒƒƒƒƒˆƒƒƒƒƒƒƒƒˆ*/
/*                           Total                  30       47       77*/
/*                                               38.96    61.04   100.00*/









/*ii. Modify the TABLES statement to suppress those dang column, row and total percentages:*/
/*tables customer_group* customer_gender/nocolumn norow nopercent;*/

proc freq data=orion.customer_dim ;
    tables customer_group* customer_gender /norow nocol nopercent;
run;


/*                 INTERNET/CATALOG CUSTOMERS     14:31 Friday, July 13, 2018  10*/
/**/
/*                                        The FREQ Procedure*/
/**/
/*                            Table of Customer_Group by Customer_Gender*/
/**/
/*                           Customer_Group(Customer Group Name)*/
/*                                             Customer_Gender(Customer Gender)*/
/**/
/*                           Frequency        ‚F       ‚M       ‚  Total*/
/*                           ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒˆƒƒƒƒƒƒƒƒˆƒƒƒƒƒƒƒƒˆ*/
/*                           Internet/Catalog ‚      4 ‚      4 ‚      8*/
/*                            Customers       ‚        ‚        ‚*/
/*                           ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒˆƒƒƒƒƒƒƒƒˆƒƒƒƒƒƒƒƒˆ*/
/*                           Orion Club Gold  ‚     11 ‚     10 ‚     21*/
/*                           members          ‚        ‚        ‚*/
/*                           ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒˆƒƒƒƒƒƒƒƒˆƒƒƒƒƒƒƒƒˆ*/
/*                           Orion Club membe ‚     15 ‚     33 ‚     48*/
/*                           rs               ‚        ‚        ‚*/
/*                           ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒˆƒƒƒƒƒƒƒƒˆƒƒƒƒƒƒƒƒˆ*/
/*                           Total                  30       47       77*/


/*iii. Considering the considerable frequency with which you may want to suppress these percent-*/
/*ages, use a %let assignment that creates a macro variable called nocrp whose text can be*/
/*used instead having to type nocolumn norow nopercent every time. Rerun the code using*/
/*the macro variable in the TABLES statement.*/

%let nocrp = norow nocol nopercent;

proc freq data=orion.customer_dim;
%put &nocrp;
    tables customer_group* customer_gender/&nocrp;
run;

/*                  INTERNET/CATALOG CUSTOMERS     14:31 Friday, July 13, 2018  11*/
/**/
/*                                        The FREQ Procedure*/
/**/
/*                            Table of Customer_Group by Customer_Gender*/
/**/
/*                           Customer_Group(Customer Group Name)*/
/*                                             Customer_Gender(Customer Gender)*/
/**/
/*                           Frequency        ‚F       ‚M       ‚  Total*/
/*                           ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒˆƒƒƒƒƒƒƒƒˆƒƒƒƒƒƒƒƒˆ*/
/*                           Internet/Catalog ‚      4 ‚      4 ‚      8*/
/*                            Customers       ‚        ‚        ‚*/
/*                           ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒˆƒƒƒƒƒƒƒƒˆƒƒƒƒƒƒƒƒˆ*/
/*                           Orion Club Gold  ‚     11 ‚     10 ‚     21*/
/*                           members          ‚        ‚        ‚*/
/*                           ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒˆƒƒƒƒƒƒƒƒˆƒƒƒƒƒƒƒƒˆ*/
/*                           Orion Club membe ‚     15 ‚     33 ‚     48*/
/*                           rs               ‚        ‚        ‚*/
/*                           ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒˆƒƒƒƒƒƒƒƒˆƒƒƒƒƒƒƒƒˆ*/
/*                           Total                  30       47       77*/









/*iv. Classify every single token in the code below according to its type, writing them in the order*/
/*in which they appear, as we did on slide 10/20 from Module 6:*/

/*name token = proc, freq , data, orion, customer_dim, tables ,customer_group, customer_gender,nocrp, run*/
/*special tokens = =,.,;,*, /,&;,;*/

/*v. What macro statement can be used to send the value of the nocrp macro variable to the log?*/
/*Can it be used in open code, or must it be within a DATA step or a procedure (PROC)?*/

%put &nocrp;
/*it can be used in open code, datasteps and proc*/

/*(g) What macro statement can you use to delete the macro variable group after the report has been*/
/*generated?*/
%symdel group;

/*6450  %symdel group;*/


/*Question 2*/
/*(a) Use the PROC FREQ step below to identify the most abundant level or value of the variable*/
/*customer group.*/

ods trace on;
proc freq data = orion.customer_dim ;
    tables customer_group ;
run ;

/*most abbundent is : Orion Club members*/

/*(b) Inspect the log generated upon submission of the code. What is the name of the temporary data*/
/*set that contains the One-Way Frequencies of the customer group variable?*/

/*OneWayFreqs*/

/*(c) Add the following statement to the PROC FREQ step above to generate a data set, named*/
/*owf, with the frequencies of the three customer groups. Use PROC SORT so that the first*/
/*observation in owf corresponds to the most abundant group. Then use a DATA step (in which*/
/*no new data set is created) and the SYMPUTX routine to create a macro variable called most*/
/*and assign its (data-dependent) value as the name of the most frequent customer group.*/

ods output onewayfreqs =owf ;
proc freq data = orion.customer_dim ;
    tables customer_group ;
run ;

proc sort data = work.owf;
    by descending frequency ;
run;

/*datastep that set the variable most*/
data _null_;
    set work.owf;
    if(_N_ = 1) then
        call symputx("most", customer_group);
    else 
        stop;
run;
%put &most;


/*(d) Using the macro variable you created, use the code below to produce a report of observations*/
/*from orion.customer dim who come from the most frequent group. It is ok to use (obs=5) to*/
/*limit the report to the first five observations from that group.*/

proc print data = orion.customer_dim (firstobs= 1 obs = 5);
    where customer_group ="&most";
    title "the most abundant group is &most";
    var customer_name customer_gender customer_age customer_group ;
run ;

/*              the most abundant group is Orion Club members                         17*/
/*                                                                       14:31 Friday, July 13, 2018*/
/**/
/*                                        Customer_    Customer_*/
/*              Obs     Customer_Name      Gender         Age         Customer_Group*/
/**/
/*                1    James Kvarniq          M            33       Orion Club members*/
/*                4    Karen Ballinger        F            23       Orion Club members*/
/*                5    Elke Wallstab          F            33       Orion Club members*/
/*                6    David Black            M            38       Orion Club members*/
/*                9    Jimmie Evans           M            53       Orion Club members*/


/*(e) Consider the abbreviated report, but with a title which indicates which group is most abundant,*/
/*in ALL CAPS. Give this title statement. (It is ok to use the %upcase macro function.)*/

proc print data = orion.customer_dim (firstobs= 1 obs = 5);
    where customer_group ="&most";
    title "the most abundant group is %upcase(&most) !!!";
    var customer_name customer_gender customer_age customer_group ;
run ;

/*                        the most abundant group is ORION CLUB MEMBERS !!!                       19*/
/*                                                                       14:31 Friday, July 13, 2018*/
/**/
/*                                        Customer_    Customer_*/
/*              Obs     Customer_Name      Gender         Age         Customer_Group*/
/**/
/*                1    James Kvarniq          M            33       Orion Club members*/
/*                4    Karen Ballinger        F            23       Orion Club members*/
/*                5    Elke Wallstab          F            33       Orion Club members*/
/*                6    David Black            M            38       Orion Club members*/
/*                9    Jimmie Evans           M            53       Orion Club members*/



/*(g) (Challenging.) Write a SAS program, using a defined macro call frequent, in which the user*/
/*supplies one parameter, which takes one of two values: "most" or "least" and produces a listing*/
/*of the corresponding list of customers, with an appropriate title. There may be a need for indirect*/
/*reference to macro variables, including use of the triple amper sand.*/

options mlogic mprint;

%macro frequent (value);

    /*macro to perform the work based on the input from the user*/
    %macro sort(order, value) ;
        
        /*using the owf dataset created in step 2c, to sort based on the order*/
        /*decreaseing put the most at the top*/
        /*ascending put the least at the top*/
        proc sort data = work.owf out =work._owf;
            by &order frequency ;
        run;

        /*create variable g_ with the value from the first row*/
        data _null_;
            set work._owf;
            if(_N_ = 1) then
                call symputx("g_", customer_group);
            else
                stop;
        run;

        /*proc print the based on the value fo g_ and the value */
        proc print data = orion.customer_dim;
            where customer_group = "&g_";
            title "the &value abundant group is &g_";
            var customer_name customer_gender customer_age customer_group ;
        run ;

    %mend sort;
    
    /*user input is received and the result is displayed based on the value supplied int he */
    %if(&value = most) %then
        %sort(descending, most);
    %else
        %sort(, least);


%mend frequent;


%frequent(least)

/*                      the least abundant group is Internet/Catalog Customers                    21*/
/*                                                                       14:31 Friday, July 13, 2018*/
/**/
/*                                    Customer_    Customer_*/
/*         Obs    Customer_Name        Gender         Age             Customer_Group*/
/**/
/*           8    Ulrich Heyde            M            68       Internet/Catalog Customers*/
/*          13    Tulio Devereaux         M            58       Internet/Catalog Customers*/
/*          14    Robyn Klem              F            48       Internet/Catalog Customers*/
/*          15    Cynthia Mccluney        F            38       Internet/Catalog Customers*/
/*          16    Candy Kinsey            F            73       Internet/Catalog Customers*/
/*          20    Phenix Hill             M            43       Internet/Catalog Customers*/
/*          59    Avinoam Zweig           M            48       Internet/Catalog Customers*/
/*          67    Lauren Marx             F            38       Internet/Catalog Customers*/

%frequent(most)
/*below I have shown only the first 27 rows*/
/**/
/*                         the most abundant group is Orion Club members                         22*/
/*                                                                       14:31 Friday, July 13, 2018*/
/**/
/*                                          Customer_    Customer_*/
/*           Obs    Customer_Name            Gender         Age         Customer_Group*/
/**/
/*             1    James Kvarniq               M            33       Orion Club members*/
/*             4    Karen Ballinger             F            23       Orion Club members*/
/*             5    Elke Wallstab               F            33       Orion Club members*/
/*             6    David Black                 M            38       Orion Club members*/
/*             9    Jimmie Evans                M            53       Orion Club members*/
/*            10    Tonie Asmussen              M            53       Orion Club members*/
/*            12    Michael Dineley             M            48       Orion Club members*/
/*            18    Rolf Robak                  M            68       Orion Club members*/
/*            19    Alvan Goheen                M            23       Orion Club members*/
/*            22    Wendell Summersby           M            43       Orion Club members*/
/*            23    Thomas Leitmann             M            28       Orion Club members*/
/*            27    Yan Kozlowski               M            38       Orion Club members*/

title;

/*3. The firrst argument(s) of the sysfunc macro function is/are the function(s) you'd like to execute.*/
/*sysfunc also allows for an optional last argument which may be used to apply a format to the result*/
/*of the executed function . . .*/

%let date = %sysfunc(mdy(12,17,1984),weekdate);
%put &date;

/*Monday, December 17, 1984*/


/*4*/
/*Add a macro statement that will extract the numeric part of the dataset names (\5" and \9") and*/
/*send the sum of these numbers to the log. (The answer should be 14.)*/

%let dsn1 = shoes5 ;
%let dsn2 = shoes9 ;


%let sum = %eval(%substr(&dsn1, 6) + %substr(&dsn2, 6) );
%put the sum is &sum;

/**/
/*6678  %let dsn1 = shoes5 ;*/
/*6679  %let dsn2 = shoes9 ;*/
/*6680*/
/*6681*/
/*6682  %let sum = %eval(%substr(&dsn1, 6) + %substr(&dsn2, 6) );*/
/*6683  %put the sum is &sum;*/
/*the sum is 14*/


/*5. Consider the orion.customer dataset.*/
/*(a) Write a program that produces a frequency table giving the number of customers by country, with*/
/*two separate summaries: one for countries in the Southern Hemisphere (\Australia" and \South*/
/*Africa"), one for those is in the Northern Hemisphere. The output should like the table below*/

/*creating a dataset with the various hemisphere taged as s = south hemi and n = nothern hemi*/
data customerConti;
    set orion.customer_dim;
    if customer_country in("AU", "ZA") then
        cont = "S";
    else
        cont = "N";
    ;
    Label
        cont = Customer Country
    ;
run;

/*macro freq creates the freq table with north and south hemisphere*/
%macro freq(order);
/*  sort dataset created, based on user supplied parameter*/
    proc sort data = customerConti;
        by &order cont;
    run;

    %if (&order = descending)%then
        %do;
            title "Southern Hemisphere";
        %end;
    %else
        %do;
            title "Northern Hemisphere";
        %end;

    proc freq data = customerConti ;
        by &order cont;
        table customer_country;
    run;
%mend freq;

%freq(descending);

/**/
/**/
/*                                     Southern Hemisphere         14:31 Friday, July 13, 2018  23*/
/**/
/*--------------------------------------- Customer Country=S ---------------------------------------*/
/**/
/*                                        The FREQ Procedure*/
/**/
/*                                         Customer Country*/
/**/
/*                  Customer_                             Cumulative    Cumulative*/
/*                  Country      Frequency     Percent     Frequency      Percent*/
/*                  ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ*/
/*                  AU                  8       66.67             8        66.67*/
/*                  ZA                  4       33.33            12       100.00*/
/**/
/**/
/*--------------------------------------- Customer Country=N ---------------------------------------*/
/**/
/*                                        The FREQ Procedure*/
/**/
/*                                         Customer Country*/
/**/
/*                  Customer_                             Cumulative    Cumulative*/
/*                  Country      Frequency     Percent     Frequency      Percent*/
/*                  ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ*/
/*                  CA                 15       23.08            15        23.08*/
/*                  DE                 10       15.38            25        38.46*/
/*                  IL                  5        7.69            30        46.15*/
/*                  TR                  7       10.77            37        56.92*/
/*                  US                 28       43.08            65       100.00*/



/*(b) Write a macro, called hemifreq that will take as an argument the hemisphere of interest and*/
/*return a table like that given above. The macro must utilize the IN operator. It should also allow*/
/*the southern hemisphere to be a user-supplied argument that can be \s, south or \southern"*/
/*and can be upper or lower case or some combination. Similarly for the other hemisphere. If some*/
/*other value is supplied, the macro should send an appropriate ERROR message to the log. No*/
/*matter which version of \southern" is supplied, the title printed should appear as above, and*/
/*similarly for \northern." This code is to help get you started;*/


/*this code uses the prveious macro freq from part b*/
%macro hemifreq(hemi)/minoperator ;
    %let hemi=%upcase(&hemi);
    %if &hemi in (S SOUTH SOUTHERN) %then 
        %do; 
            %freq(descending);
        %end;
    %else %if &hemi in (N NORTH NORTHERN) %then 
        %do;  
            %freq();
        %end;
    %else 
        %do; 
            %put ERROR: input must be s, south, southern, n, north or nothern;
        %end;
%mend hemifreq;


/*(c) As you code, use the MCOMPILENOTE=ALL to ensure that the macro compiles. Once it*/
/*compiles, include here the note to that eect that appears here in the SAS Log.*/


options mcompilenote= all;
options mlogic;
/*(d) Call the macro three times, using the arguments SOUTHERN, n and western. Copy the SAS*/
/*Listing here.*/

/*SOUTHERN*/
%hemifreq(SOUTHERN)

/**/
/*                                      Southern Hemisphere         12:13 Friday, July 13, 2018   3*/
/**/
/*--------------------------------------- Customer Country=S ---------------------------------------*/
/**/
/*                                        The FREQ Procedure*/
/**/
/*                                         Customer Country*/
/**/
/*                  Customer_                             Cumulative    Cumulative*/
/*                  Country      Frequency     Percent     Frequency      Percent*/
/*                  ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ*/
/*                  AU                  8       66.67             8        66.67*/
/*                  ZA                  4       33.33            12       100.00*/
/**/
/*--------------------------------------- Customer Country=N ---------------------------------------*/
/**/
/*                                        The FREQ Procedure*/
/**/
/*                                         Customer Country*/
/**/
/*                  Customer_                             Cumulative    Cumulative*/
/*                  Country      Frequency     Percent     Frequency      Percent*/
/*                  ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ*/
/*                  CA                 15       23.08            15        23.08*/
/*                  DE                 10       15.38            25        38.46*/
/*                  IL                  5        7.69            30        46.15*/
/*                  TR                  7       10.77            37        56.92*/
/*                  US                 28       43.08            65       100.00*/




/*n*/
%hemifreq(n)

/**/
/*                                       Northern Hemisphere         12:13 Friday, July 13, 2018   5*/
/**/
/*--------------------------------------- Customer Country=N ---------------------------------------*/
/**/
/*                                        The FREQ Procedure*/
/**/
/*                                         Customer Country*/
/**/
/*                  Customer_                             Cumulative    Cumulative*/
/*                  Country      Frequency     Percent     Frequency      Percent*/
/*                  ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ*/
/*                  CA                 15       23.08            15        23.08*/
/*                  DE                 10       15.38            25        38.46*/
/*                  IL                  5        7.69            30        46.15*/
/*                  TR                  7       10.77            37        56.92*/
/*                  US                 28       43.08            65       100.00*/
/**/
/*--------------------------------------- Customer Country=S ---------------------------------------*/
/**/
/*                                        The FREQ Procedure*/
/**/
/*                                         Customer Country*/
/**/
/*                  Customer_                             Cumulative    Cumulative*/
/*                  Country      Frequency     Percent     Frequency      Percent*/
/*                  ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ*/
/*                  AU                  8       66.67             8        66.67*/
/*                  ZA                  4       33.33            12       100.00*/




/*western*/
%hemifreq(western)

/*(e) As you code, consider using the MLOGIC option. The MLOGIC should send messages for the*/
/*result of every %IF %THEN condition to the SAS Log. After your program runs, copy them here.*/

%hemifreq(SOUTHERN)
/*6579  %hemifreq(SOUTHERN)*/
/*MLOGIC(HEMIFREQ):  Beginning execution.*/
/*MLOGIC(HEMIFREQ):  Parameter HEMI has value SOUTHERN*/
/*MLOGIC(HEMIFREQ):  %LET (variable name is HEMI)*/
/*MLOGIC(HEMIFREQ):  %IF condition &hemi in (S SOUTH SOUTHERN) is TRUE*/
/*MLOGIC(FREQ):  Beginning execution.*/
/*MLOGIC(FREQ):  Parameter ORDER has value descending*/
/**/
/*NOTE: Input data set is already sorted, no sorting done.*/
/*NOTE: PROCEDURE SORT used (Total process time):*/
/*      real time           0.01 seconds*/
/*      cpu time            0.00 seconds*/
/**/
/**/
/*MLOGIC(FREQ):  %IF condition (&order = descending) is TRUE*/
/**/
/*NOTE: There were 77 observations read from the data set WORK.CUSTOMERCONTI.*/
/*NOTE: PROCEDURE FREQ used (Total process time):*/
/*      real time           1.76 seconds*/
/*      cpu time            0.04 seconds*/
/**/
/**/
/*MLOGIC(FREQ):  Ending execution.*/
/*MLOGIC(HEMIFREQ):  Ending execution.*/


%hemifreq(n)
/*6580  %hemifreq(n)*/
/*MLOGIC(HEMIFREQ):  Beginning execution.*/
/*MLOGIC(HEMIFREQ):  Parameter HEMI has value n*/
/*MLOGIC(HEMIFREQ):  %LET (variable name is HEMI)*/
/*MLOGIC(HEMIFREQ):  %IF condition &hemi in (S SOUTH SOUTHERN) is FALSE*/
/*MLOGIC(HEMIFREQ):  %IF condition &hemi in (N NORTH NORTHERN) is TRUE*/
/*MLOGIC(FREQ):  Beginning execution.*/
/*MLOGIC(FREQ):  Parameter ORDER has value*/
/**/
/*NOTE: There were 77 observations read from the data set WORK.CUSTOMERCONTI.*/
/*NOTE: The data set WORK.CUSTOMERCONTI has 77 observations and 12 variables.*/
/*NOTE: PROCEDURE SORT used (Total process time):*/
/*      real time           0.03 seconds*/
/*      cpu time            0.01 seconds*/
/**/
/**/
/*MLOGIC(FREQ):  %IF condition (&order = descending) is FALSE*/
/**/
/*NOTE: There were 77 observations read from the data set WORK.CUSTOMERCONTI.*/
/*NOTE: PROCEDURE FREQ used (Total process time):*/
/*      real time           1.84 seconds*/
/*      cpu time            0.04 seconds*/
/**/
/**/
/*MLOGIC(FREQ):  Ending execution.*/
/*MLOGIC(HEMIFREQ):  Ending execution.*/

%hemifreq(western)
/*6581  %hemifreq(western)*/
/*MLOGIC(HEMIFREQ):  Beginning execution.*/
/*MLOGIC(HEMIFREQ):  Parameter HEMI has value western*/
/*MLOGIC(HEMIFREQ):  %LET (variable name is HEMI)*/
/*MLOGIC(HEMIFREQ):  %IF condition &hemi in (S SOUTH SOUTHERN) is FALSE*/
/*MLOGIC(HEMIFREQ):  %IF condition &hemi in (N NORTH NORTHERN) is FALSE*/
/*MLOGIC(HEMIFREQ):  %PUT ERROR: input must be s, south, southern, n, north or nothern*/
/*ERROR: input must be s, south, southern, n, north or nothern*/
/*MLOGIC(HEMIFREQ):  Ending execution*/

/*(f) What is the name of the option you can use to get the SAS code produced by your hemifreq*/
/*macro to be written to the SAS Log? Use it, and include the relevant messages here.*/
/* the name of the option is mprint*/
option mprint;


%hemifreq(SOUTHERN)
/*6583  %hemifreq(SOUTHERN)*/
/*MLOGIC(HEMIFREQ):  Beginning execution.*/
/*MLOGIC(HEMIFREQ):  Parameter HEMI has value SOUTHERN*/
/*MLOGIC(HEMIFREQ):  %LET (variable name is HEMI)*/
/*MLOGIC(HEMIFREQ):  %IF condition &hemi in (S SOUTH SOUTHERN) is TRUE*/
/*MLOGIC(FREQ):  Beginning execution.*/
/*MLOGIC(FREQ):  Parameter ORDER has value descending*/
/*MPRINT(FREQ):   proc sort data = customerConti;*/
/*MPRINT(FREQ):   by descending cont;*/
/*MPRINT(FREQ):   run;*/
/**/
/*NOTE: There were 77 observations read from the data set WORK.CUSTOMERCONTI.*/
/*NOTE: The data set WORK.CUSTOMERCONTI has 77 observations and 12 variables.*/
/*NOTE: PROCEDURE SORT used (Total process time):*/
/*      real time           0.03 seconds*/
/*      cpu time            0.01 seconds*/
/**/
/**/
/*MLOGIC(FREQ):  %IF condition (&order = descending) is TRUE*/
/*MPRINT(FREQ):   title "Southern Hemisphere";*/
/*MPRINT(FREQ):   proc freq data = customerConti ;*/
/*MPRINT(FREQ):   by descending cont;*/
/*MPRINT(FREQ):   table customer_country;*/
/*MPRINT(FREQ):   run;*/
/**/
/*NOTE: There were 77 observations read from the data set WORK.CUSTOMERCONTI.*/
/*NOTE: PROCEDURE FREQ used (Total process time):*/
/*      real time           1.82 seconds*/
/*      cpu time            0.04 seconds*/
/**/
/**/
/*MLOGIC(FREQ):  Ending execution.*/
/*MPRINT(HEMIFREQ):  ;*/
/*MLOGIC(HEMIFREQ):  Ending execution.*/

%hemifreq(n)

/*6584  %hemifreq(n)*/
/*MLOGIC(HEMIFREQ):  Beginning execution.*/
/*MLOGIC(HEMIFREQ):  Parameter HEMI has value n*/
/*MLOGIC(HEMIFREQ):  %LET (variable name is HEMI)*/
/*MLOGIC(HEMIFREQ):  %IF condition &hemi in (S SOUTH SOUTHERN) is FALSE*/
/*MLOGIC(HEMIFREQ):  %IF condition &hemi in (N NORTH NORTHERN) is TRUE*/
/*MLOGIC(FREQ):  Beginning execution.*/
/*MLOGIC(FREQ):  Parameter ORDER has value*/
/*MPRINT(FREQ):   proc sort data = customerConti;*/
/*MPRINT(FREQ):   by cont;*/
/*MPRINT(FREQ):   run;*/
/**/
/*NOTE: There were 77 observations read from the data set WORK.CUSTOMERCONTI.*/
/*NOTE: The data set WORK.CUSTOMERCONTI has 77 observations and 12 variables.*/
/*NOTE: PROCEDURE SORT used (Total process time):*/
/*      real time           0.03 seconds*/
/*      cpu time            0.04 seconds*/
/**/
/**/
/*MLOGIC(FREQ):  %IF condition (&order = descending) is FALSE*/
/*MPRINT(FREQ):   title "Northern Hemisphere";*/
/*MPRINT(FREQ):   proc freq data = customerConti ;*/
/*MPRINT(FREQ):   by cont;*/
/*MPRINT(FREQ):   table customer_country;*/
/*MPRINT(FREQ):   run;*/
/**/
/*NOTE: There were 77 observations read from the data set WORK.CUSTOMERCONTI.*/
/*NOTE: PROCEDURE FREQ used (Total process time):*/
/*      real time           1.79 seconds*/
/*      cpu time            0.04 seconds*/
/**/
/**/
/*MLOGIC(FREQ):  Ending execution.*/
/*MPRINT(HEMIFREQ):  ;*/
/*MLOGIC(HEMIFREQ):  Ending execution.*/


%hemifreq(western)

/*6585  %hemifreq(western)*/
/*MLOGIC(HEMIFREQ):  Beginning execution.*/
/*MLOGIC(HEMIFREQ):  Parameter HEMI has value western*/
/*MLOGIC(HEMIFREQ):  %LET (variable name is HEMI)*/
/*MLOGIC(HEMIFREQ):  %IF condition &hemi in (S SOUTH SOUTHERN) is FALSE*/
/*MLOGIC(HEMIFREQ):  %IF condition &hemi in (N NORTH NORTHERN) is FALSE*/
/*MLOGIC(HEMIFREQ):  %PUT ERROR: input must be s, south, southern, n, north or nothern*/
/*ERROR: input must be s, south, southern, n, north or nothern*/
/*MLOGIC(HEMIFREQ):  Ending execution.*/


/*6. Run the code below to create a dataset called \NC" and some macro variables to go along.*/

options ls=75 nocenter mlogic ;
    data NC;
    length county $20 city $20;
    input county_id county $ city_id city $ popn income;
    call symputx("county"||left(county_id),county);
    call symputx("city"||left(city_id),city);
    * call symputx("county"||strip(put(county_id,best.)),county); *Mr. Bailey's suggestion;
    * call symputx("city"||strip(put(city_id,best.)),city); *Mr. Bailey's suggestion;
    datalines;
1 Wake 1 Raleigh 404 32.6
1 Wake 2 Cary 135 32.6
2 Mecklenburg 3 Charlotte 731 31.8
2 Mecklenburg 4 Davidson 11 31.8
;
run;

/**/
/*(a) Use PROC MEANS with a BY statement to report the mean population size (in thousands) and*/
/*per-capita income (in thousands) separately for each county.*/

proc sort data = nc;
    by county;
run;


proc means data = nc;
    by county;
    var popn income;
run;


/*                      12:13 Friday, July 13, 2018  17*/
/**/
/*county=Mecklenburg*/
/**/
/*The MEANS Procedure*/
/**/
/*Variable   N           Mean        Std Dev        Minimum        Maximum*/
/*ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ*/
/*popn       2    371.0000000    509.1168825     11.0000000    731.0000000*/
/*income     2     31.8000000              0     31.8000000     31.8000000*/
/*ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ*/
/**/
/**/
/*county=Wake*/
/**/
/*Variable   N           Mean        Std Dev        Minimum        Maximum*/
/*ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ*/
/*popn       2    269.5000000    190.2117241    135.0000000    404.0000000*/
/*income     2     32.6000000              0     32.6000000     32.6000000*/
/*ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ*/


/*(b) Use indirect macro variable references to complete the macro below so that it produces a county*/
/*report with the name of the county in the title.*/

%macro countysum(id);
    %let co1 = Mecklenburg;
    %let co2 = Wake;
    proc means data=NC;
        title "report for county= &&co&id";
        where county="&&co&id";
        var popn income;
    run;
%mend countysum;


/*(c) Call the macro once for each county code. Report the results, whose numerical summaries should*/
/*agree with part (a).*/
%countysum(1)

/*report for county= Mecklenburg              12:13 Friday, July 13, 2018  21*/
/**/
/*The MEANS Procedure*/
/**/
/*Variable   N           Mean        Std Dev        Minimum        Maximum*/
/*ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ*/
/*popn       2    371.0000000    509.1168825     11.0000000    731.0000000*/
/*income     2     31.8000000              0     31.8000000     31.8000000*/
/*ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ*/

%countysum(2)

/*report for county= Wake                     12:13 Friday, July 13, 2018  22*/
/**/
/*The MEANS Procedure*/
/**/
/*Variable   N           Mean        Std Dev        Minimum        Maximum*/
/*ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ*/
/*popn       2    269.5000000    190.2117241    135.0000000    404.0000000*/
/*income     2     32.6000000              0     32.6000000     32.6000000*/
/*ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ*/

/*(d) (Challenging) Write a macro called munisum that has two parameters, mtype and id. The first*/
/*parameter can take as valid values either county or city.*/

options mprint;

/*The macro take a parameter of country or city and searched */
/*the county id or city id based on the first parameter. Then a proc means is run.*/

%macro munisum(mtype,id);
    /*Determine if the first parameter is city or county then set second parameter. */
    %let mytype = %upcase(&mtype);
    %let trigger = 1;
    %if(&mytype = COUNTY)%then
        %do;
            %let i = county_id;
            %let c = county;
            %let trigger = 2;
        %end;
    %else %if( &mytype = CITY) %then
        %do;
            %let i = city_id;
            %let c = city;
            %let trigger = 2;
        %end;
    %if(&trigger = 2) %then
        %do;
            data _null_;
                set nc;
                call symputx("v", &c);
                where  &i = &id; 
            run;
            /*proc mean based on the macros values from the if  */
            proc means data=NC;
                title "&mytype report";
                title2 " &mytype is &v with &i = &id";
                where  &i = &id;
                var popn income;
            run;
        %end;
%mend munisum;

/*(e) Call the new macro for each county and for each city, for a total of 4 calls. Report the results.*/
%munisum(county,1)

/*COUNTY report                                22:03 Monday, July 9, 2018  10*/
/* COUNTY is Wake with county_id = 1*/
/**/
/*The MEANS Procedure*/
/**/
/*Variable   N           Mean        Std Dev        Minimum        Maximum*/
/*ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ*/
/*popn       2    269.5000000    190.2117241    135.0000000    404.0000000*/
/*income     2     32.6000000              0     32.6000000     32.6000000*/
/*ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ*/

%munisum(county,2)


/*COUNTY report                                22:03 Monday, July 9, 2018  11*/
/* COUNTY is Mecklenburg with county_id = 2*/
/**/
/*The MEANS Procedure*/
/**/
/*Variable   N           Mean        Std Dev        Minimum        Maximum*/
/*ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ*/
/*popn       2    371.0000000    509.1168825     11.0000000    731.0000000*/
/*income     2     31.8000000              0     31.8000000     31.8000000*/
/*ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ*/

%munisum(city,1)

/*CITY report                                  22:03 Monday, July 9, 2018  12*/
/* CITY is Raleigh with city_id = 1*/
/**/
/*The MEANS Procedure*/
/**/
/*Variable   N           Mean        Std Dev        Minimum        Maximum*/
/*ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ*/
/*popn       1    404.0000000              .    404.0000000    404.0000000*/
/*income     1     32.6000000              .     32.6000000     32.6000000*/
/*ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ*/


%munisum(city,2)

/*CITY report                                  22:03 Monday, July 9, 2018  13*/
/* CITY is Cary with city_id = 2*/
/**/
/*The MEANS Procedure*/
/**/
/*Variable   N           Mean        Std Dev        Minimum        Maximum*/
/*ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ*/
/*popn       1    135.0000000              .    135.0000000    135.0000000*/
/*income     1     32.6000000              .     32.6000000     32.6000000*/
/*ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ*/

/*7. List the four types of tokens in SAS syntax.*/
/*literals, name, number and special char*/


/*8. What is an option you can use so that every time a macro variable is referenced, the resolved value is*/
/*reported in the log?*/

options symbolgen;
