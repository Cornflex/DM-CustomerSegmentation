*****************************************;
*** Begin Scoring Code from PROC DMVQ ***;
*****************************************;


*** Begin Class Look-up, Standardization, Replacement ;
drop _dm_bad; _dm_bad = 0;

*** Standardize ClaimsRate ;
drop T_ClaimsRate ;
if missing( ClaimsRate ) then T_ClaimsRate = .;
else T_ClaimsRate = (ClaimsRate - 0.67794677876012) * 3.19941338729829;

*** Standardize CustomerMonetaryValue ;
drop T_CustomerMonetaryValue ;
if missing( CustomerMonetaryValue ) then T_CustomerMonetaryValue = .;
else T_CustomerMonetaryValue = (CustomerMonetaryValue
         - 216.160594666394) * 0.00411467214717;

*** Standardize IMP_GrossMonthlySalary ;
drop T_IMP_GrossMonthlySalary ;
if missing( IMP_GrossMonthlySalary ) then T_IMP_GrossMonthlySalary = .;
else T_IMP_GrossMonthlySalary = (IMP_GrossMonthlySalary
         - 5037.76267683033) * 0.00052230054959;

*** Standardize IMP_REP_CustomerAge ;
drop T_IMP_REP_CustomerAge ;
if missing( IMP_REP_CustomerAge ) then T_IMP_REP_CustomerAge = .;
else T_IMP_REP_CustomerAge = (IMP_REP_CustomerAge
         - 48.3002159661034) * 0.05849681051166;

*** Standardize LOYALTY ;
drop T_LOYALTY ;
if missing( LOYALTY ) then T_LOYALTY = .;
else T_LOYALTY = (LOYALTY - 29.0027065039337) * 0.15179623368094;

*** Standardize TOTAL_PREMIUM ;
drop T_TOTAL_PREMIUM ;
if missing( TOTAL_PREMIUM ) then T_TOTAL_PREMIUM = .;
else T_TOTAL_PREMIUM = (TOTAL_PREMIUM - 748.218286034205) * 0.00576895696549;

*** Generate dummy variables for IMP_GeographicLiving ;
drop IMP_GeographicLiving1 IMP_GeographicLiving2 IMP_GeographicLiving3 
        IMP_GeographicLiving4 ;
