test_that("Simulated carbon is correct for calibration", {

  # Expected output
  real_out <- as.matrix(structure(c(
    33.3123306844144, 22.0065344560305, 15.398799118121,
    11.249464249403, 3.50438904066499, 2.30435817980118, 1.604047482973,
    1.16488906197561, 12.6162443949078, 7.86391857046053, 5.04910994114368,
    3.27769684811328, 20.7997734726964, 24.7337552148445, 26.2099241988328,
    26.3668184601324, 0.537305095044618, 0.823818065507579, 1.01263275589893,
    1.15024426809318), .Dim = 4:5))

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

test_that("Steady state predictions are correct", {

  # Expected output
  real_out <- as.matrix(structure(c(
    55.0714532814246, 62.7219901387319, 70.3725269960391,
    78.0230638533463, 6.08278287358969, 6.95519998028987, 7.82761708699004,
    8.70003419369021, 22.4294433438193, 24.8906442870783, 27.3518452303373,
    29.8130461735963, 274.549346416613, 302.404493618539, 330.259640820465,
    358.114788022391, 381.17024437073, 431.507093197029, 481.843942023328,
    532.180790849627), .Dim = 4:5))


  # Simulated output
  simulated_out <- calibrate_yasso(
    par = sample_parameters,
    n_runs = sample_data_cal$n_runs,
    time = sample_data_cal$time,
    weather = sample_data_cal$weather,
    init = sample_data_cal$init,
    litter = sample_data_cal$litter + matrix(1:16, nrow = 4),
    wsize = sample_data_cal$wsize,
    leac = sample_data_cal$leac,
    sspred = 1L
  )

  # Compare
  expect_equal(simulated_out, real_out, tolerance = 1e-4)
})
