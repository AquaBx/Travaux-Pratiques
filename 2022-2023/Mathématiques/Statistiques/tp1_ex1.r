# Exo 1

# td1ex1 <- read.table("td1ex2_data.dat",dec=".")

# mean(td1ex1[,1])
# median(td1ex1[,1])
# quantile(td1ex1[,1])

# summary(td1ex1[,1])

# boxplot(td1ex1[,1])

# Exo 2

# td1ex2 <- read.table("td1ex3_data.dat",dec=".")
# hist(td1ex2[,1],breaks= c(150,160,170,180,190,200))
# hist(td1ex2[,1],breaks= c(150,160,170,180,190,200),main="Histogramme des tailles")

# Exo 3

# td1ex3 <- read.table("td1ex4_data.txt",header=T,dec=".")

# X <- td1ex3[,1]
# Y <- td1ex3[,2]

# plot(X,Y)
# # par(new=T)
# # plot(Y,X,col="red")

# R = cor(X,Y)
# # cor(Y,X)

# abline(lm( formula = X ~ Y))

# sigX = sd(X)
# sigY = sd(Y)

# plot(X,Y)
# abline(a=6,b=R*sigX/sigY)

# Exo 4

# iris <- read.table("iris.txt",header=T,dec=",")

# spe = c("setosa","versicolor","virginica")


# par(mfrow=c(3,4))
# for ( i in 1:3) {
#     for ( k in 1:4) {
#         hist(iris[ iris$Species == spe[i], ][,k], xlim=c(0,8))
#     }
# }

# par(mfrow=c(1,1))
# pie( table (iris$Species ) )


# boxplot(iris$Sepal.Length~iris$Species)


# boxplot(iris$Sepal.Length~iris$Species, main="comparatif par espèces", col="red",ylab="longueur de Sépale")

# Exo 5

titanic <- read.table("titanic.txt",header=T,dec=",")
class=c("first","second","third","crew")

par(mfrow=c(2,2))
for (i in 1:4){
    pie ( table( titanic[ titanic$Class == class[i], ][,4] ) )
}

par(mfrow=c(1,1))

mosaicplot(~ Class  + Survived,data=titanic, color=TRUE)
mosaicplot(~ Sex  + Survived,data=titanic, color=TRUE)
mosaicplot(~ Age  + Survived,data=titanic, color=TRUE)