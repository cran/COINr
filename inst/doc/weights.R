## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library(COINr)

# build example coin
coin <- build_example_coin(up_to = "Normalise", quietly = TRUE)

# view weights
head(coin$Meta$Weights$Original)

## -----------------------------------------------------------------------------
# view rows not in level 1
coin$Meta$Weights$Original[coin$Meta$Weights$Original$Level != 1, ]

## -----------------------------------------------------------------------------
# copy original weights
w1 <- coin$Meta$Weights$Original

# modify weights of Conn and Sust to 0.3 and 0.7 respectively
w1$Weight[w1$iCode == "Conn"] <- 0.3
w1$Weight[w1$iCode == "Sust"] <- 0.7

# put weight set back with new name
coin$Meta$Weights$MyFavouriteWeights <- w1

## -----------------------------------------------------------------------------
coin <- Aggregate(coin, dset = "Normalised", w = "MyFavouriteWeights")

## -----------------------------------------------------------------------------
coin <- Aggregate(coin, dset = "Normalised", w = w1)

## -----------------------------------------------------------------------------
w_eff <- get_eff_weights(coin, out2 = "df")

head(w_eff)

## -----------------------------------------------------------------------------
# get sum of effective weights for each level
tapply(w_eff$EffWeight, w_eff$Level, sum)

## ---- fig.width=5, fig.height=5-----------------------------------------------
plot_framework(coin)

## -----------------------------------------------------------------------------
coin <- get_PCA(coin, dset = "Aggregated", Level =  2,
                weights_to = "PCAwtsLev2", out2 = "coin")

## -----------------------------------------------------------------------------
coin$Meta$Weights$PCAwtsLev2[coin$Meta$Weights$PCAwtsLev2$Level == 2, ]

## -----------------------------------------------------------------------------
# build example coin
coin <- build_example_coin(quietly = TRUE)

# check correlations between level 3 and index
get_corr(coin, dset = "Aggregated", Levels = c(3, 4))

## -----------------------------------------------------------------------------
# optimise weights at level 3
coin <- get_opt_weights(coin, itarg = "equal", dset = "Aggregated",
                        Level = 3, weights_to = "OptLev3", out2 = "coin")

## -----------------------------------------------------------------------------
coin$Meta$Weights$OptLev3[coin$Meta$Weights$OptLev3$Level == 3, ]

## -----------------------------------------------------------------------------
# re-aggregate
coin <- Aggregate(coin, dset = "Normalised", w = "OptLev3")

# check correlations between level 3 and index
get_corr(coin, dset = "Aggregated", Levels = c(3, 4))

