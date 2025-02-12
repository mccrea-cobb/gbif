% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_gbif.R
\name{get_gbif}
\alias{get_gbif}
\title{Download species occurrence data from GBIF}
\usage{
get_gbif(prop, pause = 90, ...)
}
\arguments{
\item{prop}{An \code{sf} multipolygon object of a refuge boundary, returned by \code{get_refuge}.}

\item{pause}{The number of seconds to pause to wait for the data request from GBIF to be ready. Default is 60 secs. If it returns file size: 0 MB then increase the pause time.}
}
\value{
A data frame of species occurrence data from GBIF within the boundary of the desired refuge
}
\description{
Download species occurrence data from GBIF
}
\note{
First time user - Add your GBIF credentials (username, password, email) to an .renviron file using \code{usethis::edit_r_environ(scope = "user")}
\itemize{
\item GBIF_USER = "your GBIF user name"
\item GBIF_PWD = "your GBIF password"
\item GBIF_EMAIL = "your email address"
}
}
\examples{
\dontrun{
get_gbif(orgname = "KODIAK NATIONAL WILDLIFE REFUGE")
}
}
\author{
McCrea Cobb \email{mccrea_cobb@fws.gov}
}
