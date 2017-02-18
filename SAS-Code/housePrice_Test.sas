/* Import Data From .csv File */
PROC IMPORT 
            OUT= price 
            DATAFILE= "E:\Stevens\2016 Fall\Multivariate Data Analysis\FinalProject\kc_house_data.csv" 
            DBMS=csv REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
run;

/*** This whole program is used for Linear Regression Analysis ***/

/* Create dummy variable for categorical variables */
data price2;
      set price;
	  ARRAY A {*} bedrooms_1 - bedrooms_33;
      Do i = 1 To 33;
	     A(i) = (bedrooms = i);
	  END;
      
	  if bathrooms = 1 then bathrooms_1 = 1;
	  else bathrooms_1 = 0;
	  if bathrooms = 2.25 then bathrooms_2_25 = 1;
	  else bathrooms_2_25 = 0;
	  if bathrooms = 3 then bathrooms_3 = 1;
	  else bathrooms_3 = 0;
	  if bathrooms = 2 then bathrooms_2 = 1;
	  else bathrooms_2 = 0;
	  if bathrooms = 4.5 then bathrooms_4_5 = 1;
	  else bathrooms_4_5 = 0;
	  if bathrooms = 1.5 then bathrooms_1_5 = 1;
	  else bathrooms_1_5 = 0;
	  if bathrooms = 2.5 then bathrooms_2_5 = 1;
	  else bathrooms_2_5 = 0;
	  if bathrooms = 1.75 then bathrooms_1_75 = 1;
	  else bathrooms_1_75 = 0;
	  if bathrooms = 2.75 then bathrooms_2_75 = 1;
	  else bathrooms_2_75 = 0;
	  if bathrooms = 3.25 then bathrooms_3_25 = 1;
	  else bathrooms_3_25 = 0;
	  if bathrooms = 4 then bathrooms_4 = 1;
	  else bathrooms_4 = 0;
	  if bathrooms = 3.5 then bathrooms_3_5 = 1;
	  else bathrooms_3_5 = 0;
	  if bathrooms = 0.75 then bathrooms_0_75 = 1;
	  else bathrooms_0_75 = 0;
	  if bathrooms = 4.75 then bathrooms_4_75 = 1;
	  else bathrooms_4_75 = 0;
	  if bathrooms = 5 then bathrooms_5 = 1;
	  else bathrooms_5 = 0;
	  if bathrooms = 4.25 then bathrooms_4_25 = 1;
	  else bathrooms_4_25 = 0;
	  if bathrooms = 3.75 then bathrooms_3_75 = 1;
	  else bathrooms_3_75 = 0;
	  if bathrooms = 0 then bathrooms_0 = 1;
	  else bathrooms_0 = 0;
	  if bathrooms = 1.25 then bathrooms_1_25 = 1;
	  else bathrooms_1_25 = 0;
	  if bathrooms = 5.25 then bathrooms_5_25 = 1;
	  else bathrooms_5_25 = 0;
	  if bathrooms = 6 then bathrooms_6 = 1;
	  else bathrooms_6 = 0;
	  if bathrooms = 0.5 then bathrooms_0_5 = 1;
	  else bathrooms_0_5 = 0;
	  if bathrooms = 5.5 then bathrooms_5_5 = 1;
	  else bathrooms_5_5 = 0;
	  if bathrooms = 6.75 then bathrooms_6_75 = 1;
	  else bathrooms_6_75 = 0;
	  if bathrooms = 5.75 then bathrooms_5_75 = 1;
	  else bathrooms_5_75 = 0;
	  if bathrooms = 8 then bathrooms_8 = 1;
	  else bathrooms_8 = 0;
	  if bathrooms = 7.5 then bathrooms_7_5 = 1;
	  else bathrooms_7_5 = 0;
	  if bathrooms = 7.75 then bathrooms_7_75 = 1;
	  else bathrooms_7_75 = 0;
	  if bathrooms = 6.25 then bathrooms_6_25 = 1;
	  else bathrooms_6_25 = 0;
	  if bathrooms = 6.5 then bathrooms_6_5 = 1;
	  else bathrooms_6_5 = 0;

	  ARRAY B {*} view_0 - view_4;
	  Do i = 1 To 5;
	     B(i) = (view = i-1);
	  END;

	  ARRAY C {*} condition_1 - condition_5;
	  Do i = 1 To 5;
	     C(i) = (condition = i);
	  END;

	  ARRAY D {*} grade_1 - grade_13;
	  Do i = 1 To 13;
	     D(i) = (grade = i);
	  END;

	  if yr_built < 1910 then yr_built_1900s = 1;
	  else yr_built_1900s = 0;
	  if 1910 <= yr_built < 1920 then yr_built_1910s = 1;
	  else yr_built_1910s = 0;
      if 1920 <= yr_built < 1930 then yr_built_1920s = 1;
	  else yr_built_1920s = 0;
	  if 1930 <= yr_built < 1940 then yr_built_1930s = 1;
	  else yr_built_1930s = 0;
	  if 1940 <= yr_built < 1950 then yr_built_1940s = 1;
	  else yr_built_1940s = 0;
      if 1950 <= yr_built < 1960 then yr_built_1950s = 1;
	  else yr_built_1950s = 0;
      if 1960 <= yr_built < 1970 then yr_built_1960s = 1;
	  else yr_built_1960s = 0;
	  if 1970 <= yr_built < 1970 then yr_built_1970s = 1;
	  else yr_built_1970s = 0;
      if 1980 <= yr_built < 1980 then yr_built_1980s = 1;
	  else yr_built_1980s = 0;
	  if 1990 <= yr_built < 2000 then yr_built_1990s = 1;
	  else yr_built_1990s = 0;
	  if 2000 <= yr_built < 2005 then yr_built_00_05 = 1;
	  else yr_built_00_05 = 0;
	  if 2005 <= yr_built < 2010 then yr_built_05_10 = 1;
	  else yr_built_05_10 = 0;
	  if 2010 <= yr_built <= 2015 then yr_built_10_15 = 1;
	  else yr_built_10_15 = 0;

	  ARRAY F {*} zipcode_98001 - zipcode_98199;
	  Do i = 1 To 199;
	     F(i) = (zipcode = i+98000);
	  END;
      
	  if bedrooms = 33 then bedrooms2 = 3;
	  else bedrooms2 = bedrooms;
	  bedrooms_sqrt = bedrooms2 ** 3;

	  numeric_zipcode = input(zipcode, BEST32.);
	 numeric_floors  = input(floors, BEST32.);
