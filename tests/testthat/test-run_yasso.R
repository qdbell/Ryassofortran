test_that("Simulated carbon is correct", {

  # Expected output
  real <- 282.098786642746

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

  simulated <- sum(simulated_out)

  # Compare
  expect_equal(simulated, real, tolerance = 1e-4)
})
