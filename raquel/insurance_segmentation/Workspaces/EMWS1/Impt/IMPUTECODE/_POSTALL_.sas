*;
* Drop prediction variables since they are for INPUTS not TARGETS;
* Replace _NODE_ by _XODE_ so it can be safely dropped;
*;
drop
P_EducationalDegr4___PhD
P_EducationalDegr3___BSc_MSc
P_EducationalDegr2___High_School
P_EducationalDegr1___Basic
I_EducationalDegree
U_EducationalDegree
Q_EducationalDegr4___PhD
Q_EducationalDegr3___BSc_MSc
Q_EducationalDegr2___High_School
Q_EducationalDegr1___Basic
P_GeographicLiving2
P_GeographicLiving3
P_GeographicLiving4
P_GeographicLiving1
I_GeographicLiving
U_GeographicLiving
Q_GeographicLiving2
Q_GeographicLiving3
Q_GeographicLiving4
Q_GeographicLiving1
P_HasChildren0
P_HasChildren1
I_HasChildren
U_HasChildren
Q_HasChildren0
Q_HasChildren1
;
