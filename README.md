
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Ryassofortran

<!-- badges: start -->

<!-- badges: end -->

The goal of Ryassofortran is to provide convenient R-functions for
calling the Fortran90-release of the soil carbon model YASSO15. The
Fortran90-release is highly computationally efficient, which makes it
ideal for model calibration purposes.

## Installation

### Requirements

  - R-version 3.5.0 or higher.
  - On Windows systems, Rtools needs to be installed.

You can install the development version of Ryassofortran from GitHub
with:

``` r
# install.packages("devtools")
devtools::install_github("YASSOmodel/Ryassofortran")
```

## Usage

Ryassofortran provides two R-functions: `run_yasso()` and
`calibrate_yasso()`. These functions call the respective
Fortran90-wrappers `runyasso` and `calyasso`, which in turn call the
Fortran90-subroutine `mod5c` containing the YASSO15 model code. In other
words, the package makes it possible to use simple R-functions to run a
very fast implementation of YASSO15. While both R-functions essentially
call the same model code, there are a few distinctive differences in how
they work.

**It is important to explicitly define the data types for the R-function
inputs.** The Fortran90-wrappers expect certain data types (double or
integer) for certain variables and the code will crash or silently fail
if the types are not cast correctly in R. See the in-built data
documentation `?sample_data_run` and `?sample_data_cal` for details.

The `run_yasso()` function is designed for generic use, such as making
predictions with YASSO15. The user provides YASSO15 with driver data and
initial carbon in a vector. The model “rolls” the carbon forward one
time step at a time using the simulated carbon of the current time step
as the initial carbon of the next step.

Do soil carbon predictions with `run_yasso()`:

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

The `calibrate_yasso()` function is highly specialized and not intended
for standard use. It is utilized for model calibration at the Finnish
Meteorological Institute: In the database used for calibration, there is
a measured initial state corresponding to an observed carbon value at
each time step. Consequently, the initial carbon is passed to the
function as a matrix and the model uses a pre-determined initial state
at each time step. Furthermore, the leaching input is a single value
instead of a vector, since every calibration dataset has a
characteristic leaching.

During calibrations, run YASSO with `calibrate_yasso()`:

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
# Run YASSO during a calibration
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
