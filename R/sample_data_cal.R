#' Sample data for calibrating YASSO
#'
#' Sample data for the \code{\link{calibrate_yasso}} function. Identical to the
#' data in \code{\link{sample_data_run}}, except for \code{init}, which is now a
#' matrix instead of a vector and \code{leac}, which is now a single value.
#'
#' @format A list with input data. The data types have to be set with
#'   \code{as.<datatype>} exactly as described below for \code{calibrate_yasso()}
#'   to function:
#' \describe{
#'   \item{n_runs}{\code{integer} Number of time steps to run the model over.
#'     All inputs below except \code{init} and \code{leac} have to be of length
#'     \code{n_runs}, i.e. have to be specified at each time step.}
#'   \item{time}{\code{double} A vector with length of each time step in years.}
#'   \item{temp}{\code{matrix} Average temperature of each month in a year.
#'   Specified for each time step.}
#'   \item{prec}{\code{double} Annual precipitation sum for each time step.}
#'   \item{init}{\code{matrix} Initial soil carbon values for each
#'     time step (A, W, E, N, H).}
#'   \item{litter}{\code{matrix} Litter input to the model at each time step (A,
#'     W, E, N, H).}
#'   \item{wsize}{\code{double} A vector with litter size for each time step.}
#'   \item{leach}{\code{double} The leaching correction value.}
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
"sample_data_cal"
