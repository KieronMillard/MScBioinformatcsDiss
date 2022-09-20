library(ggplot2)

# Final IQ Mean Graph Visual

Tic <- c("Absent", "Present")
IQMean <- c(82.78842,82.39241)
IQChart <- data.frame(Tic, IQMean)

ggplot(data=IQChart, aes(x=Tic, y = IQMean)) + geom_bar(stat='identity') + ylim(0,120) + ggtitle("IQ Score Comparison Between Tic Absence and Tic Presence") + geom_errorbar(aes(ymin=IQMean-0.5590526, ymax=IQMean+0.5590526), width=.2, position=position_dodge(.9))+ theme(plot.title = element_text(hjust = 0.5)) + labs(y = "IQ Score", x = "Tic Phenotype")


# Inattentive Score

InatMean <- c(7.417939, 7.917647)
InatChart <- data.frame(Tic, InatMean)

ggplot(data=InatChart, aes(x=Tic, y = InatMean)) + geom_bar(stat='identity') + geom_text(aes(label= InatMean), vjust = 1.5, colour = "white")

# Hyperactivity Impulsivity Scoremean

HypImpMean <- c(7.677481, 8.023529)
HypImpChart <- data.frame(Tic, HypImpMean)

ggplot(data=HypImpChart, aes(x=Tic, y = HypImpMean)) + geom_bar(stat='identity') + geom_text(aes(label= HypImpMean), vjust = 1.5, colour = "white")

# Final ADHD Score

FinalScore <- c(15.09542, 15.94118)
FinalScoreChart <- data.frame(Tic, FinalScore)

ggplot(data=FinalScoreChart, aes(x=Tic, y = FinalScore)) + geom_bar(stat='identity') + geom_text(aes(label= FinalScore), vjust = 1.5, colour = "white")#

# SCQ Score

SCQScore <- c(12.95682, 15.95455)
SCQChart <- data.frame(Tic, SCQScore)

ggplot(data=SCQChart, aes(x=Tic, y = SCQScore)) + geom_bar(stat='identity') + geom_text(aes(label= SCQScore), vjust = 1.5, colour = "white")


# TABLE
install.packages("plotrix")
library(plotrix)

# IQ Results

Present <- filter(TicList, Tic_Phenotype == 1)
Absent <- filter(TicList, Tic_Phenotype == 0)

sd(Absent$Final_IQ, na.rm = TRUE)
sd(Present$Final_IQ, na.rm = TRUE)

std.error(Absent$Final_IQ, na.rm = TRUE)
std.error(Present$Final_IQ, na.rm = TRUE)

# Inattentive Results

sd(Absent$inat_final, na.rm = TRUE)
sd(Present$inat_final, na.rm = TRUE)

std.error(Absent$inat_final, na.rm = TRUE)
std.error(Present$inat_final, na.rm = TRUE)

# Hyperactivity/Impulsivity Results

sd(Absent$hypimp_final, na.rm = TRUE)
sd(Present$hypimp_final, na.rm = TRUE)

std.error(Absent$hypimp_final, na.rm = TRUE)
std.error(Present$hypimp_final, na.rm = TRUE)

#Final ADHD Score Results

sd(Absent$adhd_final, na.rm = TRUE)
sd(Present$adhd_final, na.rm = TRUE)

std.error(Absent$adhd_final, na.rm = TRUE)
std.error(Present$adhd_final, na.rm = TRUE)

# SCQ Score Results
sd(Absent$SCQ_total_imputed, na.rm = TRUE)
sd(Present$SCQ_total_imputed, na.rm = TRUE)

std.error(Absent$SCQ_total_imputed, na.rm = TRUE)
std.error(Present$SCQ_total_imputed, na.rm = TRUE)

library(tidyverse)
Tic <- filter(CAPAPRS, Tic_Phenotype == "1")
NoTic <- filter(CAPAPRS, Tic_Phenotype == "0")

std.error(Tic$Final_IQ, na.rm = TRUE)
std.error(NoTic$Final_IQ, na.rm = TRUE)

