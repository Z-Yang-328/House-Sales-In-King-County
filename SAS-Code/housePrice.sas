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
	 

	 
/* Show dummy variable of bedrooms */
proc FREQ data = price2_training;
     Tables bedrooms*bedrooms_1*bedrooms_2*bedrooms_3*bedrooms_4*bedrooms_5*bedrooms_6*bedrooms_7*bedrooms_8*bedrooms_9*bedrooms_10
	        *bedrooms_11*bedrooms_33/list;
run;
/* Show dummy variable of bathrooms */
proc FREQ data = price2_training;
     Tables bathrooms*bathrooms_1*bathrooms_2_25*bathrooms_3*bathrooms_2*bathrooms_4_5*bathrooms_1_5*bathrooms_2_5*bathrooms_1_75*bathrooms_2_75
            *bathrooms_3_25*bathrooms_4*bathrooms_3_5*bathrooms_0_75*bathrooms_4_75*bathrooms_5*bathrooms_4_25*bathrooms_3_75*bathrooms_0*bathrooms_1_25
			*bathrooms_5_25*bathrooms_6*bathrooms_0_5*bathrooms_5_5*bathrooms_6_75*bathrooms_5_75*bathrooms_8*bathrooms_7_5*bathrooms_7_75*bathrooms_6_25
            *bathrooms_6_5/list;
run;
/* Show dummy variable of view */
proc FREQ data = price2_training;
     Tables view*view_0*view_1*view_2*view_3*view_4/list;
run;

/* Show dummy variable of condition */
proc FREQ data = price2_training;
     Tables condition*condition_1*condition_2*condition_3*condition_4*condition_5/list;
run;

/* Show dummy variable of grade */
proc FREQ data = price2_training;
     Tables grade*grade_1*grade_2*grade_3*grade_4*grade_5*grade_6*grade_7*grade_8*grade_9*grade_10*grade_11*grade_12*grade_13/list;
run;

/* Show dummy variable of yr_built */
proc FREQ data = price2_training;
     Tables yr_built*yr_built_1900s*yr_built_1910s*yr_built_1920s*yr_built_1930s*yr_built_1940s*yr_built_1950s*yr_built_1960s*yr_built_1970s*yr_built_1980s
	        *yr_built_1990s*yr_built_00_05*yr_built_05_10*yr_built_10_15/list;
run;

/* Show dummy variable of zipocd */
proc FREQ data = price2_training;
     Tables zipcode*zipcode_98178*zipcode_98125*zipcode_98028*zipcode_98136*zipcode_98074*zipcode_98053*zipcode_98003*zipcode_98198*zipcode_98146
	        *zipcode_98038*zipcode_98007*zipcode_98115*zipcode_98107*zipcode_98126*zipcode_98019*zipcode_98103*zipcode_98002*zipcode_98133*zipcode_98040
			*zipcode_98092*zipcode_98030*zipcode_98119*zipcode_98112*zipcode_98052*zipcode_98027*zipcode_98117*zipcode_98058*zipcode_98001*zipcode_98056
			*zipcode_98166*zipcode_98023*zipcode_98070*zipcode_98148/list out = tmp1;

     Tables zipcode*zipcode_98105*zipcode_98042*zipcode_98008*zipcode_98059*zipcode_98122*zipcode_98144
			*zipcode_98004*zipcode_98005*zipcode_98034*zipcode_98075*zipcode_98116*zipcode_98010*zipcode_98118*zipcode_98199*zipcode_98032*zipcode_98045
			*zipcode_98102*zipcode_98077*zipcode_98108*zipcode_98168*zipcode_98177*zipcode_98065*zipcode_98029*zipcode_98006*zipcode_98109*zipcode_98022
			*zipcode_98033*zipcode_98155*zipcode_98024*zipcode_98011*zipcode_98031*zipcode_98106*zipcode_98072*zipcode_98188*zipcode_98014*zipcode_98055
			*zipcode_98039/list out = tmp2;
