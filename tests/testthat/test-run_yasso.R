test_that("Simulated carbon is correct", {

  # Expected output
  real_out <- structure(c(40.5, 19.22992, 6.20665, 2.52327, 0.85607, 30.5,
                          2.00021, 0.63027, 0.25471, 0.08639, 20.3, 6.2641,
                          0.91119, 0.22392, 0.07286, 10.3, 23.5613, 17.42272,
                          7.9718, 2.71721, 0, 0.96378, 1.56691, 1.91318, 2.09061),
                        .Dim = c(5L, 5L))

  # Simulated output
  simulated_out <- run_yasso(sample_parameters, sample_data_run)

  # Round to a sensible precision
  real_out <- round(real_out, 3)
  simulated_out <- round(simulated_out, 3)

  # Compare
  expect_equal(simulated_out, real_out)
})
