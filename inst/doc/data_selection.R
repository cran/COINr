## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library(COINr)

# build full example coin
coin <- build_example_coin(quietly = TRUE)

# retrieve normalised data set
dset_norm <- get_dset(coin, dset = "Normalised")

# view first few rows and cols
head(dset_norm[1:5], 5)

## -----------------------------------------------------------------------------
# retrieve normalised data set
dset_norm2 <- get_dset(coin, dset = "Normalised", also_get = c("uName", "GDP_group"))

# view first few rows and cols
head(dset_norm2[1:5], 5)

## -----------------------------------------------------------------------------
x <- get_data(coin, dset = "Raw", iCodes = c("Flights", "LPI"))

# see first few rows
head(x, 5)

## -----------------------------------------------------------------------------
x <- get_data(coin, dset = "Raw", iCodes = "Political", Level = 1)
head(x, 5)

## -----------------------------------------------------------------------------
x <- get_data(coin, dset = "Aggregated", iCodes = "Sust", Level = 2)

head(x, 5)

## -----------------------------------------------------------------------------
get_data(coin, dset = "Raw", iCodes = "Goods", uCodes = c("AUT", "VNM"))

## -----------------------------------------------------------------------------
coin

## -----------------------------------------------------------------------------
get_data(coin, dset = "Raw", iCodes = "Goods", use_group = list(GDP_group = "XL"))

## -----------------------------------------------------------------------------
get_data(coin, dset = "Raw", iCodes = "Flights", uCodes = "MLT", use_group = "Pop_group")

## -----------------------------------------------------------------------------
names(coin$Data)

## -----------------------------------------------------------------------------
data_raw <- coin$Data$Raw

head(data_raw[1:5], 5)

## -----------------------------------------------------------------------------
str(coin$Meta$Unit)

