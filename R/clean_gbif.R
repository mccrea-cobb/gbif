
#' Clean up raw GBIF data
#'
#' @author McCrea Cobb \email{mccrea_cobb@@fws.gov}
#'
#' @param dat a data frame returned by \code{get_gbif()}
#'
#' @return A cleaned data frame containing a single observation for each species. The data frame includes the following columns:
#' \itemize{
#'  \item{"species"}{The scientific species name}
#'  \item{"lat"}{Degrees latitude of the observation}
#'  \item{"long"}{Degrees longitude of the observation}
#'  \item{"evidence"}{The website for the evidence link}
#'  \item{"date"}{The date that the species was observed (event)}
#'  }
#'
#' @export
#' @import tidyverse
#'
#' @example
#' \dontrun{
#' clean_gbif(dat)
#' }
clean_gbif <- function(dat){
  library(tidyverse)

  out <- dat %>%

    mutate(evidence = case_when(   # Add evidence link, based on values in the reference column (if present) or a GBIF link
      references != "" ~ references,
      references == "" ~ str_c("https://www.gbif.org/occurrence/", as.character(gbifID))
    )) %>%

    arrange(desc(references)) %>%  # sort by reverse order to drop empty reference to the bottom

    dplyr::distinct(species, .keep_all = TRUE) %>%  # Keep a single observation for each species

    select(species,  # Keep just the species names, lat/longs, evidence links, data evidence dates
           lat = decimalLatitude,
           long = decimalLongitude,
           evidence,
           date = eventDate) %>%

    filter(species != "")  # filter out rows without species names

  return(out)
}




# Map the result
# (p <- ggplot() + geom_sf(dat = prop))
# (p + geom_point(dat = dat, aes(long, lat)))

# Save as a csv
# write.csv(dat, "gbif_spp.csv")
