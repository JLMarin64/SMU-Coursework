
library(sqldf)

baseball <- read.csv("Baseball_Data.csv")

baseball <- sqldf("select * from baseball where Team <> 'TEX'")

n <- as.numeric(nrow(baseball))

criticalValue <- as.data.frame(qt(c(.025,.975), df = n-2))
cv <- criticalValue[2,1]
cv

testStat <- (r*sqrt(n-2))/(sqrt(1-r^2))

cortest <- cor.test(baseball$Payroll, baseball$Wins)
cortest
pvalue <- cortest$p.value



g <- ggplot(baseball, aes(Wins, Payroll ))

# Scatterplot
g + geom_point() + 
  geom_smooth(method="lm", se=F) + 
  labs(y="Payroll", 
       x="Wins", 
       title="Wins vs Payroll") 
