## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(COINr)

# build example up to normalised data set
coin <- build_example_coin(up_to = "Normalise")

## -----------------------------------------------------------------------------
# aggregate normalised data set
coin <- Aggregate(coin, dset = "Normalised")

## -----------------------------------------------------------------------------
dset_aggregated <- get_dset(coin, dset = "Aggregated")

nc <- ncol(dset_aggregated)
# view aggregated scores (last 11 columns here)
dset_aggregated[(nc - 10) : nc] |>
  head(5) |>
  signif(3)

## -----------------------------------------------------------------------------
coin <- Normalise(coin, dset = "Treated",
                   global_specs = list(f_n = "n_minmax",
                                        f_n_para = list(l_u = c(1,100))))

## -----------------------------------------------------------------------------
coin <- Aggregate(coin, dset = "Normalised",
                   f_ag = "a_gmean")

## -----------------------------------------------------------------------------
# ms_installed <- requireNamespace("matrixStats", quietly = TRUE)
# ms_installed

# ci_installed <- requireNamespace("Compind", quietly = TRUE)
# ci_installed

## ---- eval=F------------------------------------------------------------------
#  # RESTORE above eval=ms_installed
#  # load matrixStats package
#  # library(matrixStats)
#  #
#  # # aggregate using weightedMedian()
#  # coin <- Aggregate(coin, dset = "Normalised",
#  #                    f_ag = "weightedMedian",
#  #                    f_ag_para = list(na.rm = TRUE))

## ---- eval= F-----------------------------------------------------------------
#  # RESTORE ABOVE eval= ci_installed
#  
#  # NOTE: this chunk disabled - see comments above.
#  
#  # load Compind
#  # suppressPackageStartupMessages(library(Compind))
#  #
#  # # wrapper to get output of interest from ci_bod
#  # # also suppress messages about missing values
#  # ci_bod2 <- function(x){
#  #   suppressMessages(Compind::ci_bod(x)$ci_bod_est)
#  # }
#  #
#  # # aggregate
#  # coin <- Aggregate(coin, dset = "Normalised",
#  #                    f_ag = "ci_bod2", by_df = TRUE, w = "none")

## -----------------------------------------------------------------------------
# data with all NAs except 1 value
x <- c(NA, NA, NA, 1, NA)

mean(x)

mean(x, na.rm = TRUE)

## -----------------------------------------------------------------------------
df1 <- data.frame(
  i1 = c(1, 2, 3),
  i2 = c(3, NA, NA),
  i3 = c(1, NA, 1)
)
df1

## -----------------------------------------------------------------------------
# aggregate with arithmetic mean, equal weight and data avail limit of 2/3
Aggregate(df1, f_ag = "a_amean",
           f_ag_para = list(w = c(1,1,1)),
           dat_thresh = 2/3)

## -----------------------------------------------------------------------------
coin <- Aggregate(coin, dset = "Normalised", f_ag = c("a_amean", "a_gmean", "a_amean"))

## -----------------------------------------------------------------------------
# get some indicator data - take a few columns from built in data set
X <- ASEM_iData[12:15]

# normalise to avoid zeros - min max between 1 and 100
X <- Normalise(X,
                global_specs = list(f_n = "n_minmax",
                                     f_n_para = list(l_u = c(1,100))))

# aggregate using harmonic mean, with some weights
y <- Aggregate(X, f_ag = "a_hmean", f_ag_para = list(w = c(1, 1, 2, 1)))

cbind(X, y) |>
  head(5) |>
  signif(3)

## -----------------------------------------------------------------------------
# build example purse up to normalised data set
purse <- build_example_purse(up_to = "Normalise", quietly = TRUE)

# aggregate using defaults
purse <- Aggregate(purse, dset = "Normalised")

