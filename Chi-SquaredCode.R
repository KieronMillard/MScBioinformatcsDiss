# Contigency Chi-Squared Statistical Testing Set up and Analysis.

## HYPOTHESIS TESTING

# Null: There is no significant difference between Low Income, Low Education, 
## Socioeconomic Status and ADHD Diagnosis Scores in relation to Tic Presence.

# Alternative Hypothesis: There is significant difference between Low Income, 
## Low Education, Socioeconomic Status and ADHD Diagnosis Scores in relation to Tic Presence.

# Import CAPA with Tic Phenotype added (Presence/Absence)

TicList<- read.table("T-TestList.csv", header = TRUE, sep = ",")

# Remove all numerical values that indicate NA (-1 is the code for NA in CAPA)

TicList["Low_income"][TicList["Low_income"] == "-1"] <- NA
TicList["Low_education"][TicList["Low_education"] == "-1"] <- NA
TicList["SS_low"][TicList["SS_low"] == "-1"] <- NA

# Create a contingency table for Income(Tic Presence/Absence Vs. Low Income or 
## High Income)
Income <- table(CAPAPRS$Tic_Phenotype, CAPAPRS$Low_income)

#Conduct chisq test on contingency table with Yates' continuity correction
chisq.test(Income)

# Chi-Squared Value: 3.9202, DoF: 1 

# p-value: 0.04771

# Conclusion: The p-value is 0.04771, therefore we can reject the null 
## hypothesis that there is no difference in the relation between family income 
### and Tic Presence

# Repeat previous steps again for each variable.
Education <- table(CAPAPRS$Tic_Phenotype, CAPAPRS$Low_education)

chisq.test(Education)

# Chi-Squared Value: 0.082148, DoF: 1

# p-value: 0.7744

# Conclusion: The p-value is 0.7744, therefore we can accept the null 
## hypothesis that there is no difference in the relation between family 
### education and Tic Presence

Socio <- table(CAPAPRS$Tic_Phenotype, CAPAPRS$SS_low)

chisq.test(Socio)

# Chi-Squared Value: 0.54512, DoF: 1

# p-value: 0.4603

# Conclusion: The p-value is 0.4603, therefore we can accept the null 
## hypothesis that there is no difference in the relation between family 
### education and Tic Presence

Diagnosis <- table(CAPAPRS$Tic_Phenotype, CAPAPRS$ADHD_DSM_diagnosis)

comb <- c(391,69)
other <- c(152,18)

Diagnosis <- data.frame(comb,other)

chisq.test(Diagnosis)

# Chi-Squared Value: 2.9663 (States this may be incorrect), DoF: 4

# p-value: 0.1954

# Conclusion: The p-value is 0.5635, therefore we can accept the null 
## hypothesis that there is no difference in the relation between family 
### education and Tic Presence

Sex <- table(CAPAPRS$Tic_Phenotype, CAPAPRS$sex)

chisq.test(Sex)

# Chi-Squared Value: 3.9758, DoF: 1 

# p-value: 0.04771

# Conclusion: The p-value is 0.04771, therefore we can reject the null 
## hypothesis that there is no difference in the relation between family 
### education and Tic Presence