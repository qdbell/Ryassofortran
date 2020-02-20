
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Ryassofortran

<!-- badges: start -->

[![Travis build
status](https://travis-ci.org/jpusa/Ryassofortran.svg?branch=master)](https://travis-ci.org/jpusa/Ryassofortran)
<!-- [![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/jpusa/Ryassofortran?branch=master&svg=true)](https://ci.appveyor.com/project/jpusa/ryassofortran) -->
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

On Windows systems the installation requires Rtools to be installed.

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
  weather = sample_data_run$weather,
  init = sample_data_run$init,
  litter = sample_data_run$litter,
  size = sample_data_run$size,
  leac = sample_data_run$leac
)

# Show the results
round(soil_c, 3)
#>        [,1]   [,2]   [,3]   [,4]  [,5]
#> [1,] 40.500 30.500 20.300 10.300 0.000
#> [2,] 19.230  2.000  6.264 23.561 0.964
#> [3,]  6.207  0.630  0.911 17.423 1.567
#> [4,]  2.523  0.255  0.224  7.972 1.913
#> [5,]  0.856  0.086  0.073  2.717 2.091
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
# Run in calibration mode
soil_c_cal <- calibrate_yasso(
  par = sample_parameters,
  n_runs = sample_data_cal$n_runs,
  time = sample_data_cal$time,
  weather = sample_data_cal$weather,
  init = sample_data_cal$init,
  litter = sample_data_cal$litter,
  size = sample_data_cal$size,
  leac = sample_data_cal$leac
)

# Show the results
round(soil_c_cal, 3)
#>        [,1]  [,2]  [,3]   [,4]  [,5]
#> [1,] 19.230 2.000 6.264 23.561 0.964
#> [2,]  9.684 0.992 2.150 21.590 1.346
#> [3,]  6.276 0.637 0.932 17.547 1.562
#> [4,]  4.512 0.456 0.501 13.712 1.712
```
