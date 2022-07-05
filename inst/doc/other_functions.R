## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library(COINr)

# build example coin
coin <- build_example_coin(quietly = TRUE)

## ---- eval=FALSE--------------------------------------------------------------
#  # export coin to Excel
#  export_to_excel(coin, fname = "example_coin_results.xlsx")

## ---- eval=FALSE--------------------------------------------------------------
#  # make sure file is in working directory!
#  coin_import <- import_coin_tool("COIN_Tool_v1_LITE_exampledata.xlsm",
#                                  makecodes = TRUE, out2 = "coin")

## ---- eval=FALSE--------------------------------------------------------------
#  coin <- COIN_to_coin(COIN)

## -----------------------------------------------------------------------------
X <- ASEM_iData[1:5,c(2,10:12)]
X

## -----------------------------------------------------------------------------
rank_df(X)

## -----------------------------------------------------------------------------
replace_df(X, data.frame(old = c("AUT", "BEL"), new = c("test1", "test2")))

## -----------------------------------------------------------------------------
round_df(X, 1)

## -----------------------------------------------------------------------------
signif_df(X, 3)

## -----------------------------------------------------------------------------
# copy
X1 <- X

# change three values
X1$GDP[3] <- 101
X1$Population[1] <- 10000
X1$Population[2] <- 70000

# reorder
X1 <- X1[order(X1$uCode), ]

# now compare
compare_df(X, X1, matchcol = "uCode")

