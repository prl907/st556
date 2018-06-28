
*
DONE BY :Robin Baldeo
COURSE: ST556
SECTION: Online Section
DATE WRITTEN: 6/28/2018
HOMEWORK #: 1
INPUT FILE: None
;

libname hw1 'C:\Users\prl90\Desktop\St556';
%let seed = 123;

/****************************************************************************************************************/
/*Question 2*/
/* (a) Simulate the rolling of n = 3 fair, six-sided dice. Show your result.*/

data hw1.DiceRolla;
/*array for n dices */
array dice[3] dice1 - dice3;
    do n = 1 to 3;
        dice[n] = ceil(ranuni(&seed) * 6);
    end;
    drop n;
run;


/*(b) Estimate the chance, when rolling n = 3 dice, that they sum to 9. To address this question,*/
/*   simulate nsim = 10000 rolls of n = 3 dice, computing the sum for each roll.*/

data hw1.DiceRollb;
/*array for n dices */
array dice[3] dice1 dice2 dice3;
/*var for the number of dices */
n_ = dim(dice);
/*var for the sum */
retain sum_ 0; 
    do i = 1 to 10000;
        do n = 1 to n_;
            do;
                dice[n] = ceil(ranuni(&seed) * 6);
                sum_ = sum_ + dice[n];
            end;
        end;
        /*bool to see if the sum was a 9 */
        if(sum_ = 9) then
            is9 = 1;
        else
            is9 = 0;
        ;
        output;
        /*reset sum var*/
        sum_ = 0;
        
    end;
    drop n i n_;
run;


/*finding the proportion */
proc means data = hw1.DiceRollb mean n;
    title 'phat generated when sum is 9';
    var is9;
    output out = hw1.phat9 mean = ph;
run;

/*output for phat for part b*/
/*phat = 0.1206*/


/*/*(c) Use PROC GCHART to produce a histogram for sums of 3 dice.*/

proc gchart data = hw1.DiceRollb;
  title 'Histogram for when sum is 9 for 3 dice';
  vbar sum_;
run;



/* (d) The Monte Carlo Standard Error (MCSE) for a sample proportion, bp, like the one computed in*/
/*  part (b) is given by the expression,*/

/*calcuating Monte Carlo Standard Error from part b using formula*/
data hw1.Mcse;
    set hw1.phat9;
        n_ = 3;
        sePHat = sqrt((ph*(1-ph))/n_);
run;

/*output for phat for part d*/
/*sePhat = 0.1880881974*/


/*(e) Use the Central Limit Theorem to analytically (i.e. no simulation) estimate the chance of getting*/
/*  a sum of 9 when rolling three dice.*/

/*Instead of simulation, I will use the CLT method by utilizing the CDF function*/
data hw1.clt;
    n =3;
    ana = CDF ('normal ' ,9.5 ,n*3.5 , sqrt (n*35/ 12)) - CDF ('normal ' ,8.5 ,n*3.5 , sqrt (n*35/ 12));
run;

/*output for phat for part e*/
/*ana = 0.118177196*/


/*(f) Repeat parts b) and e) by considering the chance that n = 5 dice leads to a sum of 15.*/
/*   simulate nsim = 10000 rolls of n = 5 dice, computing the sum for each roll.*/

data hw1.DiceRollf;
/*array for n dices */
array dice[5] dice1 dice2 dice3 dice4 dice5;
/*var for the number of dices */
n_ = dim(dice);
/*var for the sum */
/*var for the sum */
retain sum_ 0; 
    do i = 1 to 10000;
        do n = 1 to n_;
            do;
                dice[n] = ceil(ranuni(&seed) * 6);
                sum_ = sum_ + dice[n];
            end;
        end;
        /*bool to see if the sum was a 15 */
        if(sum_ = 15) then
            is15 = 1;
        else
            is15 = 0;
        ;
        output;
        /*reset sum var*/
        sum_ = 0;
        
    end;
    drop n i n_;
run;


proc means data = hw1.DiceRollf;
    title 'phat generated when sum is 15';
    var is15;
    output out = hw1.phat15 mean = phat15;

run;


/*Instead of simulation, I will use the CLT method by utilizing the CDF function*/
data hw1.cltf;
    n =5;
    ana = CDF ('normal ' ,15.5 ,n*3.5 , sqrt (n*35/ 12)) - CDF ('normal ' ,14.5 ,n*3.5 , sqrt (n*35/ 12));
run;

