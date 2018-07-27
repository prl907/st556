
*
DONE BY :Robin Baldeo
COURSE: ST556
DATE WRITTEN: 7/25/2018
HOMEWORK #: 5
INPUT FILE: runsathome2011.csv, 
;




libname mlb 'C:\Users\u551791\Desktop\st556';

filename csv 'C:\Users\u551791\Desktop\st556\runsathome2011.csv';

/*Consider orion.order fact and orion.product_dim.*/


/*(a) Use describe table to discover the names and attributes of all columns in orion.order_fact.*/
/*Print the relevant information from the SAS Log.*/
proc sql;
    describe table orion.order_fact
    ;
quit;

/*6285  proc sql;*/
/*6286      describe table orion.order_fact*/
/*6287      ;*/
/*NOTE: SQL table ORION.ORDER_FACT was created like:*/
/**/
/*create table ORION.ORDER_FACT( bufsize=65536 )*/
/*  (*/
/*   Customer_ID num format=12. label='Customer ID',*/
/*   Employee_ID num format=12. label='Employee ID',*/
/*   Street_ID num format=12. label='Street ID',*/
/*   Order_Date num format=DATE9. label='Date Order was placed by Customer',*/
/*   Delivery_Date num format=DATE9. label='Date Order was Delivered',*/
/*   Order_ID num format=12. label='Order ID',*/
/*   Order_Type num label='Order Type',*/
/*   Product_ID num format=12. label='Product ID',*/
/*   Quantity num label='Quantity Ordered',*/
/*   Total_Retail_Price num format=DOLLAR13.2 label='Total Retail Price for This Product',*/
/*   CostPrice_Per_Unit num format=DOLLAR13.2 label='Cost Price Per Unit',*/
/*   Discount num format=PERCENT. label='Discount in percent of Normal Total Retail Price'*/
/*  );*/
/**/
/*6288  quit;*/
/*NOTE: PROCEDURE SQL used (Total process time):*/
/*      real time           0.05 seconds*/
/*      cpu time            0.00 seconds*/

/*(b) Use describe table to discover the names and attributes of all columns in orion.product dim.*/
/*/*Print the relevant information from the SAS Log.*/*/;


proc sql;
    describe table orion.product_dim
    ;
quit;


/*6289  proc sql;*/
/*6290      describe table orion.product_dim*/
/*6291      ;*/
/*NOTE: SQL table ORION.PRODUCT_DIM was created like:*/
/**/
/*create table ORION.PRODUCT_DIM( bufsize=65536 )*/
/*  (*/
/*   Product_ID num format=12. label='Product ID',*/
/*   Product_Line char(20) label='Product Line',*/
/*   Product_Category char(25) label='Product Category',*/
/*   Product_Group char(25) label='Product Group',*/
/*   Product_Name char(45) label='Product Name',*/
/*   Supplier_Country char(2) label='Supplier Country',*/
/*   Supplier_Name char(30) label='Supplier Name',*/
/*   Supplier_ID num format=12. label='Supplier ID'*/
/*  );*/
/**/
/*6292  quit;*/
/*NOTE: PROCEDURE SQL used (Total process time):*/
/*      real time           0.02 seconds*/
/*      cpu time            0.01 seconds*/


*(c) Print the first fiveve rows of orion.product dim after sorting by Product ID, selecting only those
columns with these labels: Product ID., Product Category and Product Name.;


proc sql;
    create table a1 as
        select 
               Product_ID,
               Product_Category,
               Product_Name

        from orion.product_dim
        order by Product_ID
        ;
quit;


proc print data = a1 (obs = 5);
run;

/**/
/*       The SAS System          12:22 Sunday, July 22, 2018  64*/
/**/
/*                                   Product_*/
/*         Obs      Product_ID       Category        Product_Name*/
/**/
/*           1    210200100009    Children Sports    Kids Sweat Round Neck,Large Logo*/
/*           2    210200100017    Children Sports    Sweatshirt Children's O-Neck*/
/*           3    210200200022    Children Sports    Sunfit Slow Swimming Trunks*/
/*           4    210200200023    Children Sports    Sunfit Stockton Swimming Trunks Jr.*/
/*           5    210200300006    Children Sports    Fleece Cuff Pant Kid'S*/

/*(d) How many rows are in orion.order fact?*/


proc sql;
    select count(*)
    from orion.order_fact
