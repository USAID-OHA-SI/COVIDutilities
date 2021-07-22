
#' Pull Oxford Stringency Index
#' 
#' API pull of Oxford COVID-19 Government Response Tracker. The stringency
#' index is a composite index across 7 indicators on how governments respond
#' to the COVID epidemic, with scores between 0-100
#' 
#' More info at https://covidtracker.bsg.ox.ac.uk/about-api
#'
#' @param date_start start date for stringency index as yyyy-mm-dd, default/min is Jan 22, 2020
#' @param date_end end date for stringency index as yyyy-mm-dd, default is NULL which will run through today
#'
#' @return dataframe of all PEPFAR countries and their stringency index value by day
#' @export
#'
#' @examples
#' \dontrun{
#' df_stringency <- pull_stringency_index(date_end = "2021-04-01") }

pull_stringency_index <- function(date_start = "2020-01-22", date_end = NULL){
  
  #apply today's date if left null
  if(is.null(date_end))
    date_end <- Sys.Date()
  
  #check that both dates are valid dates
  if(all(stringr::str_detect(c(date_start, date_end), "[:digit:]{4}-[:digit:]{2}-[:digit:]{2}", negate = TRUE)))
    stop("Date(s) provided are not in the following format yyyyy-mm-dd. Please fix and rerun.")
  
  #build url
  url_ox <- paste(oxford_url,
                  "api/v2/stringency/date-range",
                  date_start, date_end, 
                  sep = "/")
  
  #Government Response (Oxford - https://covidtracker.bsg.ox.ac.uk/about-api)
  json <- url_ox %>%
    jsonlite::fromJSON(flatten = TRUE)
  
  #covert from json to dataframe
  df_stringency <- json %>%
    unlist() %>%
    tibble::enframe()
  
  #clean up table
  df_stringency <- df_stringency %>% 
    dplyr::rowwise() %>%
    dplyr::mutate(
      parts = length(unlist(stringr::str_split(name, "[.]"))),
      tbl = dplyr::first(unlist(stringr::str_split(name, "[.]"))),
      tbl = gsub("\\d", "", tbl)
    ) %>%
    dplyr::filter(parts == 4) %>%    # Keep the data, section with the longest parts
    tidyr::separate(name,
                    into = c("name", "date", "iso", "variable"),
                    sep = "[.]") %>%                   # Separate column into multiple parts
    dplyr::select(date:value) %>%               # Get rid of extra columns
    dplyr::filter(date != value, iso != value) %>%     # Exclude repetition
    dplyr::mutate(date = lubridate::ymd(date), 
                  value = as.numeric(value)) %>% 
    tidyr::spread(variable, value) %>% 
    dplyr::select(-dplyr::contains("legacy"))
  
  #add colors from FT - https://ig.ft.com/coronavirus-lockdowns/)
  df_stringency <- df_stringency %>% 
    dplyr::mutate(bins = dplyr::case_when(is.na(stringency)  ~ "NA",
                                          stringency < 1     ~ "<1",
                                          stringency < 25    ~ "1-24",
                                          stringency < 50    ~ "25-49",
                                          stringency < 75    ~ "50-74",
                                          stringency < 85    ~ "75-84",
                                          TRUE               ~ "85-100"),
                  color = dplyr::case_when(is.na(stringency) ~ "#D9CDC3",
                                           stringency < 1    ~ "#D3E8F0",
                                           stringency < 25   ~ "#FAE1AF",
                                           stringency < 50   ~ "#FDAC7A",
                                           stringency < 75   ~ "#F6736B",
                                           stringency < 85   ~ "#DA3C6A",
                                           TRUE              ~ "#A90773"
                  ))
  
  #order colors
  df_stringency <- df_stringency %>% 
    dplyr::mutate(bins = factor(bins, c("NA","<1", "1-24", "25-49", "50-74", "75-84", "85-100")),
                  color = factor(color, c("#D9CDC3", "#D3E8F0","#FAE1AF", "#FDAC7A", "#F6736B", "#DA3C6A", "#A90773")))
  
  #filter to PEPFAR countries & name
  df_stringency <- df_stringency %>% 
    dplyr::right_join(pepfar_iso_map, by = "iso")
  
  #order vars
  df_stringency <- df_stringency %>% 
    dplyr::select(-c(confirmed, deaths, stringency_actual)) %>% 
    dplyr::select(date, countryname, iso, everything())
  
  return(df_stringency)  
}


