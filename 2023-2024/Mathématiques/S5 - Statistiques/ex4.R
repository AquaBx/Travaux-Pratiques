v<-read.table("td1ex4.txt",header=T,dec=".")

X <- v[,1]
Y <- v[,2]

plot(X,Y)

R = cor(X,Y)

abline(lm( formula = X ~ Y))

sigX = sd(X)
sigY = sd(Y)

abline(a=6,b = R*sigX/sigY)

# j'ai deux droites parallèles