run;

proc FREQ data = price2_training;
     Tables zipcode*zipcode_98105*zipcode_98042*zipcode_98008*zipcode_98059*zipcode_98122*zipcode_98144
			*zipcode_98004*zipcode_98005*zipcode_98034*zipcode_98075*zipcode_98116*zipcode_98010*zipcode_98118*zipcode_98199*zipcode_98032*zipcode_98045
			*zipcode_98102*zipcode_98077*zipcode_98108*zipcode_98168*zipcode_98177*zipcode_98065*zipcode_98029*zipcode_98006*zipcode_98109*zipcode_98022
			*zipcode_98033*zipcode_98155*zipcode_98024*zipcode_98011*zipcode_98031*zipcode_98106*zipcode_98072*zipcode_98188*zipcode_98014*zipcode_98055
			*zipcode_98039/list out = tmp2;
run;

proc sort data = tmp2;
     by descending count;
run;

/* Simple Linear Regressions */
title "Simple Linear Regression for variable bedrooms";
proc reg data = price2_training PLOTS(MAXPOINTS = none);
     model price = bedrooms_1 bedrooms_2 bedrooms_3 bedrooms_4 bedrooms_5 bedrooms_6 bedrooms_7 bedrooms_8 bedrooms_9 bedrooms_10
	         bedrooms_11 bedrooms_33 / STB;
quit;

proc reg data = price2_training plots(maxpoints = none);
     model price = bedrooms /STB;
quit;

title "Simple Linear Regression for variable bedrooms_sqrt";
proc reg data = price2_training plots(maxpoints = none);
     model price = bedrooms_sqrt;
quit;

title "Simple Linear Regression for variable bathrooms";
proc reg data = price2_training plots(maxpoints = none);
     model price = bathrooms_1 bathrooms_2_25 bathrooms_3 bathrooms_2 bathrooms_4_5 bathrooms_1_5 bathrooms_2_5 bathrooms_1_75 bathrooms_2_75
             bathrooms_3_25 bathrooms_4 bathrooms_3_5 bathrooms_0_75 bathrooms_4_75 bathrooms_5 bathrooms_4_25 bathrooms_3_75 bathrooms_0 bathrooms_1_25
			 bathrooms_5_25 bathrooms_6 bathrooms_0_5 bathrooms_5_5 bathrooms_6_75 bathrooms_5_75 bathrooms_8 bathrooms_7_5 bathrooms_7_75 bathrooms_6_25
             bathrooms_6_5;
quit;

title "Simple Linear Regression for variable bathrooms";
proc reg data = price2_training plots(maxpoints = none);
     model price = bathrooms / STB;
quit;


title "Simple Linear Regression for variable sqft_living";
proc reg data = price2_training plots(maxpoints = none);
     model price = sqft_living / STB;
quit;

title "Simple Linear Regression for variable sqft_lot";
proc reg data = price2_training plots(maxpoints = none);
     model price = sqft_lot /STB;
quit;

title "Simple Linear Regression for variable waterfront";
proc reg data = price2_training plots(maxpoints = none);
     model price = waterfront /STB;
quit;

title "Simple Linear Regression for variable view";
proc reg data = price2_training plots(maxpoints = none);
     model price = view_0 view_1 view_2 view_3 view_4 / STB;
quit;

title "Simple Linear Regression for variable view";
proc reg data = price2_training plots(maxpoints = none);
     model price = view_0 /STB;
quit;

title "Simple Linear Regression for variable condition";
proc reg data = price2_training plots(maxpoints = none);
     model price = condition_1 condition_2 condition_3 condition_4 condition_5;
quit;

title "Simple Linear Regression for variable condition";
proc reg data = price2_training plots(maxpoints = none);
     model price = condition_1;
quit;

title "Simple Linear Regression for variable grade";
proc reg data = price2_training plots(maxpoints = none);
     model price = grade_1 grade_2 grade_3 grade_4 grade_5 grade_6 grade_7 grade_8 grade_9 grade_10 grade_11 grade_12 grade_13;
