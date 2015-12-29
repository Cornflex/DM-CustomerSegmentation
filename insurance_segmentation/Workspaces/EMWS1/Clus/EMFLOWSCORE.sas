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

*** Generate dummy variables for IMP_CustomerAge ;
drop T_IMP_CustomerAge ;
if missing( IMP_CustomerAge ) then do;
   T_IMP_CustomerAge = .;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( IMP_CustomerAge , BEST12. );
   %DMNORMIP( _dm12 )
   _dm_find = 0; drop _dm_find;
   if _dm12 <= '48'  then do;
     if _dm12 <= '31'  then do;
       if _dm12 <= '23'  then do;
         if _dm12 <= '19'  then do;
           if _dm12 <= '17'  then do;
             if _dm12 <= '16'  then do;
               if _dm12 = '15'  then do;
                  T_IMP_CustomerAge = -1.73017911357965;
                  _dm_find = 1;
               end;
               else do;
                 if _dm12 = '16'  then do;
                    T_IMP_CustomerAge = -1.72227183836201;
                    _dm_find = 1;
                 end;
               end;
             end;
             else do;
               if _dm12 = '17'  then do;
                  T_IMP_CustomerAge = -1.70477488894424;
                  _dm_find = 1;
               end;
             end;
           end;
           else do;
             if _dm12 = '18'  then do;
                T_IMP_CustomerAge = -1.67735178552986;
                _dm_find = 1;
             end;
             else do;
               if _dm12 = '19'  then do;
                  T_IMP_CustomerAge = -1.63916132862763;
                  _dm_find = 1;
               end;
             end;
           end;
         end;
         else do;
           if _dm12 <= '21'  then do;
             if _dm12 = '20'  then do;
                T_IMP_CustomerAge = -1.59373655610074;
                _dm_find = 1;
             end;
             else do;
               if _dm12 = '21'  then do;
                  T_IMP_CustomerAge = -1.5446105058124;
                  _dm_find = 1;
               end;
             end;
           end;
           else do;
             if _dm12 = '22'  then do;
                T_IMP_CustomerAge = -1.48875485959416;
                _dm_find = 1;
             end;
             else do;
               if _dm12 = '23'  then do;
                  T_IMP_CustomerAge = -1.43289921337591;
                  _dm_find = 1;
               end;
             end;
           end;
         end;
       end;
       else do;
         if _dm12 <= '27'  then do;
           if _dm12 <= '25'  then do;
             if _dm12 = '24'  then do;
                T_IMP_CustomerAge = -1.37939892573313;
                _dm_find = 1;
             end;
             else do;
               if _dm12 = '25'  then do;
                  T_IMP_CustomerAge = -1.32522567849736;
                  _dm_find = 1;
               end;
             end;
           end;
           else do;
             if _dm12 = '26'  then do;
                T_IMP_CustomerAge = -1.26667819390715;
                _dm_find = 1;
             end;
             else do;
               if _dm12 = '27'  then do;
                  T_IMP_CustomerAge = -1.20628007043622;
                  _dm_find = 1;
               end;
             end;
           end;
         end;
         else do;
           if _dm12 <= '29'  then do;
             if _dm12 = '28'  then do;
                T_IMP_CustomerAge = -1.15042442421797;
                _dm_find = 1;
             end;
             else do;
               if _dm12 = '29'  then do;
                  T_IMP_CustomerAge = -1.09490525779622;
                  _dm_find = 1;
               end;
             end;
           end;
           else do;
             if _dm12 = '30'  then do;
                T_IMP_CustomerAge = -1.03686249290075;
                _dm_find = 1;
             end;
             else do;
               if _dm12 = '31'  then do;
                  T_IMP_CustomerAge = -0.98050212698776;
                  _dm_find = 1;
               end;
             end;
           end;
         end;
       end;
     end;
     else do;
       if _dm12 <= '40'  then do;
         if _dm12 <= '36'  then do;
           if _dm12 <= '34'  then do;
             if _dm12 <= '33'  then do;
               if _dm12 = '32'  then do;
                  T_IMP_CustomerAge = -0.92279584188879;
                  _dm_find = 1;
               end;
               else do;
                 if _dm12 = '33'  then do;
                    T_IMP_CustomerAge = -0.86525779668807;
                    _dm_find = 1;
                 end;
               end;
             end;
             else do;
               if _dm12 = '34'  then do;
                  T_IMP_CustomerAge = -0.8114210292488;
                  _dm_find = 1;
               end;
             end;
           end;
           else do;
             if _dm12 = '35'  then do;
                T_IMP_CustomerAge = -0.75203234516735;
                _dm_find = 1;
             end;
             else do;
               if _dm12 = '36'  then do;
                  T_IMP_CustomerAge = -0.69146598179816;
                  _dm_find = 1;
               end;
             end;
           end;
         end;
         else do;
           if _dm12 <= '38'  then do;
             if _dm12 = '37'  then do;
                T_IMP_CustomerAge = -0.63527385578342;
                _dm_find = 1;
             end;
             else do;
               if _dm12 = '38'  then do;
                  T_IMP_CustomerAge = -0.57857701007394;
                  _dm_find = 1;
               end;
             end;
           end;
           else do;
             if _dm12 = '39'  then do;
                T_IMP_CustomerAge = -0.51834712650125;
                _dm_find = 1;
             end;
             else do;
               if _dm12 = '40'  then do;
                  T_IMP_CustomerAge = -0.45879020252155;
                  _dm_find = 1;
               end;
             end;
           end;
         end;
       end;
       else do;
         if _dm12 <= '44'  then do;
           if _dm12 <= '42'  then do;
             if _dm12 = '41'  then do;
                T_IMP_CustomerAge = -0.40074743762609;
                _dm_find = 1;
             end;
             else do;
               if _dm12 = '42'  then do;
                  T_IMP_CustomerAge = -0.33967635456216;
                  _dm_find = 1;
               end;
             end;
           end;
           else do;
             if _dm12 = '43'  then do;
                T_IMP_CustomerAge = -0.28079239017546;
                _dm_find = 1;
             end;
             else do;
               if _dm12 = '44'  then do;
                  T_IMP_CustomerAge = -0.22931098131165;
                  _dm_find = 1;
               end;
             end;
           end;
         end;
         else do;
           if _dm12 <= '46'  then do;
             if _dm12 = '45'  then do;
                T_IMP_CustomerAge = -0.18001669112507;
                _dm_find = 1;
             end;
             else do;
               if _dm12 = '46'  then do;
                  T_IMP_CustomerAge = -0.12617992368579;
                  _dm_find = 1;
               end;
             end;
           end;
           else do;
             if _dm12 = '47'  then do;
                T_IMP_CustomerAge = -0.07570795421147;
                _dm_find = 1;
             end;
             else do;
               if _dm12 = '48'  then do;
                  T_IMP_CustomerAge = -0.02018878778972;
                  _dm_find = 1;
               end;
             end;
           end;
         end;
       end;
     end;
   end;
   else do;
     if _dm12 <= '65'  then do;
       if _dm12 <= '57'  then do;
         if _dm12 <= '53'  then do;
           if _dm12 <= '51'  then do;
             if _dm12 <= '50'  then do;
               if _dm12 = '49'  then do;
                  T_IMP_CustomerAge = 0.04357413364616;
                  _dm_find = 1;
               end;
               else do;
                 if _dm12 = '50'  then do;
                    T_IMP_CustomerAge = 0.10195337833812;
                    _dm_find = 1;
                 end;
               end;
             end;
             else do;
               if _dm12 = '51'  then do;
                  T_IMP_CustomerAge = 0.15713606496337;
                  _dm_find = 1;
               end;
             end;
           end;
           else do;
             if _dm12 = '52'  then do;
                T_IMP_CustomerAge = 0.21669298894307;
                _dm_find = 1;
             end;
             else do;
               if _dm12 = '53'  then do;
                  T_IMP_CustomerAge = 0.28062415027721;
                  _dm_find = 1;
               end;
             end;
           end;
         end;
         else do;
           if _dm12 <= '55'  then do;
             if _dm12 = '54'  then do;
                T_IMP_CustomerAge = 0.34943426866053;
                _dm_find = 1;
             end;
             else do;
               if _dm12 = '55'  then do;
                  T_IMP_CustomerAge = 0.41302895019817;
                  _dm_find = 1;
               end;
             end;
           end;
           else do;
             if _dm12 = '56'  then do;
                T_IMP_CustomerAge = 0.46703395753569;
                _dm_find = 1;
             end;
             else do;
               if _dm12 = '57'  then do;
                  T_IMP_CustomerAge = 0.52373080324518;
                  _dm_find = 1;
               end;
             end;
           end;
         end;
       end;
       else do;
         if _dm12 <= '61'  then do;
           if _dm12 <= '59'  then do;
             if _dm12 = '58'  then do;
                T_IMP_CustomerAge = 0.5812688484459;
                _dm_find = 1;
             end;
             else do;
               if _dm12 = '59'  then do;
                  T_IMP_CustomerAge = 0.63914337344312;
                  _dm_find = 1;
               end;
             end;
           end;
           else do;
             if _dm12 = '60'  then do;
                T_IMP_CustomerAge = 0.69752261813508;
                _dm_find = 1;
             end;
             else do;
               if _dm12 = '61'  then do;
                  T_IMP_CustomerAge = 0.7557336229288;
                  _dm_find = 1;
               end;
             end;
           end;
         end;
         else do;
           if _dm12 <= '63'  then do;
             if _dm12 = '62'  then do;
                T_IMP_CustomerAge = 0.81579526660324;
                _dm_find = 1;
             end;
             else do;
               if _dm12 = '63'  then do;
                  T_IMP_CustomerAge = 0.87938994814088;
                  _dm_find = 1;
               end;
             end;
           end;
           else do;
             if _dm12 = '64'  then do;
                T_IMP_CustomerAge = 0.94315286957677;
                _dm_find = 1;
             end;
             else do;
               if _dm12 = '65'  then do;
                  T_IMP_CustomerAge = 1.00573811172492;
                  _dm_find = 1;
               end;
             end;
           end;
         end;
       end;
     end;
     else do;
       if _dm12 <= '74'  then do;
         if _dm12 <= '70'  then do;
           if _dm12 <= '68'  then do;
             if _dm12 <= '67'  then do;
               if _dm12 = '66'  then do;
                  T_IMP_CustomerAge = 1.06226671753616;
                  _dm_find = 1;
               end;
               else do;
                 if _dm12 = '67'  then do;
                    T_IMP_CustomerAge = 1.11761764405966;
                    _dm_find = 1;
                 end;
               end;
             end;
             else do;
               if _dm12 = '68'  then do;
                  T_IMP_CustomerAge = 1.17549216905688;
                  _dm_find = 1;
               end;
             end;
           end;
           else do;
             if _dm12 = '69'  then do;
                T_IMP_CustomerAge = 1.23202077486812;
                _dm_find = 1;
             end;
             else do;
               if _dm12 = '70'  then do;
                  T_IMP_CustomerAge = 1.29140945894957;
                  _dm_find = 1;
               end;
             end;
           end;
         end;
         else do;
           if _dm12 <= '72'  then do;
             if _dm12 = '71'  then do;
                T_IMP_CustomerAge = 1.34978870364153;
                _dm_find = 1;
             end;
             else do;
               if _dm12 = '72'  then do;
                  T_IMP_CustomerAge = 1.40614906955452;
                  _dm_find = 1;
               end;
             end;
           end;
           else do;
             if _dm12 = '73'  then do;
                T_IMP_CustomerAge = 1.46217295567101;
                _dm_find = 1;
             end;
             else do;
               if _dm12 = '74'  then do;
                  T_IMP_CustomerAge = 1.51685092260153;
                  _dm_find = 1;
               end;
             end;
           end;
         end;
       end;
       else do;
         if _dm12 <= '78'  then do;
           if _dm12 <= '76'  then do;
             if _dm12 = '75'  then do;
                T_IMP_CustomerAge = 1.56850057136358;
                _dm_find = 1;
             end;
             else do;
               if _dm12 = '76'  then do;
                  T_IMP_CustomerAge = 1.61426182368696;
                  _dm_find = 1;
               end;
             end;
           end;
           else do;
             if _dm12 = '77'  then do;
                T_IMP_CustomerAge = 1.65262052048745;
                _dm_find = 1;
             end;
             else do;
               if _dm12 = '78'  then do;
                  T_IMP_CustomerAge = 1.68256722237554;
                  _dm_find = 1;
               end;
             end;
           end;
         end;
         else do;
           if _dm12 <= '80'  then do;
             if _dm12 = '79'  then do;
                T_IMP_CustomerAge = 1.70511136874074;
                _dm_find = 1;
             end;
             else do;
               if _dm12 = '80'  then do;
                  T_IMP_CustomerAge = 1.72092591917602;
                  _dm_find = 1;
               end;
             end;
           end;
           else do;
             if _dm12 = '81'  then do;
                T_IMP_CustomerAge = 1.72950615398666;
                _dm_find = 1;
             end;
             else do;
               if _dm12 = '988'  then do;
                  T_IMP_CustomerAge = 1.73202975246037;
                  _dm_find = 1;
               end;
             end;
           end;
         end;
       end;
     end;
   end;
   if not _dm_find then do;
      T_IMP_CustomerAge = .;
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
   goto CLUSvlex ;
