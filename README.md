
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Ryassofortran

<!-- badges: start -->

<!-- [![Build Status](https://travis-ci.com/jpusa/Ryassofortran.svg?branch=master)](https://travis-ci.com/jpusa/Ryassofortran) -->

[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/jpusa/Ryassofortran?branch=master&svg=true)](https://ci.appveyor.com/project/jpusa/ryassofortran)
<!-- badges: end -->

The goal of Ryassofortran is to provide a convenient way to call the
Fortran90-release of the soil carbon model YASSO15 in R.

The Fortran-release of YASSO is up to two orders of magnitude faster
than the R-release. The absolute speed increase is not necessarily
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

### Requirements

* R-version 3.5.0 or higher.
* On Windows systems, Rtools needs to be installed.

## Examples

Simulate soil carbon with YASSO:

``` r
library(Ryassofortran)
```

``` r
# The initial carbon is given as a vector (A, W, E, N, H)
sample_data_run$init
#> [1] 40.5 30.5 20.3 10.3  0.0
```

``` r
# Run the YASSO model with sample parameters and data
soil_c <- run_yasso(
  par = sample_parameters,
  n_runs = sample_data_run$n_runs,
  time = sample_data_run$time,
  temp = sample_data_run$temp,
  prec = sample_data_run$prec,
  init = sample_data_run$init,
  litter = sample_data_run$litter,
  wsize = sample_data_run$wsize,
  leac = sample_data_run$leac
)

# Show the results
round(soil_c, 3)
#>        [,1]   [,2]   [,3]   [,4]  [,5]
#> [1,] 40.500 30.500 20.300 10.300 0.000
#> [2,] 35.218  3.708 13.394 20.001 0.493
#> [3,] 17.538  1.830  5.922 25.655 0.954
#> [4,]  8.179  0.840  1.941 25.074 1.287
#> [5,]  4.606  0.466  0.620 20.482 1.514
```

Run YASSO in a way intended for calibration:

``` r
# The initial carbon is given as a matrix
sample_data_cal$init
#>      [,1] [,2] [,3] [,4] [,5]
#> [1,] 40.5 30.5 20.3 10.3    0
#> [2,] 40.5 30.5 20.3 10.3    0
#> [3,] 40.5 30.5 20.3 10.3    0
#> [4,] 40.5 30.5 20.3 10.3    0
```

``` r
# There is a single leaching value for the entire data set
sample_data_cal$leac
#> [1] 0
```

``` r
# Run in calibration mode
soil_c_cal <- calibrate_yasso(
  par = sample_parameters,
  n_runs = sample_data_cal$n_runs,
  time = sample_data_cal$time,
  temp = sample_data_run$temp,
  prec = sample_data_run$prec,
  init = sample_data_cal$init,
  litter = sample_data_cal$litter,
  wsize = sample_data_cal$wsize,
  leac = sample_data_cal$leac
)

# Show the results
round(soil_c_cal, 3)
#>        [,1]  [,2]   [,3]   [,4]  [,5]
#> [1,] 35.218 3.708 13.394 20.001 0.493
#> [2,] 24.409 2.558  8.851 23.891 0.764
#> [3,] 17.702 1.847  5.992 25.624 0.950
#> [4,] 13.250 1.376  4.084 26.131 1.089
```
