# COVIDutilities 1.1.0
* build site via `pkgdown`
* created the `using-covid-data` vignette to demonstrate importing COVID data and the stringency index.
* rename `get_vax_data` to `pull_vax_data` to match other functions.
* add `pull_covid_gov_measures` to pull in HDX COVID government measures.
* change default option to `get_vax_countries` to only return PEPFAR countries.
* `pull_vax_data` converts country names to match PEPFAR ones where applicable. 
* clean up exports, removing COVID related urls and background supporting functions.
* give user option to look at more than PEPFAR only countries in`pull_stringency_index`.

# COVIDutilities 1.0.0
* add `pull_stringency_index` to pull Oxford stringency data.
* add `get_vax_data`  to fetch COVID-19 vaccine data from Our World In Data Github Repo.
* add parameter to `pull_jhu` to limit to just PEPFAR countries.

# COVIDutilities 0.0.0.9000

* add `pull_jhu_covid()` to extract JHU's COVID data from Github repo