run;

proc surveyselect data=price2 samprate=0.80 seed=123 outall out = sample 
           method=srs noprint;
        run;
data price2_training price2_testing;
     set sample;
	 if selected = 0 then output price2_testing;
	 else output price2_training;
run;

/* All variables together */
proc reg data = price2_training plots(maxpoints=none) outest = coef_all_linear;
     model price = bedrooms bathrooms zipcode_98103 zipcode_98038 zipcode_98115 zipcode_98052 zipcode_98117 zipcode_98042 zipcode_98034 zipcode_98118 
	               zipcode_98023 zipcode_98006 yr_built_1900s yr_built_1910s yr_built_1920s yr_built_1930s yr_built_1940s yr_built_1950s yr_built_1960s yr_built_1970s yr_built_1980s
	               yr_built_1990s yr_built_00_05 yr_built_05_10 yr_built_10_15 view_0 view_1 view_2 view_3 view_4 condition_1 condition_2 condition_3 condition_4 condition_5
             grade_1 grade_2 grade_3 grade_4 grade_5 grade_6 grade_7 grade_8 grade_9 grade_10 grade_11 grade_12 grade_13 
			 sqft_living sqft_lot sqft_above sqft_basement sqft_living15 sqft_lot15 /STB vif selection = stepwise;
quit;

proc reg data = price2_training;
     model price = sqft_living view_4 grade_11 grade_12 grade_10 grade_13 grade_9 view_0 yr_built_1920s zipcode_98023 yr_built_1900s
                   grade_8 yr_built_1990s yr_built_1910s zipcode_98042 condition_3 zipcode_98115 zipcode_98038 grade_7 yr_built_1940s
                   yr_built_1930s yr_built_1950s bathrooms zipcode_98103 yr_built_1960s bedrooms sqft_living15 zipcode_98117 sqft_lot15
                   zipcode_98052 view_2 zipcode_98034 condition_5 yr_built_00_05 zipcode_98118 grade_6 condition_4 zipcode_98006 yr_built_05_10
                   sqft_above; 
quit;

data price2_testing_sl;
     set price2_testing;
	 price_pridict = -23649 + 134.11260 * sqft_living + 362410 * view_4 + 768996 * grade_11 + 1262676 * grade_12 + 514015 * grade_10
                   + 2450799 * grade_13 + 329746 * grade_9 - 99353 * view_0 + 202096 * yr_built_1920s - 176209 * zipcode_98023
                   + 236914 * yr_built_1900s + 207289 * grade_8 - 72319 * yr_built_1990s + 206833 * yr_built_1910s - 117997 * zipcode_98042
                   - 16684 * condition_3 + 88419 * zipcode_98115 - 87354 * zipcode_98038 + 126123 * grade_7 + 150753 * yr_built_1940s
                   + 169157 * yr_built_1930s + 115138 * yr_built_1950s + 56850 * bathrooms + 87636 * zipcode_98103 + 49774 * yr_built_1960s
                   - 25999 * bedrooms + 33.53755 * sqft_living15 + 71694 * zipcode_98117 - 0.37774 * sqft_lot15 + 63327 * zipcode_98052
                   - 47852 * view_2 + 50009 * zipcode_98034 + 78265 * condition_5 - 28657 * yr_built_00_05 - 45997 * zipcode_98118
                   + 50279 * grade_6 + 44253 * condition_4 + 17042 * zipcode_98006 - 7081.12864 * yr_built_05_10 - 3.31758 * sqft_above;
run;

data price2_testing_sl;
     set price2_testing_sl;
     MSE = (((price_pridict - price) ** 2)/ 4322)  ;
run;

proc means data = price2_testing_sl sum;
     var MSE;
	 output out = sum_MSE (drop=_:) sum = ;
run;

data sum_MSE;
     set sum_MSE;
	 RMSE = MSE ** 0.5;
run;


data price2_testing_sl;
     set price2_testing;
	 price_pridict = -82807 + 313.55594 * sqft_living;
run;

data price2_testing_sl;
     set price2_testing_sl;
     MSE = (((price_pridict - price) ** 2)/ 4322)  ;
run;

proc means data = price2_testing_sl sum;
     var MSE;
	 output out = sum_MSE (drop=_:) sum = ;
run;

data sum_MSE;
     set sum_MSE;
	 RMSE = MSE ** 0.5;
run;
