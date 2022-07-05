## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
# numbers between 1 and 10
x <- 1:10

# two outliers
x <- c(x, 30, 100)

## -----------------------------------------------------------------------------
library(COINr)

skew(x)

kurt(x)

## -----------------------------------------------------------------------------
check_SkewKurt(x)

## ---- fig.width=5, fig.height=3.5---------------------------------------------
l_treat <- Treat(x, f1 = "winsorise", f1_para = list(winmax = 2),
                 f_pass = "check_SkewKurt")

plot(x, l_treat$x)

## -----------------------------------------------------------------------------
check_SkewKurt(l_treat$x)

## -----------------------------------------------------------------------------
# select three indicators
df1 <- ASEM_iData[c("Flights", "Goods", "Services")]

# treat the data frame using defaults
l_treat <- Treat(df1)

str(l_treat, max.level = 1)

## -----------------------------------------------------------------------------
l_treat$Dets_Table

## -----------------------------------------------------------------------------
l_treat$Treated_Points

## -----------------------------------------------------------------------------
coin <- build_example_coin(up_to = "new_coin")

## -----------------------------------------------------------------------------
coin <- Treat(coin, dset = "Raw")

## -----------------------------------------------------------------------------
# summary of treatment for each indicator
head(coin$Analysis$Treated$Dets_Table)

## -----------------------------------------------------------------------------
# default treatment for all cols
specs_def <- list(f1 = "winsorise",
                  f1_para = list(na.rm = TRUE,
                                 winmax = 5,
                                 skew_thresh = 2,
                                 kurt_thresh = 3.5,
                                 force_win = FALSE),
                  f2 = "log_CT",
                  f2_para = list(na.rm = TRUE),
                  f_pass = "check_SkewKurt",
                  f_pass_para = list(na.rm = TRUE,
                                     skew_thresh = 2,
                                     kurt_thresh = 3.5))

## -----------------------------------------------------------------------------
# treat with max winsorisation of 3 points
coin <- Treat(coin, dset = "Raw", global_specs = list(f1_para = list(winmax = 1)))

# see what happened
coin$Analysis$Treated$Dets_Table |>
  head(10)

## -----------------------------------------------------------------------------
# change individual specs for Flights
indiv_specs <- list(
  Flights = list(
    f1_para = list(winmax = 0)
  )
)

# re-run data treatment
coin <- Treat(coin, dset = "Raw", indiv_specs = indiv_specs)

## -----------------------------------------------------------------------------
coin$Analysis$Treated$Dets_Table[
  coin$Analysis$Treated$Dets_Table$iCode == "Flights", 
]

## -----------------------------------------------------------------------------
# change individual specs for two indicators
indiv_specs <- list(
  Flights = "none",
  LPI = "none"
)

# re-run data treatment
coin <- Treat(coin, dset = "Raw", indiv_specs = indiv_specs)

## ---- include = FALSE---------------------------------------------------------
# check if performance package installed
perf_installed <- requireNamespace("performance", quietly = TRUE)

## ---- eval = perf_installed---------------------------------------------------
library(performance)

# the check_outliers function outputs a logical vector which flags specific points as outliers.
# We need to wrap this to give a single TRUE/FALSE output, where FALSE means it doesn't pass,
# i.e. there are outliers
outlier_pass <- function(x){
  # return FALSE if any outliers
  !any(check_outliers(x))
}

# now call treat(), passing this function
# we set f_pass_para to NULL to avoid passing default parameters to the new function
coin <- Treat(coin, dset = "Raw",
               global_specs = list(f_pass = "outlier_pass",
                                    f_pass_para = NULL)
)

# see what happened
coin$Analysis$Treated$Dets_Table |>
  head(10)

## -----------------------------------------------------------------------------
# build example purse
purse <- build_example_purse(up_to = "new_coin", quietly = TRUE)

# apply treatment to all coins in purse (default specs)
purse <- Treat(purse, dset = "Raw")

## -----------------------------------------------------------------------------
# select three indicators
df1 <- ASEM_iData[c("Flights", "Goods", "Services")]

# treat data frame, changing winmax and skew/kurtosis limits
l_treat <- qTreat(df1, winmax = 1, skew_thresh = 1.5, kurt_thresh = 3)

## -----------------------------------------------------------------------------
l_treat$Dets_Table

