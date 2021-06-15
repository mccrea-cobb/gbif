
#' Plot species occurrence data on refuges
#'
#' @author McCrea Cobb \email{mccrea@@fws.gov}
#'
#' @param prop A simple feature (sf) multipolygon object returned \code{get_gbif}
#' @param dat A data frame of cleaned species occurrences on refuges returned by \code{clean_gbif}
#'
#' @return A ggplot object
#'
#' @import ggplot2
#' @export
#'
#' @examples
#' \dontrun{
#' plot_gbif(dat)
#' }
plot_gbif <- function(prop, dat){
  (p <- ggplot2::ggplot() +
    ggplot2::geom_sf(dat = prop) +
    ggplot2::geom_point(dat = dat, ggplot2::aes(long, lat)))
  }
