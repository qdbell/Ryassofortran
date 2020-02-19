
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Ryassofortran

<!-- badges: start -->

<!-- badges: end -->

The goal of Ryassofortran is to provide a convenient way to call the
Fortran90-release of the soil carbon model YASSO15 in R.

The Fortran-release of YASSO is up to two orders of magnitude faster
than the R-release. The absolute speed increase is not always
significant while simulating soil carbon, but for model calibration
purposes the Fortran-release is superior.

NOTE: This package is very early in development and is subject to
changes. Furthermore, the package might be removed and included into a
more advanced calibration package in the following months.

## Installation

You can install the development version of Ryassofortran from GitHub
with:

``` r
# install.packages("devtools")
devtools::install_github("jpusa/Ryassofortran")
```

On Windows systems the installation requires Rtools to be installed.

## Example

There are basic examples that show you how to run the Fortran-version of
YASSO using the package:

``` r
library(Ryassofortran)
# Run the YASSO model with sample parameters and data
soilC <- run_yasso(par = sample_parameters, sdl = sample_data_run)
# Show the results
soilC
#>            [,1]        [,2]        [,3]      [,4]      [,5]
#> [1,] 40.5000000 30.50000000 20.30000000 10.300000 0.0000000
#> [2,] 19.2299265  2.00021166  6.26410347 23.561303 0.9637758
#> [3,]  6.2066538  0.63027022  0.91119835 17.422722 1.5669063
#> [4,]  2.5232739  0.25471258  0.22392117  7.971798 1.9131830
#> [5,]  0.8560755  0.08639225  0.07286388  2.717212 2.0906141
```

``` r
# Run in calibration mode
soilC_cal <- calibrate_yasso(par = sample_parameters, sdl = sample_data_cal)
# Show the results
soilC_cal
#>           [,1]      [,2]      [,3]     [,4]      [,5]
#> [1,] 19.229926 2.0002117 6.2641035 23.56130 0.9637758
#> [2,]  9.684244 0.9924152 2.1499171 21.59019 1.3460262
#> [3,]  6.276065 0.6374348 0.9315165 17.54721 1.5615542
#> [4,]  4.512421 0.4564702 0.5012585 13.71189 1.7124061
```
