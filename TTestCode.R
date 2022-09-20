# T-Test Set Up and Analysis - This follows on from data import from 
## "CAPA_Descriptive_Stats.Rmd"

# import ggplot 2 for data visualisation

install.packages("ggplot2")
install.packages("car")
library(ggplot2)
library(car)
## HYPOTHESIS TESTING

# Null: There is no difference in mean values (IQ, Inattentive Score, 
## Hyperactive Score, Final ADHD Score) between children with Tic Presence and 
###Children Without.

# Alternative: This is a difference in mean values (IQ, Inattentive Score, 
## Hyperactive Score, Final ADHD Score) between children with Tic Presence and 
### Children Without.

#Is it one-sided or two-sided test?
 ##Two-sided. No directionality is implied.

#is this a two-sample or paired t-test
  ##Two sample, the individuals with the tic presence and without the tic 
  ###presence are statistically independent.


#graph the data
# a boxplot intially for numeric and categorical data 

IQBox <- ggplot(CAPAPRS, aes(x = Tic_Phenotype, y = Final_IQ)) +geom_boxplot() + 
  theme_classic()
InattentiveBox <- ggplot(CAPAPRS, aes(x = Tic_Phenotype, y = inat_final)) +
  geom_boxplot() + theme_classic()
HyperactiveBox <- ggplot(CAPAPRS, aes(x = Tic_Phenotype, y = hypimp_final)) +
  geom_boxplot() + theme_classic()
ADHDScoreBox <- ggplot(CAPAPRS, aes(x = Tic_Phenotype, y = adhd_final)) +
  geom_boxplot() + theme_classic()

# Hypothesis Testing Step 2: Calculate the Test Statistic
 # var.equal = need to conduct a levene test to see if variance is equal, if 
 ## the test is significant, it must be assumed that the variance is not equal 
 ##  paired = FALSE as its a two sample test.

leveneTest(CAPAPRS$Final_IQ, CAPAPRS$Tic_Phenotype, center=mean)

# Levene test came back with a p value of 0.4016, not significant so therefore 
 # variance is equal

t.test(Final_IQ ~ Tic_Phenotype, data = CAPAPRS, var.equal = TRUE, paired = FALSE)

## t = 0.24278

# Step 3: Calculate the p-value
# p = 0.8083

# Step 4: State Conclusion
## Our p-value is insignificant, therefore we can accept the null hypothesis 
### that there is no difference in mean IQ between Tic Absence and Tic Presence.

# Mean in Absent = 82.78842, Present = 82.39241

leveneTest(CAPAPRS$inat_final, CAPAPRS$Tic_Phenotype, center=mean)

# Levene test came back with a p value of 0.008283, this is significant so can 
 # be assumed the variance is not equal.

t.test(inat_final ~ Tic_Phenotype, data = CAPAPRS, var.equal = FALSE, paired = FALSE)

## t = -3.0624

# Step 3: Calculate p-value
## p = 0.002659

# Step 4: State Conclusion
## The p-value is 0.002659, therefore we can reject the null hypothesis that 
### there is no difference in mean Inattentive Score between Tic Absence and 
#### Tic Presence

# Mean in Absent = 7.417939, Present = 7.917647

leveneTest(CAPAPRS$hypimp_final, CAPAPRS$Tic_Phenotype, center=mean)

# Levene test came back with a p value of 0.03229, this is significant so can be 
 # assumed the variance is not equal.

t.test(hypimp_final ~ Tic_Phenotype, data = CAPAPRS, var.equal = FALSE, paired = FALSE)

## t = -2.0047

#Step 3: Calculate the p-value

## p = 0.04736

#Step 4: State Conclusion
## The p-value is 0.04736, therefore we can reject the null hypothesis that 
### there is no difference in the mean Hyperactive-Impulsivity Score between
#### Tic Absence and Tic Presence.

# Mean in Absent = 7.677481, Present = 8.023529

leveneTest(CAPAPRS$adhd_final, CAPAPRS$Tic_Phenotype, center=mean)

# Levene test came back with a p value of 0.05166, this is not significant so 
 # Can be assumed the variance is equal.

t.test(adhd_final ~ Tic_Phenotype, data = CAPAPRS, var.equal = TRUE, paired = FALSE)

## t = -2.9775

# Step 3: Calculate p-value
## p = 0.003022

# Step 4: State Conclusion
## The p-value is 0.003022, therefore we can reject the null hypothesis that 
### there is no difference in the mean ADHD Final Score between Tic Absence and
#### Tic Presence

# Mean in Absent = 15.09542, Present = 15.94118

leveneTest(CAPAPRS$SCQ_total_imputed, CAPAPRS$Tic_Phenotype, center=mean)

# Levene test came back with a p value of 0.5972, this is not significant so can
 # be assumed the variance is equal.

t.test(SCQ_total_imputed ~ Tic_Phenotype, data = CAPAPRS, var.equal = TRUE, paired = FALSE)

## t = -3.2356

# Step 3: Calculate p-value
## p = 0.001294

# Step 4: State Conclusion
## The p-value is 0.001294, therefore we can reject the null hypothesis that 
### there is no difference in the mean ADHD Final Score between Tic Absence and
#### Tic Presence

# Mean in Absent = 12.95682, Present = 15.95455


