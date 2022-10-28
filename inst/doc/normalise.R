## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library(COINr)

# build example coin
coin <- build_example_coin(up_to = "new_coin")

# normalise the raw data set
coin <- Normalise(coin, dset = "Raw")

## -----------------------------------------------------------------------------
plot_scatter(coin, dsets = c("Raw", "Normalised"), iCodes = "Goods")

## -----------------------------------------------------------------------------
coin <- Normalise(coin, dset = "Raw",
                   global_specs = list(f_n = "n_zscore",
                                        f_n_para = list(c(10,2))))

## -----------------------------------------------------------------------------
plot_scatter(coin, dsets = c("Raw", "Normalised"), iCodes = "Goods")

## -----------------------------------------------------------------------------
# wrapper function
f_bin <- function(x, nbins){
  cut(x, breaks = nbins, labels = FALSE)
}

# pass wrapper to normalise, specify 5 bins
coin <- Normalise(coin, dset = "Raw",
                   global_specs = list(f_n = "f_bin",
                                        f_n_para = list(nbins = 5)))

## -----------------------------------------------------------------------------
plot_scatter(coin, dsets = c("Raw", "Normalised"), iCodes = "Goods")

## -----------------------------------------------------------------------------
# get directions from coin
directions <- coin$Meta$Ind[c("iCode", "Direction")]

head(directions, 10)

## -----------------------------------------------------------------------------
# change Goods to -1
directions$Direction[directions$iCode == "Goods"] <- -1

# re-run (using min max default)
coin <- Normalise(coin, dset = "Raw", directions = directions)

## -----------------------------------------------------------------------------
# individual specifications:
# LPI - borda scores
# Flights - z-scores with mean 10 and sd 2
indiv_specs <- list(
  LPI = list(f_n = "n_borda"),
  Flights = list(f_n = "n_zscore",
                 f_n_para = list(m_sd = c(10, 2)))
)

# normalise
coin <- Normalise(coin, dset = "Raw", indiv_specs = indiv_specs)

# a quick look at the first three indicators
get_dset(coin, "Normalised")[1:4] |>
  head(10)

## -----------------------------------------------------------------------------
head(ASEM_iMeta[c("iCode", "Target")])

## ---- eval=FALSE--------------------------------------------------------------
#  coin <- Normalise(coin, dset = "Raw", global_specs = list(f_n = "n_dist2targ"))

## ---- eval=FALSE--------------------------------------------------------------
#  coin <- Normalise(coin, dset = "Raw", global_specs = list(f_n = "n_dist2targ", f_n_para = list(cap_max = TRUE)))

## -----------------------------------------------------------------------------
mtcars_n <- Normalise(mtcars, global_specs = list(f_n = "n_dist2max"))

head(mtcars_n)

## -----------------------------------------------------------------------------
Normalise(iris) |>
  head()

## -----------------------------------------------------------------------------
# example vector
x <- runif(10)

# normalise using distance to reference (5th data point)
x_norm <- Normalise(x, f_n = "n_dist2ref", f_n_para = list(iref = 5))

# view side by side
data.frame(x, x_norm)

## -----------------------------------------------------------------------------
purse <- build_example_purse(quietly = TRUE)

## -----------------------------------------------------------------------------
purse <- Normalise(purse, dset = "Raw", global = TRUE)

## -----------------------------------------------------------------------------
# get normalised data of first coin in purse
x1 <- get_dset(purse$coin[[1]], dset = "Normalised")

# get min and max of first four indicators (exclude uCode col)
sapply(x1[2:5], min, na.rm = TRUE)
sapply(x1[2:5], max, na.rm = TRUE)

## -----------------------------------------------------------------------------
# get entire normalised data set for all coins in one df
x1_global <- get_dset(purse, dset = "Normalised")

# get min and max of first four indicators (exclude Time and uCode cols)
sapply(x1_global[3:6], min, na.rm = TRUE)
sapply(x1_global[3:6], max, na.rm = TRUE)

## -----------------------------------------------------------------------------
purse <- Normalise(purse, dset = "Raw", global = FALSE)

# get normalised data of first coin in purse
x1 <- get_dset(purse$coin[[1]], dset = "Normalised")

# get min and max of first four indicators (exclude uCode col)
sapply(x1[2:5], min, na.rm = TRUE)
sapply(x1[2:5], max, na.rm = TRUE)

## -----------------------------------------------------------------------------
# some made up data
X <- data.frame(uCode = letters[1:10],
                a = runif(10),
                b = runif(10)*100)

X

## -----------------------------------------------------------------------------
qNormalise(X)

## -----------------------------------------------------------------------------
qNormalise(X, f_n = "n_dist2ref", f_n_para = list(iref = 1, cap_max = TRUE))

