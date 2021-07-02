#' Helper function to create html strings needed for loop
#' @param x countryname that you want to create url for (ends in .csv)
#' @export 
#' @examples
#' \dontrun{
#' test_url <- function(x = "Zambia")
#' }

make_url <- function(x) {
  
  x <- ifelse(stringr::str_detect(x, " "), stringr::str_replace_all(x, " ", "%20"), x)
  x <- paste(owid_vax_url, x, sep = "")
  x <- gsub("github.com/owid/covid-19-data/tree/master/public/data/", 
            "raw.githubusercontent.com/owid/covid-19-data/master/public/data/", 
            x)
  
  return(x)
}