end; *** omitted;

*** Compute Distances and Cluster Membership;
label _SEGMENT_ = 'Segment Id' ;
label Distance = 'Distance' ;
array CLUSvads [3] _temporary_;
drop _vqclus _vqmvar _vqnvar;
_vqmvar = 0;
do _vqclus = 1 to 3; CLUSvads [_vqclus] = 0; end;
if not missing( T_ClaimsRate ) then do;
   CLUSvads [1] + ( T_ClaimsRate - -0.00839720996467 )**2;
   CLUSvads [2] + ( T_ClaimsRate - -0.0257225071637 )**2;
   CLUSvads [3] + ( T_ClaimsRate - 0.05533007658259 )**2;
end;
else _vqmvar + 1;
if not missing( T_CustomerMonetaryValue ) then do;
   CLUSvads [1] + ( T_CustomerMonetaryValue - 0.02634245834679 )**2;
   CLUSvads [2] + ( T_CustomerMonetaryValue - 0.01257750775709 )**2;
   CLUSvads [3] + ( T_CustomerMonetaryValue - -0.05642988767147 )**2;
end;
else _vqmvar + 1;
if not missing( T_IMP_GrossMonthlySalary ) then do;
   CLUSvads [1] + ( T_IMP_GrossMonthlySalary - -0.90098045134894 )**2;
   CLUSvads [2] + ( T_IMP_GrossMonthlySalary - 0.14517850291388 )**2;
   CLUSvads [3] + ( T_IMP_GrossMonthlySalary - 0.94055259005961 )**2;
