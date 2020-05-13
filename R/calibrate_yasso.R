#' Calibrate the YASSO model
#'
#' \code{calibrate_yasso()} runs the YASSO model in a way intended for model
#' calibration at the Finnish Meteorological Institute. For most users, it is
#' recommended to instead use \code{\link{run_yasso}} for simulating soil
#' carbon.
#'
#' \code{calibrate_yasso()} wraps the Fortran90-release of the soil carbon model
#' YASSO15 into a simple R-function. The function is intended for calibrating
#' the model using the data sets and methods applied at the Finnish
#' Meteorological Institute.
#'
#' The function provides YASSO with the initial soil carbon values in the matrix
#' \code{init} and runs the model one time step at a time. The initial value
#' of each time step is read from the matrix. The model runs until it has looped
#' over all the time steps.
#'
#' @param par A numeric vector of YASSO parameters.
#' @param n_runs Input data. Refer to \code{\link{sample_data_cal}} for now.
#' @param time -||-
#' @param weather -||-
#' @param init -||-
#' @param litter -||-
#' @param wsize -||-
#' @param leac -||-
#'
#' @return A matrix containing simulated soil carbon. Each row corresponds to a
#'   row in the matrix of initial states provided to the model.
#' @export
#'
#' @examples
#' soil_c <- calibrate_yasso(
#'  par = sample_parameters,
#'  n_runs = sample_data_cal$n_runs,
#'  time = sample_data_cal$time,
#'  weather = sample_data_cal$weather,
#'  init = sample_data_cal$init,
#'  litter = sample_data_cal$litter,
#'  wsize = sample_data_cal$wsize,
#'  leac = sample_data_cal$leac
#' )

calibrate_yasso <- function(par, n_runs, time, weather, init, litter, wsize, leac) {

  # Typeset parameters
  par <- as.double(par)

  # Initialize, typeset an array for the results
  soil_c <- matrix(rep(0, len = (n_runs) * 5), nrow = n_runs)
  soil_c <- as.matrix(soil_c)

  # Call the fortran model
  xx <- .Fortran(
    "calyasso",
    par = par,
    n_runs = n_runs,
    time = time,
    weather = weather,
    init = init,
    litter = litter,
    wsize = wsize,
    leac = leac,
    soil_c = soil_c
  )

  # Return simulated soil carbon
  return(xx$soil_c)
}
