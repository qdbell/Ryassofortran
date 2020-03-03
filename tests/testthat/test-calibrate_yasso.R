test_that("Simulated carbon is correct for calibration", {

  # Expected output
  real <- c(81.9671285079688, 8.57768376541478, 28.8069697546253,
            98.1102713465062, 3.5240001845443)

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

  simulated <- colSums(simulated_out)

  # Compare
  expect_equal(simulated, real)
})