;
quit;

/*617*/


/*(e) How many dierent values of the column order id are there in orion.order fact?*/


proc sql;
    select count(of.order_id)
    from (select distinct order_id
          from orion.order_fact) as of
    ;
quit;

/*490*/
/*(f) How many dierent values of the column discount are there in orion.order fact?*/

proc sql;
    select count(of.discount)
    from (select distinct discount
          from orion.order_fact) as of
    ;
quit;

/*2*/


/*2. Modify the program below (s102a05) so that only those employees with first names starting with J are*/
/*selected in the query.*/


*** s102a05 ***;
proc  sql feedback;
        select Employee_Name, 
               Employee_ID
        from orion.employee_addresses
        where strip(scan(upcase(Employee_Name), 2, ',')) like ('J%')
        ;
quit;

/**/
/*                    The SAS System          12:22 Sunday, July 22, 2018  89*/
/**/
/*                     Employee_Name                             Employee_ID*/
/*                     ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ*/
/*                     Areu, Jeryl                                    121030*/
/*                     Atkins, John                                   120754*/
/*                     Banaszak, John                                 121007*/
/*                     Blackley, James                                121035*/
/*                     Buddery, Jeannette                             120114*/
/*                     Carhide, Jacqulin                              121059*/
/*                     Chantharasy, Judy                              120149*/
/*                     Denhollem, Julius                              120789*/
/*                     Eggleston, Jennifer                            120779*/
/*                     Filo, John                                     120150*/
/*                     Fiocca, Jina                                   120195*/
/*                     Graham-Rowe, Jannene                           120191*/
/*                     Havasy, Jay                                    120659*/
/*                     Heinsler, John                                 120813*/
/*                     Hilburger, James                               121106*/
/*                     Hoppmann, John                                 121071*/
/*                     Hornsey, John                                  120106*/
/*                     Kempster, Janelle                              120766*/
/*                     Kirkman, John                                  121034*/
/*                     Lapsley, Jason                                 121069*/
/*                     Laurer, Jaime                                  120280*/
/*                     Leacock, Jill                                  120665*/
/*                     Macnair, Jeanilla                              121067*/
/*                     Magolan, Julienne                              121018*/
/*                     Onuscheck, John                                120666*/
/*                     Pascoe, Julia                                  120770*/
/*                     Penhale, James                                 121126*/
/*                     Phaiyakounh, Julianna                          120151*/
/*                     Pinol, Jennifer                                120784*/
/*                     Plybon, John-Michael                           121086*/
/*                     Robbin-Coker, Joseph                           121042*/
/*                     Sangiorgio, Julieanne                          121146*/
/*                     Savacool, Jessica                              121105*/
/*                     Sleva, Jon                                     120717*/
/*                     Spingola, John                                 120720*/
/*                     Stefandonovan, Jeffery                         120799*/
/*                     Van Damme, Jean-Claude                         120752*/
/*                     Villeneuve, Jacques                            120268*/
/*                     Wade, Johannes                                 120996*/
/*                     Wetherington, Jaime                            121041*/


/*Question 3*/

proc sql feedback ;
    select * from mlb.sal2015 ;
run ;
proc sql feedback ;
    select * from mlb.sal2015 ;
quit ;
proc sql ;
    describe table mlb.sal2015 ;
quit ;

/*(a) What message was included in the log because of the use of the run; statement?*/

/*        select SAL2015.year, SAL2015.sport, SAL2015.Team, SAL2015.rank, SAL2015.opening,*/
/*SAL2015.Current, SAL2015.Avgsal, SAL2015.medsal*/
/*          from MLB.SAL2015;*/
/**/
/*111  run ;*/
/*NOTE: PROC SQL statements are executed immediately; The RUN statement has no effect.*/
/*NOTE: PROCEDURE SQL used (Total process time):*/
/*      real time           0.09 seconds*/
/*      cpu time            0.04 seconds*/




/*(b) What variable type is the column named opening? Is it character? numeric?*/

proc sql;
    describe table mlb.sal2015;
quit;

/*   opening num,*/


/*(c) Describe and contrast the function of the feedback option and the DESCRIBE statement in PROC SQL.*/

/*proc sql;*/
/*  describe table mlb.sal2015;*/
/*quit;*/
/**/
/*proc sql feedback;*/
/*  select * from  mlb.sal2015;*/
/*quit;*/
/**/
/*Feedback gives a two level description of the table then the column of the columns indicated within the select statement only. */
/*While, describe table gives the table name, data type of each column, and labels*/

