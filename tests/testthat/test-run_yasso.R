test_that("Simulated carbon is correct", {

  # Expected output
  real_out <- matrix(data = c(40.5, 33.31233, 15.24216, 6.83534, 3.93259, 30.5,
                              3.50439, 1.58746, 0.69936, 0.39716, 20.3, 12.61624,
                              4.98216, 1.44365, 0.45704, 10.3, 20.79977, 26.23076,
                              24.64433, 19.35745, 0, 0.53731, 1.01746, 1.34135,
                              1.56046),
                     nrow = 5, ncol = 5)

  # Simulated output
  simulated_out <- run_yasso(
    par = sample_parameters,
    n_runs = sample_data_run$n_runs,
    time = sample_data_run$time,
    weather = sample_data_run$weather,
    init = sample_data_run$init,
    litter = sample_data_run$litter,
    size = sample_data_run$size,
    leac = sample_data_run$leac
  )

  # Round to a sensible precision
  real_out <- round(real_out, 3)
  simulated_out <- round(simulated_out, 3)

  # Compare
  expect_equal(simulated_out, real_out)
})
