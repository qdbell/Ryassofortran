test_that("Simulated carbon is correct for calibration", {

  # Expected output
  real_out <- structure(c(19.2299264776091, 9.68424417943183, 6.27606543843457,
                          4.51242110632996, 2.00021165581069, 0.992415210455358,
                          0.637434842011072, 0.456470249478737, 6.26410347287329,
                          2.1499170711192, 0.931516502402896,0.501258493484273,
                          23.5613025463883, 21.5901887968128, 17.5472099839851,
                          13.7118900978109, 0.963775827011475, 1.34602617270601,
                          1.56155418493683, 1.71240610163779), .Dim = 4:5)

  # Simulated output
  simulated_out <- calibrate_yasso(sample_parameters, sample_data_cal)

  # Round to a sensible precision
  real_out <- round(real_out, 4)
  simulated_out <- round(simulated_out, 4)

  # Compare
  expect_equal(simulated_out, real_out)


})
