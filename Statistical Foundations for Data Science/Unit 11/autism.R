
library(xlsx)
library(olsrr)


setwd("C:/Users/Marin Family/Desktop/Statistical Foundations for Data Science/Unit 11")

autism <- read.xlsx("AutismDataProb29_2_2_2.xlsx", "Autism Data Prob 29")

autism$Prevalence <- log(autism$Prevalence)
#autism$Year <- log(autism$Year)

model=lm(Year~Prevalence, data = autism)

plot(autism$Year, autism$Prevalence)

newx=autism$Prevalence
newx=sort(newx)

prd_c=predict(model, newdata= data.frame(Prevalence = newx), interval=c("confidence"), type = c("response"), level=.95) 

prd_c


prd_p=predict(model, newdata= data.frame(Prevalence = newx), interval=c("prediction"), type = c("response"), level=.95) 

prd_p

#Plot with confidence and prediction intervals
plot(autism[,2],autism[,1],xlim = c(0,3), ylim = c(1990,2010),xlab = "Prevelance",ylab = "Year", main = "Autism Prevelance per Year")
abline(model, col = "red")
lines(newx,prd_c[,2],col = "blue",lty = 2, lwd = 2)
lines(newx,prd_c[,3],col = "blue", lty = 2, lwd = 2)
lines(newx,prd_p[,2],col = "green", lty = 2, lwd = 2)
lines(newx,prd_p[,3],col = "green", lty = 2, lwd = 2)


#qqplot
ols_rsd_qqplot(model)

##residual vs fitted  test
ols_rvsp_plot(model)

##histogram
ols_rsd_hist(model)


ols_rsd_qqplot(model)

