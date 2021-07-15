[![Build Status](https://travis-ci.com/mccrea-cobb/refugbif.png)](https://travis-ci.com/mccrea-cobb/refugbif)

# refugbif
An R package to download and clean GBIF species occurrence data in a National Wildlife Refuge.

# USFWS Disclaimer
The United States Fish and Wildlife Service (FWS) GitHub project code is provided on an "as is" basis and the user assumes responsibility for its use. FWS has relinquished control of the information and no longer has responsibility to protect the integrity, confidentiality, or availability of the information. Any reference to specific commercial products, processes, or services by service mark, trademark, manufacturer, or otherwise, does not constitute or imply their endorsement, recommendation or favoring by FWS. The FWS seal and logo shall not be used in any manner to imply endorsement of any commercial product or activity by FWS or the United States Government.

# Instructions

The `refugbif` package requires [R](https://cloud.r-project.org/) (>=4.0)   to function.

To install and load the `refugbif` R package:  
`if (!require("devtools")) install.packages("devtools")`  
`devtools::install_github("mccrea-cobb/refugbif", ref = "main")`  
`library(refugbif)`  

`species_list <- get_species("ARCTIC NATIONAL WILDLIFE REFUGE") # Get species list for Arctic Refuge`

