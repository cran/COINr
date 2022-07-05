## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ---- message=F, fig.width=5, fig.height=5------------------------------------
library(COINr)

# assemble example COIN
coin <- build_example_coin(up_to = "new_coin")

# plot framework
plot_framework(coin)

## ---- fig.width=6, fig.height= 5----------------------------------------------
plot_framework(coin, type = "stack", colour_level = 2)

## -----------------------------------------------------------------------------
plot_dist(coin, dset = "Raw", iCodes = "CO2")

## ---- message=F, fig.width=7--------------------------------------------------
plot_dist(coin, dset = "Raw", iCodes = "P2P", Level = 1, type = "Violindot")

## -----------------------------------------------------------------------------
coin <- build_example_coin(quietly = TRUE)

## ---- fig.width=5-------------------------------------------------------------
plot_corr(coin, dset = "Normalised", iCodes = list("Physical"), Levels = 1)

## ---- fig.width=4-------------------------------------------------------------
plot_corr(coin, dset = "Aggregated",
          iCodes = list(c("Flights", "LPI"), c("Physical", "P2P")), Levels = c(1,2))

## ---- fig.width=4, fig.height=4-----------------------------------------------
plot_corr(coin, dset = "Aggregated", iCodes = list("Sust"), withparent = "family", flagcolours = T)

## ---- fig.width=7, fig.height=5-----------------------------------------------
plot_corr(coin, dset = "Normalised", iCodes = list("Sust"),
          grouplev = 2, flagcolours = T)

## ---- fig.width=7, fig.height=6-----------------------------------------------
plot_corr(coin, dset = "Normalised", grouplev = 3, box_level = 2, showvals = F)

## ---- fig.width=7-------------------------------------------------------------
plot_bar(coin, dset = "Raw", iCode = "CO2")

## ---- fig.width=7-------------------------------------------------------------
plot_bar(coin, dset = "Raw", iCode = "CO2", by_group = "GDPpc_group", axes_label = "iName")

## ---- fig.width=7-------------------------------------------------------------
plot_bar(coin, dset = "Aggregated", iCode = "Sust", stack_children = TRUE)

## ---- fig.height=2, fig.width=4-----------------------------------------------
plot_dot(coin, dset = "Raw", iCode = "LPI", usel = c("JPN", "ESP"))

## ---- fig.height=2, fig.width=4-----------------------------------------------
plot_dot(coin, dset = "Raw", iCode = "LPI", usel = c("JPN", "ESP"), add_stat = "median",
         stat_label = "Median", plabel = "iName+unit")

## ---- fig.width=4-------------------------------------------------------------
plot_scatter(coin, dsets = "Raw", iCodes = c("Goods", "Services"), point_label = "uCode")

## ---- fig.width=5-------------------------------------------------------------
plot_scatter(coin, dsets = c("uMeta", "Raw"), iCodes = c("Population", "Flights"),
             by_group = "GDPpc_group", log_scale = c(TRUE, FALSE))

