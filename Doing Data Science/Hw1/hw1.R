
#1
  #a) Log of Positive Number
  log(7)
  
  #b)
  ?log
  #Answer log 10
  
  #C)
  log(-1)
  #Warning message:
  #  In log(-1) : NaNs produced   Log of a negative number is undefined
  
  #d)
  sqrt(64)


#2

  #a)
  vector <- runif(15, min=0, max=100)
  
  
  mean <- mean(vector)
  sd <- sd(vector)
  
  #b)
  
  mean <- 10
  sd <- 2
  
  
  vector2 <- runif(15, min=0, max=100)
  
  mean2 <- mean(vector2)
  sd2 <- sd(vector2)
  
  #c)
  # These were random samples of 15 between 1-100 (decimcal).  
  
  
  #3 
    #a) - #c)
  weight <- c(60,72,57,90,95,72)
  heights <- c(1.8,1.85,1.72,1.90,1.74,1.91)
  
  #d
  plot(weight ~ heights)
  
  # As people get taller, you can see that weight increases.  There is one person that is short that weighs more than others that seems to be an outlier.
  
  #e
  
  bmi <- weight/(heights * heights)
  
  #f
  
  meanweight <- mean(weight)
  
  meanweight
  
  #g
  meanweighterror <- meanweight - weight
  
  #h
  sum(meanweighterror)
  
  #4)
  
  profile <- data.frame("Category" = "Computer Programming" , "Ranking" =  3, stringsAsFactors = FALSE)
  
  
 profile <- rbind(profile, c("Math",3))
 profile <- rbind(profile, c("Statistics", 2))
 profile <- rbind(profile, c("Machine Learning",1))
 profile <- rbind(profile, c("Domain Expertise",5))
 profile <- rbind(profile, c("Communication", 4))
 profile <- rbind(profile, c("Data visualization", 4))
 
 profile$Ranking <- as.numeric(profile$Ranking)
 
 op <- par(mar = c(10,4,4,2) + 0.1) 
 
 barplot(profile$Ranking, names = profile$Category,  horiz = F, ylab = "Ranking", las = 2, main = "My Ranking by Category" )
  
 #5)
 
 
  