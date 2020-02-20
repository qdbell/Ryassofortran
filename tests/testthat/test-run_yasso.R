test_that("Simulated carbon is correct", {

  # Expected output
  real_out <- matrix(data = c(40.5, 19.22992, 6.20665, 2.52327, 0.85607, 30.5,
                              2.00021, 0.63027, 0.25471, 0.08639, 20.3, 6.2641,
                              0.91119, 0.22392, 0.07286, 10.3, 23.5613, 17.42272,
                              7.9718, 2.71721, 0, 0.96378, 1.56691, 1.91318, 2.09061),
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
