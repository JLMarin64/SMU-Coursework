library(xlsx)

#1a

setwd("C:/Users/Marin Family/Desktop/Statistical Foundations for Data Science/Unit 10")

bird <- read.xlsx("MaleDisplayDataSet_2_2_2.xlsx","Male Display Data Set")

plot(bird)


bird.lm=lm(Tcell~Mass, data = bird)
newx=bird$Mass
newx=sort(newx)

prd_c=predict(bird.lm, newdata= data.frame(Mass = newx), interval=c("confidence"), type = c("response"), level=0.99) 

prd_c


prd_p=predict(bird.lm, newdata= data.frame(Mass = newx), interval=c("prediction"), type = c("response"), level=0.99) 

prd_p

#Plot with confidence and prediction intervals
plot(bird[,1],bird[,2],xlim = c(0,10), ylim = c(0,.8),xlab = "Mass",ylab = "Tcell", main = "Mass versus Tcell")
abline(bird.lm, col = "red")
lines(newx,prd_c[,2],col = "blue",lty = 2, lwd = 2)
lines(newx,prd_c[,3],col = "blue", lty = 2, lwd = 2)
lines(newx,prd_p[,2],col = "green", lty = 2, lwd = 2)
lines(newx,prd_p[,3],col = "green", lty = 2, lwd = 2)


#1b

summary(bird.lm)

confint(bird.lm, level = .99)


#1c
  #i

n <- as.numeric(nrow(bird))

criticalValue <- as.data.frame(qt(c(.005,.995), df = n-2))
cv <- criticalValue[2,1]
cv

summary(bird.lm)
confint(bird.lm, level = .99)


#1f



bird <- read.xlsx("MaleDisplayDataSet_2_2_2.xlsx","Male Display Data Set")

plot(bird)


bird.lm=lm(Tcell~Mass, data = bird)
newx=bird$Mass
newx=sort(newx)

prd_c=predict(bird.lm, newdata= data.frame(Mass = newx), interval=c("confidence"), type = c("response"), level=0.99) 

prd_c


newpoint <- data.frame(Mass=4.5, TCell=NA)
predict(bird.lm, newpoint, interval = "confidence", level = .99)



newpoint <- data.frame(Mass=4.5, TCell=NA)
predict(bird.lm, newpoint, interval = "prediction", level = .99)


prd_p=predict(bird.lm, newdata= data.frame(Mass = newx), interval=c("prediction"), type = c("response"), level=0.99) 

prd_p

#Plot with confidence and prediction intervals
plot(bird[,1],bird[,2],xlim = c(0,14), ylim = c(0,.8),xlab = "Mass",ylab = "Tcell", main = "Mass versus Tcell")
abline(bird.lm, col = "red")
lines(newx,prd_c[,2],col = "blue",lty = 2, lwd = 2)
lines(newx,prd_c[,3],col = "blue", lty = 2, lwd = 2)
lines(newx,prd_p[,2],col = "green", lty = 2, lwd = 2)
lines(newx,prd_p[,3],col = "green", lty = 2, lwd = 2)
abline(h=.3)


library(investr)

#Mean Response
calibrate(bird.lm, y0 = .3, interval = "Wald", level = .99, mean.response = TRUE)

#Single 
calibrate(bird.lm, y0 = .3, interval = "inversion", level = .99, mean.response = FALSE)


invest(bird.lm, y0 = .3, interval = "Wald", level = .99, mean.response = TRUE)

#Single 
calibrate(bird.lm, y0 = .3, interval = "inversion", level = .99, mean.response = FALSE)




plotFit(bird.lm, interval = "confidence", shade = TRUE, col.conf = "lightblue")

bird.res = resid(bird.lm)

plot(bird$Mass, bird.res, ylab = "Residuals", xlab = "Mass", main = "Bird Stone Mass and Health")

hist(bird.res)
lines(density(bird.res))

summary(bird.lm)