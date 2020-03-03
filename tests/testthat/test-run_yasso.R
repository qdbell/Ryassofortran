test_that("Simulated carbon is correct", {

  # Expected output
  real <- c(99.8224302943704, 36.6883641040158, 39.7990955184471,
            101.332316053511, 4.45658067240158)

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

  simulated <- colSums(simulated_out)

  # Compare
  expect_equal(simulated, real)
})