/****************************************************************************************************************/

/*question 3*/

/*Consider De Mere's frst problem, which requires estimation of the chance of rolling at least one*/
/*in 4 rolls of a fair six-sided die. Obtain a Monte Carlo estimate (and 95% confdence interval) for this*/
/*probability. Using the DATA step to simulate dice rolls and PROC MEANS to obtain the necessary*/
/*summary statistics. (Try the clm option in the PROC MEANS statement.)*/

data hw1.Demere;
    /*array for n dices */
    array roll[4] roll1 - roll4;
    /*var for the number of dices */
    n_ = dim(roll);
    do i = 1 to 10000;
        do n = 1 to n_;
            roll[n] = ceil(ranuni(&seed) * 6);
        end;
        one = min(of roll1-roll4) = 1;
        output;
    end;
    drop n i n_;
run;

/*mean and confidence interval*/
proc means data =hw1.Demere  mean std clm;
    title 'demere probelm 1 mean and CI';
    var one;
run;

/****************************************************************************************************************/
/*question 4*/

/*Recall that if FY (y) denotes the cumulative distribution function (CDF) of a random variable (RV) of*/
/*interest and U is a RV uniformly distributed between 0 and 1, then F??1*/
/*Y (U) is a RV with CDF FY (y)*/
/*where F??1*/
/*Y is the inverse of FY (y), or the so-called quantile function.*/


/*(a) Use a DO loop within a DATA step to generate a random sample of n = 10 independent uniformly*/
/*distributed RVs. Report the sample here.*/

data hw1.random;
    do i = 1 to 10;
        ranNum = ranuni(&seed);
        output;
    end;
run;

/*(b) The CDF of the exponential probability distribution with mean 5 is given below*/
/*F(y) = 1 ?? e??y=5*/
/*Find the inverse of this function. (Set F(y) = q and solve for y. as a function of q.)*/


/*inverse of f(y) = 1-e^(-y/5) is y = -5ln(1-q) */



/*(c) Using the data from part (a) and the inverse CDF from (b), generate a random sample of n = 10*/
/*independent observations from the exponential distribution with mean 5. Report the sample here,*/
/*along with the sample mean and sample standard deviation.*/


data hw1.expoDist;
    set hw1.random;
    expo = -5*log(1-ranNum);
run;



/*mean and stand dev for the manual function*/
proc means data = hw1.expoDist mean std;
    title 'using the inverse expo function to create mean and std';
    var expo;
run;



/*(d) Draw a larger sample of uniform RVs by increasing the sample size to n = 1000.*/
/*i. Report the sample mean and standard deviation of this larger sample.*/
/*ii. Use the following statement within the do loop to generate another random sample from*/
/*the exponential distribution using the built-in SAS function, RANEXP: x2=5*ranexp(1234);*/
/*Report the sample mean and standard deviation of this larger sample.*/

/*using built in function with larger sample*/
data hw1.expoDistB;
    do i = 1 to 1000;
        expo =5*ranexp(&seed);
        output;
    end;
run;

/*mean and stand dev for the built in function*/
proc means data = hw1.expoDistB mean std;
    title 'using sas built in ranexp to create mean and std';
    var expo;
run;

/****************************************************************************************************************/

/*question #5*/

/*answer*/

/*(b) a = c for every observation*/

/****************************************************************************************************************/
/*question #6*/

/*(a) List the variables that will be in the data set called \d".*/
/*    seed1, seed2, i, d1, d2 ,d3*/

/*(b) Will any of the values of d3 be equal to any of the values of d2? If so, which ones?*/
/*    none will be the same*/

/*(c) Will any of the values of d1 be equal to any of the values of d2? If so, which ones?*/
/*      yes, index 1 to 4 will be the same value but the fifth index will differ*/

/*(d) Will any of the values of either seed1 or seed2 be equal to 4 for any of the observations? If so,which ones?*/
/*    no, because we are using the call routine where the seed is reset every time in the loop*/

/****************************************************************************************************************/
/*question #7*/

/*Use the statement (x=rand('cauchy');) in SAS to generate a random sample, X1; : : : ;X20 from the*/
/*Cauchy distribution. Report the sample mean and variance.*/


data hw1.cauchy;
    call streaminit(&seed);
    do i = 1 to 10;
        cau =rand('cauchy');
        output;
    end;
run;

proc means data = hw1.cauchy mean std;
    title 'using sas built in function for cacuchy';
    var cau;
run;

