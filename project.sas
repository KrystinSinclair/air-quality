/*Project BioStats*/

/*Used Import Wizard to Import CSV and name it epa_aqi*/


data aqi;
set epa_aqi;
if days_with_aqi >365/2 then  measurement_taken  =1 ; /*We are converting this into a binary variable to understand how many days sites had measurements*/
else measurement_taken = 0;
keep state county  Median_AQI Days_Ozone measurement_taken ;
run;


/*We want to see summary statistics for our categorical feature*/
proc freq data=aqi;
table measurement_taken;
run;


/*We want summary stats for our continuous variables*/
proc means data=aqi;
var median_aqi days_ozone;
run;

/*We will view correlation of two continuous variables*/
proc corr data=aqi;
var median_aqi days_ozone;
run;


/*We use the t test to understand how the response variable differs by group*/
proc ttest data=aqi sides=2 alpha=.05;
class measurement_taken;
var median_aqi;
title"two sample t-test, two sided";
run;


/* Multiple Linear Model, With Categorical Predictor */
proc glm data=aqi plots=residuals;
class measurement_taken;
model Median_AQI=Days_ozone measurement_taken /solution;
title "Multipe Linear Regression Model  With Residual Plot";
run;
