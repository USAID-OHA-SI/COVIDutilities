#' Import Our World in Data Vaccine rates
#' @title Pull list of countries for which vax data exist
#' @description Returns an object of the countries being tracked by Our World in Data
#' @param url what is the url for the github repo containing vax info by country
#' @export 
#' @examples
#' \dontrun{
#' vax_list <- get_vax_countries(url)
#' }


# Pull down the ous for which vaccine data exist

get_vax_countries <- function(url = owid_vax_url) {
  
  # fetch all the countries in the repo, make a list to pass to map_dfr
  cntry_obj <- 
    rvest::read_html(url) %>% 
    rvest::html_nodes(xpath = '//*[@class = "js-navigation-open Link--primary"]') %>% 
    xml2::xml_text()
  
  return(cntry_obj)  
}