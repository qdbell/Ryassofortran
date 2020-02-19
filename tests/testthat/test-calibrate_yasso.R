test_that("Simulated carbon is correct for calibration", {

  # Expected output
  real_out <- structure(c(19.22993, 9.68424, 6.27607, 4.51242, 2.00021, 0.99242,
                          0.63743, 0.45647, 6.2641, 2.14992, 0.93152, 0.50126,
                          23.5613, 21.59019, 17.54721, 13.71189, 0.96378,
                          1.34603, 1.56155, 1.71241),
                        .Dim = 4:5)

  # Simulated output
  simulated_out <- calibrate_yasso(sample_parameters, sample_data_cal)

  # Round to a sensible precision
  real_out <- round(real_out, 3)
  simulated_out <- round(simulated_out, 3)

  # Compare
  expect_equal(simulated_out, real_out)


})
