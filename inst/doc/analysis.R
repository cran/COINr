## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
# load COINr
library(COINr)

# build example coin
coin <-  build_example_coin(up_to = "new_coin", quietly = TRUE)

# get table of indicator statistics for raw data set
stat_table <- get_stats(coin, dset = "Raw", out2 = "df")

## -----------------------------------------------------------------------------
head(stat_table[1:5], 5)

## -----------------------------------------------------------------------------
head(stat_table[6:10], 5)

## -----------------------------------------------------------------------------
head(stat_table[11:15], 5)

## -----------------------------------------------------------------------------
head(stat_table[16:ncol(stat_table)], 5)

## -----------------------------------------------------------------------------
l_dat <- get_data_avail(coin, dset = "Raw", out2 = "list")

str(l_dat, max.level = 1)

## -----------------------------------------------------------------------------
head(l_dat$Summary, 5)

## -----------------------------------------------------------------------------
head(l_dat$ByGroup[1:5], 5)

## -----------------------------------------------------------------------------
coin <- build_example_coin(quietly = TRUE)

## -----------------------------------------------------------------------------
# get correlations
cmat <- get_corr(coin, dset = "Raw", iCodes = list("Environ"), Levels = 1)
# examine first few rows
head(cmat)

## -----------------------------------------------------------------------------
# get correlations
cmat <- get_corr(coin, dset = "Raw", iCodes = list("Environ"), Levels = 1, make_long = FALSE)
# examine first few rows
round_df(head(cmat), 2)

## -----------------------------------------------------------------------------
get_corr_flags(coin, dset = "Normalised", cor_thresh = 0.75,
               thresh_type = "high", grouplev = 2)

## -----------------------------------------------------------------------------
get_corr_flags(coin, dset = "Normalised", cor_thresh = -0.5,
               thresh_type = "low", grouplev = 2)

## -----------------------------------------------------------------------------
get_denom_corr(coin, dset = "Raw", cor_thresh = 0.7)

## -----------------------------------------------------------------------------
get_cronbach(coin, dset = "Raw", iCodes = "P2P", Level = 1)

## -----------------------------------------------------------------------------
l_pca <- get_PCA(coin, dset = "Raw", iCodes = "Sust", out2 = "list")

## -----------------------------------------------------------------------------
str(l_pca, max.level = 1)

## -----------------------------------------------------------------------------
str(l_pca$PCAresults, max.level = 2)

## -----------------------------------------------------------------------------
# summarise PCA results for "Social" group
summary(l_pca$PCAresults$Social$PCAres)

