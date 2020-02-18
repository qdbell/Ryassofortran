
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Ryassofortran

<!-- badges: start -->

<!-- badges: end -->

The goal of Ryassofortran is to provide a convenient way to call the
Fortran90-release of the soil carbon model YASSO15 in R.

The Fortran-release is on average two orders of magnitude faster than
the R-release. Using the Fortran-release is superior for model
calibration purposes.

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

This is a basic example that shows you how to run the Fortran-version of
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
