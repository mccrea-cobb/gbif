

#

#' Download FWS refuge boundary
#'
#' @author McCrea Cobb \email{mccrea_cobb@@fws.gov}
#'
#' @param orgname The name of a refuge (e.g., "KODIAK NATIONAL WILDLIFE REFUGE")
#'
#' @return An \code{sf} multipolygon object of a refuge boundary
#'
#' @import httr
#' @import sf
#' @export
#'
#' @examples
#' \dontrun{
#' get_refuge(orgname = "TETLIN NATIONAL WILDLIFE REFUGE")}
get_refuge <- function(orgname = "Arctic National Wildlife Refuge"){
  orgname <- toupper(orgname)
  message(paste("Downloading boundary layer for", orgname))
  url <- httr::parse_url("https://services.arcgis.com/QVENGdaPbd4LUkLV/arcgis/rest/services")
  url$path <- paste(url$path, "National_Wildlife_Refuge_System_Boundaries/FeatureServer/0/query", sep = "/")
  url$query <- list(where = paste("ORGNAME =", paste0("'",orgname,"'")),  # Arctic Refuge, in this case
                    outFields = "*",
                    returnGeometry = "true",
                    f = "pgeojson"
  )
  request <- httr::build_url(url)
  prop <- sf::st_read(request)
  message("Done.")
  return(prop)
}
