rm(list=ls())
########################################Collating the data for a growth rate table################################
h<-parameter_table
growthtable<-data.frame(a)

n<-2
for(i in 2:8){
 # growthtable<-rbind(i,growthtable)
  growthtable<-rbind(chartr("12345678","abcdefgh",n),growthtable)
  n<-n+1
}

###################################this doesnt work because it just binds the letters#############################