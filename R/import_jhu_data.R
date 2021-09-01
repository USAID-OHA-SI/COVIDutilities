#' Import John's Hopkins COVID-19 data
#'
#' @param type what dataset do you want returned? cases, recoveries or deaths
#' @keywords internal
#' @examples
#' \dontrun{
#' cases <- import_jhu("cases")
#' }

import_jhu_data <- function(type){

  stopifnot(length(type) != 0 & type %in% c("cases", "recoveries", "deaths"))

  # Select the type of data to pull
  type_url <- dplyr::case_when(type == "cases" ~ tsCases,
                           type == "recoveries" ~ tsRecov,
                           type == "deaths" ~ tsDeaths)

  df <- readr::read_csv(file.path(paste0(jhuRepo, type_url)), col_types = c(.default = "d",
                                                                        `Province/State` = "c",
                                                                        `Country/Region` = "c"))
  df <- reshape_jhu_covid(df)

  if(type == "recoveries")
    df <- dplyr::rename(df, recoveries = cases, daily_recoveries = daily_cases)
  
  if(type == "deaths")
    df <- dplyr::rename(df, deaths = cases, daily_deaths = daily_cases)
  
  return(df)
}

