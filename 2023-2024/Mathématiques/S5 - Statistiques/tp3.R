v<-read.table("td3ex1_100.txt",header=T,dec=".")

mean(v[,1]) # 1.550396


# H0 : mu = 1.5 
# H1 : mu != 1.5 

t.test(v,conf.level=0.95, mu=1.5)

# p-value c'est notre tolérence de rejet, si p-value < rejet, on rejette
# ici la confiance est à 5% = 0.05

# ici on rejettte pas , p-value = 0.2999 > 0.05

v<-read.table("td3ex1_1000.txt",header=T,dec=".")
t.test(v,conf.level=0.95, mu=1.5)

# ici on rejettte , p-value = 0.001926 < 0.05