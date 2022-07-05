## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----InstallCOINrC, eval=FALSE------------------------------------------------
#  install.packages("COINr")

## ----InstallCOINr, eval=FALSE-------------------------------------------------
#  remotes::install_github("bluefoxr/COINr")

## ----setup--------------------------------------------------------------------
library(COINr)

## ---- eval=F------------------------------------------------------------------
#  coin <- COINr_function(coin, function_arguments)

## -----------------------------------------------------------------------------
ASEM <- new_coin(ASEM_iData, ASEM_iMeta, level_names = c("Indicator", "Pillar", "Sub-index", "Index"))

## -----------------------------------------------------------------------------
ASEM

## ---- fig.width=5, fig.height=5-----------------------------------------------
plot_framework(ASEM)

## -----------------------------------------------------------------------------
ASEM <- Denominate(ASEM, dset = "Raw")

## -----------------------------------------------------------------------------
ASEM <- Screen(ASEM, dset = "Denominated", dat_thresh = 0.9, unit_screen = "byNA")

## -----------------------------------------------------------------------------
ASEM

## -----------------------------------------------------------------------------
ASEM <- Impute(ASEM, dset = "Screened", f_i = "i_mean_grp", use_group = "EurAsia_group")

## -----------------------------------------------------------------------------
ASEM <- Treat(ASEM, dset = "Screened")

## -----------------------------------------------------------------------------
ASEM <- Normalise(ASEM, dset = "Treated")

## -----------------------------------------------------------------------------
ASEM <- Aggregate(ASEM, dset = "Normalised", f_ag = "a_amean")

## -----------------------------------------------------------------------------
# get results table
df_results <- get_results(ASEM, dset = "Aggregated", tab_type = "Aggs")

head(df_results)

## ---- fig.width=7-------------------------------------------------------------
plot_bar(ASEM, dset = "Aggregated", iCode = "Index", stack_children = TRUE)

## ---- eval=FALSE--------------------------------------------------------------
#  # export coin to Excel
#  export_to_excel(coin, fname = "example_coin_results.xlsx")

