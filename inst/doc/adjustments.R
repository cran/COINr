## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library(COINr)

# create new coin by calling new_coin()
coin <- new_coin(ASEM_iData, ASEM_iMeta,
                 level_names = c("Indicator", "Pillar", "Sub-index", "Index"))

# look in log
str(coin$Log, max.level = 2)

## -----------------------------------------------------------------------------
# normalise
coin <- Normalise(coin, dset = "Raw")

# view log
str(coin$Log, max.level = 2)

## -----------------------------------------------------------------------------
# regenerate the coin
coin <- Regen(coin, quietly = FALSE)

## -----------------------------------------------------------------------------
# build full example coin
coin <- build_example_coin(quietly = TRUE)

# copy coin
coin2 <- coin

## -----------------------------------------------------------------------------
str(coin2$Log$Normalise)

## -----------------------------------------------------------------------------
# change to prank function (percentile ranks)
# we don't need to specify any additional parameters (f_n_para) here
coin2$Log$Normalise$global_specs <- list(f_n = "n_prank")

# regenerate
coin2 <- Regen(coin2)

## -----------------------------------------------------------------------------
# copy base coin
coin_remove <- coin

# remove two indicators and regenerate the coin
coin_remove <- change_ind(coin, drop = c("LPI", "Forest"), regen = TRUE)

coin_remove

## -----------------------------------------------------------------------------
# compare index, sort by absolute rank difference
compare_coins(coin, coin2, dset = "Aggregated", iCode = "Index",
              sort_by = "Abs.diff", decreasing = TRUE)

## -----------------------------------------------------------------------------
# copy original coin
coin90 <- coin

# remove imputation entry completely (function will not be run)
coin90$Log$Impute <- NULL

# set data availability threshold to 90%
coin90$Log$Screen$dat_thresh <- 0.9

# we also need to tell Screen() to use the denominated dset now
coin90$Log$Screen$dset <- "Denominated"

# regenerate
coin90 <- Regen(coin90)

# summarise coin
coin90

## -----------------------------------------------------------------------------
# compare index, sort by absolute rank difference
compare_coins(coin, coin90, dset = "Aggregated", iCode = "Index",
              sort_by = "Abs.diff", decreasing = TRUE)

## -----------------------------------------------------------------------------
compare_coins_multi(list(Nominal = coin, Prank = coin2, NoLPIFor = coin_remove,
                         Screen90 = coin90), dset = "Aggregated", iCode = "Index")

