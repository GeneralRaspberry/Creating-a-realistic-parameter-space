rm(list=ls())
########################################Collating the data for a growth rate table################################


###########################Using a function to load objects needed with unique names##############################
setwd("C:\Users\owner\Documents\Uni stuff\PhD\R scripts\
Chapter 1\Script for identifying parameter space\Raw Data\
      Growth rate table corresponding to raw data")

loadRData <- function(fileName){
  #loads an RData file, and returns it
  load(fileName)
  get(ls()[ls() != "fileName"])
}
###########################################Not going to work with the weird save file names#######################
