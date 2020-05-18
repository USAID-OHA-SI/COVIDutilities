#' Function to reshape Covid-19 data from Johns Hopkins github repo
#' @title Reshape JHU data
#' @name reshape_jhu_covid
#' @description Pivots JHU COVID-19 data from wide to long format. Creates daily cases. Used in pull_jhu_covid.a
#' 
#'

# Reshape, coerce date col to dates for sorting, and create daily cases
# parameters are a dataframe


reshape_jhu_covid <- function(df) {

  df %>%
    tidyr::pivot_longer(-c(1:4),
                 names_to = "date",
                 values_to = "cases") %>%
    dplyr::rename(countryname = `Country/Region`) %>%
    dplyr::mutate(date = as.Date(date, "%m/%d/%y")) %>%
    dplyr::group_by(countryname, date) %>%
    dplyr::summarise(cases = sum(cases, na.rm = TRUE)) %>%
    dplyr::ungroup() %>%
    dplyr::arrange(countryname, date) %>%
    dplyr::group_by(countryname) %>%
    dplyr::mutate(daily_cases = cases - lag(cases)) %>%
    dplyr::ungroup()
 return(df)
}
