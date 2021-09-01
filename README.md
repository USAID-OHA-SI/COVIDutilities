
# COVIDutilities <img src='man/figures/logo.png' align="right" height="120" />

  <!-- badges: start -->
  [![R-CMD-check](https://github.com/USAID-OHA-SI/COVIDutilities/workflows/R-CMD-check/badge.svg)](https://github.com/USAID-OHA-SI/COVIDutilities/actions)
  <!-- badges: end -->


## Overview

With COVID-19 increasingly affecting many of the operating units in which PEPFAR operates, it is imperative to be able to pull daily COVID-19 datasets. This package automates many of these data fetching exercises and standardizes the COVID-19 data to be compatible with other PEPFER dataset. The package primarily extracts data from various repositories listed below. Focal users are analysts in USAID/GH/OHA who are using R to pull and/or wrangle COVID-19 data for bumping up against relevant PEPFAR indicators.  

The COVIDutilities package allows users to access the following data

  * Case counts, recoveries, deaths - Johns Hopkins (GitHub)
  * Vaccinations - Our World In Data (GitHub)
  * Stringency index - Blavatnik School of Government (API)
  * Government Measures - UN OCHA Humanitarian Data Exchange (Excel Download)

## Installation

`COVIDutilities` is not on CRAN, so you will have to install it directly from Github using `remotes`.

If you do not have the remotes package installed, you will have to run the `install.packages("remotes")` line in the code below as well.

``` r
## SETUP

  #install
    install.packages("remotes")
    remotes::install_github("USAID-OHA-SI/COVIDutilities")

  #load the package
    library(COVIDutilities)

## LIST TYPES OF STYLES INCLUDED WITH PACKAGE
  ls(package:COVIDutilities)
```


---

*Disclaimer: The findings, interpretation, and conclusions expressed herein are those of the authors and do not necessarily reflect the views of United States Agency for International Development. All errors remain our own.*
