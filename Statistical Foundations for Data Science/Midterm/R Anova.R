
library(xlsx)

setwd("C:/Users/Marin Family/Desktop/Statistical Foundations for Data Science/Unit 5")


EducData <- read.xlsx("ex0525_2_2.xlsx", sheetIndex = "ex0525")

EducData$Income2005 <- log(EducData$Income2005)

library(sqldf)

EducData <- sqldf("select * from EducData order by Educ asc")

fit <- aov(Income2005 ~ Educ, data=EducData)

summary(fit)



