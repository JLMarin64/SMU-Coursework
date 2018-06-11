proc import datafile="/home/jturner1/Unit5/MeaslesVaccine.csv"
          dbms=dlm out=meas replace;
     delimeter=',';
     getnames=yes;
     
run;
/*
proc print data=meas;
run;*/


*To predict into the future, we are going to add 5 additional data points
with missing observations to predict into the future;

data extra;
input  VAR1 $	Year	Cases	Vaccine $;
datalines;
60 2009 . yes
61 2010 . yes
62 2011 . yes
63 2012 . yes
;
run;

/*proc print data=extra;
run;*/


proc append base=meas data=extra force;
run;
/*
proc print data=meas;
run;*/

data meas;
set meas;
if Vaccine='yes' then VacNum=1;
if Vaccine='no' then VacNum=0;
run;


*Analysis Question 1
Examine the autocorrelation and partial autocorellation plots
of the raw time series.  Does this support evidence of a 
stationary time series? ;

proc autoreg data=meas all plots(unpack);
   model cases =  / method=yw;
   output out=p p=yhat  pm=ytrend
                lcl=lcl ucl=ucl;
run;


*Analysis Question 2
Using proc auto reg, build a Ordinary regression model that could be used to test
if a change in the mean of measles cases using 1963 as a cut off.  Examine the ACF
and PACF with this regression model. (Note it may be helpful to use the noint option)  Does the ACF and PACF support the assumption of a
stationary time series now?  What is the time series we are actualy making a comment on now, 
is it the original time series or something else?  ;


proc autoreg data=meas all plots(unpack);
   model cases = VacNum / dw=1 dwprob method=yw;
   output out=p p=yhat  pm=ytrend
                lcl=lcl ucl=ucl;
run;

*Analysis Question 3
Use your rule of thumbs and the previous ACF and PACF plot to propose a candidate
model to account for any correlation that exists. Also add the options dw=1 and dwprob
to the model statement of your previous code.  What does the Durbin Watson test tell us about
the time series of the current model?  Is the conclusion consistent with what is going on 
in the ACF and PACF plots?; 


*Analysis Question 4
Based on your decision of how to handle any serial correlation present in your regression model,
run that model and provide diagnostic evidence that you have accounted for the serial correlation
present. Not all the residual diagnostics are given in proc auto reg, but given the ones that are
there, is there any other concerns on the assumptions before moving on to hypothesis testing?;
*Reardless of any concerns, what would be the conclusion of the test; 

proc autoreg data=meas all plots(unpack);
   class vaccine;
   model cases = VacNum /nlag=1 dw=1 dwprob method=yw;
   output out=p p=yhat  pm=ytrend
                lcl=lcl ucl=ucl;
run;

data p;
set p;
resids=Cases-yhat;
run;

/*
proc print data=p;
run;
*/

proc sgplot data=p;
scatter x=yhat y=resids;
run;





*Analysis question 5.  A potential fix to residual assumption in the previous model
could be dealt with using a log transformation.  Reexplore the analysis using the log
transformed values of the measels cases.  Make changes to the model as needed to help 
answer the original question.


*Reruning on log scale, creates something interesting.  We can see here that a simple
change in mean may not be the best fit, we may actually be able to model that with a slope
using an interaction term.  It makes sense that the measles wouldn't go away overnight, but
but gradually.;
data meas;
set meas;
lCases=log(Cases);
run;

*Model without dealing with serial residuals but accounting for the trend;
proc autoreg data=meas all plots(unpack);
   class vaccine;
   model lCases = VacNum Year VacNum*Year / dw=1 dwprob  method=yw;
   output out=p p=yhat  pm=ytrend
                lcl=lcl ucl=ucl;
run;


*Residuals Look Good now;
data p;
set p;
resids=lCases-yhat;
run;

/*
proc print data=p;
run;*/

proc sgplot data=p;
scatter x=yhat y=resids;
run;


*Finishing modeling the serial correlation;

proc autoreg data=meas all plots(unpack);
   class vaccine;
   model lCases = VacNum Year VacNum*Year /nlag=1 dw=6 dwprob noint  method=yw;
   output out=p p=yhat  pm=ytrend
                lcl=lcl ucl=ucl;
run;

*Using the slope parameter for the "yes" group we can test is the mean is decreasing
since the vaccine came into effect.  At some point it probably will flatten out and we will
have to update the model to reflect this.


