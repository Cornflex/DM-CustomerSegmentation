*****************************************;
*** Begin Scoring Code from PROC DMVQ ***;
*****************************************;


*** Begin Class Look-up, Standardization, Replacement ;
drop _dm_bad; _dm_bad = 0;

*** Standardize ClaimsRate ;
drop T_ClaimsRate ;
if missing( ClaimsRate ) then T_ClaimsRate = .;
else T_ClaimsRate = (ClaimsRate - 0.74278480769098) * 0.34282299968436;

*** Standardize CustomerMonetaryValue ;
drop T_CustomerMonetaryValue ;
if missing( CustomerMonetaryValue ) then T_CustomerMonetaryValue = .;
else T_CustomerMonetaryValue = (CustomerMonetaryValue
         - 177.89260352564) * 0.00051392438417;

*** Standardize IMP_GrossMonthlySalary ;
drop T_IMP_GrossMonthlySalary ;
if missing( IMP_GrossMonthlySalary ) then T_IMP_GrossMonthlySalary = .;
else T_IMP_GrossMonthlySalary = (IMP_GrossMonthlySalary
         - 5012.8385565301) * 0.00043274126676;

*** Standardize IMP_PremiumsinLOBHealth ;
drop T_IMP_PremiumsinLOBHealth ;
if missing( IMP_PremiumsinLOBHealth ) then T_IMP_PremiumsinLOBHealth = .;
else T_IMP_PremiumsinLOBHealth = (IMP_PremiumsinLOBHealth
         - 171.58083292696) * 0.00338081900561;

*** Standardize IMP_PremiumsinLOBLife ;
drop T_IMP_PremiumsinLOBLife ;
if missing( IMP_PremiumsinLOBLife ) then T_IMP_PremiumsinLOBLife = .;
else T_IMP_PremiumsinLOBLife = (IMP_PremiumsinLOBLife
         - 41.8557819858754) * 0.02116841219401;

*** Standardize IMP_PremiumsinLOBMotor ;
drop T_IMP_PremiumsinLOBMotor ;
if missing( IMP_PremiumsinLOBMotor ) then T_IMP_PremiumsinLOBMotor = .;
else T_IMP_PremiumsinLOBMotor = (IMP_PremiumsinLOBMotor
         - 300.470252387456) * 0.00472668476828;

*** Standardize IMP_PremiumsinLOBWorkComp ;
drop T_IMP_PremiumsinLOBWorkComp ;
if missing( IMP_PremiumsinLOBWorkComp ) then T_IMP_PremiumsinLOBWorkComp = .;
else T_IMP_PremiumsinLOBWorkComp = (IMP_PremiumsinLOBWorkComp
         - 41.2775142017676) * 0.01949395258122;

*** Standardize IMP_REP_CustomerAge ;
drop T_IMP_REP_CustomerAge ;
if missing( IMP_REP_CustomerAge ) then T_IMP_REP_CustomerAge = .;
else T_IMP_REP_CustomerAge = (IMP_REP_CustomerAge
         - 47.900758902511) * 0.05754504433;

*** Standardize LOYALTY ;
drop T_LOYALTY ;
if missing( LOYALTY ) then T_LOYALTY = .;
else T_LOYALTY = (LOYALTY - 28.9829517779525) * 0.15146587841461;

*** Standardize PremiumsinLOBHousehold ;
drop T_PremiumsinLOBHousehold ;
if missing( PremiumsinLOBHousehold ) then T_PremiumsinLOBHousehold = .;
else T_PremiumsinLOBHousehold = (PremiumsinLOBHousehold
         - 210.431191724937) * 0.00283610717435;

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
      IMP_GeographicLiving1 = -0.32422559943915;
      IMP_GeographicLiving2 = -0.16723350696889;
      IMP_GeographicLiving3 = -0.25050370517151;
      IMP_GeographicLiving4 = 0.60893624085983;
   end;
   else if _dm12 = '1'  then do;
      IMP_GeographicLiving1 = 0.77099315772144;
      IMP_GeographicLiving2 = -0.16723350696889;
      IMP_GeographicLiving3 = -0.25050370517151;
      IMP_GeographicLiving4 = -0.41051213896014;
   end;
   else if _dm12 = '3'  then do;
      IMP_GeographicLiving1 = -0.32422559943915;
      IMP_GeographicLiving2 = -0.16723350696889;
      IMP_GeographicLiving3 = 0.99789230085265;
      IMP_GeographicLiving4 = -0.41051213896014;
   end;
   else if _dm12 = '2'  then do;
      IMP_GeographicLiving1 = -0.32422559943915;
      IMP_GeographicLiving2 = 1.4947705352625;
      IMP_GeographicLiving3 = -0.25050370517151;
      IMP_GeographicLiving4 = -0.41051213896014;
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
      IMP_HasChildren0 = -0.45478729278124;
      IMP_HasChildren1 = 0.45478729278124;
   end;
   else if _dm12 = '0'  then do;
      IMP_HasChildren0 = 1.09930828188709;
      IMP_HasChildren1 = -1.09930828188709;
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
      T_IMP_EducationalDegree = 0.74260910169779;
   end;
   else if _dm15 = '2 - HIGH SCHOOL'  then do;
      T_IMP_EducationalDegree = -0.77133883677817;
   end;
   else if _dm15 = '1 - BASIC'  then do;
      T_IMP_EducationalDegree = -1.64086790737535;
   end;
   else if _dm15 = '4 - PHD'  then do;
      T_IMP_EducationalDegree = 1.74524048924962;
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
   goto CLUS2vlex ;
