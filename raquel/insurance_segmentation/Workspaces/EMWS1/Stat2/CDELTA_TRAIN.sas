if ROLE in('INPUT', 'REJECTED') then do;
if upcase(NAME) in(
'CLAIMSRATE'
'CUSTOMERMONETARYVALUE'
'IMP_EDUCATIONALDEGREE'
'IMP_FIRSTPOLICYYEAR'
'IMP_GEOGRAPHICLIVING'
'IMP_GROSSMONTHLYSALARY'
'IMP_HASCHILDREN'
'IMP_PREMIUMSINLOBHEALTH'
'IMP_PREMIUMSINLOBLIFE'
'IMP_PREMIUMSINLOBMOTOR'
'IMP_PREMIUMSINLOBWORKCOMP'
'IMP_REP_CUSTOMERAGE'
'IMP_REP_FIRSTPOLICYYEAR'
'LOYALTY'
'PREMIUMSINLOBHOUSEHOLD'
'TOTAL_PREMIUM'
) then ROLE='INPUT';
else delete;
end;
