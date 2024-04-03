v<-read.table("iris.txt",header=T,dec=".")

vals <- table( v[,5] ) # 50 setosa 50 versicolor 50 virginica

pie(vals)

setosa <- v[0:50,]
virginica <- v[51:100,]
versicolor <- v[101:150,]

petalesetosa <- v[0:50,3]
petalevirginica <- v[51:100,3]
petaleversicolor <- v[101:150,3]

head<-c("Longueur Sépal","Largeur Sépal","Longueur Pétale","Largeur Pétale")

par(mfrow=c(4,3))

echelle<-seq(0, 8, by=0.5)

for (i in 1:4) {
    
    
    hist(setosa[,i],breaks=echelle,main="setosa",xlab=head[i])
    hist(virginica[,i],breaks=echelle,main="virginica ",xlab=head[i])
    hist(versicolor[,i],breaks=echelle,main="versicolor ",xlab=head[i])
}

par(mfrow=c(2,2))



boxplot(iris$Sepal.Length ~ iris$Species,main="comparatif par esp`ece",col="red", ylab="longueur de s'epale")
boxplot(iris$Petal.Length ~ iris$Species,main="comparatif par esp`ece",col="red", ylab="longueur de petale")
boxplot(iris$Sepal.Width  ~ iris$Species,main="comparatif par esp`ece",col="red", ylab="largeur de s'epale")
boxplot(iris$Petal.Width  ~ iris$Species,main="comparatif par esp`ece",col="red", ylab="largeur de petale")
