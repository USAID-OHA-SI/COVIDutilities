#' Pull JHU COVID-19 Case, Recovery, and Death Data
#' 
#' %>% Returns a tidy data frame of JHU COVID-19 data. Returns a tidy 
#' data frame with columns for COVID-19 confirmed cases, recoveries and deaths.
#' 
#' @param pepfar_only limit to just PEPFAR countries, default = TRUE
#' @export
#'
#' @examples
#' \dontrun{
#' covid_data <- pull_jhu_covid() }
#'
pull_jhu_covid <- function(pepfar_only = TRUE) {

  cases <- import_jhu_data("cases")
  recover <- import_jhu_data("recoveries")
  deaths <- import_jhu_data("deaths") 

  df <- dplyr::left_join(cases, recover, by = c("countryname", "date")) %>%
    dplyr::left_join(deaths, by = c("countryname", "date")) %>%
    dplyr::arrange(countryname, date) %>%
    dplyr::group_by(countryname) %>%
    dplyr::mutate(first_case = first_time_flag(cases, 1),
           first_death = first_time_flag(deaths, 1),
           tenth_case = dplyr::if_else(cases >= 10, 1, 0),
           tenth_death = dplyr::if_else(deaths >= 10, 1, 0)) %>%
    dplyr::arrange(countryname, date) %>%
    dplyr::group_by(countryname) %>%
    dplyr::mutate(rollingavg_7day = zoo::rollmean(daily_cases, 7, fill = NA, align = c("right")),
                  days_since_ten_case = cumsum(tenth_case),
                  days_since_ten_death = cumsum(tenth_death),
                  who_pandemic = dplyr::if_else(date == "2020-03-11", "WHO declares COVID-19 Pandemic", NULL)) %>%
    dplyr::ungroup()
  
  if(pepfar_only == TRUE){
    df <- right_join(df, pepfar_iso_map)
  }
     
  
  return(df)
}

