## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library(COINr)

# build example coin
coin <- build_example_coin(quietly = TRUE)

## -----------------------------------------------------------------------------
# component of SA_specs for winmax distribution
l_winmax <- list(Address = "$Log$Treat$global_specs$f1_para$winmax",
               Distribution = 1:5,
               Type = "discrete")

## -----------------------------------------------------------------------------
# normalisation method

# first, we define the two alternatives: minmax or zscore (along with respective parameters)
norm_alts <- list(
  list(f_n = "n_minmax", f_n_para = list(c(1,100))),
  list(f_n = "n_zscore", f_n_para = list(c(10,2)))
)

# now put this in a list
l_norm <- list(Address = "$Log$Normalise$global_specs",
               Distribution = norm_alts,
               Type = "discrete")

## -----------------------------------------------------------------------------
# get nominal weights
w_nom <- coin$Meta$Weights$Original

# build data frame specifying the levels to apply the noise at
noise_specs = data.frame(Level = c(2,3),
                         NoiseFactor = c(0.25, 0.25))

# get 100 replications
noisy_wts <- get_noisy_weights(w = w_nom, noise_specs = noise_specs, Nrep = 100)

# examine one of the noisy weight sets
tail(noisy_wts[[1]])

## -----------------------------------------------------------------------------
# component of SA_specs for weights
l_weights <- list(Address = "$Log$Aggregate$w",
                  Distribution = noisy_wts,
                  Type = "discrete")

## -----------------------------------------------------------------------------
## aggregation
l_agg <- list(Address = "$Log$Aggregate$f_ag",
               Distribution = c("a_amean", "a_gmean"),
               Type = "discrete")

## -----------------------------------------------------------------------------
# create overall specification list
SA_specs <- list(
  Winmax = l_winmax,
  Normalisation = l_norm,
  Weights = l_weights,
  Aggregation = l_agg
)

## ---- eval=FALSE--------------------------------------------------------------
#  # Not run here: will take a few seconds to finish if you run this
#  SA_res <- get_sensitivity(coin, SA_specs = SA_specs, N = 100, SA_type = "UA",
#                            dset = "Aggregated", iCode = "Index")

## ----include=FALSE------------------------------------------------------------
SA_res <- readRDS("UA_results.RDS")

## ---- fig.width= 7------------------------------------------------------------
plot_uncertainty(SA_res)

## -----------------------------------------------------------------------------
head(SA_res$RankStats)

## ---- eval=FALSE--------------------------------------------------------------
#  # Not run here: will take a few seconds to finish if you run this
#  SA_res <- get_sensitivity(coin, SA_specs = SA_specs, N = 100, SA_type = "SA",
#                            dset = "Aggregated", iCode = "Index", Nboot = 100)

## ----include=FALSE------------------------------------------------------------
SA_res <- readRDS("SA_results.RDS")

## ---- fig.width=5-------------------------------------------------------------
plot_sensitivity(SA_res)

## ---- fig.width=7-------------------------------------------------------------
plot_sensitivity(SA_res, ptype = "box")

## -----------------------------------------------------------------------------
# run function removing elements in level 2
l_res <- remove_elements(coin, Level = 2, dset = "Aggregated", iCode = "Index")

# get summary of rank changes
l_res$MeanAbsDiff

