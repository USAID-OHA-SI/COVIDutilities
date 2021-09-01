
#' Pull HDX COVID Government Measures data
#'
#' Downloads the UNOCHA HDX COVID Government Measures dataset and loads it into
#'  R. The COVID Government Measures dataset "puts together all the measures 
#' implemented by governments worldwide in response to the Coronavirus 
#' pandemic." For more information, see 
#' https://data.humdata.org/dataset/acaps-covid19-government-measures-dataset.
#' 
#' @param pepfar_only limit to just PEPFAR countries, default = TRUE
#' @param natl_lvl_only limit data to national level, default = TRUE 
#'
#' @return dataframe of countries and their types of government interventions
#'  by day
#' @export
#'
#' @examples
#' \dontrun{
#' df_gov_measures <- pull_covid_gov_measures()
#' df_restrictions <- df_gov_measures %>% 
#'   filter(countryname == "Nigeria",
#'          measure %in% c("Domestic travel restrictions",
#'                         "Partial lockdown", "Full lockdown",
#'                         "Checkpoints within the country",
#'                         "Curfews"),
#'          log_type == "Introduction / extension of measures") %>% 
#'   select(countryname, 
#'          date = date_implemented, 
#'          restrict_cat = category, 
#'          restrict_measure = measure) }
#'          
pull_covid_gov_measures <- function(natl_lvl_only = TRUE, pepfar_only = TRUE){
  df_gov_measures <- glamr::extract_excel_data(hdx_govmes_url, 
                                               hdx_govmes_linkid)
  
  #Keeping only PEPFAR countries if pepfar_only =TRUE
  if(pepfar_only == TRUE){
    df_gov_measures <- df_gov_measures %>% 
      dplyr::right_join(pepfar_iso_map, by = "iso")
  } else {
    df_gov_measures <- df_gov_measures %>% 
      dplyr::left_join(pepfar_iso_map, by = "iso")
  }
  
  #replace with PEPFAR country names where applicable
  df_gov_measures <- df_gov_measures %>% 
    dplyr::mutate(country = ifelse(!is.na(countryname), countryname, country)) %>% 
    dplyr::select(-countryname) %>% 
    dplyr::rename(countryname = country)
  
  #limit to national level
  if(natl_lvl_only == TRUE)
    df_gov_measures <- filter(df_gov_measures, is.na(admin_level_name))
  
  return(df_gov_measures)
}