/*(d) Modify the style of the middle proc sql code (three lines) by putting all SAS syntax into upper*/
/*case and all user-specified names in lower case. Include here your modified (but equivalent!) code.*/

PROC SQL FEEDBACK ;
    SELECT * FROM mlb.sal2015 ;
RUN ;
PROC SQL FEEDBACK ;
    SELECT * FROM mlb.sal2015 ;
QUIT ;
PROC SQL ;
    DESCRIBE TABLE mlb.sal2015 ;
QUIT ;


/*(e) Write an SQL query that produces a table with two columns, team name and opening salary*/
/*(unformatted).*/

proc sql;
    select  team, 
            opening 
    from mlb.sal2015
    ;
quit;

/*(f) Modify your query so that the column with opening salary, which is in the hundreds of mil-*/
/*lions of samoleans (dollars), has the heading \Opening Salary" and has a format of the form*/
/*$xxx,xxx,xxx.*/

proc sql;
    select  team label= 'Opening Salary' , 
            opening format= dollar15.0
    from mlb.sal2015
    ;
quit;

/**/
/*                  The SAS System           11:16 Monday, July 23, 2018   2*/
/**/
/*                                 Opening Salary           opening*/
/*                                 ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ*/
/*                                 Dodgers             $223,352,402*/
/*                                 Yankees             $213,472,857*/
/*                                 Red_Sox             $182,161,414*/
/*                                 Tigers              $172,792,250*/
/*                                 Giants              $166,495,942*/
/*                                 Nationals           $166,010,977*/
/*                                 Angels              $146,449,583*/
/*                                 Rangers             $144,816,873*/
/*                                 Phillies            $133,048,000*/
/*                                 Padres              $126,369,628*/
/*                                 Mariners            $123,225,842*/
/*                                 Cardinals           $120,301,957*/
/*                                 Orioles             $118,862,632*/
/*                                 Reds                $117,732,284*/
/*                                 Cubs                $117,164,522*/
/*                                 Blue_Jays           $116,415,800*/
/*                                 Royals              $112,914,525*/
/*                                 White_Sox           $110,712,867*/
/*                                 Twins               $108,262,000*/
/*                                 Mets                $100,133,953*/
/*                                 Brewers              $98,683,035*/
/*                                 Rockies              $98,261,171*/
/*                                 Braves               $91,622,648*/
/*                                 Indians              $87,746,767*/
/*                                 Pirates              $85,885,832*/
/*                                 Marlins              $84,637,500*/
/*                                 Athletics            $80,786,666*/
/*                                 Rays                 $74,849,584*/
/*                                 Diamondbacks         $70,762,833*/
/*                                 Astros               $69,064,200*/

/*(g) Modify your code so that it the teams are ordered by opening salary, in increasing order, so that*/
/*the (dis)Astros come first, (for once). Include an appropriate title to the report created by the*/
/*query.*/

proc sql;
    title 'baseball salary';
    select  team label= 'Opening Salary' , 
            opening format= dollar15.0
    from mlb.sal2015
    order by 2 asc;
    ;
quit;
title;

/*                     baseball salary           11:16 Monday, July 23, 2018   7*/
/**/
/*                                 Opening Salary           opening*/
/*                                 ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ*/
/*                                 Astros               $69,064,200*/
/*                                 Diamondbacks         $70,762,833*/
/*                                 Rays                 $74,849,584*/
/*                                 Athletics            $80,786,666*/
/*                                 Marlins              $84,637,500*/
/*                                 Pirates              $85,885,832*/
/*                                 Indians              $87,746,767*/
/*                                 Braves               $91,622,648*/
/*                                 Rockies              $98,261,171*/
/*                                 Brewers              $98,683,035*/
/*                                 Mets                $100,133,953*/
/*                                 Twins               $108,262,000*/
/*                                 White_Sox           $110,712,867*/
/*                                 Royals              $112,914,525*/
/*                                 Blue_Jays           $116,415,800*/
/*                                 Cubs                $117,164,522*/
/*                                 Reds                $117,732,284*/
/*                                 Orioles             $118,862,632*/
/*                                 Cardinals           $120,301,957*/
/*                                 Mariners            $123,225,842*/
/*                                 Padres              $126,369,628*/
/*                                 Phillies            $133,048,000*/
/*                                 Rangers             $144,816,873*/
/*                                 Angels              $146,449,583*/
/*                                 Nationals           $166,010,977*/
/*                                 Giants              $166,495,942*/
/*                                 Tigers              $172,792,250*/
/*                                 Red_Sox             $182,161,414*/
/*                                 Yankees             $213,472,857*/
/*                                 Dodgers             $223,352,402*/