end;
else _vqmvar + 1;
if not missing( T_IMP_REP_FirstPolicyYear ) then do;
   CLUSvads [1] + ( T_IMP_REP_FirstPolicyYear - 0.01047279101086 )**2;
   CLUSvads [2] + ( T_IMP_REP_FirstPolicyYear - -0.02721915232072 )**2;
   CLUSvads [3] + ( T_IMP_REP_FirstPolicyYear - 0.03297602469684 )**2;
end;
else _vqmvar + 1;
if not missing( T_TOTAL_PREMIUM ) then do;
   CLUSvads [1] + ( T_TOTAL_PREMIUM - 0.2346074660789 )**2;
   CLUSvads [2] + ( T_TOTAL_PREMIUM - -0.17947211888365 )**2;
   CLUSvads [3] + ( T_TOTAL_PREMIUM - -0.00127233354532 )**2;
end;
else _vqmvar + 1;
if not missing( IMP_GeographicLiving1 ) then do;
   CLUSvads [1] + ( IMP_GeographicLiving1 - 0.01188877255933 )**2;
   CLUSvads [2] + ( IMP_GeographicLiving1 - -0.00155845761023 )**2;
   CLUSvads [3] + ( IMP_GeographicLiving1 - -0.01302529324438 )**2;
end;
else _vqmvar + 0.25;
if not missing( IMP_GeographicLiving2 ) then do;
   CLUSvads [1] + ( IMP_GeographicLiving2 - -0.01975152584848 )**2;
   CLUSvads [2] + ( IMP_GeographicLiving2 - 0.01389485686447 )**2;
   CLUSvads [3] + ( IMP_GeographicLiving2 - 0.00219637881705 )**2;