sd(Tic$Final_IQ, na.rm = TRUE)
sd(NoTic$Final_IQ, na.rm = TRUE)

-------------------------------------------------------------------------------
CAPAPRS$Tic_Phenotype[CAPAPRS$Tic_Phenotype == "0"] <- "Absent"
CAPAPRS$Tic_Phenotype[CAPAPRS$Tic_Phenotype == "1"] <- "Present"

FinalIQ <- select(CAPAPRS, Tic_Phenotype, Final_IQ)

CleanIQ <- FinalIQ %>%
  group_by(Tic_Phenotype)%>%
  summarise(mean_IQ = mean(Final_IQ, na.rm=TRUE), sd_IQ = sd(Final_IQ, na.rm=TRUE), count = n(), se_IQ = sd_IQ/(sqrt(count)))

IQPlot <- ggplot(CleanIQ, aes(x=Tic_Phenotype, y = mean_IQ, fill = Tic_Phenotype)) + geom_bar(stat="identity", colour = "black", position = position_dodge()) + geom_errorbar(aes(ymin=mean_IQ-se_IQ, ymax = mean_IQ+se_IQ), width = .2) + ylim(0,120) + ggtitle("IQ Score Comparison Between Tic Phenotype") + theme(plot.title = element_text(hjust = 0.5),legend.position= "none") + labs(y = "IQ Score", x = "Tic Phenotype")

-------------------------------------------------------------------------------
  
FinalInat <- select(CAPAPRS, Tic_Phenotype, inat_final)

CleanInat <- FinalInat %>%
  group_by(Tic_Phenotype)%>%
  summarise(mean_inat = mean(inat_final, na.rm = TRUE), sd_Inat=sd(inat_final, na.rm = TRUE), count = n(), se_Inat=sd_Inat/(sqrt(count)))

InatPlot <- ggplot(CleanInat, aes(x=Tic_Phenotype, y = mean_inat, fill = Tic_Phenotype)) + geom_bar(stat="identity", colour = "black", position = position_dodge()) + geom_errorbar(aes(ymin=mean_inat-se_Inat, ymax = mean_inat+se_Inat), width = .2) + ylim(0,10) + ggtitle("Inattentive Score Comparison Between Tic Phenotype") + theme(plot.title = element_text(hjust = 0.5), legend.position="none") + labs(y = "Inattentive Score", x = "Tic Phenotype")


-------------------------------------------------------------------------------

FinalHyp <- select(CAPAPRS, Tic_Phenotype, hypimp_final)

CleanHyp <- FinalHyp%>%
  group_by(Tic_Phenotype)%>%
  summarise(mean_hyp = mean(hypimp_final, na.rm = TRUE), sd_hyp = sd(hypimp_final, na.rm = TRUE), count = n(), se_hyp = sd_hyp/(sqrt(count)))

HypImpPlot<- ggplot(CleanHyp, aes(x=Tic_Phenotype, y = mean_hyp, fill = Tic_Phenotype)) + geom_bar(stat="identity", colour = "black", position = position_dodge()) + geom_errorbar(aes(ymin=mean_hyp-se_hyp, ymax = mean_hyp+se_hyp), width = .2) + ylim(0,10) + ggtitle("Hyperactive-Impulsive Score Comparison Between Tic Phenotype") + theme(plot.title = element_text(hjust = 0.5), legend.position="none") + labs(y = "Hyperactive/Impulsive Score", x = "Tic Phenotype")

-------------------------------------------------------------------------------

FinalADHD <- select(CAPAPRS, Tic_Phenotype, adhd_final)

CleanADHD <- FinalADHD%>%
  group_by(Tic_Phenotype)%>%
  summarise(mean_adhd = mean(adhd_final, na.rm= TRUE), sd_adhd = sd(adhd_final, na.rm = TRUE), count = n(), se_adhd = sd_adhd/(sqrt(count)))

