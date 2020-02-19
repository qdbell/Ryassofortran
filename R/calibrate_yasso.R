#' Calibrate the YASSO model
#'
#' \code{calibrate_yasso()} runs the YASSO model in a way intended for model
#' calibration. To simulate soil carbon, use \code{\link{run_yasso}} instead.
#'
#' \code{calibrate_yasso()} wraps the Fortran90-release of the soil carbon model
#' YASSO15 into a simple R-function. The function is intended for calibrating
#' the model using the data sets and methods applied at the Finnish
#' Meteorological Institute.
#'
#' The function provides YASSO with the initial soil carbon values in the matrix
#' \code{sdl$init} and runs the model one time step at a time. The initial value
#' of each time step is read from the matrix. The model runs until it has looped
#' over all the time steps.
#'
#' @param par A numeric vector of YASSO parameters.
#' @param sdl A list of input data. See \code{\link{sample_data_cal}} for
#'   details.
#'
#' @return A matrix containing simulated soil carbon. Each row corresponds to a
#'   row in the matrix of initial states provided to the model.
#' @export
#'
#' @examples
#' soil_c <- calibrate_yasso(par = sample_parameters, sdl = sample_data_cal)

calibrate_yasso <- function(par, sdl) {

  # Typeset parameters
  par <- as.double(par)

  # Initialize, typeset an array for the results
  soil_c <- matrix(rep(0, len = (sdl$n_runs) * 5), nrow = sdl$n_runs)
  soil_c <- as.matrix(soil_c)

  # Call the fortran model
  xx <- .Fortran(
    "calyasso",
    n_runs = sdl$n_runs,
    par = par,
    time = sdl$time,
    weather = sdl$weather,
    init = sdl$init,
    litter = sdl$litter,
    size = sdl$size,
    leac = sdl$leac,
    soil_c = soil_c
  )

  # Return simulated soil carbon
  return(xx$soil_c)
}