end; *** omitted;

*** Compute Distances and Cluster Membership;
label _SEGMENT_ = 'Segment Id' ;
label Distance = 'Distance' ;
array CLUS2vads [5] _temporary_;
drop _vqclus _vqmvar _vqnvar;
_vqmvar = 0;
do _vqclus = 1 to 5; CLUS2vads [_vqclus] = 0; end;
if not missing( T_ClaimsRate ) then do;
   CLUS2vads [1] + ( T_ClaimsRate - -0.01260105144505 )**2;
   CLUS2vads [2] + ( T_ClaimsRate - 0.00030583971189 )**2;
   CLUS2vads [3] + ( T_ClaimsRate - -0.02275356560844 )**2;
   CLUS2vads [4] + ( T_ClaimsRate - -0.02990614488976 )**2;
   CLUS2vads [5] + ( T_ClaimsRate - 0.05802616820402 )**2;
end;
else _vqmvar + 1;
if not missing( T_CustomerMonetaryValue ) then do;
   CLUS2vads [1] + ( T_CustomerMonetaryValue - 0.06081460838246 )**2;
   CLUS2vads [2] + ( T_CustomerMonetaryValue - 0.00143806283742 )**2;
   CLUS2vads [3] + ( T_CustomerMonetaryValue - 0.01634717870663 )**2;
   CLUS2vads [4] + ( T_CustomerMonetaryValue - 0.01533956506821 )**2;
   CLUS2vads [5] + ( T_CustomerMonetaryValue - -0.06012263937542 )**2;
end;
else _vqmvar + 1;
if not missing( T_IMP_GrossMonthlySalary ) then do;
   CLUS2vads [1] + ( T_IMP_GrossMonthlySalary - -1.09481481093318 )**2;
   CLUS2vads [2] + ( T_IMP_GrossMonthlySalary - -0.86301974179088 )**2;
   CLUS2vads [3] + ( T_IMP_GrossMonthlySalary - 0.15389607215452 )**2;
   CLUS2vads [4] + ( T_IMP_GrossMonthlySalary - 0.06912925317816 )**2;
   CLUS2vads [5] + ( T_IMP_GrossMonthlySalary - 0.96641587399498 )**2;
end;
else _vqmvar + 1;
if not missing( T_IMP_PremiumsinLOBHealth ) then do;
   CLUS2vads [1] + ( T_IMP_PremiumsinLOBHealth - -0.02999705147399 )**2;
   CLUS2vads [2] + ( T_IMP_PremiumsinLOBHealth - 0.21924147942219 )**2;
   CLUS2vads [3] + ( T_IMP_PremiumsinLOBHealth - -0.09196010391119 )**2;
   CLUS2vads [4] + ( T_IMP_PremiumsinLOBHealth - -0.16861869074931 )**2;
   CLUS2vads [5] + ( T_IMP_PremiumsinLOBHealth - 0.11752604795898 )**2;
end;
else _vqmvar + 1;
if not missing( T_IMP_PremiumsinLOBLife ) then do;
   CLUS2vads [1] + ( T_IMP_PremiumsinLOBLife - 1.70486542916924 )**2;
   CLUS2vads [2] + ( T_IMP_PremiumsinLOBLife - 0.0036368677869 )**2;
   CLUS2vads [3] + ( T_IMP_PremiumsinLOBLife - -0.19892770126015 )**2;
   CLUS2vads [4] + ( T_IMP_PremiumsinLOBLife - -0.56113817937738 )**2;
   CLUS2vads [5] + ( T_IMP_PremiumsinLOBLife - 0.00285760290798 )**2;
