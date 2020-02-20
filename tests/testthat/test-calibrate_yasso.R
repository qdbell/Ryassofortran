test_that("Simulated carbon is correct for calibration", {

  # Expected output
  real_out <- matrix(data = c(19.22993, 9.68424, 6.27607, 4.51242, 2.00021,
                              0.99242, 0.63743, 0.45647, 6.2641, 2.14992,
                              0.93152, 0.50126, 23.5613, 21.59019, 17.54721,
                              13.71189, 0.96378, 1.34603, 1.56155, 1.71241),
                     nrow = 4, ncol = 5)

  # Simulated output
  simulated_out <- calibrate_yasso(
    par = sample_parameters,
    n_runs = sample_data_cal$n_runs,
    time = sample_data_cal$time,
    weather = sample_data_cal$weather,
    init = sample_data_cal$init,
    litter = sample_data_cal$litter,
    size = sample_data_cal$size,
    leac = sample_data_cal$leac
  )

  # Round to a sensible precision
  real_out <- round(real_out, 3)
  simulated_out <- round(simulated_out, 3)

  # Compare
  testthat::expect_equal(simulated_out, real_out)
})