/*Question 4*/
/*4. Recall Problem #2 where we used PROC SQL to print employees whose first names start with \J" .*/
/*Write a defined macro called firstletter that can be used to generate the same code as in your*/
/*solution for problem 2, but for any letter. Call firstletter while supplying the argument \D" to*/
/*print out those employees whose first name starts with \D". Print the employee name and ID number.*/
/*If you are not careful, Jean-Claude Van Damme may end up in your report by mistake. Hint: You*/
/*may assume that there are no employees with a comma in their first name.*/



%macro firstletter(letter); 
    proc  sql feedback;
        select Employee_Name, 
               Employee_ID
        from orion.employee_addresses
        where strip(scan(upcase(Employee_Name), 2, ',')) like ("%upcase(&letter)%")
        ;
    quit;
%mend firstletter;

%firstletter(d)


/*                       11:16 Monday, July 23, 2018  23*/
/**/
/*                      Employee_Name                             Employee_ID*/
/*                      ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ*/
/*                      Anstey, David                                  121038*/
/*                      Antonini, Doris                                120273*/
/*                      Armant, Debra                                  121062*/
/*                      Bergeron-Jeter, Dale                           120811*/
/*                      Court, Donald                                  121073*/
/*                      Deacon, David                                  120795*/
/*                      Donnell, Damesha                               120785*/
/*                      Entwisle, Dennis                               120110*/
/*                      Gonzalez, Deginald                             121124*/
/*                      Hartshorn, Darshi                              120118*/
/*                      Karp, Davis                                    120783*/
/*                      Knust, Dlutomi                                 120721*/
/*                      Kochneff, Deven                                120683*/
/*                      Kohake, Del                                    121058*/
/*                      Lamp, Donald                                   121010*/
/*                      Lansberry, Dennis                              121145*/
/*                      Liguori, Donelle                               121014*/
/*                      Marples, Donald                                120727*/
/*                      Mckee, Diosdado                                121139*/
/*                      Olsen, Deanna                                  120723*/
/*                      Pilgrim, Daniel                                120158*/
/*                      Pulliam, Daniel                                121054*/
/*                      Sergeant, Danelle                              120994*/
/*                      Simms, Doungkamol                              120174*/
/*                      Tellam, Diaz                                   120693*/
/*                      Washington, Donald                             121039*/

/*(a) List the MLB teams that scored fewer runs (rs variable) than average in 2010 (Suggestion: SAS*/
/*Doc indicates that a summary function cannot appear in a WHERE clause (e.g. where rs <*/
/*avg(rs)). Try the HAVING clause.)*/


proc sql;
    select team
    from mlb.Mlb2010
    having rs < avg(rs)
    ;
quit;

/**/
/*  11:16 Monday, July 23, 2018  27*/
/**/
/*                                         team*/
/*                                         ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ*/
/*                                         Baltimore*/
/*                                         Cleveland*/
/*                                         Kansas_City*/
/*                                         Oakland*/
/*                                         LA_Angels*/
/*                                         Seattle*/
/*                                         Houston*/
/*                                         Chi_Cubs*/
/*                                         Pittsburgh*/
/*                                         NY_Mets*/
/*                                         Washington*/
/*                                         San_Francisco*/
/*                                         San_Diego*/
/*                                         LA_Dodgers*/


/*(b) List the MLB teams that scored fewer runs than the average in their league (AL,NL) in 2010.*/
/*Sort them in ascending order according to runs scored. (Suggestion: calculate average by group*/
/*using the avg function and the group by clause and select desired teams using having clause.)*/

proc sql;
    select team
    from mlb.Mlb2010
    group by league
    having rs < avg(rs)
    ;
quit;

