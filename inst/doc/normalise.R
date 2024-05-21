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
# show first few rows of iCode and Target cols in built-in iMeta
head(ASEM_iMeta[c("iCode", "Target")])

## -----------------------------------------------------------------------------
# copy built in data
iMeta <- ASEM_iMeta
# set cap_max
iMeta$dist2targ_cap_max <- TRUE

## -----------------------------------------------------------------------------
# build coin
coin <- new_coin(ASEM_iData, iMeta, quietly = TRUE)

# normalise, referencing iMeta columns
coin <- Normalise(coin, dset = "Raw", global_specs = list(f_n = "n_dist2targ", f_n_para = "use_iMeta"))

## -----------------------------------------------------------------------------
plot_scatter(coin, dsets = c("Raw", "Normalised"), iCodes = "LPI")

## -----------------------------------------------------------------------------
# get iCodes and raw data
iCodes <- iMeta$iCode[iMeta$Type == "Indicator"]

# set general parameters
iMeta$goalpost_scale <- 1
iMeta$goalpost_trunc2posts <- TRUE

# set goalposts for each indicator
for(iCode in iCodes){
  maxx <- max(ASEM_iData[[iCode]], na.rm = TRUE)
  minx <- min(ASEM_iData[[iCode]], na.rm = TRUE)
  rx <- maxx - minx
  # fake goalposts in 5% of range
  iMeta$goalpost_lower[iMeta$iCode == iCode] <- minx + 0.05*rx
  iMeta$goalpost_upper[iMeta$iCode == iCode] <- maxx - 0.05*rx
}

# build coin
coin <- new_coin(ASEM_iData, iMeta, quietly = TRUE)

# normalise using minmax
coin <- Normalise(coin, dset = "Raw", 
                  global_specs = list(f_n = "n_goalposts", f_n_para = "use_iMeta"))

## -----------------------------------------------------------------------------
plot_scatter(coin, dsets = c("Raw", "Normalised"), iCodes = "Cov4G")

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

## -----------------------------------------------------------------------------
# example data
set.seed(69)
x <- runif(20)

library(ggplot2)
# generic plot function to use in the other examples
nplot <- function(x, y, plot_title = NULL){
  ggplot(data = NULL, aes(x = x, y = y)) +
    geom_point() +
    xlab("x") +
    ylab("x (normalised)") +
    ggtitle(plot_title)
}

# rescale onto [50, 100] interval
xdash <- n_minmax(x, l_u = c(50, 100))
nplot(x, xdash, "Min-max onto [50, 100]")

## -----------------------------------------------------------------------------
nplot(x, n_zscore(x, c(10, 2)))

## -----------------------------------------------------------------------------
nplot(x, n_scaled(x, c(1,10)), "Linear scaling using c(1,10)")

## -----------------------------------------------------------------------------
nplot(x, n_dist2max(x), "Distance to maximum")

## -----------------------------------------------------------------------------
nplot(x, n_fracmax(x), "Fraction of max value")

## -----------------------------------------------------------------------------
nplot(x, n_rank(x), "Rank")

## -----------------------------------------------------------------------------
# normalise
xdash <- n_borda(x)
nplot(x, xdash, "Borda")

## -----------------------------------------------------------------------------
nplot(x, n_prank(x), "Percentile ranks")

## -----------------------------------------------------------------------------
xdash <- n_dist2ref(x, iref = 3, cap_max = FALSE)
nplot(x, xdash, "Distance to reference (no cap)")

## -----------------------------------------------------------------------------
xdash <- n_dist2ref(x, iref = 3, cap_max = TRUE)
nplot(x, xdash, "Distance to reference (no cap)")

## -----------------------------------------------------------------------------
xdash <- n_dist2targ(x, targ = 0.75, direction = 1, cap_max = TRUE)
nplot(x, xdash, "Distance to 0.75 target (positive direction: with cap)")

## -----------------------------------------------------------------------------
xdash <- n_dist2targ(x, targ = 0.2, direction = -1, cap_max = TRUE)
nplot(x, xdash, "Distance to 0.2 target (negative direction: with cap)")

## -----------------------------------------------------------------------------
xdash <- n_goalposts(x, gposts = c(0.2, 0.75, 1), direction = 1)
nplot(x, xdash, "Goalposts with positive indicator")

## -----------------------------------------------------------------------------
xdash <- n_goalposts(x, gposts = c(0.2, 0.75, 1), direction = -1)
nplot(x, xdash, "Goalposts with negative indicator")

