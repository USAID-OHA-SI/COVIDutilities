#' Helper function to create html strings needed for loop
#' @param x countryname that you want to create url for (ends in .csv)
#' @keywords internal
#' @examples
#' \dontrun{
#' test_url <- make_url(x = "Zambia")
#' }

make_url <- function(x) {
  
  x <- gsub("[[:space:]]", "%20", x)
  x <- paste(owid_vax_url, x, sep = "")
  x <- gsub("github.com/owid/covid-19-data/tree/master/public/data/", 
            "raw.githubusercontent.com/owid/covid-19-data/master/public/data/", 
            x)
  
  return(x)
}

#' Helper function to check if list of countries needs .csv added at the end or not
#' @param x object to which you want to add .csv to the end of
#' @keywords internal
#' @examples
#' \dontrun{
#' add_csv_stub(c("Zambia", "Zambia.csv"))
#' }

add_csv_stub <- function(x) {
  ifelse(endsWith(x, ".csv"), x, paste(x, ".csv", sep = ""))
}


#' Flags the first time and event occurs
#' 
#' Returns an indicator variable for the first time a condition is met in a 
#' dataframe. Useful for tagging when an event started or ended in a panel dataset.
#' 
#' @param var column name on which you wish to run funciton
#' @param value value for which you are searching for first occurence
#' @keywords internal
#' 

first_time_flag <- function(var, value) {
  dplyr::if_else((var == value) & (cumsum(var == value) == 1), 1, 0)
}

