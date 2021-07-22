#Crosswalk table for PEPFAR Country name and ISO code
library(glamr)
library(tidyverse)
library(countrycode)

load_secrets()


df_outable <- get_outable(datim_user(), datim_pwd())

pepfar_iso_map <- df_outable %>% 
  select(countryname, iso = countryname_iso)




usethis::use_data(pepfar_iso_map, overwrite = TRUE)
