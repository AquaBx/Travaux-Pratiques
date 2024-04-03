x<-read.table("td1ex1.txt",header=T,dec=".")

mean(x[,1])

quantile(x[,1])

summary(x)

boxplot(x)

# deux outliners : 3 et 5.5