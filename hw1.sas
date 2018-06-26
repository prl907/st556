libname hw1 'C:\Users\u551791\Desktop\per\556';





/****************************************************************************************************************/

/* (a) Simulate the rolling of n = 3 fair, six-sided dice. Show your result.*/
data hw1.DiceRolla;
/*array for n dices */
array dice[3] dice1 - dice3;
	do n = 1 to 3;
		dice[n] = ceil(ranuni(1) * 6);
	end;
	drop n;
run;


/****************************************************************************************************************/

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
				dice[n] = ceil(ranuni(1) * 6);
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
	drop n i;
run;


/*proc sort the dataset from part b so the sum of 9 is stacked at the bottom of the dataset;*/
proc sort data = hw1.DiceRollb out =hw1.DiceRollb_ ;
	by is9 ;
run;



/*calcuating phat */
data hw1.phat;
	set hw1.DiceRollb_;
	by is9;
	f = first.is9;
	l = last.is9;
	retain count 1;

	if(is9 = 1) then
		count = count + 1;
	;
    /*count of the sums of 9 divided by the total # of observations*/
    /*cal sephat*/
	if(is9 = 1 & l = 1) then
		do;
			ph = count / _N_;
		end;
	;
	if ph > 0;
	keep ph n_ ;
run;


/*output for phat for part b*/
/*phat = 0.1207*/

/****************************************************************************************************************/

/*/*(c) Use PROC GCHART to produce a histogram for sums of 3 dice.*/*/
/*proc gchart data = hw1.DiceRollb;*/
/*	title 'Histogram for sums of 3 dice';*/
/*	vbar sum_;*/
/*run;*/;

/****************************************************************************************************************/

/* (d) The Monte Carlo Standard Error (MCSE) for a sample proportion, bp, like the one computed in*/
/*  part (b) is given by the expression,*/

/*calcuating Monte Carlo Standard Error from part b using formula*/
data hw1.Mcse;
	set hw1.phat;
		sePHat = sqrt((ph*(1-ph))/n_);
run;

/*output for phat for part d*/
/*sePhat = 0.1880881974*/

/****************************************************************************************************************/

/*(e) Use the Central Limit Theorem to analytically (i.e. no simulation) estimate the chance of getting*/
/*  a sum of 9 when rolling three dice.*/

/*Instead of simulation, I will use the CLT method by utilizing the CDF function*/
data hw1.clt;
	n =3;
	ana = CDF ('normal ' ,9.5 ,n*3.5 , sqrt (n*35/ 12)) - CDF ('normal ' ,8.5 ,n*3.5 , sqrt (n*35/ 12));
run;

/*output for phat for part e*/
/*ana = 0.118177196*/


/****************************************************************************************************************/

/*(f) Repeat parts b) and e) by considering the chance that n = 5 dice leads to a sum of 15.*/
/*   simulate nsim = 10000 rolls of n = 5 dice, computing the sum for each roll.*/

data hw1.DiceRollf;
/*array for n dices */
array dice[5] dice1 dice2 dice3 dice4 dice5;
/*var for the number of dices */
n_ = dim(dice);
/*var for the sum */
retain sum_ 0; 
	do i = 1 to 10000;
		do n = 1 to n_;
			do;
				dice[n] = ceil(ranuni(1) * 6);
				sum_ = sum_ + dice[n];
			end;
		end;
		/*bool to see if the sum was a 9 */
		if(sum_ = 15) then
			is15 = 1;
		else
			is15 = 0;
		;
		output;
		/*reset sum var*/
		sum_ = 0;
		
	end;
	drop n i;
run;


/*proc sort the dataset from part b so the sum of 9 is stacked at the bottom of the dataset;*/
proc sort data = hw1.DiceRollf out =hw1.DiceRollf_ ;
	by is15 ;
run;



/*calcuating phat */
data hw1.phatf;
	set hw1.DiceRollf_;
	by is15;
	f = first.is15;
	l = last.is15;
	retain count 1;

	if(is15 = 1) then
		count = count + 1;
	;
    /*count of the sums of 9 divided by the total # of observations*/
    /*cal sephat*/
	if(is15 = 1 & l = 1) then
		do;
			ph = count / _N_;
		end;
	;
	if ph > 0;
	keep ph n_ ;
run;


/*Instead of simulation, I will use the CLT method by utilizing the CDF function*/
data hw1.cltf;
	n =5;
	ana = CDF ('normal ' ,15.5 ,n*3.5 , sqrt (n*35/ 12)) - CDF ('normal ' ,14.5 ,n*3.5 , sqrt (n*35/ 12));
run;

/****************************************************************************************************************/
