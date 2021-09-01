#' Import Our World in Data Vaccine rates
#' @title Import Our World in Data Vaccine rates
#' 
#' Pull list of countries for which vax data exist
#' @return Returns an object of the countries being tracked by Our World in Data
#' @param pepfar_only pepfar_only limit to just PEPFAR countries, default = TRUE
#' @export 
#' @family vax
#' @examples
#' \dontrun{
#' #all countries
#'   cntry_list <- get_vax_countries()
#'   df_vax <- get_vax_data(cntry_list)
#' #pepfar only countries
#'   cntry_list <- get_vax_countries()
#' }


# Pull down the ous for which vaccine data exist

get_vax_countries <- function(pepfar_only = TRUE) {
  
  # fetch all the countries in the repo, make a list to pass to map_dfr
  cntry_obj <- 
    rvest::read_html(owid_vax_url) %>% 
    rvest::html_nodes(xpath = '//*[@class = "js-navigation-open Link--primary"]') %>% 
    xml2::xml_text() 
  
  cntry_obj <- gsub('.{4}$', '', cntry_obj)
  
  if(pepfar_only == TRUE)
    cntry_obj <-
      c("Angola", "Myanmar", "Cambodia", "China", "India", "Indonesia", 
        "Kazakhstan", "Kyrgyzstan", "Laos", "Nepal", "Papua New Guinea", 
        "Philippines", "Tajikistan", "Thailand", "Turkmenistan", 
        "Uzbekistan", "Botswana", "Brunei", "Cameroon", "Cote d'Ivoire", 
        "Democratic Republic of Congo", "Dominican Republic", "Eswatini", 
        "Ethiopia", "Haiti", "Kenya", "Lesotho", "Malawi", "Mozambique", 
        "Namibia", "Nigeria", "Rwanda", "South Africa", "South Sudan", 
        "Tanzania", "Uganda", "Ukraine", "Vietnam", "Benin", 
        "Burkina Faso", "Ghana", "Liberia", "Mali", "Senegal", 
        "Sierra Leone", "Togo", "Antigua and Barbuda", "Bahamas", 
        "Barbados", "Belize", "Brazil", "Colombia", "Costa Rica", 
        "Dominica", "El Salvador", "Grenada", "Guatemala", "Guyana", 
        "Honduras", "Jamaica", "Nicaragua", "Panama", "Peru", 
        "Saint Kitts and Nevis", "Saint Lucia", "Saint Vincent and the Grenadines", 
        "Suriname", "Trinidad and Tobago", "Venezuela", "Zambia", "Zimbabwe")
  
  return(cntry_obj)  
}