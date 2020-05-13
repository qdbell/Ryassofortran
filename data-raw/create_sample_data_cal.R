# Amount of rows to run model over
n_runs <- 4

# Time for each run
time <- c(1.01, 2.03, 3.01, 4.00)

# Weather for each run
weather_v <- c(9.710, 814.585, 7.3625)
weather <- matrix(weather_v, nrow = n_runs, ncol = length(weather_v), byrow = TRUE)

# Litter input for each run
litter <- matrix(rep(0, len = n_runs * 4), nrow = n_runs)

# Woody size for each run
wsize <- rep(0, 4)

# Leaching for each run
leac <- 0

# Initial carbon for each run
init_v <- c(40.5, 30.5, 20.3, 10.3, 0)
init <- matrix(init_v, nrow = n_runs, ncol = length(init_v), byrow = TRUE)

# Create a list, typeset for fortran
sample_data_cal <- list(
  "n_runs" = as.integer(n_runs),
  "time" = as.double(time),
  "weather" = as.matrix(weather),
  "init" = as.matrix(init),
  "litter" = as.matrix(litter),
  "wsize" = as.double(wsize),
  "leac" = as.double(leac)
)

usethis::use_data(sample_data_cal, overwrite = TRUE)
