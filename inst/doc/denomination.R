## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library(COINr)

# Get a sample of indicator data (note must be indicators plus a "UnitCode" column)
iData <- ASEM_iData[c("uCode", "Goods", "Flights", "LPI")]
head(iData)

## -----------------------------------------------------------------------------
head(WorldDenoms)

## -----------------------------------------------------------------------------
# specify how to denominate
denomby <- data.frame(iCode = c("Goods", "Flights"),
                      Denominator = c("GDP", "Population"),
                      ScaleFactor = c(1, 1000))

## -----------------------------------------------------------------------------
# Denominate one by the other
iData_den <- Denominate(iData, WorldDenoms, denomby)

head(iData_den)

## -----------------------------------------------------------------------------
# first few rows of the example iMeta, selected cols
head(ASEM_iMeta[c("iCode", "Denominator")])

## -----------------------------------------------------------------------------
# see names of example iData
names(ASEM_iData)

## -----------------------------------------------------------------------------
# build example coin
coin <- build_example_coin(up_to = "new_coin", quietly = TRUE)

# denominate (here, we only need to say which dset to use)
coin <- Denominate(coin, dset = "Raw")

## -----------------------------------------------------------------------------
plot_scatter(coin, dsets = c("Raw", "Denominated"), iCodes = "Flights")

## -----------------------------------------------------------------------------
# build example purse
purse <- build_example_purse(up_to = "new_coin", quietly = TRUE)

# denominate using data/specs already included in coin
purse <- Denominate(purse, dset = "Raw")

