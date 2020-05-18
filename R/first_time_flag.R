#' Flags the first time and event occurs
#' @title First time flag
#' @description Returns an indicator variable for the first time a condition is met in a dataframe.
#' USeful for tagging when an event started or ended in a panel dataset.
#' @export

# Flag the first time an event occurs
# var - column on which the event is contained
# value - value of first occurence, set to 1 here
# Imports @if_else


# Flag the first occurence of an event  
first_time_flag <- function(var, value) {
  dplyr::if_else((var == value) & (cumsum(var == value) == 1), 1, 0)
}

