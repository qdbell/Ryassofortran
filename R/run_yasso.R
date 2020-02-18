#' Run the YASSO model
#'
#' \code{run_yasso()} runs the YASSO model and returns simulated soil carbon.
#'
#' \code{run_yasso()} wraps the Fortran90-release of the soil carbon model
#' YASSO15 into a simple R-function. The function is a convenient way to call
#' the Fortran-release, which is two orders of magnitude faster than
#' the R-release.
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
#' soilC <- run_yasso(par = sample_parameters, sdl = sample_data_run)

run_yasso <- function(par, sdl) {

  # Typeset parameters
  par <- as.double(par)

  # Initialize, typeset an array for the results
  soilC <- matrix(rep(0, len = (sdl$nYears) * 5), nrow = sdl$nYears)
  soilC <- rbind(sdl$init, soilC)
  soilC <- as.matrix(soilC)

  # Call the fortran model
  xx <- .Fortran(
    "runyasso",
    nYears = sdl$nYears,
    par = par,
    time = sdl$time,
    weather = sdl$weather,
    litter = sdl$litter,
    wsize = sdl$wsize,
    leac = sdl$leac,
    soilC = soilC
  )

  # Return simulated soil carbon
  return(xx$soilC)
}
