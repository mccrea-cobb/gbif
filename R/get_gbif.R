#' Download species occurrence data from GBIF
#'
#' @author McCrea Cobb \email{mccrea@@fws.gov}
#'
#' @param orgcode The org code for desired refuge
#' @param pause The number of seconds to pause to wait for the data request from GBIF to be ready. Default is 30 secs.
#'
#' @return A data frame of species occurrence data from GBIF within the boundary of the desired refuge
#'
#' @note First time user - Add your GBIF credentials (username, password, email) to an .renviron file using \code{usethis::edit_r_environ(scope = "project")}
#' * GBIF_USER = "your GBIF user name"
#' * GBIF_PWD = "your GBIF password"
#' * GBIF_EMAIL = "your email address"
#'
#' @export
#'
#' @import dplyr
#' @importFrom magrittr %>%
#' @import rgbif
#' @import httr
#' @import sf
#'
#' @examples
#' \dontrun{
#' get_gbif(orgcode = 75600)
#' }
get_gbif <- function(orgname = "ARCTIC NATIONAL WILDLIFE REFUGE",
                     pause = 45){

  # Query the FWS Cadastral Database for a refuge boundary
  url <- httr::parse_url("https://services.arcgis.com/QVENGdaPbd4LUkLV/arcgis/rest/services")
  url$path <- paste(url$path, "National_Wildlife_Refuge_System_Boundaries/FeatureServer/0/query", sep = "/")
  url$query <- list(where = paste("ORGNAME =", paste0("'",orgname,"'")),  # Arctic Refuge, in this case
                    outFields = "*",
                    returnGeometry = "true",
                    f = "pgeojson"
  )
  request <- httr::build_url(url)
  prop <- sf::st_read(request)

  message(paste("Downloaded boundary layer for", prop$ORGNAME))

  # Create a simplified convex hull of the refuge boundary in WKT format
  get_wkt <- function(prop) {
    wkt_txt <- prop %>%
      sf::st_convex_hull() %>%
      sf::st_geometry() %>% sf::st_as_text()
    wkt_txt
  }
  wkt <- get_wkt(prop)

  # Spin up a request for data from GBIF within the convex hull boundary of the refuge
  res <- rgbif::occ_download(pred_within(wkt))

  #Pause to wait for the status to turn "Completed"
  message("Waiting for the data request from GBIF")
  Sys.sleep(pause)

  # Check on the status of the download
  rgbif::occ_download_meta(res)

  # Download the data
  dat <- rgbif::occ_download_get(res, overwrite = TRUE)

  message("Unpacking and loading the data...hold on tight!")
  Sys.sleep(15)

  # Import it into R
  dat <- rgbif::occ_download_import(dat)

  # Clip out GBIF observations outside of true refuge boundary
  clip_occ <- function(occ_recs, prop) {
    occ_pts <- sf::st_multipoint(cbind(occ_recs$decimalLongitude, occ_recs$decimalLatitude)) %>%
      sf::st_sfc(crs = sf::st_crs(prop)$proj4string) %>%
      sf::st_cast("POINT")
    suppressMessages(
      keep <- sapply(sf::st_intersects(occ_pts, prop),
                     function(z) {as.logical(length(z))})
    )
    occ_recs[keep, ]
  }
  dat <- clip_occ(dat, prop)

  message("Done.")

  return(dat)
}
