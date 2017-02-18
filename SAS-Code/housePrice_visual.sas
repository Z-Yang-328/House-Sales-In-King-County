/* Import Data From .csv File */
PROC IMPORT 
            OUT= price 
            DATAFILE= "E:\Stevens\2016 Fall\Multivariate Data Analysis\FinalProject\kc_house_data.csv" 
            DBMS=csv REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
run;

/*** This program is used for data visulization ***/
/* Data Understanding */
/* Mean of Price */
proc summary data = price nway;
      var price;
	 
run;

data price;
      set price;
	  year_month = substr(date, 1, 6); 
run;

proc means data = price mean sum median;
     class year_month;
	 var price;
	 output out = mean_price_by_month (drop=_:) mean = ; 
     output out = sum_price_by_month (drop=_:) sum = ;
     output out = meadian_price_by_month (drop=_:) median= ;
run;

title "Mean of price by month";
proc sgplot data = mean_price_by_month;
     series X = year_month Y = price /markers;
run;

title "Sum of price by month";
proc sgplot data = sum_price_by_month;
     series X = year_month Y = price /markers;
run;

title "Median of price by month";
proc sgplot data = meadian_price_by_month;
     series X = year_month Y = price /markers;
run;

proc means data = price mean sum median;
     class zipcode;
	 var price;
	 output out = mean_price_by_zipcode (drop=_:) mean = ;
	 output out = sum_price_by_zipcode (drop=_:) sum = ;
	 output out = median_price_by_zipcode (drop=_:) median = ;
run;

title "Mean of price by zipcode";
proc sgplot data = mean_price_by_zipcode;
     series X = zipcode Y = price /markers;
run;

data price;
     set price;
	 if yr_built < 1910 then yr_built_decades = 1900;
     else if yr_built < 1920 then yr_built_decades = 1910;
     else if yr_built < 1930 then yr_built_decades = 1920;
     else if yr_built < 1940 then yr_built_decades = 1930;
     else if yr_built < 1950 then yr_built_decades = 1940;
     else if yr_built < 1960 then yr_built_decades = 1950;
     else if yr_built < 1970 then yr_built_decades = 1960;
     else if yr_built < 1980 then yr_built_decades = 1970;
     else if yr_built < 1990 then yr_built_decades = 1980; 
	 else if yr_built < 2000 then yr_built_decades = 1990;
	 else if yr_built < 2010 then yr_built_decades = 2000;
	 else if yr_built < 2020 then yr_built_decades = 2010;
run;

proc means data = price mean sum median;
     class yr_built_decades;
	 var price;
	 output out = mean_price_by_decades (drop=_:) mean = ;
	 output out = sum_price_by_decades (drop=_:) sum = ;
	 output out = median_price_by_decades (drop=_:) median = ;
run;
title "Mean of price by built year";
proc sgplot data = mean_price_by_decades;
     series X = yr_built_decades Y = price /markers;
run;