/**/
/*                              11:16 Monday, July 23, 2018  35*/
/**/
/*                                         team*/
/*                                         ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ*/
/*                                         Oakland*/
/*                                         Kansas_City*/
/*                                         Cleveland*/
/*                                         LA_Angels*/
/*                                         Baltimore*/
/*                                         Seattle*/
/*                                         LA_Dodgers*/
/*                                         San_Francisco*/
/*                                         Washington*/
/*                                         NY_Mets*/
/*                                         San_Diego*/
/*                                         Pittsburgh*/
/*                                         Chi_Cubs*/
/*                                         Houston*/


/*(c) Also, reproduce the table in part (b) using constant text, \<", in an appropriate place to help a*/
/*reader better see the relationship between a team's runs and the league average.*/

proc sql;
    select team label= "MLB teams that scored < the average of the league"
    from mlb.Mlb2010
    group by league
    having rs < avg(rs)
    ;
quit;


/*                          11:16 Monday, July 23, 2018  37*/
/**/
/*                                         MLB teams that*/
/*                                         scored < the*/
/*                                         average of*/
/*                                         the league*/
/*                                         ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ*/
/*                                         Oakland*/
/*                                         Kansas_City*/
/*                                         Cleveland*/
/*                                         LA_Angels*/
/*                                         Baltimore*/
/*                                         Seattle*/
/*                                         LA_Dodgers*/
/*                                         San_Francisco*/
/*                                         Washington*/
/*                                         NY_Mets*/
/*                                         San_Diego*/
/*                                         Pittsburgh*/
/*                                         Chi_Cubs*/
/*                                         Houston*/


/*(d) Reproduce the table in part (c) but in descending order according to runs scored.*/

proc sql;
    select team label= "MLB teams that scored < the average of the league"
    from mlb.Mlb2010
    group by league
    having rs < avg(rs)
    order by rs desc
    ;
quit;

/*                               11:16 Monday, July 23, 2018  41*/
/**/
/*                                         MLB teams that*/
/*                                         scored < the*/
/*                                         average of*/
/*                                         the league*/
/*                                         ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ*/
/*                                         San_Francisco*/
/*                                         Chi_Cubs*/
/*                                         LA_Angels*/
/*                                         Kansas_City*/
/*                                         LA_Dodgers*/
/*                                         San_Diego*/
/*                                         Oakland*/
/*                                         NY_Mets*/
/*                                         Washington*/
/*                                         Cleveland*/
/*                                         Baltimore*/
/*                                         Houston*/
/*                                         Pittsburgh*/
/*                                         Seattle*/




/*question 6*/
/*6. Explain what a left outer join is.*/
/*When we do a left join we select all the members within the tables indicated in the left side of the join clause.*/


/*Question 7*/
/*7. How many rows would be in a cartesian join two tables A and B, if the number of respective rows is*/
/*rA = 15; rB = 100?*/
/*1500*/

/*Question 8*/
/*Using an inner join with orion.product dim and orion.order fact, compute the profit for each of*/
/*the three items sold at a discount and generate the following table :*/


proc sql;
        select f.product_id label= 'Product Id',
               p.product_name label = 'Product Name',
               f.profit label = 'total profit',
               f.discount format = percent10.
        from orion.product_dim as p
                join (
                        select product_id as product_id,
                               sum(Total_Retail_Price - quantity * CostPrice_Per_Unit) as profit,
                               max(discount)as discount
                        from orion.order_fact
                        where product_id in (240700100017, 240200100050, 220100700023) 
                        group by product_id
                        
                    )as f
                on p.product_id = f.product_id
        ;
quit;


/*         The SAS System          13:36 Tuesday, July 24, 2018   5*/
/**/
/*                                                                        total*/
/*          Product Id  Product Name                                     profit    discount*/
/*        ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ*/
/*        220100700023  Armadillo Road Dmx Men's Running Shoes            29.74        30%*/
/*        240200100050  Bretagne St2 Men's Golf Glove, left               27.23        30%*/
/*        240700100017  Football Super Bowl                               27.58        40%*/


/*Question 9*/
/*9. Use these tables: orion.employee addresses and orion.staff to create a report of all trainees and*/
/*temporary workers at Orion. For each trainee or temporary worker, include employee ID, name, job*/
/*title and manager ID and name. Sort by manager name and then employee name.*/

