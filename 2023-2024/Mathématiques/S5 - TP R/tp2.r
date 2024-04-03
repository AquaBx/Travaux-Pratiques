sig2=81
sig=9
N=36
mu=100

cpt1=0
cpt2=0

for ( i in 1:1000 ) {
    norm<-rnorm(N,mean=mu,sd=sig)


    m<-mean(norm)
    q<-qnorm(c(0.025,0.975),mean=m,sd=sig/sqrt(N))
    q2<-qnorm(c(0.05,0.95),mean=m,sd=sig/sqrt(N))

    # qnorm2<-qnorm(c(0.05,0.95),mean=M,sd=sig/sqrt(N)) # plus serrer car on va réduire l'intervalle de confiance

    # qnorm # différent car la moyenne n'est pas exactement à 100
    # qnorm2

    # qnorm[2]-qnorm[1] # intercartile de 5,88
    # qnorm2[2]-qnorm2[1] # intercartile de 4,93

    b1<-q[1]
    b2<-q[2]

    b3<-q2[1]
    b4<-q2[2]

    if (mu < b2 && mu > b1) {
        cpt1=cpt1+1
    }

    if (mu < b4 && mu > b3) {
        cpt2=cpt2+1
    }

    # b1
    # b2

    # test<-seq(min(norm)-10,max(norm)+10,by=5)

    # test 
    # hist(norm,breaks=test)

}

cpt1
cpt2