## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library(COINr)

# example data
iData <- ASEM_iData[40:51, c("uCode", "Research", "Pat", "CultServ", "CultGood")]

iData

## -----------------------------------------------------------------------------
l_scr <- Screen(iData, unit_screen = "byNA", dat_thresh = 0.75)

## -----------------------------------------------------------------------------
str(l_scr, max.level = 1)

## -----------------------------------------------------------------------------
l_scr$ScreenedData

## -----------------------------------------------------------------------------
head(l_scr$DataSummary)

## -----------------------------------------------------------------------------
# build example coin
coin <- build_example_coin(up_to = "new_coin", quietly = TRUE)

# screen units from raw dset
coin <- Screen(coin, dset = "Raw", unit_screen = "byNA", dat_thresh = 0.85, write_to = "Filtered_85pc")

# some details about the coin by calling its print method
coin

## -----------------------------------------------------------------------------
coin$Analysis$Filtered_85pc$RemovedUnits

## -----------------------------------------------------------------------------
# build example purse
purse <- build_example_purse(up_to = "new_coin", quietly = TRUE)

# screen units in all coins to 85% data availability
purse <- Screen(purse, dset = "Raw", unit_screen = "byNA",
                dat_thresh = 0.85, write_to = "Filtered_85pc")

