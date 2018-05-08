
library(xlsx)
library(olsrr)

library(investr)


setwd("C:/Users/Marin Family/Desktop/Statistical Foundations for Data Science/Unit 11")

autism <- read.xlsx("AutismDataProb29_2_2_2.xlsx", "Autism Data Prob 29")

autism.lm <- lm(Prevalence ~ Year, data = autism)
newx <- autism$Year
newx <- sort(newx)

prd_c <- predict(autism.lm, newdata= data.frame(Year = newx), interval=c("confidence"), 
                 type = c("response"), level=0.95)
prd_p <- predict(autism.lm, newdata= data.frame(Year = newx), interval=c("prediction"), 
                 type = c("response"), level=0.95)

#Plot with confidence and prediction intervals
plot(autism[,1], autism[,2],xlim = c(1990,2002), ylim = c(-5,25), xlab = "Year", 
     ylab = "Prevalence", main = "Autism Prevalence")
abline(autism.lm, col = "red")
lines(newx,prd_c[,2],col = "blue",lty = 2, lwd = 2)
lines(newx,prd_c[,3],col = "blue", lty = 2, lwd = 2)
lines(newx,prd_p[,2],col = "green", lty = 2, lwd = 2)
lines(newx,prd_p[,3],col = "green", lty = 2, lwd = 2)


calibrate(autism.lm, y0 = 10, interval = "inversion", mean.response =  TRUE, level = .95)


#qqplot
ols_rsd_qqplot(model)

##residual vs fitted  test
ols_rvsp_plot(model)

##histogram
ols_rsd_hist(model)


ols_rsd_qqplot(model)

