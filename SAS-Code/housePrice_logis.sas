/* Import Data From .csv File */
PROC IMPORT 
            OUT= price 
            DATAFILE= "E:\Stevens\2016 Fall\Multivariate Data Analysis\FinalProject\kc_house_data.csv" 
            DBMS=csv REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
run;

data price3;
     set price;

	 if price < 300000 then price_cate = 0;
	 else if price < 600000 then price_cate = 1;
	 else price_cate = 2;

	 if sqft_living < 1560 then sqft_living_cate = 0;
	 else if sqft_living < 2250 then sqft_living_cate = 1;
	 else sqft_living_cate = 2;

	 if sqft_lot < 5937 then sqft_lot_cate = 0;
	 else if sqft_lot <9145 then sqft_lot_cate = 1;
     else sqft_lot_cate = 2;
     
	 if sqft_above < 1290 then sqft_above_cate = 0;
	 else if sqft_above < 1880 then sqft_above_cate = 1;
	 else sqft_above_cate = 2;
     
	 if sqft_basement < 270 then sqft_basement_cate = 0;
	 else sqft_basement_cate = 1;

	 if sqft_living15 < 1580 then sqft_living15_cate = 0;
	 else if sqft_living15 < 2110 then sqft_living15_cate = 1;
	 else sqft_living15_cate = 2;

	 if sqft_lot15 < 5907 then sqft_lot15_cate = 0;
	 else if sqft_lot15 < 8800 then sqft_lot15_cate = 1;
	 else sqft_lot15_cate = 2;

	  cate_zipcode = input(zipcode, BEST32.);
	  cate_floors  = input(floors, BEST32.);

run;

proc contents data = price3;
quit;

proc logistic data = price3 descending;
      class waterfront(ref='0')/param = ref;
	  model price_cate = waterfront;
quit;

proc logistic data = price3 descending;
     class price_cate(ref='0') waterfront(ref='1') view(ref='2') condition(ref='3') grade(ref='4') /param = ref;
     model price_cate = sqft_living sqft_lot sqft_above sqft_basement sqft_living15 sqft_lot15 bedrooms bathrooms
	                    waterfront view condition grade yr_built cate_zipcode cate_floors /link = glogit;
quit;


