#' John's Hopkins Github Repo Links
#' 
#' @export
#' @title  JHU main repo
#' @description link to rawdata
jhuRepo <- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/"

#' @export
#' @title  JHU cases
#' @description link to confirmed covid cases
tsCases <- "csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv"

#' @export
#' @title  JHU recoveries
#' @description link to covid recoveries
tsRecov <- "csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_recovered_global.csv"

#' @export
#' @title  JHU deaths
#' @description link to covid deaths
tsDeaths <- "csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv"

#' @export
#' @title  HDX COVID-19 government measures
#' @description Excel file of government measures taken by diffferent countries
hdx_govmes_url <- "https://data.humdata.org/dataset/acaps-covid19-government-measures-dataset"

#' @export
#' @title HDX COVID-19 government measures linkid for parsing
#' @description Excel file of government measures taken by diffferent countries
#' @examples 
#' \dontrun{
#' glamr::extract_excel_data(hdx_govmes_url, hdx_govmes_url, 2, 'xlsx') }
hdx_govmes_linkid <- "a[class='btn btn-empty btn-empty-blue hdx-btn resource-url-analytics ga-download']"#' 

#' @export
#' @title  OWID vaccination home
#' @description link to vaccination data main folder
owid_vax_url <- "https://github.com/owid/covid-19-data/tree/master/public/data/vaccinations/country_data/"

#' Oxford COVID-19 Government Response Tracker (Stringency Index)
#' 
#' @export
#' @title  Oxford COVID-19 Stringency Index
#' @description API base 
oxford_url <- "https://covidtrackerapi.bsg.ox.ac.uk"