proc sql;
    select e.Employee_ID,
           Job_Title,
           s.Manager_ID,
           Employee_Name,
           manager_name

    from
        orion.employee_addresses as e
    join 
        orion.staff as s
             on e.Employee_ID = s.Employee_ID
    /*getting the manager name*/
    left join
         (
            select distinct Employee_Name as manager_name, 
                   s.Manager_ID
            from 
                orion.employee_addresses as e
                    join orion.staff as s
                on e.Employee_ID = s.Manager_ID
         ) as ma
             on ma.Manager_ID = s.Manager_ID
            
    order by ma.manager_name
    ;
quit;


/*Question 11*/

/*first set the source() then*/
/*package.skeleton(name="thenameOfPackage");*/


























/*question 13*/
/*13. Table A has three rows and two columns, ID and name. Table B has four rows and two columns, ID*/
/*and status. Consider the join code below:*/

/*data a;*/
/*    do id = 1 to 3;*/
/*        do a = 1 to 2;*/
/*            name = a;*/
/*        end;*/
/*        output;*/
/*    end;*/
/*    drop a;*/
/*run;*/
/**/
/*data b;*/
/*    do id = 1 to 4;*/
/*        do a = 1 to 2;*/
/*            status = a;*/
/*        end;*/
/*        output;*/
/*    end;*/
/*    drop a;*/
/*run;*/


proc sql;
    select *
    from a,b
    ;
quit;


/*(a) How many rows will be in the report produced by this code?*/
/*12*/


/*(b) How many columns will be in the report produced by this code (not counting the row indicator)?*/
/*4*/


/*question 14*/
/*14. Assuming ID is the same variable type in both tables A and B in problem #1,*/
/*(a) modify the code so that only rows for which ID matches across tables will be reported by the*/
/*query.*/

proc sql;
    select *
    from a,b
    where a.id = b.id
    ;
quit;

/*(b) using the keyword LEFT, modify the code so that matching rows and non-matching rows from*/
/*Table A will be reported by the query.*/


proc sql;
    select *
    from a
        left join b
            on a.id = b.id
    ;
quit;

/*(c) using the keyword LEFT, modify the code so that matching rows and non-matching rows from*/
/*Table B will be reported by the query.*/

proc sql;
    select *
    from b
        left join a
            on a.id = b.id
    ;
quit;


/*(d) suppose a natural join with tables a and b is accomplished using the following original join syntax:*/
/*How many columns will there be in the report from this query?*/
/*4*/


/*(e) Suppose alternative join syntax is used with the tables a and b from problem # 1:*/
PROC SQL ;
SELECT * 
FROM a NATURAL JOIN b;
QUIT ;

/*3*/


/*(f)Briey, why aren't the number of variables the same when using dierent join syntaxes?*/

/*The difference between natural and the outer and inner joins are the number of columns returned. */
/*Common tables in both tables with the same data type and name will get outputted for the inner and outer. */
/*With the natural joins these common columns are not shown multiple times but once.*/

/*Question 15*/
/*15. Find the file \runsathome2011.csv" on the moodle page and read in the data. This file includes*/
/*every half-inning of every major league baseball game played during the 2011 season. The columns in*/
/*the table are inning, visiting team (vteam), home team (hteam) and runs scored by the home team*/
/*(hruns). (Runs scored by the home team is equal to runs allowed by the visiting team.) (inspired by*/
/*Forum discussion)*/


/*reading in the file*/
data runs ;
    infile csv dlm= ',' dsd firstobs = 2;
        input id inning vteam$  hteam$  hruns ;
    drop id;
run;

/*(a) Compute the mean runs allowed per inning among all team-innings. That is, compute the mean*/
/*of the hruns column.*/
proc sql;
    select  mean(hruns) as m 
    from runs
    ;
quit;

/*0.490078*/


/*(b) Select those visiting teams with average runs allowed that are fewer than the overall average from*/
/*part (a).*/
proc sql;
    select *
    from runs
    where hruns < all(select  mean(hruns) from runs)
    ;
quit;


/*Question 16*/

data digest;
    set mlb.dig_aminoa;
    length aminoacid $ 10;
    array re [*] DIG_LYS3 -- DIG_VAL3;
    array am [17] $ _temporary_('DIG_LYS3' 'DIG_THR3' 'DIG_ALA3' 'DIG_ARG3' 'DIG_ASP3'
                                'DIG_CYS3' 'DIG_GLU3' 'DIG_GLY3' 'DIG_HIS3' 'DIG_ILE3' 
                                'DIG_LEU3' 'DIG_MET3' 'DIG_PHE3' 'DIG_PRO3' 'DIG_SER3'
                                'DIG_TYR3' 'DIG_VAL3');
    do i = 1 to dim(am);
        block = block;
        aminoacid = am[i];
        response = re[i];
        phytate = phytate;
        dose = dose;
        output;
    end;    

    drop DIG_: i;
