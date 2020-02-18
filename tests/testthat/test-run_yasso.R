test_that("Simulated carbon is correct", {

  # Expected output
  real_out <- structure(c(40.5, 19.2299264776091, 6.20665384992087,
                          2.52327387792653, 0.856075468324991, 30.5,
                          2.00021165581069, 0.63027022155572, 0.254712580954942,
                          0.0863922470385123, 20.3, 6.26410347287329,
                          0.911198352689665, 0.22392117346921, 0.0728638810896671,
                          10.3, 23.5613025463883, 17.4227220912582, 7.97179840488946,
                          2.71721240388795, 0, 0.963775827011475, 1.56690625274911,
                          1.91318304326072, 2.0906140586988
                          ), .Dim = c(5L, 5L))

  # Simulated output
  simulated_out <- run_yasso(sample_parameters, sample_data_run)

  # Round to a sensible precision
  real_out <- round(real_out, 4)
  simulated_out <- round(simulated_out, 4)

  # Compare
  expect_equal(simulated_out, real_out)
})
