.onAttach <- function(...) {
  if(requireNamespace("gagglr", quietly = TRUE))
    gagglr::oha_check("COVIDutilities", suppress_success = TRUE)
}