quit;

title "Simple Linear Regression for variable grade";
proc reg data = price2_training plots(maxpoints = none);
     model price = grade_11 /STB;
quit;

title "Simple Linear Regression for variable sqft_above";
proc reg data = price2_training plots(maxpoints = none);
     model price = sqft_above /STB;
quit;

title "Simple Linear Regression for variable sqrt_basement";
proc reg data = price2_training plots(maxpoints = none);
     model price = sqft_basement /STB;
quit;

title "Simple Linear Regression for variable sqrt_living15";
proc reg data = price2_training plots(maxpoints = none);
     model price = sqft_living15 /STB;
quit;

title "Simple Linear Regression for variable sqrt_lot15";
proc reg data = price2_training plots(maxpoints = none);
     model price = sqft_lot15 /STB;
quit;

title "Simple Linear Regression for variable yr_built";
proc reg data = price2_training plots(maxpoints = none);
     model price = yr_built_1900s yr_built_1910s yr_built_1920s yr_built_1930s yr_built_1940s yr_built_1950s yr_built_1960s yr_built_1970s yr_built_1980s
	        yr_built_1990s yr_built_00_05 yr_built_05_10 yr_built_10_15;
quit;

title "Simple Linear Regression for variable zipcode";
proc reg data = price2_training plots(maxpoints = none);
     model price = zipcode_98178 zipcode_98125 zipcode_98028 zipcode_98136 zipcode_98074 zipcode_98053 zipcode_98003 zipcode_98198 zipcode_98146
	         zipcode_98038 zipcode_98007 zipcode_98115 zipcode_98107 zipcode_98126 zipcode_98019 zipcode_98103 zipcode_98002 zipcode_98133 zipcode_98040
			 zipcode_98092 zipcode_98030 zipcode_98119 zipcode_98112 zipcode_98052 zipcode_98027 zipcode_98117 zipcode_98058 zipcode_98001 zipcode_98056
			 zipcode_98166 zipcode_98023 zipcode_98070 zipcode_98148 zipcode_98105 zipcode_98042 zipcode_98008 zipcode_98059 zipcode_98122 zipcode_98144
			 zipcode_98004 zipcode_98005 zipcode_98034 zipcode_98075 zipcode_98116 zipcode_98010 zipcode_98118 zipcode_98199 zipcode_98032 zipcode_98045
			 zipcode_98102 zipcode_98077 zipcode_98108 zipcode_98168 zipcode_98177 zipcode_98065 zipcode_98029 zipcode_98006 zipcode_98109 zipcode_98022
			 zipcode_98033 zipcode_98155 zipcode_98024 zipcode_98011 zipcode_98031 zipcode_98106 zipcode_98072 zipcode_98188 zipcode_98014 zipcode_98055
			 zipcode_98039;
quit;

title "Simple Linear Regression for variable zipcode";
proc reg data = price2_training plots(maxpoints = none);
     model price = zipcode_98103 zipcode_98038 zipcode_98115 zipcode_98052 zipcode_98117 zipcode_98042 zipcode_98034 zipcode_98118 
	               zipcode_98023 zipcode_98006;
quit;

proc reg data = price2_training plots(maxpoints = none);
     model price = numeric_zipcode;
quit;

proc surveyreg data = price2_training;
     class  floors;
	 model price = floors/ STB solution;
run;

/* Multivariate Linear Regression */
/* Non-categorical variables only */
proc reg data = price2_training plots(maxpoints=none);
     model price = sqft_living sqft_lot sqft_above sqft_basement sqft_living15 sqft_lot15;
quit;

