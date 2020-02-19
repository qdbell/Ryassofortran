#' Run the YASSO model
#'
#' \code{run_yasso()} runs the YASSO model and returns simulated soil carbon.
#'
#' \code{run_yasso()} wraps the Fortran90-release of the soil carbon model
#' YASSO15 into a simple R-function. The function is a convenient way to call
#' the Fortran-release.
#'
#' The function provides YASSO with the initial soil carbon values in the vector
#' \code{sdl$init} and runs the model one time step at a time. The simulated
#' carbon of the current time step is used as the initial value of the next time
#' step. The model runs until it has looped over all the time steps.
#'
#' @param par A numeric vector of YASSO parameters.
#' @param sdl A list of input data. See \code{\link{sample_data_run}} for
#'   details.
#'
#' @return A matrix containing the initial soil carbon on the first row and
#'   simulated soil carbon on the following rows.
#' @export
#'
#' @examples
#' soil_c <- run_yasso(par = sample_parameters, sdl = sample_data_run)

run_yasso <- function(par, sdl) {

  # Typeset parameters
  par <- as.double(par)

  # Initialize, typeset an array for the results
  soil_c <- matrix(rep(0, len = (sdl$n_runs) * 5), nrow = sdl$n_runs)
  soil_c <- rbind(sdl$init, soil_c)
  soil_c <- as.matrix(soil_c)

  # Call the fortran model
  xx <- .Fortran(
    "runyasso",
    n_runs = sdl$n_runs,
    par = par,
    time = sdl$time,
    weather = sdl$weather,
    litter = sdl$litter,
    size = sdl$size,
    leac = sdl$leac,
    soil_c = soil_c
  )

  # Return simulated soil carbon
  return(xx$soil_c)
}
