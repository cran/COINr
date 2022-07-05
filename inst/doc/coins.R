## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(COINr)

## -----------------------------------------------------------------------------
head(ASEM_iData[1:20], 5)

## -----------------------------------------------------------------------------
check_iData(ASEM_iData)

## -----------------------------------------------------------------------------
head(ASEM_iMeta, 5)

## -----------------------------------------------------------------------------
ASEM_iMeta[ASEM_iMeta$Type == "Aggregate", ]

## -----------------------------------------------------------------------------
ASEM_iMeta[ASEM_iMeta$Type == "Group", ]

## -----------------------------------------------------------------------------
ASEM_iMeta[ASEM_iMeta$Type == "Denominator", ]

## -----------------------------------------------------------------------------
check_iMeta(ASEM_iMeta)

## -----------------------------------------------------------------------------
# build a new coin using example data
coin <- new_coin(iData = ASEM_iData,
                 iMeta = ASEM_iMeta,
                 level_names = c("Indicator", "Pillar", "Sub-index", "Index"))

## -----------------------------------------------------------------------------
coin

## -----------------------------------------------------------------------------
# first few cols and rows of Raw data set
data_raw <- get_dset(coin, "Raw")
head(data_raw[1:5], 5)

## -----------------------------------------------------------------------------
get_dset(coin, "Raw", also_get = c("uName", "Pop_group"))[1:5] |>
  head(5)

## -----------------------------------------------------------------------------
# exclude two indicators
coin <- new_coin(iData = ASEM_iData,
                 iMeta = ASEM_iMeta,
                 level_names = c("Indicator", "Pillar", "Sub-index", "Index"),
                 exclude = c("LPI", "Flights"))

coin

## -----------------------------------------------------------------------------
ASEM <- build_example_coin(quietly = TRUE)

ASEM

## -----------------------------------------------------------------------------
# sample of 2018 observations
ASEM_iData_p[ASEM_iData_p$Time == 2018, 1:15] |>
  head(5)

# sample of 2019 observations
ASEM_iData_p[ASEM_iData_p$Time == 2019, 1:15] |>
  head(5)

## -----------------------------------------------------------------------------
# build purse from panel data
purse <- new_coin(iData = ASEM_iData_p,
                  iMeta = ASEM_iMeta,
                  split_to = "all",
                  quietly = TRUE)

## -----------------------------------------------------------------------------
purse

## -----------------------------------------------------------------------------
ASEM_purse <- build_example_purse(quietly = TRUE)

ASEM_purse