if missing( IMP_GeographicLiving ) then do;
   IMP_GeographicLiving1 = .;
   IMP_GeographicLiving2 = .;
   IMP_GeographicLiving3 = .;
   IMP_GeographicLiving4 = .;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( IMP_GeographicLiving , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '4'  then do;
      IMP_GeographicLiving1 = -0.32404062826594;
      IMP_GeographicLiving2 = -0.16763086377407;
      IMP_GeographicLiving3 = -0.25011493503349;
      IMP_GeographicLiving4 = 0.6085514560971;
   end;
   else if _dm12 = '1'  then do;
      IMP_GeographicLiving1 = 0.77142936442447;
      IMP_GeographicLiving2 = -0.16763086377407;
      IMP_GeographicLiving3 = -0.25011493503349;
      IMP_GeographicLiving4 = -0.41076962910268;
   end;
   else if _dm12 = '3'  then do;
      IMP_GeographicLiving1 = -0.32404062826594;
      IMP_GeographicLiving2 = -0.16763086377407;
      IMP_GeographicLiving3 = 0.99943834172648;
      IMP_GeographicLiving4 = -0.41076962910268;
   end;
   else if _dm12 = '2'  then do;
      IMP_GeographicLiving1 = -0.32404062826594;
      IMP_GeographicLiving2 = 1.49121975680923;
      IMP_GeographicLiving3 = -0.25011493503349;
      IMP_GeographicLiving4 = -0.41076962910268;
   end;
   else do;
      IMP_GeographicLiving1 = .;
      IMP_GeographicLiving2 = .;
      IMP_GeographicLiving3 = .;
      IMP_GeographicLiving4 = .;
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for IMP_HasChildren ;
drop IMP_HasChildren0 IMP_HasChildren1 ;
if missing( IMP_HasChildren ) then do;
   IMP_HasChildren0 = .;
   IMP_HasChildren1 = .;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( IMP_HasChildren , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '1'  then do;
      IMP_HasChildren0 = -0.45354645930186;
      IMP_HasChildren1 = 0.45354645930186;
   end;
   else if _dm12 = '0'  then do;
      IMP_HasChildren0 = 1.10231025194501;
      IMP_HasChildren1 = -1.10231025194501;
   end;
   else do;
      IMP_HasChildren0 = .;
      IMP_HasChildren1 = .;
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for IMP_EducationalDegree ;
drop T_IMP_EducationalDegree ;
if missing( IMP_EducationalDegree ) then do;
   T_IMP_EducationalDegree = .;
end;
else do;
   length _dm15 $ 15; drop _dm15 ;
   _dm15 = put( IMP_EducationalDegree , $CHAR15. );
   %DMNORMIP( _dm15 )
   if _dm15 = '3 - BSC/MSC'  then do;
      T_IMP_EducationalDegree = 0.73555748368902;
   end;
   else if _dm15 = '2 - HIGH SCHOOL'  then do;
      T_IMP_EducationalDegree = -0.80523581525977;
   end;
   else if _dm15 = '1 - BASIC'  then do;
      T_IMP_EducationalDegree = -1.6661375152455;
   end;
   else if _dm15 = '4 - PHD'  then do;
      T_IMP_EducationalDegree = 1.7532834175406;
   end;
   else do;
      T_IMP_EducationalDegree = .;
      _DM_BAD = 1;
   end;
end;

*** End Class Look-up, Standardization, Replacement ;


*** Omitted Cases;
if _dm_bad then do;
   _SEGMENT_ = .; Distance = .;
   goto CLUS3vlex ;
end; *** omitted;

*** Compute Distances and Cluster Membership;
label _SEGMENT_ = 'Segment Id' ;
label Distance = 'Distance' ;
array CLUS3vads [5] _temporary_;
drop _vqclus _vqmvar _vqnvar;
_vqmvar = 0;
do _vqclus = 1 to 5; CLUS3vads [_vqclus] = 0; end;
if not missing( T_ClaimsRate ) then do;
   CLUS3vads [1] + ( T_ClaimsRate - -0.29359001097883 )**2;
   CLUS3vads [2] + ( T_ClaimsRate - 0.58734432964936 )**2;
   CLUS3vads [3] + ( T_ClaimsRate - -1.18486875416666 )**2;
   CLUS3vads [4] + ( T_ClaimsRate - 0.87626583283747 )**2;
   CLUS3vads [5] + ( T_ClaimsRate - 0.11104515239159 )**2;
end;
else _vqmvar + 1;
if not missing( T_CustomerMonetaryValue ) then do;
   CLUS3vads [1] + ( T_CustomerMonetaryValue - 0.77712268390124 )**2;
   CLUS3vads [2] + ( T_CustomerMonetaryValue - -0.58993742822212 )**2;
   CLUS3vads [3] + ( T_CustomerMonetaryValue - 0.9214537439035 )**2;
   CLUS3vads [4] + ( T_CustomerMonetaryValue - -0.83954393743256 )**2;
   CLUS3vads [5] + ( T_CustomerMonetaryValue - -0.09482220564392 )**2;
end;
else _vqmvar + 1;
if not missing( T_IMP_GrossMonthlySalary ) then do;
   CLUS3vads [1] + ( T_IMP_GrossMonthlySalary - -1.16998906624103 )**2;
   CLUS3vads [2] + ( T_IMP_GrossMonthlySalary - -0.98970566886277 )**2;
   CLUS3vads [3] + ( T_IMP_GrossMonthlySalary - -0.02789009952008 )**2;
   CLUS3vads [4] + ( T_IMP_GrossMonthlySalary - 0.33365957129819 )**2;
   CLUS3vads [5] + ( T_IMP_GrossMonthlySalary - 1.13248055529285 )**2;
end;
else _vqmvar + 1;
if not missing( T_IMP_REP_CustomerAge ) then do;
   CLUS3vads [1] + ( T_IMP_REP_CustomerAge - -1.24262657674986 )**2;
   CLUS3vads [2] + ( T_IMP_REP_CustomerAge - -0.99671439987596 )**2;
   CLUS3vads [3] + ( T_IMP_REP_CustomerAge - -0.03431848283995 )**2;
   CLUS3vads [4] + ( T_IMP_REP_CustomerAge - 0.3143864910529 )**2;
   CLUS3vads [5] + ( T_IMP_REP_CustomerAge - 1.19544633876766 )**2;
end;
else _vqmvar + 1;
if not missing( T_LOYALTY ) then do;
   CLUS3vads [1] + ( T_LOYALTY - 0.00683509154549 )**2;
   CLUS3vads [2] + ( T_LOYALTY - -0.0389550538598 )**2;
   CLUS3vads [3] + ( T_LOYALTY - 0.01285947235263 )**2;
   CLUS3vads [4] + ( T_LOYALTY - 0.07406355898021 )**2;
   CLUS3vads [5] + ( T_LOYALTY - -0.04648089199002 )**2;
end;
else _vqmvar + 1;
if not missing( T_TOTAL_PREMIUM ) then do;
   CLUS3vads [1] + ( T_TOTAL_PREMIUM - 1.80019443065879 )**2;
   CLUS3vads [2] + ( T_TOTAL_PREMIUM - -0.158011719916 )**2;
   CLUS3vads [3] + ( T_TOTAL_PREMIUM - -0.3839475421619 )**2;
   CLUS3vads [4] + ( T_TOTAL_PREMIUM - -0.4144941441014 )**2;
   CLUS3vads [5] + ( T_TOTAL_PREMIUM - 0.0419242264738 )**2;
end;
else _vqmvar + 1;
if not missing( IMP_GeographicLiving1 ) then do;
   CLUS3vads [1] + ( IMP_GeographicLiving1 - 0.00590809313209 )**2;
   CLUS3vads [2] + ( IMP_GeographicLiving1 - 0.0099643568855 )**2;
   CLUS3vads [3] + ( IMP_GeographicLiving1 - 0.00460036954118 )**2;
   CLUS3vads [4] + ( IMP_GeographicLiving1 - -0.00207058511988 )**2;
   CLUS3vads [5] + ( IMP_GeographicLiving1 - -0.01420598226465 )**2;
end;
else _vqmvar + 0.25;
if not missing( IMP_GeographicLiving2 ) then do;
   CLUS3vads [1] + ( IMP_GeographicLiving2 - -0.01073314667574 )**2;
   CLUS3vads [2] + ( IMP_GeographicLiving2 - -0.02192666994192 )**2;
   CLUS3vads [3] + ( IMP_GeographicLiving2 - 0.00101894931855 )**2;
   CLUS3vads [4] + ( IMP_GeographicLiving2 - 0.02772446849391 )**2;
   CLUS3vads [5] + ( IMP_GeographicLiving2 - -0.0010338486597 )**2;
end;
else _vqmvar + 0.25;
if not missing( IMP_GeographicLiving3 ) then do;
   CLUS3vads [1] + ( IMP_GeographicLiving3 - 0.00576236590082 )**2;
   CLUS3vads [2] + ( IMP_GeographicLiving3 - 0.01165417645332 )**2;
   CLUS3vads [3] + ( IMP_GeographicLiving3 - 0.0091673698942 )**2;
   CLUS3vads [4] + ( IMP_GeographicLiving3 - -0.00674446794435 )**2;
   CLUS3vads [5] + ( IMP_GeographicLiving3 - -0.01629294848098 )**2;
end;
else _vqmvar + 0.24999999999999;
if not missing( IMP_GeographicLiving4 ) then do;
   CLUS3vads [1] + ( IMP_GeographicLiving4 - -0.0036028044361 )**2;
   CLUS3vads [2] + ( IMP_GeographicLiving4 - -0.00530520954819 )**2;
   CLUS3vads [3] + ( IMP_GeographicLiving4 - -0.01238497163709 )**2;
   CLUS3vads [4] + ( IMP_GeographicLiving4 - -0.00960753115289 )**2;
   CLUS3vads [5] + ( IMP_GeographicLiving4 - 0.02714470835868 )**2;
end;
else _vqmvar + 0.24999999999999;
if not missing( IMP_HasChildren0 ) then do;
   CLUS3vads [1] + ( IMP_HasChildren0 - -0.12637365225362 )**2;
   CLUS3vads [2] + ( IMP_HasChildren0 - -0.31060556003537 )**2;
   CLUS3vads [3] + ( IMP_HasChildren0 - -0.3854777281848 )**2;
   CLUS3vads [4] + ( IMP_HasChildren0 - -0.43788609985297 )**2;
   CLUS3vads [5] + ( IMP_HasChildren0 - 1.09362950634574 )**2;
end;
else _vqmvar + 0.5;
if not missing( IMP_HasChildren1 ) then do;
   CLUS3vads [1] + ( IMP_HasChildren1 - 0.12637365225362 )**2;
   CLUS3vads [2] + ( IMP_HasChildren1 - 0.31060556003537 )**2;
   CLUS3vads [3] + ( IMP_HasChildren1 - 0.3854777281848 )**2;
   CLUS3vads [4] + ( IMP_HasChildren1 - 0.43788609985297 )**2;
   CLUS3vads [5] + ( IMP_HasChildren1 - -1.09362950634574 )**2;
end;
else _vqmvar + 0.5;
if not missing( T_IMP_EducationalDegree ) then do;
   CLUS3vads [1] + ( T_IMP_EducationalDegree - -1.01345682353822 )**2;
   CLUS3vads [2] + ( T_IMP_EducationalDegree - 0.08341888774289 )**2;
   CLUS3vads [3] + ( T_IMP_EducationalDegree - 0.28707912495606 )**2;
   CLUS3vads [4] + ( T_IMP_EducationalDegree - 0.03359486328774 )**2;
   CLUS3vads [5] + ( T_IMP_EducationalDegree - 0.0783943223035 )**2;
end;
else _vqmvar + 0.99999999999999;
_vqnvar = 9 - _vqmvar;
if _vqnvar <= 1.3301360013429E-11 then do;
   _SEGMENT_ = .; Distance = .;
end;
else do;
   _SEGMENT_ = 1; Distance = CLUS3vads [1];
   _vqfzdst = Distance * 0.99999999999988; drop _vqfzdst;
   do _vqclus = 2 to 5;
      if CLUS3vads [_vqclus] < _vqfzdst then do;
         _SEGMENT_ = _vqclus; Distance = CLUS3vads [_vqclus];
         _vqfzdst = Distance * 0.99999999999988;
      end;
   end;
   Distance = sqrt(Distance * (9 / _vqnvar));
end;
CLUS3vlex :;

***************************************;
*** End Scoring Code from PROC DMVQ ***;
***************************************;
