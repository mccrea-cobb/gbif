% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_refuge.R
\name{get_refuge}
\alias{get_refuge}
\title{Download FWS refuge boundary}
\usage{
get_refuge(orgname = "ARCTIC NATIONAL WILDLIFE REFUGE")
}
\arguments{
\item{orgname}{The name of a refuge (e.g., "KODIAK NATIONAL WILDLIFE REFUGE")}
}
\value{
An \code{sf} multipolygon object of a refuge boundary
}
\description{
Download FWS refuge boundary
}
\examples{
\dontrun{
get_refuge(orgname = "TETLIN NATIONAL WILDLIFE REFUGE")}
}
\author{
McCrea Cobb \email{mccrea_cobb@fws.gov}
}
