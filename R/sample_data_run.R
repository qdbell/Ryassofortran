#' Sample data for running YASSO
#'
#' Sample data for the \code{\link{run_yasso}} function.
#'
#' @format A list with input data. The data types have to be exactly as
#'   described here for \code{run_yasso()} to function:
#' \describe{
#'   \item{n_runs}{\code{integer} Number of time steps to run the model over.}
#'   \item{time}{\code{double} A vector with length of each time step in years.}
#'   \item{weather}{\code{matrix} Weather data for each time step (mean
#'     temperarure, temperature amplitude, precipitation sum).}
#'   \item{init}{\code{double} A vector with initial soil carbon values (A, W,
#'     E, N, H).}
#'   \item{litter}{\code{matrix} Litter input to the model at each time step (A,
#'     W, E, N, H).}
#'   \item{size}{\code{double} A vector with litter size for each time step.}
#'   \item{leach}{\code{double} A vector with leaching correction factor for
#'     each time step.}
#' }
#'
#' @references
#'   Järvenpää, M., Repo, A., Akujärvi, A., Kaasalainen, M. & Liski, J. Soil
#'   carbon model Yasso15 - Bayesian calibration using worldwide litter
#'   decomposition and carbon stock data. Manuscript in preparation.
#'   (\href{https://en.ilmatieteenlaitos.fi/yasso-description}{FMI})
#'
#'   Tuomi, M., Laiho, R., Repo, A., & Liski. J. 2011. Wood
#'   decomposition model for boreal forests. Ecological Modelling 222 (3):
#'   709-718.
#'   (\href{https://doi.org/10.1016/j.ecolmodel.2010.10.025}{EcolModel})
#'
#'   Tuomi, M., Thum, T., Järvinen, H., Fronzek, S., Berg, B., Harmon, M.,
#'   Trofymow, J.A., Sevanto, S. & Liski, J. 2009. Leaf litter decomposition -
#'   Estimates of global variability based on Yasso07 model. Ecological
#'   Modelling 220 (23):3362-3371.
#'   (\href{doi:10.1016/j.ecolmodel.2009.05.016}{EcolModel})
#'
"sample_data_run"
