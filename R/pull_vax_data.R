#' Import OWID vaccine data
#' @title Fetch Our World In Data vaccine data
#' @description Retrieves COVID-19 vaccination data for a given list of countries
#' @param cntry country, or list of countries, that appear in the our world in 
#'   data page
#' @family vax
#' @return Returns data frame of total vaccinations by day  
#' @source \url{https://github.com/owid/covid-19-data}
#' @export 
#' @examples
#' \dontrun{
#' #only one country
#'   df_vax_zmb <- get_vax_data("Zambia")
#' #only PEPFAR countries
#'   cntry_list <- get_vax_countries()
#'   df_vax_pepfar <- get_vax_data(cntry_list)
#' #all countries
#'   cntry_list <- get_vax_countries(pepfar_only = FALSE)
#'   df_vax <- get_vax_data(cntry_list)
#' }
#' 
pull_vax_data <- function(cntry){
  
  tryCatch(
    {
      df <- cntry %>%
        add_csv_stub() %>% 
        purrr::map_dfr(~make_url(.x) %>% 
                         readr::read_csv(show_col_types = FALSE, 
                                         progress = FALSE))
      
      df <- df %>% 
        dplyr::rename(countryname = location) %>% 
        dplyr::mutate(countryname = dplyr::recode(countryname,
                                                  "Myanmar" = "Burma",
                                                  "Brunei" = "Burundi",
                                                  "Democratic Republic of Congo" = "Democratic Republic of the Congo"))
      
      return(df)
    }
  )
    
}

#' Import OWID vaccine data
#' @title Fetch Our World In Data vaccine data
#' @description Retrieves COVID-19 vaccination data for a given list of countries
#' @param cntry country, or list of countries, that appear in the our world in 
#'   data page
#' @return Returns data frame of total vaccinations by day  
#' @export 

get_vax_data <- function(cntry){
  
 .Deprecated("pull_vax_data")
  
  pull_vax_data(cntry)
}


