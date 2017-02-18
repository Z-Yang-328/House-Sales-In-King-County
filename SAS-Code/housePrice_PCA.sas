/* Import Data From .csv File */
PROC IMPORT 
            OUT= price 
            DATAFILE= "E:\Stevens\2016 Fall\Multivariate Data Analysis\FinalProject\kc_house_data.csv" 
            DBMS=csv REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
run;

proc princomp data = price out = pca_price;
     var sqft_living sqft_lot sqft_above sqft_basement sqft_living15 sqft_lot15 bedrooms bathrooms
	                    waterfront view condition grade yr_built;
quit;

data price4 ;
     set price;
     zipcoden = input(zipcode, BEST32.);
	 floorsn = input(floors, BEST32.);
run;

proc princomp data = price4;
     var sqft_living sqft_lot sqft_above sqft_basement sqft_living15 sqft_lot15 bedrooms bathrooms
	                    waterfront view condition grade yr_built zipcoden floorsn;
quit;

proc contents data = price;
quit;

/* Train test split */
proc surveyselect data=price samprate=0.80 seed=123 outall out = sample 
           method=srs noprint;
        run;
data price_training price_testing;
     set sample;
	 if selected = 0 then output price_testing;
	 else output price_training;
run;

