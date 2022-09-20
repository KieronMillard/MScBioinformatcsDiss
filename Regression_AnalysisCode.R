# PRS IMPORT AND LOGISTICAL REGRESSION ANALYSIS

# import PRS data

PRS <- read.table("ADHD_TouretteGWAS_PRS_CS_auto.profile", header = TRUE, sep = "")
colnames(PRS)[1] <- "ID"
colnames(PRS)[2] <- "ID2"

MyFilt <- c("ID", "ID2", "SCORE")
PRSFilt <- PRS[MyFilt]

# Scaling (Standardising) PRS 
CAPAPRS$SCORE_STD <- scale(CAPAPRS$SCORE)


apply(scaled.dat, 2, mean)
apply(scaled.dat, 2, sd)

library(tidyverse)
CAPAPRS <- left_join(TicList, PRSFilt, by = c("ID", "ID2"))
rm(PRS)

#LOGISTICAL REGRESSION ANALYSIS

CAPAPRS["Tic_Phenotype"][CAPAPRS["Tic_Phenotype"] == "Absent"] <- "0"
CAPAPRS["Tic_Phenotype"][CAPAPRS["Tic_Phenotype"] == "Present"] <- "1"
CAPAPRS["SCQ_total_imputed"][CAPAPRS["SCQ_total_imputed"] == "-1"] <- NA
CAPAPRS["inat_final"][CAPAPRS["inat_final"] == "-1"] <- NA
CAPAPRS["hypimp_final"][CAPAPRS["hypimp_final"] =="-1"] <- NA
CAPAPRS["adhd_final"][CAPAPRS["adhd_final"] == "-1"]<- NA


---------------------------------------------------------------------------------
## Looking at standardised score on its own in relation to tic phenotype

CAPAPRS$Tic_Phenotype <- as.factor(CAPAPRS$Tic_Phenotype)

Logistic <- glm(Tic_Phenotype ~ SCORE_STD, data = CAPAPRS, family = binomial(link="logit"))

## Tic Presence = -3.237e+00 + 1.670e+06 x SCORE
summary(Logistic)


round(exp(coef(Logistic))[2],2) # OR
round(exp(confint(Logistic))[2,1],2) # 95% CI (lower)
round(exp(confint(Logistic))[2,2],2) # 95% CI (upper)



--------------------------------------------------------------------------------------------

MultiLogistic <- glm(Tic_Phenotype ~ V1 + study_source + PC1 + PC2 + PC3 + PC4 + PC5 + PC6 + PC7 + PC8 + PC9 + PC10,
  data = CAPAPRSPC, family = binomial(link="logit"))

PC <- read.table("ADHD_10_PCs", header = TRUE, sep = "")
colnames(PC) <- c("ID", "ID2", "PC1", "PC2", "PC3", "PC4", "PC5", "PC6", "PC7", "PC8", "PC9", "PC10")
CAPAPRSPC <- left_join(CAPAPRS, PC, by = c("ID", "ID2"))
CAPAPRSPC <- left_join(CAPAPRSPC, PRSComp, by = c("ID", "ID2"))

summary(MultiLogistic)

round(exp(coef(MultiLogistic))[2],2) # OR
round(exp(confint(MultiLogistic))[2,1],2) # 95% CI (lower)
round(exp(confint(MultiLogistic))[2,2],2) # 95% CI (upper)



