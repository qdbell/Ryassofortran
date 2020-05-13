test_that("Simulated carbon is correct for calibration", {

  # Expected output
  real_out <- matrix(data = c(33.31233, 22.00653, 15.3988, 11.24946, 3.50439,
                              2.30436, 1.60405, 1.16489, 12.61624, 7.86392,
                              5.04911, 3.2777, 20.79977, 24.73376, 26.20992,
                              26.36682, 0.53731, 0.82382, 1.01263, 1.15024
                              ),
                     nrow = 4, ncol = 5)

  # Simulated output
  simulated_out <- calibrate_yasso(
    par = sample_parameters,
    n_runs = sample_data_cal$n_runs,
    time = sample_data_cal$time,
    weather = sample_data_cal$weather,
    init = sample_data_cal$init,
    litter = sample_data_cal$litter,
    wsize = sample_data_cal$wsize,
    leac = sample_data_cal$leac
  )

  # Compare
  expect_equal(simulated_out, real_out, tolerance = 1e-4)
})
