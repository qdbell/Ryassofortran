#' Run the YASSO model
#'
#' Run the YASSO model and return simulated soil carbon.
#'
#' The driver data types have to be set with as.<datatype> exactly as described
#' under "Arguments".
#'
#' The \code{run_yasso()} function is designed for generic
#' use, such as making predictions with YASSO15. The user provides YASSO15 with
#' driver data and initial carbon in a vector. The model “rolls” the carbon
#' forward one time step at a time using the simulated carbon of the current
#' time step as the initial carbon of the next step. The model runs until it has
#' looped over all the time steps.
#'
#' See also the sample dataset
#' \code{\link{sample_data_run}}.
#'
#' @param par \code{double} A vector containing the YASSO parameters.
#' @param n_runs \code{integer} Number of time steps to run the model over.
#' @param time \code{double} Length of each time step in years.
#' @param temp \code{matrix} Average temperature for each month of each modelled
#'   year.
#' @param prec \code{double} Annual precipitation sum of each year.
#' @param init \code{double} Initial soil carbon values (A, W, E, N, H) to start
#'   the simulation with.
#' @param litter \code{matrix} Litter input to the model on each time step (A,
#'   W, E, N, H).
#' @param wsize \code{double} Litter size on each time step.
#' @param leac \code{double} Leaching correction factor on each time step. Only
#'   defined for litter bag measurements - describes how much litter falls out
#'   of the holes in the bags over time. Usually a calibrated value.
#' @param sspred \code{integer} Defines if steady state mode should be used (1 =
#'   yes).
#'
#' @return A matrix containing the initial soil carbon on the first row and
#'   simulated soil carbon on the following rows.
#' @export
#'
#' @seealso \code{\link{sample_data_run}}
#'
#' @examples
#' soil_c <- run_yasso(
#'  par = sample_parameters,
#'  n_runs = sample_data_run$n_runs,
#'  time = sample_data_run$time,
#'  temp = sample_data_run$temp,
#'  prec = sample_data_run$prec,
#'  init = sample_data_run$init,
#'  litter = sample_data_run$litter,
#'  wsize = sample_data_run$wsize,
#'  leac = sample_data_run$leac
#' )

run_yasso <- function(par, n_runs, time, temp, prec, init, litter, wsize, leac,
                      sspred = 0L) {

  # Typeset parameters
  par <- as.double(par)

  # Initialize, typeset an array for the results
  soil_c <- matrix(rep(0, len = (n_runs) * 5), nrow = n_runs)
  soil_c <- rbind(init, soil_c)
  soil_c <- unname(as.matrix(soil_c))

  # Call the fortran model
  xx <- .Fortran(
    "runyasso",
    par = par,
    n_runs = n_runs,
    time = time,
    temp = temp,
    prec = prec,
    litter = litter,
    wsize = wsize,
    leac = leac,
    soil_c = soil_c,
    sspred = sspred
  )

  # Return simulated soil carbon
  return(xx$soil_c)
}
