#' Get species occurrence data for a refuge
#'
#' @param orgname The organizational name (ORGNAME) for a refuge
#' @param ...
#'
#' @return A data frame of species occurrence data in a refuge and a map of their locations
#' @export
#'
#' @examples
#' \dontrun{
#' get_species("ARCTIC NATIONAL WILDLIFE REFUGE")
#' }
get_species <- function(orgname,
                        ...){
  refuge <- get_refuge(orgname)
  dat <- get_gbif(refuge)
  clean_dat <- clean_gbif(dat)
  return(clean_dat)
}
