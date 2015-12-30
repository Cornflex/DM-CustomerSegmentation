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
         - 5012.80240773115) * 0.00043274125167;

*** Standardize IMP_REP_CustomerAge ;
drop T_IMP_REP_CustomerAge ;
if missing( IMP_REP_CustomerAge ) then T_IMP_REP_CustomerAge = .;
else T_IMP_REP_CustomerAge = (IMP_REP_CustomerAge
         - 47.900758902511) * 0.05754504433;

*** Standardize IMP_REP_FirstPolicyYear ;
drop T_IMP_REP_FirstPolicyYear ;
if missing( IMP_REP_FirstPolicyYear ) then T_IMP_REP_FirstPolicyYear = .;
else T_IMP_REP_FirstPolicyYear = (IMP_REP_FirstPolicyYear
         - 1986.01704822204) * 0.15146587841036;

*** Standardize TOTAL_PREMIUM ;
drop T_TOTAL_PREMIUM ;
if missing( TOTAL_PREMIUM ) then T_TOTAL_PREMIUM = .;
else T_TOTAL_PREMIUM = (TOTAL_PREMIUM - 765.277830225334) * 0.0021215808759;

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
      IMP_GeographicLiving2 = -0.16732323362943;
      IMP_GeographicLiving3 = -0.25050370517151;
      IMP_GeographicLiving4 = 0.60905920171182;
   end;
   else if _dm12 = '1'  then do;
      IMP_GeographicLiving1 = 0.77099315772144;
      IMP_GeographicLiving2 = -0.16732323362943;
      IMP_GeographicLiving3 = -0.25050370517151;
      IMP_GeographicLiving4 = -0.41042926208673;
   end;
   else if _dm12 = '3'  then do;
      IMP_GeographicLiving1 = -0.32422559943915;
      IMP_GeographicLiving2 = -0.16732323362943;
      IMP_GeographicLiving3 = 0.99789230085265;
      IMP_GeographicLiving4 = -0.41042926208673;
   end;
   else if _dm12 = '2'  then do;
      IMP_GeographicLiving1 = -0.32422559943915;
      IMP_GeographicLiving2 = 1.49396896834617;
      IMP_GeographicLiving3 = -0.25050370517151;
      IMP_GeographicLiving4 = -0.41042926208673;
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
      IMP_HasChildren0 = -0.4551073921315;
      IMP_HasChildren1 = 0.4551073921315;
   end;
   else if _dm12 = '0'  then do;
      IMP_HasChildren0 = 1.09853508445535;
      IMP_HasChildren1 = -1.09853508445535;
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
      T_IMP_EducationalDegree = 0.74362255932363;
   end;
   else if _dm15 = '2 - HIGH SCHOOL'  then do;
      T_IMP_EducationalDegree = -0.77016752109899;
   end;
   else if _dm15 = '1 - BASIC'  then do;
      T_IMP_EducationalDegree = -1.64069681548568;
   end;
   else if _dm15 = '4 - PHD'  then do;
      T_IMP_EducationalDegree = 1.74505851452034;
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
array CLUS2vads [4] _temporary_;
drop _vqclus _vqmvar _vqnvar;
_vqmvar = 0;
do _vqclus = 1 to 4; CLUS2vads [_vqclus] = 0; end;
if not missing( T_ClaimsRate ) then do;
   CLUS2vads [1] + ( T_ClaimsRate - -0.0128805317996 )**2;
   CLUS2vads [2] + ( T_ClaimsRate - -0.01627256862429 )**2;
   CLUS2vads [3] + ( T_ClaimsRate - -0.02481714457584 )**2;
   CLUS2vads [4] + ( T_ClaimsRate - 0.05619608676141 )**2;
end;
else _vqmvar + 1;
if not missing( T_CustomerMonetaryValue ) then do;
   CLUS2vads [1] + ( T_CustomerMonetaryValue - 0.03860585163493 )**2;
   CLUS2vads [2] + ( T_CustomerMonetaryValue - 0.00362948895522 )**2;
   CLUS2vads [3] + ( T_CustomerMonetaryValue - 0.01550571562809 )**2;
   CLUS2vads [4] + ( T_CustomerMonetaryValue - -0.05734862991024 )**2;
end;
else _vqmvar + 1;
if not missing( T_IMP_GrossMonthlySalary ) then do;
   CLUS2vads [1] + ( T_IMP_GrossMonthlySalary - -0.88437121645153 )**2;
   CLUS2vads [2] + ( T_IMP_GrossMonthlySalary - -0.55327421498551 )**2;
   CLUS2vads [3] + ( T_IMP_GrossMonthlySalary - 0.44677912947269 )**2;
   CLUS2vads [4] + ( T_IMP_GrossMonthlySalary - 0.95592558479447 )**2;
end;
else _vqmvar + 1;
if not missing( T_IMP_REP_CustomerAge ) then do;
   CLUS2vads [1] + ( T_IMP_REP_CustomerAge - -1.06961335814996 )**2;
   CLUS2vads [2] + ( T_IMP_REP_CustomerAge - -0.65670559920056 )**2;
   CLUS2vads [3] + ( T_IMP_REP_CustomerAge - 0.52097617833307 )**2;
   CLUS2vads [4] + ( T_IMP_REP_CustomerAge - 1.16363977265747 )**2;
