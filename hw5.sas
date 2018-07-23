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