ADHDPlot <- ggplot(CleanADHD, aes(x=Tic_Phenotype, y = mean_adhd, fill = Tic_Phenotype)) + geom_bar(stat="identity", colour = "black", position = position_dodge()) + geom_errorbar(aes(ymin=mean_adhd-se_adhd, ymax = mean_adhd+se_adhd), width = .2) + ylim(0,20) + ggtitle("Total ADHD Score Comparison Between Tic Phenotype") + theme(plot.title = element_text(hjust = 0.5), legend.position="none") + labs(y = "Total ADHD Score", x = "Tic Phenotype")

-------------------------------------------------------------------------------
  
FinalSCQ <- select(CAPAPRS, Tic_Phenotype, SCQ_total_imputed)

CleanSCQ <- FinalSCQ%>%
  group_by(Tic_Phenotype)%>%
  summarise(mean_SCQ = mean(SCQ_total_imputed, na.rm = TRUE), sd_SCQ = sd(SCQ_total_imputed, na.rm = TRUE), count = n(), se_SCQ = sd_SCQ/(sqrt(count)))

SCQPlot <- ggplot(CleanSCQ, aes(x=Tic_Phenotype, y = mean_SCQ, fill = Tic_Phenotype)) + geom_bar(stat="identity", colour = "black", position = position_dodge()) + geom_errorbar(aes(ymin=mean_SCQ-se_SCQ, ymax = mean_SCQ+se_SCQ), width = .2) + ylim(0,40) + ggtitle("SCQ Score Comparison Between Tic Phenotype") + theme(plot.title = element_text(hjust = 0.5), legend.position="none") + labs(y = "SCQ Score", x = "Tic Phenotype")

Figure1 <- grid.arrange(IQPlot, InatPlot, HypImpPlot, ADHDPlot, SCQPlot, ncol=3)

-------------------------------------------------------------------------------
specie <- c(rep("sorgho" , 3) , rep("poacee" , 3) , rep("banana" , 3) , rep("triticum" , 3) )
condition <- rep(c("normal" , "stress" , "Nitrogen") , 4)
value <- abs(rnorm(12 , 0 , 15))
data <- data.frame(specie,condition,value) 

Variable <- c(rep("Income", 2), rep("Education", 2), rep("Socio Status", 2), rep("Diagnosis", 2), rep("Sex", 2))
Phenotype <- c("Low", "High","Low", "High","Low", "High","Combined", "Other", "Male", "Female")
Percent <- c(62,38,28,72,54,46,72,28,83,17)

percent <- c(75,25,26,74,59,41,79,21,92,8)

Chi <- data.frame(Variable,Phenotype,Percent, percent)

Chi$Phenotype <- factor(Chi$Phenotype, levels = c("Low", "High", "Combined", "Other", "Male", "Female"))

Chi$Variable <- factor(Chi$Variable, levels = c("Income", "Education", "Socio Status", "Diagnosis", "Sex"))

ggplot(Chi, aes(fill=Phenotype, y=Percent, x=Variable)) + 
  geom_bar(position="stack", stat="identity") + ggtitle("Percentage Breakdown of Individuals Without Tics") + theme(plot.title = element_text(hjust = 0.5)) + theme(plot.title = element_text(size=25)) + theme(axis.title = element_text(size = 21)) + theme(axis.text.x = element_text(size = 15)) + theme(legend.text = element_text(size = 15)) + theme(legend.title = element_text(size=18)) +  theme(axis.text.y = element_text(size=15))

ggplot(Chi, aes(fill=Phenotype, y=percent, x=Variable)) + 
  geom_bar(position="stack", stat="identity") + ggtitle("Percentage Breakdown of Individuals With Tics") + theme(plot.title = element_text(hjust = 0.5)) + labs(y="Percent", x = "Variable") + theme(plot.title = element_text(size=25)) + theme(axis.title = element_text(size = 21)) + theme(axis.text.x = element_text(size = 15)) + theme(legend.text = element_text(size = 15))+ theme(legend.title = element_text(size=18)) +  theme(axis.text.y = element_text(size=15))

