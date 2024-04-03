sig2=81
sig=9
N=36
mu=100

cpt1=0
cpt2=0

norm<-rnorm(N,mean=mu,sd=sig)

q2<-qnorm(c(0.05,0.95),mean=mu,sd=sig/sqrt(N))

q2

t.test(norm,conf.level=0.9)$conf.int