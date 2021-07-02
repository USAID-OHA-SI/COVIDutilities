#' Import OWID vaccine data
#' @title Fetch Our World In Data vaccine data
#' @description Retrieves COVID-19 vaccination data for a given list of countries
#' @param cntry list of countries that appear in the our world in data page (ends in .csv)
#' @export 
#' @examples
#' \dontrun{
#' zmb <- get_vax_data(cntry = "Zambia.csv")
#' }


# Pull and compress list of ous into a dataframe
get_vax_data <- function(cntry){
  
  suppressMessages(
    df <-  
   cntry %>%
   purrr::map_dfr(~make_url(.x) %>% readr::read_csv())
  )
  
 df <- 
   df %>% 
   dplyr::rename(countryname = location)
  
 return(df)
}

