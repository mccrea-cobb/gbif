#' Download species occurrence data from GBIF
#'
#' @author McCrea Cobb \email{mccrea_cobb@@fws.gov}
#'
#' @param prop An \code{sf} multipolygon object of a refuge boundary, returned by \code{get_refuge}.
#' @param pause The number of seconds to pause to wait for the data request from GBIF to be ready. Default is 60 secs. If it returns file size: 0 MB then increase the pause time.
#'
#' @return A data frame of species occurrence data from GBIF within the boundary of the desired refuge
#'
#' @note First time user - Add your GBIF credentials (username, password, email) to an .renviron file using \code{usethis::edit_r_environ(scope = "user")}
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
#' get_gbif(orgname = "Kodiak National Wildlife Refuge")
#' }
get_gbif <- function(prop,
                     pause = 90,
                     ...){
  # Create a simplified convex hull of the refuge boundary in WKT format
  wkt <- get_wkt(prop)

  # Spin up a request for data from GBIF within the convex hull boundary of the refuge
  res <- rgbif::occ_download(rgbif::pred_within(wkt))

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
  dat <- clip_occ(dat, prop)

  message("Done.")

  return(dat)
}
