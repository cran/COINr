## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library(COINr)

ASEM <- build_example_coin(up_to = "new_coin", quietly = TRUE)

## -----------------------------------------------------------------------------
l_avail <- get_data_avail(ASEM, dset = "Raw", out2 = "list")

## -----------------------------------------------------------------------------
head(l_avail$Summary)

## -----------------------------------------------------------------------------
min(l_avail$Summary$Dat_Avail)

## -----------------------------------------------------------------------------
df_avail <- get_stats(ASEM, dset = "Raw", out2 = "df")

head(df_avail[c("iCode", "N.Avail", "Frc.Avail")], 10)

## -----------------------------------------------------------------------------
min(df_avail$Frc.Avail)

## -----------------------------------------------------------------------------
# some data to use as an example
# this is a selected portion of the data with some missing values
df1 <-  ASEM_iData[37:46, 36:39]
print(df1, row.names = FALSE)

## -----------------------------------------------------------------------------
Impute(df1, f_i = "i_mean")

## -----------------------------------------------------------------------------
# demo of i_mean() function, which is built in to COINr
x <- c(1,2,3,4, NA)
i_mean(x)

## -----------------------------------------------------------------------------
# row grouping
groups <- c(rep("a", 5), rep("b", 5))

# impute
dfi2 <- Impute(df1, f_i = "i_median_grp", f_i_para = list(f = groups))

# display
print(dfi2, row.names = FALSE)

## -----------------------------------------------------------------------------
Impute(df1, f_i = "i_mean", impute_by = "row", normalise_first = FALSE)

## -----------------------------------------------------------------------------
Impute(df1, f_i = "i_mean", impute_by = "row", normalise_first = TRUE, directions = rep(1,4))

## -----------------------------------------------------------------------------
ASEM <- Impute(ASEM, dset = "Raw", f_i = "i_mean")

ASEM

## -----------------------------------------------------------------------------
ASEM <- Impute(ASEM, dset = "Raw", f_i = "i_mean_grp", use_group = "GDP_group", )

## -----------------------------------------------------------------------------
ASEM <- Impute(ASEM, dset = "Raw", f_i = "i_mean", impute_by = "row",
               group_level = 2, normalise_first = TRUE)

## -----------------------------------------------------------------------------
# copy
dfp <- ASEM_iData_p

# create NA for GB in 2022
dfp$LPI[dfp$uCode == "GB" & dfp$Time == 2022] <- NA

## -----------------------------------------------------------------------------
dfp$LPI[dfp$uCode == "GB" & dfp$Time == 2021]

## -----------------------------------------------------------------------------
# build purse
ASEMp <- new_coin(dfp, ASEM_iMeta, split_to = "all", quietly = TRUE)

# impute raw data using latest available value
ASEMp <- Impute(ASEMp, dset = "Raw", f_i = "impute_panel")

## -----------------------------------------------------------------------------
get_data(ASEMp, dset = "Imputed", iCodes = "LPI", uCodes = "GBR", Time = 2021)

