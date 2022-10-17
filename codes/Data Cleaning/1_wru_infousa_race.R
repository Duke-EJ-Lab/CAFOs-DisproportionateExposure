library(data.table)
library(dplyr)
library(wru)
library(foreach)
library(doParallel)
library(stringr)

#create census data 
key <- "35174f78234f3c8fd4852c35d4886f7760a1dad6"
#numCores <- detectCores()
#registerDoParallel(numCores)

#census <- get_census_data(key,"NC", age = FALSE, sex = FALSE, retry = 5)

#stopImplicitCluster()
censusObj2  = list()
county.nc <- census_geo_api(key = key, state = "NC", geo = "county")
tract.nc <- census_geo_api(key = key, state = "NC", geo = "tract")
block.nc <- census_geo_api(key = key, state = "NC", geo = "block")
censusObj2[["NC"]] <- list(state = "NC", county = county.nc, tract = tract.nc, block = block.nc, age = FALSE, sex = FALSE)
codes <- data.frame(code = c(1:5, NA), race = c("W", "B", "H", "A", "Z", "Z"))

# read data
data<-read.csv(file='InfoUSA_TractBlock_2014.csv',sep = "",header = TRUE)
### use wru package to predict race by location and last name
#data$STATE <- "NC"
data$countyfp10<- str_pad(data$countyfp10, 3, pad ="0")
data$tractce10<- str_pad(data$tractce10, 6, pad ="0")
data$blockce10<- str_pad(data$blockce10, 4, pad ="0")
race_predicted <- data %>%
  select(Orig_fid, familyid, STATE, statefp10, countyfp10, tractce10, blockce10, LastName, vacant) %>%
  filter(vacant == 0 | is.na(vacant)) %>%
  transmute(Orig_fid = Orig_fid,
            familyid = familyid,
            surname = LastName, 
            state = STATE, 
            CD = statefp10,
            county = countyfp10, 
            tract = tractce10,
            block = blockce10) %>%
  predict_race(voter.file =., census.geo = "tract", census.data = censusObj2, age = FALSE, sex = FALSE)
# determine race based on highest probability
race_group <- race_predicted %>% transmute(Orig_fid = Orig_fid, familyid = familyid,
                             code = as.numeric(apply(select(., pred.whi:pred.oth), 1, which.max))) %>%
  merge(codes, all = TRUE)

# export data
write.csv(race_group, file = 'InfoUSA2014_WruRace.csv')