end;
else _vqmvar + 1;
if not missing( T_IMP_PremiumsinLOBMotor ) then do;
   CLUS2vads [1] + ( T_IMP_PremiumsinLOBMotor - -0.99956847767285 )**2;
   CLUS2vads [2] + ( T_IMP_PremiumsinLOBMotor - -0.32171231910435 )**2;
   CLUS2vads [3] + ( T_IMP_PremiumsinLOBMotor - 0.21655277358803 )**2;
   CLUS2vads [4] + ( T_IMP_PremiumsinLOBMotor - 0.63363707740186 )**2;
   CLUS2vads [5] + ( T_IMP_PremiumsinLOBMotor - -0.19603686771174 )**2;
end;
else _vqmvar + 1;
if not missing( T_IMP_PremiumsinLOBWorkComp ) then do;
   CLUS2vads [1] + ( T_IMP_PremiumsinLOBWorkComp - 1.49762462905868 )**2;
   CLUS2vads [2] + ( T_IMP_PremiumsinLOBWorkComp - 0.06371076512666 )**2;
   CLUS2vads [3] + ( T_IMP_PremiumsinLOBWorkComp - -0.16562285336111 )**2;
   CLUS2vads [4] + ( T_IMP_PremiumsinLOBWorkComp - -0.50410184523598 )**2;
   CLUS2vads [5] + ( T_IMP_PremiumsinLOBWorkComp - -0.03652389577082 )**2;
end;
else _vqmvar + 1;
if not missing( T_IMP_REP_CustomerAge ) then do;
   CLUS2vads [1] + ( T_IMP_REP_CustomerAge - -1.36333536717752 )**2;
   CLUS2vads [2] + ( T_IMP_REP_CustomerAge - -1.03140313978479 )**2;
   CLUS2vads [3] + ( T_IMP_REP_CustomerAge - 0.17554148934151 )**2;
   CLUS2vads [4] + ( T_IMP_REP_CustomerAge - 0.09426762043582 )**2;
   CLUS2vads [5] + ( T_IMP_REP_CustomerAge - 1.17346246282471 )**2;
end;
else _vqmvar + 1;
if not missing( T_LOYALTY ) then do;
   CLUS2vads [1] + ( T_LOYALTY - 0.0408668676427 )**2;
   CLUS2vads [2] + ( T_LOYALTY - -0.03628650693045 )**2;
   CLUS2vads [3] + ( T_LOYALTY - 0.01289927880442 )**2;
   CLUS2vads [4] + ( T_LOYALTY - 0.03470928612816 )**2;
   CLUS2vads [5] + ( T_LOYALTY - -0.0426643998811 )**2;
end;
else _vqmvar + 1;
if not missing( T_PremiumsinLOBHousehold ) then do;
   CLUS2vads [1] + ( T_PremiumsinLOBHousehold - 1.01201307468596 )**2;
   CLUS2vads [2] + ( T_PremiumsinLOBHousehold - 0.0982925706468 )**2;
   CLUS2vads [3] + ( T_PremiumsinLOBHousehold - -0.13242330942728 )**2;
   CLUS2vads [4] + ( T_PremiumsinLOBHousehold - -0.38233839596612 )**2;
   CLUS2vads [5] + ( T_PremiumsinLOBHousehold - -0.0015702461965 )**2;
end;
else _vqmvar + 1;
if not missing( IMP_GeographicLiving1 ) then do;
   CLUS2vads [1] + ( IMP_GeographicLiving1 - -0.00342283794804 )**2;
   CLUS2vads [2] + ( IMP_GeographicLiving1 - 0.01983451577429 )**2;
   CLUS2vads [3] + ( IMP_GeographicLiving1 - -0.00500724992857 )**2;
   CLUS2vads [4] + ( IMP_GeographicLiving1 - 0.00149140944947 )**2;
   CLUS2vads [5] + ( IMP_GeographicLiving1 - -0.01124289132675 )**2;
end;
else _vqmvar + 0.25;
if not missing( IMP_GeographicLiving2 ) then do;
   CLUS2vads [1] + ( IMP_GeographicLiving2 - -0.02104527780592 )**2;
   CLUS2vads [2] + ( IMP_GeographicLiving2 - -0.01256610551325 )**2;
   CLUS2vads [3] + ( IMP_GeographicLiving2 - 0.0138651621524 )**2;
   CLUS2vads [4] + ( IMP_GeographicLiving2 - 0.00510982800582 )**2;
   CLUS2vads [5] + ( IMP_GeographicLiving2 - 0.00291926478716 )**2;
