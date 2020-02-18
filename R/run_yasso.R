#' Call the Fortran version of YASSO15
#'
#' @param par model parameters
#' @param sdl input data in a list
#'
#' @return Simulated soil carbon
#' @export
#'
#' @examples
#' soilC <- run_yasso(par = sample_parameters, sdl = sample_data_list)

run_yasso <- function(par, sdl) {

  # Typeset parameters
  par <- as.double(par)

  # Initialize, typeset an array for the results
  soilC <- matrix(rep(0, len = (sdl$nYears) * 5), nrow = sdl$nYears)
  soilC <- as.matrix(soilC)

  # Call the fortran model
  xx <- .Fortran(
    "calyasso",
    nYears = sdl$nYears,
    par = par,
    time = sdl$time,
    weather = sdl$weather,
    init = sdl$init,
    litter = sdl$litter,
    wsize = sdl$wsize,
    leac = sdl$leac,
    soilC = soilC
  )

  # Return simulated soil carbon
  return(xx$soilC)
}
