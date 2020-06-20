#' Pull a tidy version of JHU COVID-19 data
#' @title Pull JHU Covid-19 Data
#' @description Returns a tidy data frame of JHU COVID-19 data. Returns data frame with colums for
#' COVID-19 confirmed cases, recoveries and deaths.
#' @export
#'
#' @example
#' \dontrun{
#' covoid_data <- pull_jhu_covid
#' names(covid_data) }
#'


# Pull John Hopkin's COVID-19 Data, munge it, and widen it as casese, recoveries, deaths

pull_jhu_covid <- function() {

  cases <- import_jhu_data("cases")
  recover <- import_jhu_data("recoveries")
  deaths <- import_jhu_data("deaths") 

  df <- dplyr::left_join(cases, recover) %>%
    dplyr::left_join(deaths ) %>%
    dplyr::arrange(countryname, date) %>%
    dplyr::group_by(countryname) %>%
    dplyr::mutate(first_case = first_time_flag(cases, 1),
           first_death = first_time_flag(deaths, 1),
           tenth_case = dplyr::if_else(cases >= 10, 1, 0),
           tenth_death = dplyr::if_else(deaths >= 10, 1, 0)) %>%
    dplyr::arrange(countryname, date) %>%
    dplyr::group_by(countryname) %>%
    dplyr::mutate(days_since_ten_case = cumsum(tenth_case),
           days_since_ten_death = cumsum(tenth_death),
           who_pandemic = dplyr::if_else(date == "2020-03-11", "WHO declares COVID-19 Pandemic", NULL)) %>%
    dplyr::ungroup()
  return(df)
}