/* Categorical variables only */
proc reg data = price2_training plots(maxpoints=none);
     model price =  bedrooms_1 bedrooms_2 bedrooms_3 bedrooms_4 bedrooms_5 bedrooms_6 bedrooms_7 bedrooms_8 bedrooms_9 bedrooms_10
	         bedrooms_11 bedrooms_33 bathrooms_1 bathrooms_2_25 bathrooms_3 bathrooms_2 bathrooms_4_5 bathrooms_1_5 bathrooms_2_5 bathrooms_1_75 bathrooms_2_75
             bathrooms_3_25 bathrooms_4 bathrooms_3_5 bathrooms_0_75 bathrooms_4_75 bathrooms_5 bathrooms_4_25 bathrooms_3_75 bathrooms_0 bathrooms_1_25
			 bathrooms_5_25 bathrooms_6 bathrooms_0_5 bathrooms_5_5 bathrooms_6_75 bathrooms_5_75 bathrooms_8 bathrooms_7_5 bathrooms_7_75 bathrooms_6_25
             bathrooms_6_5 zipcode_98178 zipcode_98125 zipcode_98028 zipcode_98136 zipcode_98074 zipcode_98053 zipcode_98003 zipcode_98198 zipcode_98146
	         zipcode_98038 zipcode_98007 zipcode_98115 zipcode_98107 zipcode_98126 zipcode_98019 zipcode_98103 zipcode_98002 zipcode_98133 zipcode_98040
			 zipcode_98092 zipcode_98030 zipcode_98119 zipcode_98112 zipcode_98052 zipcode_98027 zipcode_98117 zipcode_98058 zipcode_98001 zipcode_98056
			 zipcode_98166 zipcode_98023 zipcode_98070 zipcode_98148 zipcode_98105 zipcode_98042 zipcode_98008 zipcode_98059 zipcode_98122 zipcode_98144
			 zipcode_98004 zipcode_98005 zipcode_98034 zipcode_98075 zipcode_98116 zipcode_98010 zipcode_98118 zipcode_98199 zipcode_98032 zipcode_98045
			 zipcode_98102 zipcode_98077 zipcode_98108 zipcode_98168 zipcode_98177 zipcode_98065 zipcode_98029 zipcode_98006 zipcode_98109 zipcode_98022
			 zipcode_98033 zipcode_98155 zipcode_98024 zipcode_98011 zipcode_98031 zipcode_98106 zipcode_98072 zipcode_98188 zipcode_98014 zipcode_98055
			 zipcode_98039 yr_built_1900s yr_built_1910s yr_built_1920s yr_built_1930s yr_built_1940s yr_built_1950s yr_built_1960s yr_built_1970s yr_built_1980s
	         yr_built_1990s yr_built_00_05 yr_built_05_10 yr_built_10_15 waterfront view_0 view_1 view_2 view_3 view_4 condition_1 condition_2 condition_3 condition_4 condition_5
             grade_1 grade_2 grade_3 grade_4 grade_5 grade_6 grade_7 grade_8 grade_9 grade_10 grade_11 grade_12 grade_13;
quit;