end;
else _vqmvar + 0.24999999999999;
if not missing( IMP_GeographicLiving3 ) then do;
   CLUSvads [1] + ( IMP_GeographicLiving3 - 0.00243927644122 )**2;
   CLUSvads [2] + ( IMP_GeographicLiving3 - 0.00589894325882 )**2;
   CLUSvads [3] + ( IMP_GeographicLiving3 - -0.01336725818733 )**2;
end;
else _vqmvar + 0.25;
if not missing( IMP_GeographicLiving4 ) then do;
   CLUSvads [1] + ( IMP_GeographicLiving4 - -0.00093775791096 )**2;
   CLUSvads [2] + ( IMP_GeographicLiving4 - -0.0118934933768 )**2;
   CLUSvads [3] + ( IMP_GeographicLiving4 - 0.02169300671328 )**2;
end;
else _vqmvar + 0.25;
if not missing( IMP_HasChildren0 ) then do;
   CLUSvads [1] + ( IMP_HasChildren0 - -0.24140077696223 )**2;
   CLUSvads [2] + ( IMP_HasChildren0 - -0.45227098414142 )**2;
   CLUSvads [3] + ( IMP_HasChildren0 - 1.09670583507158 )**2;
end;
else _vqmvar + 0.5;
if not missing( IMP_HasChildren1 ) then do;
   CLUSvads [1] + ( IMP_HasChildren1 - 0.24140077696223 )**2;
   CLUSvads [2] + ( IMP_HasChildren1 - 0.45227098414142 )**2;
   CLUSvads [3] + ( IMP_HasChildren1 - -1.09670583507158 )**2;
