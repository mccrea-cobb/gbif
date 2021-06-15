
#
#' Create a simplified convex hull of the refuge boundary in WKT format
#'
#' @param prop An \code{sf} multipolygon object of a refuge boundary, returned by \code{get_refuge}.
#'
#' @return A WKT formatted refuge boundary
#'
get_wkt <- function(prop,
                    ...) {
  wkt_txt <- prop %>%
    sf::st_convex_hull() %>%
    sf::st_geometry() %>% sf::st_as_text()
  wkt_txt
}


#
#' Clip out GBIF observations outside of true refuge boundary
#'
#' @param dat A data frame of raw species occurrence data for contained within a simplified convex hull of a refuge boundary
#' @param prop An \code{sf} multipolygon object of a refuge boundary, returned by \code{get_refuge}.
#'
#' @return
#'
clip_occ <- function(dat,
                     prop,
                     ...) {
  occ_pts <- sf::st_multipoint(cbind(dat$decimalLongitude, dat$decimalLatitude)) %>%
    sf::st_sfc(crs = sf::st_crs(prop)$proj4string) %>%
    sf::st_cast("POINT")
  suppressMessages(
    keep <- sapply(sf::st_intersects(occ_pts, st_make_valid(prop)),
                   function(z) {as.logical(length(z))})
  )
  dat[keep, ]
}

