#' Helper function to create html strings needed for loop
#' @param x countryname that you want to create url for (ends in .csv)
#' @keywords internal
#' @examples
#' \dontrun{
#' test_url <- function(x = "Zambia")
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
#' @export 
#' @examples
#' \dontrun{
#' add_csv_stub(c("Zambia", "Zambia.csv"))
#' }

add_csv_stub <- function(x) {
  ifelse(endsWith(x, ".csv"), x, paste(x, ".csv", sep = ""))
}