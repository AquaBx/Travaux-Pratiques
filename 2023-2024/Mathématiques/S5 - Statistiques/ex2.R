x<-read.table("td1ex2.txt",header=F,dec=".")

hist(x[,1])
hist(x[,1], breaks=c(150, 160, 170, 180,190 ,200), main="Histogramme Rouge", col="red", xlab="Abcisses", ylab="Ordonnées")
