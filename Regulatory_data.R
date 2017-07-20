#Data imported for regulatory data

setwd('/nfs/water-risk-policy-data')

#load libraries 
library(gdata)
library(dplyr)
library(stringr)

#read in regulatory spreadsheet
regs_raw <- read.xls('Nonpoint Source Regulations (2).xlsx', sheet = 'SESYNC')
#run checks on data
unique(regs_raw$Geographic.Region)
filter(regs_raw, is.na(Geographic.Region))
head(regs_raw) #need followup here
unique(regs_erie$Level)
str_sub(regs_erie$Level, start = -6, -1)

#subset for all policies in Lake Erie region US
erie <- c('Ohio', 'Michigan', 'Indiana', 'Pennsylvania', 'New York')
regs_erie <- filter(regs_raw, Geographic.Region %in% erie)
counties_erie <- filter(regs_erie, str_sub(Level, start = -6, -1) == 'County')

#clean up counties
grepl('Local: ', counties_erie[1, 3])
counties_erie$Level <- gsub("Local: ", "", as.character(counties_erie$Level))
counties_erie$Level <- gsub(" County", "", as.character(counties_erie$Level))
counties_erie$Level <- gsub("State - ", "", as.character(counties_erie$Level)) 
df.expanded <- rbind(counties_erie, counties_erie[40,])
df.expanded$Level[40] <- 'Macomb'
df.expanded$Level[49] <- 'St. Clair'

#make abbreviations


#read in FIPS codes
FIPS <- read.xls('Location Codes/FIPS codes.xlsx', sheet = 'County_US')

#subset Erie counties
FIPS_erie <- filter(FIPS, State.Abbreviation %in% (c('OH', 'MI', 'IN', 'PA', 'NY')))

