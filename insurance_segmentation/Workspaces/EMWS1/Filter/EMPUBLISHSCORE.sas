

length _FILTERFMT1  $200;
drop _FILTERFMT1 ;
_FILTERFMT1= put(FirstPolicyYear,BEST12.0);
if
_FILTERFMT1 not in ( '       53784')
and
( CustomerAge eq . or (0<=CustomerAge) and (CustomerAge<=150))
and ( CustomerMonetaryValue eq . or (-35784.17035<=CustomerMonetaryValue) and (CustomerMonetaryValue<=11899.001562))
and ( GrossMonthlySalary eq . or (0<=GrossMonthlySalary) and (GrossMonthlySalary<=11558.490849))
then do;
if M_FILTER eq . then M_FILTER = 0;
else M_FILTER = M_FILTER + 0;
end;
else M_FILTER = 1;
label M_FILTER = 'Filtered Indicator';