###########################function requirements##########################################################

library("spatstat")
library("dplyr")
library("ggplot2")
library("ggthemes")

######################parameters for landscape generation##################################################
hosts <- 888 # number of hosts
dim <- 100 # dimension of the landscape

radiusCluster<-1
lambdaParent<-.2
lambdaDaughter<-30
randmod<-0

##################################landscape generation#####################################################
numbparents<-rpois(1,lambdaParent*dim)

xxParent<-runif(numbparents,0+radiusCluster,dim-radiusCluster)
yyParent<-runif(numbparents,0+radiusCluster,dim-radiusCluster)

numbdaughter<-rpois(numbparents,(lambdaDaughter))
sumdaughter<-sum(numbdaughter)



thetaLandscape<-2*pi*runif(sumdaughter)

rho<-radiusCluster*sqrt(runif(sumdaughter))



xx0=rho*cos(thetaLandscape)
yy0=rho*sin(thetaLandscape)


xx<-rep(xxParent,numbdaughter)
yy<-rep(yyParent,numbdaughter)

xx<-xx+xx0

yy<-yy+yy0
cds<-data.frame(xx,yy)
is_outlier<-function(x){
  x > dim| x < 0
}
cds<-cds[!(is_outlier(cds$xx)|is_outlier(cds$yy)),]
while (nrow(cds)<hosts){
  dif<-hosts-nrow(cds)
  extraparentxx<-sample(xxParent,dif,replace = TRUE)
  extraparentyy<-sample(yyParent,dif,replace = TRUE)
  extrathetaLandscape<-2*pi*runif(dif)
  extrarho<-radiusCluster*sqrt(runif(dif))
  newextracoodsxx<-extrarho*cos(extrathetaLandscape)
  newextracoodsyy<-extrarho*sin(extrathetaLandscape)
  extraxx<-extraparentxx+newextracoodsxx
  extrayy<-extraparentyy+newextracoodsyy
  cdsextra<-data.frame(xx=extraxx,yy=extrayy)
  cds<-rbind(cds,cdsextra)
}

sampleselect<-sample(1:nrow(cds),hosts,replace=F)
cds<-cds%>%slice(sampleselect)

randfunction<-function(x){
  x<-runif(length(x),0,dim)
}
randselect<-sample(1:nrow(cds),floor(hosts*randmod),replace=F)
cds[randselect,]<-apply(cds[randselect,],1,randfunction)

landscape<-ppp(x=cds$xx,y=cds$yy,window=owin(xrange=c(0,dim),yrange=c(0,dim)))

####################################plotting and analysis####################################################

data <- data.frame(x=landscape$x, y=landscape$y, id=1:hosts)
ggplot(data,aes(x=x,y=y))+geom_point()+theme_minimal()+
  coord_fixed(ratio = 1, xlim = NULL, ylim = NULL, expand = TRUE, clip = "on")