end;
else _vqmvar + 0.25;
if not missing( IMP_GeographicLiving3 ) then do;
   CLUS2vads [1] + ( IMP_GeographicLiving3 - 0.00535884089663 )**2;
   CLUS2vads [2] + ( IMP_GeographicLiving3 - -0.0033763623975 )**2;
   CLUS2vads [3] + ( IMP_GeographicLiving3 - 0.0001136358124 )**2;
   CLUS2vads [4] + ( IMP_GeographicLiving3 - 0.01438524887878 )**2;
   CLUS2vads [5] + ( IMP_GeographicLiving3 - -0.01702698336772 )**2;
end;
else _vqmvar + 0.25;
if not missing( IMP_GeographicLiving4 ) then do;
   CLUS2vads [1] + ( IMP_GeographicLiving4 - 0.01171882962456 )**2;
   CLUS2vads [2] + ( IMP_GeographicLiving4 - -0.00799728646532 )**2;
   CLUS2vads [3] + ( IMP_GeographicLiving4 - -0.0039366444855 )**2;
   CLUS2vads [4] + ( IMP_GeographicLiving4 - -0.01626961014543 )**2;
   CLUS2vads [5] + ( IMP_GeographicLiving4 - 0.02257878902464 )**2;
end;
else _vqmvar + 0.25;
if not missing( IMP_HasChildren0 ) then do;
   CLUS2vads [1] + ( IMP_HasChildren0 - -0.04602432352603 )**2;
   CLUS2vads [2] + ( IMP_HasChildren0 - -0.32688163225179 )**2;
   CLUS2vads [3] + ( IMP_HasChildren0 - -0.44144025617647 )**2;
   CLUS2vads [4] + ( IMP_HasChildren0 - -0.42181195889026 )**2;
   CLUS2vads [5] + ( IMP_HasChildren0 - 1.09492348985863 )**2;
end;
else _vqmvar + 0.5;
if not missing( IMP_HasChildren1 ) then do;
   CLUS2vads [1] + ( IMP_HasChildren1 - 0.04602432352603 )**2;
   CLUS2vads [2] + ( IMP_HasChildren1 - 0.32688163225179 )**2;
   CLUS2vads [3] + ( IMP_HasChildren1 - 0.44144025617647 )**2;
   CLUS2vads [4] + ( IMP_HasChildren1 - 0.42181195889026 )**2;
   CLUS2vads [5] + ( IMP_HasChildren1 - -1.09492348985863 )**2;
end;
else _vqmvar + 0.49999999999999;
if not missing( T_IMP_EducationalDegree ) then do;
   CLUS2vads [1] + ( T_IMP_EducationalDegree - -1.15953948678551 )**2;
   CLUS2vads [2] + ( T_IMP_EducationalDegree - 0.12796989017307 )**2;
   CLUS2vads [3] + ( T_IMP_EducationalDegree - -0.93986369881044 )**2;
   CLUS2vads [4] + ( T_IMP_EducationalDegree - 0.89911595088543 )**2;
   CLUS2vads [5] + ( T_IMP_EducationalDegree - 0.09821603208008 )**2;
end;
else _vqmvar + 1;
_vqnvar = 13 - _vqmvar;
if _vqnvar <= 2.5124791136477E-11 then do;
   _SEGMENT_ = .; Distance = .;
end;
else do;
   _SEGMENT_ = 1; Distance = CLUS2vads [1];
   _vqfzdst = Distance * 0.99999999999988; drop _vqfzdst;
   do _vqclus = 2 to 5;
      if CLUS2vads [_vqclus] < _vqfzdst then do;
         _SEGMENT_ = _vqclus; Distance = CLUS2vads [_vqclus];
         _vqfzdst = Distance * 0.99999999999988;
      end;
   end;
   Distance = sqrt(Distance * (13 / _vqnvar));
end;
CLUS2vlex :;

***************************************;
*** End Scoring Code from PROC DMVQ ***;
***************************************;
*------------------------------------------------------------*;
* Clus2: Creating Segment Label;
*------------------------------------------------------------*;
length _SEGMENT_LABEL_ $80;
label _SEGMENT_LABEL_='Segment Description';
if _SEGMENT_ = 1 then _SEGMENT_LABEL_="Cluster1";
else
if _SEGMENT_ = 2 then _SEGMENT_LABEL_="Cluster2";
else
if _SEGMENT_ = 3 then _SEGMENT_LABEL_="Cluster3";
else
if _SEGMENT_ = 4 then _SEGMENT_LABEL_="Cluster4";
else
if _SEGMENT_ = 5 then _SEGMENT_LABEL_="Cluster5";
