#' Flags the first time and event occurs
#' @title First time flag
#' @description Returns an indicator variable for the first time a condition is met in a dataframe.
#' USeful for tagging when an event started or ended in a panel dataset.
#' 
#' @param var column name on which you wish to run funciton
#' @param value value for which you are searching for first occurence
#' 

# Flag the first occurence of an event  
first_time_flag <- function(var, value) {
  dplyr::if_else((var == value) & (cumsum(var == value) == 1), 1, 0)
}

