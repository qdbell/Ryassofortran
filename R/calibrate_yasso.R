#'Calibrate the YASSO model
#'
#'Run the YASSO model in a way intended for model calibration at the Finnish
#'Meteorological Institute. For most users, it is recommended to instead use
#'\code{\link{run_yasso}} for simulating soil carbon.
#'
#'The driver data types have to be set with as.<datatype> exactly as described
#'under "Arguments".
#'
#'The calibrate_yasso() function is utilized for model calibration at the
#'Finnish Meteorological Institute: In the database used for calibration, there
#'is a measured initial state corresponding to an observed carbon value at each
#'time step. Consequently, the initial carbon is passed to the function as a
#'matrix and the model uses a pre-determined initial state at each time step.
#'Furthermore, the leaching input is a single value instead of a vector, since
#'every calibration dataset has a characteristic leaching.
#'
#'See also the sample dataset \code{\link{sample_data_run}}.
#'
#'@param par \code{double} A vector containing the YASSO parameters.
#'@param n_runs \code{integer} Number of time steps to run the model over.
#'@param time \code{double} Length of each time step in years.
#'@param temp \code{matrix} Average temperature for each month of each modelled
#'  year.
#'@param prec \code{double} Annual precipitation sum of each year.
#'@param init \code{matrix} Initial soil carbon on each time step (A, W, E, N,
#'  H).
#'@param litter \code{matrix} Litter input to the model on each time step (A, W,
#'  E, N, H).
#'@param wsize \code{double} Litter size on each time step.
#'@param leac \code{double} Leaching correction factor for the current dataset.
#'@param sspred \code{integer} Defines if steady state mode should be used (1 =
#'  yes).
#'
#'
#'@return A matrix containing simulated soil carbon. Each simulated row
#'  corresponds to a row in the matrix of initial states.
#'@export
#'
#'@seealso \code{\link{sample_data_cal}}, \code{\link{run_yasso}}
#'
#' @examples
#' soil_c <- calibrate_yasso(
#'  par = sample_parameters,
#'  n_runs = sample_data_cal$n_runs,
#'  time = sample_data_cal$time,
#'  temp = sample_data_cal$temp,
#'  prec = sample_data_cal$prec,
#'  init = sample_data_cal$init,
#'  litter = sample_data_cal$litter,
#'  wsize = sample_data_cal$wsize,
#'  leac = sample_data_cal$leac
#' )

calibrate_yasso <- function(par, n_runs, time, temp, prec, init, litter, wsize,
                            leac, sspred = 0L) {

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
    temp = temp,
    prec = prec,
    init = init,
    litter = litter,
    wsize = wsize,
    leac = leac,
    soil_c = soil_c,
    sspred = sspred
  )

  # Return simulated soil carbon
  return(xx$soil_c)
}