end;
else _vqmvar + 0.5;
if not missing( T_IMP_CustomerAge ) then do;
   CLUSvads [1] + ( T_IMP_CustomerAge - -1.07780956503416 )**2;
   CLUSvads [2] + ( T_IMP_CustomerAge - 0.15852371777998 )**2;
   CLUSvads [3] + ( T_IMP_CustomerAge - 1.15119939740702 )**2;
end;
else _vqmvar + 0.99999999999999;
if not missing( T_IMP_EducationalDegree ) then do;
   CLUSvads [1] + ( T_IMP_EducationalDegree - -0.57991598884349 )**2;
   CLUSvads [2] + ( T_IMP_EducationalDegree - 0.3820853514168 )**2;
   CLUSvads [3] + ( T_IMP_EducationalDegree - 0.10898713050979 )**2;
end;
else _vqmvar + 1;
_vqnvar = 9 - _vqmvar;
if _vqnvar <= 1.3301360013429E-11 then do;
   _SEGMENT_ = .; Distance = .;
end;
else do;
   _SEGMENT_ = 1; Distance = CLUSvads [1];
   _vqfzdst = Distance * 0.99999999999988; drop _vqfzdst;
   do _vqclus = 2 to 3;
      if CLUSvads [_vqclus] < _vqfzdst then do;
         _SEGMENT_ = _vqclus; Distance = CLUSvads [_vqclus];
         _vqfzdst = Distance * 0.99999999999988;
      end;
   end;
   Distance = sqrt(Distance * (9 / _vqnvar));
end;
CLUSvlex :;

***************************************;
*** End Scoring Code from PROC DMVQ ***;
***************************************;
*------------------------------------------------------------*;
* Clus: Creating Segment Label;
*------------------------------------------------------------*;
length _SEGMENT_LABEL_ $80;
label _SEGMENT_LABEL_='Segment Description';
if _SEGMENT_ = 1 then _SEGMENT_LABEL_="Cluster1";
else
if _SEGMENT_ = 2 then _SEGMENT_LABEL_="Cluster2";
else
if _SEGMENT_ = 3 then _SEGMENT_LABEL_="Cluster3";