/* All variables together */
proc reg data = price2_training plots(maxpoints=none);
     model price =  bedrooms_1 bedrooms_2 bedrooms_3 bedrooms_4 bedrooms_5 bedrooms_6 bedrooms_7 bedrooms_8 bedrooms_9 bedrooms_10
	         bedrooms_11 bedrooms_33 bathrooms_1 bathrooms_2_25 bathrooms_3 bathrooms_2 bathrooms_4_5 bathrooms_1_5 bathrooms_2_5 bathrooms_1_75 bathrooms_2_75
             bathrooms_3_25 bathrooms_4 bathrooms_3_5 bathrooms_0_75 bathrooms_4_75 bathrooms_5 bathrooms_4_25 bathrooms_3_75 bathrooms_0 bathrooms_1_25
			 bathrooms_5_25 bathrooms_6 bathrooms_0_5 bathrooms_5_5 bathrooms_6_75 bathrooms_5_75 bathrooms_8 bathrooms_7_5 bathrooms_7_75 bathrooms_6_25
             bathrooms_6_5 zipcode_98178 zipcode_98125 zipcode_98028 zipcode_98136 zipcode_98074 zipcode_98053 zipcode_98003 zipcode_98198 zipcode_98146
	         zipcode_98038 zipcode_98007 zipcode_98115 zipcode_98107 zipcode_98126 zipcode_98019 zipcode_98103 zipcode_98002 zipcode_98133 zipcode_98040
			 zipcode_98092 zipcode_98030 zipcode_98119 zipcode_98112 zipcode_98052 zipcode_98027 zipcode_98117 zipcode_98058 zipcode_98001 zipcode_98056
			 zipcode_98166 zipcode_98023 zipcode_98070 zipcode_98148 zipcode_98105 zipcode_98042 zipcode_98008 zipcode_98059 zipcode_98122 zipcode_98144
			 zipcode_98004 zipcode_98005 zipcode_98034 zipcode_98075 zipcode_98116 zipcode_98010 zipcode_98118 zipcode_98199 zipcode_98032 zipcode_98045
			 zipcode_98102 zipcode_98077 zipcode_98108 zipcode_98168 zipcode_98177 zipcode_98065 zipcode_98029 zipcode_98006 zipcode_98109 zipcode_98022
			 zipcode_98033 zipcode_98155 zipcode_98024 zipcode_98011 zipcode_98031 zipcode_98106 zipcode_98072 zipcode_98188 zipcode_98014 zipcode_98055
			 zipcode_98039 yr_built_1900s yr_built_1910s yr_built_1920s yr_built_1930s yr_built_1940s yr_built_1950s yr_built_1960s yr_built_1970s yr_built_1980s
	         yr_built_1990s yr_built_00_05 yr_built_05_10 yr_built_10_15 waterfront view_0 view_1 view_2 view_3 view_4 condition_1 condition_2 condition_3 condition_4 condition_5
             grade_1 grade_2 grade_3 grade_4 grade_5 grade_6 grade_7 grade_8 grade_9 grade_10 grade_11 grade_12 grade_13 
			 sqft_living sqft_lot sqft_above sqft_basement sqft_living15 sqft_lot15 /vif selection = stepwise;
quit;

/* All variables together */
proc reg data = price2_training plots(maxpoints=none) outest = coef_all_linear;
     model price = bedrooms bathrooms zipcode_98103 zipcode_98038 zipcode_98115 zipcode_98052 zipcode_98117 zipcode_98042 zipcode_98034 zipcode_98118 
	               zipcode_98023 zipcode_98006 yr_built_1900s yr_built_1910s yr_built_1920s yr_built_1930s yr_built_1940s yr_built_1950s yr_built_1960s yr_built_1970s yr_built_1980s
	               yr_built_1990s yr_built_00_05 yr_built_05_10 yr_built_10_15 view_0 view_1 view_2 view_3 view_4 condition_1 condition_2 condition_3 condition_4 condition_5
             grade_1 grade_2 grade_3 grade_4 grade_5 grade_6 grade_7 grade_8 grade_9 grade_10 grade_11 grade_12 grade_13 
			 sqft_living sqft_lot sqft_above sqft_basement sqft_living15 sqft_lot15 /STB vif selection = stepwise;
quit;
/* Final Answer */
proc reg data = price2 plots(maxpoints=none);
     model price = sqft_living view_4 grade_11 grade_10 grade_12 grade_13  view_0 yr_built_1920s zipcode_98023 yr_built_1900s
	               yr_built_1990s yr_built_1910s zipcode_98042 zipcode_98115 zipcode_98038 grade_7 yr_built_1940s
				   yr_built_1930s yr_built_1950s bathrooms zipcode_98103 yr_built_1960s bedrooms sqft_living15 zipcode_98117 sqft_lot15
				   zipcode_98034 condition_5 yr_built_00_05 zipcode_98118 grade_6 condition_4 /STB vif;
quit;

