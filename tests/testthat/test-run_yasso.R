test_that("Simulated carbon is correct", {

  # Expected output
  real_out <- as.matrix(structure(c(
    40.5, 33.3123306844144, 15.2421648573332, 6.83534179172177,
    3.93259296090109, 30.5, 3.50438904066499, 1.58745747978223, 0.699356387797316,
    0.397161195771229, 20.3, 12.6162443949078, 4.98216376367056,
    1.44364557626969, 0.457041783598982, 10.3, 20.7997734726964,
    26.23076208432, 24.6443266775476, 19.3574538189471, 0, 0.537305095044618,
    1.0174633834915, 1.34135274580545, 1.56045944806001), .Dim = c(5L, 5L)))

  # Simulated output
  simulated_out <- run_yasso(
    par = sample_parameters,
    n_runs = sample_data_run$n_runs,
    time = sample_data_run$time,
    weather = sample_data_run$weather,
    init = sample_data_run$init,
    litter = sample_data_run$litter,
    wsize = sample_data_run$wsize,
    leac = sample_data_run$leac
  )

  # Compare
  expect_equal(simulated_out, real_out, tolerance = 1e-4)
})

test_that("Steady state predictions are correct", {

  # Expected output
  real_out <- as.matrix(structure(c(
    40.5, 55.0714532814246, 62.7219901387319, 70.3725269960391,
    78.0230638533463, 30.5, 6.08278287358969, 6.95519998028987, 7.82761708699004,
    8.70003419369021, 20.3, 22.4294433438193, 24.8906442870783, 27.3518452303373,
    29.8130461735963, 10.3, 274.549346416613, 302.404493618539, 330.259640820465,
    358.114788022391, 0, 381.17024437073, 431.507093197029, 481.843942023328,
    532.180790849627), .Dim = c(5L, 5L)))

  # Simulated output
  simulated_out <- run_yasso(
    par = sample_parameters,
    n_runs = sample_data_run$n_runs,
    time = sample_data_run$time,
    weather = sample_data_run$weather,
    init = sample_data_run$init,
    litter = sample_data_run$litter + matrix(1:16, nrow = 4),
    wsize = sample_data_run$wsize,
    leac = sample_data_run$leac,
    sspred = 1L
  )

  # Compare
  expect_equal(simulated_out, real_out, tolerance = 1e-4)
})
