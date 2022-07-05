## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library(COINr)

# build full example coin
coin <- build_example_coin(quietly = TRUE)

# get results table
df_results <- get_results(coin, dset = "Aggregated", tab_type = "Aggs")

head(df_results)

## -----------------------------------------------------------------------------
# get results table
df_results <- get_results(coin, dset = "Aggregated", tab_type = "Aggs", use_group = "GDPpc_group", use = "groupranks")

# see first few entries in "XL" group
head(df_results[df_results$GDPpc_group == "XL", ])

## -----------------------------------------------------------------------------
# see first few entries in "L" group
head(df_results[df_results$GDPpc_group == "L", ])

## -----------------------------------------------------------------------------
get_unit_summary(coin, usel = "IND", Levels = c(4,3,2), dset = "Aggregated")

## -----------------------------------------------------------------------------
get_str_weak(coin, dset = "Raw", usel = "ESP")