end;
else _vqmvar + 1;
if not missing( T_IMP_REP_FirstPolicyYear ) then do;
   CLUS2vads [1] + ( T_IMP_REP_FirstPolicyYear - -0.01089230679187 )**2;
   CLUS2vads [2] + ( T_IMP_REP_FirstPolicyYear - -0.0280627728746 )**2;
   CLUS2vads [3] + ( T_IMP_REP_FirstPolicyYear - 0.00074358409441 )**2;
   CLUS2vads [4] + ( T_IMP_REP_FirstPolicyYear - 0.03949186078219 )**2;
end;
else _vqmvar + 1;
if not missing( T_TOTAL_PREMIUM ) then do;
   CLUS2vads [1] + ( T_TOTAL_PREMIUM - 0.32957822792364 )**2;
   CLUS2vads [2] + ( T_TOTAL_PREMIUM - -0.15563243229063 )**2;
   CLUS2vads [3] + ( T_TOTAL_PREMIUM - -0.13074614221964 )**2;
   CLUS2vads [4] + ( T_TOTAL_PREMIUM - -0.00926126836624 )**2;
end;
else _vqmvar + 1;
if not missing( IMP_GeographicLiving1 ) then do;
   CLUS2vads [1] + ( IMP_GeographicLiving1 - 0.00456772391633 )**2;
   CLUS2vads [2] + ( IMP_GeographicLiving1 - 0.00760933743189 )**2;
   CLUS2vads [3] + ( IMP_GeographicLiving1 - 0.00100639971767 )**2;
   CLUS2vads [4] + ( IMP_GeographicLiving1 - -0.01354375890968 )**2;
end;
else _vqmvar + 0.25;
if not missing( IMP_GeographicLiving2 ) then do;
   CLUS2vads [1] + ( IMP_GeographicLiving2 - -0.01259165223961 )**2;
   CLUS2vads [2] + ( IMP_GeographicLiving2 - -0.01235194613171 )**2;
   CLUS2vads [3] + ( IMP_GeographicLiving2 - 0.02014255308198 )**2;
   CLUS2vads [4] + ( IMP_GeographicLiving2 - 0.00362419597393 )**2;
end;
else _vqmvar + 0.24999999999999;
if not missing( IMP_GeographicLiving3 ) then do;
   CLUS2vads [1] + ( IMP_GeographicLiving3 - 0.00177091392525 )**2;
   CLUS2vads [2] + ( IMP_GeographicLiving3 - 0.01082098116413 )**2;
   CLUS2vads [3] + ( IMP_GeographicLiving3 - 0.00019497309837 )**2;
   CLUS2vads [4] + ( IMP_GeographicLiving3 - -0.01342254073784 )**2;
end;
else _vqmvar + 0.25;
if not missing( IMP_GeographicLiving4 ) then do;
   CLUS2vads [1] + ( IMP_GeographicLiving4 - 0.00202906443135 )**2;
   CLUS2vads [2] + ( IMP_GeographicLiving4 - -0.00833996871543 )**2;
   CLUS2vads [3] + ( IMP_GeographicLiving4 - -0.01345695379991 )**2;
   CLUS2vads [4] + ( IMP_GeographicLiving4 - 0.0213445569078 )**2;
end;
else _vqmvar + 0.25;
if not missing( IMP_HasChildren0 ) then do;
   CLUS2vads [1] + ( IMP_HasChildren0 - -0.23352761272638 )**2;
   CLUS2vads [2] + ( IMP_HasChildren0 - -0.36293233475189 )**2;
   CLUS2vads [3] + ( IMP_HasChildren0 - -0.4551073921315 )**2;
   CLUS2vads [4] + ( IMP_HasChildren0 - 1.09668330557976 )**2;
end;
else _vqmvar + 0.5;
if not missing( IMP_HasChildren1 ) then do;
   CLUS2vads [1] + ( IMP_HasChildren1 - 0.23352761272638 )**2;
   CLUS2vads [2] + ( IMP_HasChildren1 - 0.36293233475189 )**2;
   CLUS2vads [3] + ( IMP_HasChildren1 - 0.4551073921315 )**2;
   CLUS2vads [4] + ( IMP_HasChildren1 - -1.09668330557976 )**2;
end;
else _vqmvar + 0.5;
if not missing( T_IMP_EducationalDegree ) then do;
   CLUS2vads [1] + ( T_IMP_EducationalDegree - -1.08654221882581 )**2;
   CLUS2vads [2] + ( T_IMP_EducationalDegree - 0.90131135525391 )**2;
   CLUS2vads [3] + ( T_IMP_EducationalDegree - -0.01978298971131 )**2;
   CLUS2vads [4] + ( T_IMP_EducationalDegree - 0.09968811222805 )**2;
end;
else _vqmvar + 1;
_vqnvar = 9 - _vqmvar;
if _vqnvar <= 1.3301360013429E-11 then do;
   _SEGMENT_ = .; Distance = .;
end;
else do;
   _SEGMENT_ = 1; Distance = CLUS2vads [1];
   _vqfzdst = Distance * 0.99999999999988; drop _vqfzdst;
   do _vqclus = 2 to 4;
      if CLUS2vads [_vqclus] < _vqfzdst then do;
         _SEGMENT_ = _vqclus; Distance = CLUS2vads [_vqclus];
         _vqfzdst = Distance * 0.99999999999988;
      end;
   end;
   Distance = sqrt(Distance * (9 / _vqnvar));
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