run;

proc sort data = digest;
    by aminoacid;
run;

proc mixed data = digest ;
    by aminoacid ;
    class block phytate dose ;
    model response = phytate | dose block ;
run ;

/*                   The SAS System          12:22 Sunday, July 22, 2018 228*/
/**/
/*-------------------------------------- aminoacid=DIG_VAL3 --------------------------------------*/
/**/
/*                                      The Mixed Procedure*/
/**/
/*                                        Fit Statistics*/
/**/
/*                             BIC (Smaller is Better)         137.7*/
/**/
/**/
/*                                 Type 3 Tests of Fixed Effects*/
/**/
/*                                        Num     Den*/
/*                       Effect            DF      DF    F Value    Pr > F*/
/**/
/*                       PHYTATE            1      25       0.20    0.6605*/
/*                       DOSE               2      25       3.95    0.0324*/
/*                       PHYTATE*DOSE       2      25       2.11    0.1421*/
/*                       block              5      25       5.97    0.0009*/








/*Question 17*/
data flights2 ;
        *loop up array;
        array wcarray{8,9} _temporary_ (
                                        -22,-16,-11,-5,1,7,13,19,25,
                                        -28,-22,-16,-10,-4,3,9,15,21,
                                        -32,-26,-19,-13,-7,0,6,13,19,
                                        -35,-29,-22,-15,-9,-2,4,11,17,
                                        -37,-31,-24,-17,-11,-4,3,9,16,
                                        -39,-33,-26,-19,-12,-5,1,8,15,
                                        -41,-34,-27,-21,-14,-7,0,7,14,
                                        -43,-36,-29,-22,-15,-8,-1,6,13)
        ;

    attrib Flight length =$8;
    attrib Temp length =8;
    attrib WSpeed length =8;
    infile datalines dsd ;
    input Flight $ Temp WSpeed ;
/*    row = round ( wspeed ,5) /5;*/
/*    col =( round (temp ,5)/ 5)+3;*/
    *round values to the nearest 5;
    windR = round(wspeed, 5);
    *round values to the nearest 5;
    tempR= round(temp, 5);
    wc_formula = 35.7 + .62 * tempr - 35.75 * windR**.16 + .4275 * tempr * windr**.16;

    do i = 1 to dim(wcarray, 1);
        *construct wind chill;
        wind_= i * 5;
        do j = 1 to dim(wcarray, 2);
            *constuct wind temp in 5 deg;
            if(j < 3) then
               temp_= ifn(j=1, -10, -5);
            else
              do;
                a = j -3;
                temp_ = a * 5;
              end;
            * checking the look up table for values;
            if(windR = wind_ & tempr = temp_) then
               do;
                    wc_lookup = wcarray[i,j];
                    leave;
               end;
        end;
    end;

drop i j wind_ temp_ a;
    datalines ;
    IA1234 ,14 ,29
    IA3456 ,12 ,27
    IA2736 , -7 ,9
    IA6352 , -4 ,11
    IA1234 ,32 ,4
    IA3456 ,22 ,21
    IA2736 ,15 ,18
    IA6352 ,0 ,10
    ;
    

run;


/*print the output of the lookuptable vs the formula*/
/*wc_formula = using the formula provided*/
/*wc_lookup = using the look provided*/
proc print data = flights2;
run;


/*                      The SAS System          12:22 Sunday, July 22, 2018 229*/
/**/
/*                                              wind    temp*/
/*           Obs    Flight    Temp    WSpeed      R       R     wc_formula    wc_lookup*/
/**/
/*            1     IA1234      14      29       30       15      -5.5548         -5*/
/*            2     IA3456      12      27       25       10     -10.7788        -11*/
/*            3     IA2736      -7       9       10       -5     -22.1641        -22*/
/*            4     IA6352      -4      11       10       -5     -22.1641        -22*/
/*            5     IA1234      32       4        5       30      24.6418         25*/
/*            6     IA3456      22      21       20       20       4.1728          4*/
/*            7     IA2736      15      18       20       15      -2.3792         -2*/
/*            8     IA6352       0      10       10        0     -15.9745        -16*/


