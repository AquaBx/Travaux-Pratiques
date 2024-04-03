titanic<-read.table("titanic.txt",header=T,dec=".")

#plus de 2000 personnes

X<-titanic[,1]
Y<-titanic[,2]
Z<-titanic[,3]
A<-titanic[,4]

table(X,A)
table(Y,A)
table(Z,A)

# Une femme enfant de première classe


par(mfrow=c(1,1))

mosaicplot(~ Class  + Survived,data=titanic, color=TRUE)
mosaicplot(~ Sex  + Survived,data=titanic, color=TRUE)
mosaicplot(~ Age  + Survived,data=titanic, color=TRUE)

nouveautitanic=margin.table(Titanic,c(1,2,4))
nouveautitanic # pour visualiser le tableau r´esultant
mosaicplot(nouveautitanic) # nouveau graphique sans distinction d’^age