proc surveyreg data = price2_training;
     class  grade view condition;
	 model price = bedrooms bathrooms zipcode_98103 zipcode_98038 zipcode_98115 zipcode_98052 zipcode_98117 zipcode_98042 zipcode_98034 zipcode_98118 
	               zipcode_98023 zipcode_98006 yr_built_1900s yr_built_1910s yr_built_1920s yr_built_1930s yr_built_1940s yr_built_1950s yr_built_1960s yr_built_1970s yr_built_1980s
	               yr_built_1990s yr_built_00_05 yr_built_05_10 yr_built_10_15 view condition 
                   sqft_living sqft_lot sqft_above sqft_basement sqft_living15 sqft_lot15/ STB solution;
run;

data price2_testing;
     set price2_testing;
	 price_pridict = 6570.6018035 - 23356.84752 * bedrooms + 55691.397 * bathrooms + 95145.485683 * zipcode_98103 + 93043.287344 * zipcode_98115
	                + 60136.169068 * zipcode_98052 + 75199.968228 * zipcode_98117 - 119346.5893 * zipcode_98042 + 50986.038604 * zipcode_98034 - 44888.1629 * zipcode_98188
					- 174721.2209 * zipcode_98023 + 16434.190961 * zipcode_98006 + 233572.88104 * yr_built_1900s + 203420.03534 * yr_built_1910s + 203420.03534 * yr_built_1920s
					+ 168261.50104 * yr_built_1940s + 109920.86901 * yr_built_1950s + 49665.261295 * yr_built_1960s - 67766.68291 * yr_built_1990s - 32848.68079 * yr_built_00_05
					- 8948.697301 * yr_built_05_10 - 116542.6199 * view_0 - 61270.3478 * view_2 + 349956.55836 * view_4 + 27050.292131 * condition_4 + 58372.716264 * condition_5
					+ 55527.607039 * grade_6 + 128593.01096 * grade_7 + 208329.4493 * grade_8 + 332326.93468 * grade_9 + 512158.81771 * grade_10 + 773950.0575 * grade_11
					+ 1231728.013 * grade_12 + 2391989.2333 * grade_13 + 127.65308884 * sqft_living + 35.442961351 * sqft_living15 - 0.37890233 * sqft_lot;
run;

data try;
     set price2_testing;
	 price_pridict = -10806.39866 -25793.12803 * bedrooms + 56449.123264 * bathrooms + 87002.914147 * zipcode_98103 + 88772.275367 * zipcode_98115+ 63659.97693* zipcode_98052 + 71986.322114 * zipcode_98117 
                     -118304.398 * zipcode_98042 + 50842.02082 * zipcode_98034 - 46021.87543 * zipcode_98118 - 175510.0667 * zipcode_98023 + 17921.453331 * zipcode_98006 + 238271.79062 * yr_built_1900s 
                     +208186.12512 * yr_built_1910s + 203593.97085 * yr_built_1920s + 170657.95457 *  yr_built_1930s + 152363.53562 * yr_built_1940s + 116584.25055 * yr_built_1950s + 51209.776765 * yr_built_1960s 
                     -70694.97037 * yr_built_1990s - -27010.23442 * yr_built_00_05 - 100532.0225 * view_0 - 48240.64509 * view_2 + 362612.35992 * view_4 + 28847.517068 * condition_4 + 63025.276068 * condition_5 
                     +51519.636439 * grade_6 + 127823.65627 * grade_7 + 208473.19506 * grade_8 + 330031.29218 * grade_9 + 513718.58853 * grade_10 + 767850.83044 * grade_11
					 +1260576.2328 * grade_12 + 2447980.6583 * grade_13 + 132.17309842 * sqft_living + 33.434898316 * sqft_living15 - 0.378721304 * sqft_lot;
run;

proc contents data = try;
run;

data try_comp;
     set price2_testing;
	 if abs(price_pridict - price) > (0.20 * price) then result = 0;
	 else result = 1;
run;

data try_comp;
     set try_comp;
     Mser = (price_pridict - price) ** 2;
run;

proc means data = try_comp sum;
     var Mser;
run;
