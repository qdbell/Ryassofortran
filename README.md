
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Ryassofortran

<!-- badges: start -->

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
devtools::install_github("YASSOmodel/Ryassofortran")
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
  wsize = sample_data_run$wsize,
  leac = sample_data_run$leac
)

# Show the results
round(soil_c, 3)
#>        [,1]   [,2]   [,3]   [,4]  [,5]
#> [1,] 40.500 30.500 20.300 10.300 0.000
#> [2,] 33.312  3.504 12.616 20.800 0.537
#> [3,] 15.242  1.587  4.982 26.231 1.017
#> [4,]  6.835  0.699  1.444 24.644 1.341
#> [5,]  3.933  0.397  0.457 19.357 1.560
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
  weather = sample_data_cal$weather,
  init = sample_data_cal$init,
  litter = sample_data_cal$litter,
  wsize = sample_data_cal$wsize,
  leac = sample_data_cal$leac
)

# Show the results
round(soil_c_cal, 3)
#>        [,1]  [,2]   [,3]   [,4]  [,5]
#> [1,] 33.312 3.504 12.616 20.800 0.537
#> [2,] 22.007 2.304  7.864 24.734 0.824
#> [3,] 15.399 1.604  5.049 26.210 1.013
#> [4,] 11.249 1.165  3.278 26.367 1.150
```
