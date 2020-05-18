#' Returns a dataframe of when WHO declared COVID-19 a pandemic
#' @description Returns a dataframe of when WHO declared COVID-19 a pandemic
#' @export
#'
# WHO Pandemic date
who_pandemic <- function() {
  df <- tibble::tribble(
    ~date,        ~measure,
    "2020-03-11", "WHO declares COVID-19 Pandemic") %>%
    dplyr::mutate(date = as.Date(date))
  return(df)
}

