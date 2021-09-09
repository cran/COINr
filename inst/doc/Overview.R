## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, fig.align = "center")

## ----ASEMstruct, echo=F, fig.align = 'center', out.width = "100%", fig.cap = "Aggregation structure of the ASEM indexes. Underlying each pillar is a set of indicators."----
knitr::include_graphics("images/ASEM_structure-min.png")

## ---- message=F, warning=F----------------------------------------------------
library(COINr)
ASEM <- COINr::build_ASEM()
print(class(ASEM))

## ----COINdiag, echo=F, fig.align = 'center', out.width = "100%", fig.cap = "Inside a COIN"----
knitr::include_graphics("images/COIN_contents_tree-min.png")

## ---- eval=F------------------------------------------------------------------
#  COIN <- COINr_function(COIN, function_options)

## -----------------------------------------------------------------------------
library(COINr)
head(COINr::ASEMIndData[1:8])
head(COINr::ASEMIndData[9:16])

## -----------------------------------------------------------------------------
head(COINr::ASEMIndMeta)

## -----------------------------------------------------------------------------
head(COINr::ASEMAggMeta)

## ---- collapse=T--------------------------------------------------------------
ASEM <- COINr::assemble(IndData = ASEMIndData, IndMeta = ASEMIndMeta,
                 AggMeta = ASEMAggMeta)

## ----plotfwk, eval=FALSE------------------------------------------------------
#  COINr::plotframework(ASEM)

## ----plotfwk2, echo=F, fig.align = 'center', out.width = "50%", fig.cap = "Framework plot of the ASEM index."----
knitr::include_graphics("images/plotframework-min.png")

## ----indDash, echo=F, fig.align = 'center', out.width = "100%", fig.cap = "indDash screenshot"----
knitr::include_graphics("images/inddash_screenshot-min.png")

## ---- collapse=T, message=F---------------------------------------------------
# get stats
ASEM <- COINr::getStats(ASEM, dset = "Raw", out2 = "COIN")

# display stats table, first few columns/rows only
stat_tab <- ASEM$Analysis$Raw$StatTable[1:8]
roundDF(head(stat_tab, 5))

## -----------------------------------------------------------------------------
# create denominated data set
ASEM <- COINr::denominate(ASEM, dset = "Raw", specby = "metadata")

## -----------------------------------------------------------------------------
names(ASEM$Data)

## -----------------------------------------------------------------------------
ASEM$Method$denominate

## -----------------------------------------------------------------------------
ASEM <- COINr::impute(ASEM, dset = "Denominated", imtype = "indgroup_mean",
               groupvar = "Group_GDP")

## -----------------------------------------------------------------------------
ASEM <- COINr::treat(ASEM, dset = "Imputed", winmax = 5)

## ---- message=FALSE, warning=FALSE--------------------------------------------
library(dplyr)

ASEM$Analysis$Treated$TreatSummary %>%
  filter(Treatment != "None")

## ---- eval=F------------------------------------------------------------------
#  COINr::iplotIndDist2(ASEM, dsets = c("Imputed", "Treated"),
#                icodes = "Services", ptype = "Scatter")

## ----treatedscatter, echo=F, fig.align = 'center', out.width = "80%", fig.cap = "Treated vs. raw data for Services indicator."----
knitr::include_graphics("images/treated_scatter-min.png")

## -----------------------------------------------------------------------------
ASEM <- COINr::normalise(ASEM, dset = "Treated", ntype = "minmax",
                  npara = list(minmax = c(0,100)))

## -----------------------------------------------------------------------------
ASEM <- COINr::aggregate(ASEM, agtype = "arith_mean", dset = "Normalised")

## -----------------------------------------------------------------------------
str(ASEM$Data, max.level = 1, give.attr = F)

## ----resultsApp, eval=F-------------------------------------------------------
#  COINr::resultsDash(ASEM)

## ----ResultsDash, echo=F, fig.align = 'center', out.width = "100%", fig.cap = "resultsDash screenshot"----
knitr::include_graphics("images/resultsDash_screenshot-min.png")

## ---- eval=F------------------------------------------------------------------
#  COINr::iplotBar(ASEM, dset = "Aggregated", isel = "Index",
#           aglev = 4, stack_children = T)

## ----stackedbar, echo=F, fig.align = 'center', out.width = "80%", fig.cap = "Sorted index ranks divided into sub-indexes."----
knitr::include_graphics("images/stacked_bar-min.png")

## ---- eval=F------------------------------------------------------------------
#  plt <- COINr::iplotIndDist2(ASEM, dsets = "Aggregated",
#                       icodes = c("Conn", "Sust"), aglevs = 3)
#  plotly::layout(plt, xaxis = list(title = "Connectivity"),
#                    yaxis = list(title = "Sustainability"))

## ----consusScat, echo=F, fig.align = 'center', out.width = "80%", fig.cap = "Connectivity and sustainability sub-indexes."----
knitr::include_graphics("images/conn_sus_scat-min.png")

## ---- eval=FALSE--------------------------------------------------------------
#  COINr::iplotMap(ASEM, dset = "Aggregated", isel = "Conn")

## ----choro, echo=F, fig.align = 'center', out.width = "100%", fig.cap = "Choropleth map of ASEM Connectivity."----
knitr::include_graphics("images/choropleth-min.png")

## -----------------------------------------------------------------------------
rslts <- COINr::getResults(ASEM, tab_type = "Summary")
head(rslts, 10)

## ---- eval=F------------------------------------------------------------------
#  # Export entire COIN to Excel
#  COINr::coin2Excel(ASEM, "ASEM_results.xlsx")

## -----------------------------------------------------------------------------
ASEM <- checkData(ASEM, dset = "Raw")

# view missing data by group (last few rows/cols)
missdat <- ASEM$Analysis$Raw$MissDatByGroup[1:8]
roundDF(tail(missdat, 10))

## ----PolDists, message=F, warning=F, fig.width=7, fig.cap="Indicator distributions in the Political pillar."----
COINr::plotIndDist(ASEM, dset = "Raw", icodes = "Political",
                   type = "Violindot")

## ----ConnDists, message=F, warning=F, fig.width=7, fig.cap="Pillar distributions in the connectivity sub-index."----
COINr::plotIndDist(ASEM, dset = "Aggregated", icodes = "Conn",
                    aglev = 2, type = "Histogram")

## ----corr1, message=F, warning=F, fig.width=6, fig.height=5, fig.cap="Correlations within P2P pillar."----
COINr::plotCorr(ASEM, dset = "Raw", icodes = "P2P")

## ----corr2, message=F, warning=F, fig.width=4, fig.height=4, fig.cap="Grouped correlations within sub-indexes."----
COINr::plotCorr(ASEM, dset = "Aggregated", aglevs = c(2,3))

## ---- eval = F----------------------------------------------------------------
#  ASEM <- COINr::rew8r(ASEM)

## ----rew8r, echo=F, fig.align = 'center', out.width = "100%", fig.cap = "rew8r() screenshot"----
knitr::include_graphics("images/rew8r_screenshot-min.png")

## -----------------------------------------------------------------------------
PCAres <- COINr::getPCA(ASEM, dset = "Aggregated",
                        aglev = 2, out2 = "list")

## -----------------------------------------------------------------------------
str(PCAres, max.level = 2)

## -----------------------------------------------------------------------------
COINr::getCronbach(ASEM, dset = "Raw", icodes = "Physical", aglev = 1)

## ----ASEMAltNorm--------------------------------------------------------------
# Make a copy
ASEMAltNorm <- ASEM

# Edit .$Method
ASEMAltNorm$Method$normalise$ntype <- "borda"

# Regenerate
ASEMAltNorm <- COINr::regen(ASEMAltNorm, quietly = TRUE)

## -----------------------------------------------------------------------------
comptab <- COINr::compTable(ASEM, ASEMAltNorm, dset = "Aggregated",
                 isel = "Index")
head(comptab, 10)

## ----SAspecs, eval=F----------------------------------------------------------
#  # define noise to be applied to weights
#  nspecs <- data.frame(AgLevel = c(2,3), NoiseFactor = c(0.25,0.25))
#  
#  # create list specifying assumptions to vary and alternatives
#  SAspecs <- list(
#    impute = list(imtype = c("indgroup_mean", "ind_mean", "none")),
#    normalise = list(ntype = c("minmax", "rank", "dist2max")),
#    weights = list(NoiseSpecs = nspecs, Nominal = "Original")
#  )

## ---- eval=F------------------------------------------------------------------
#  function_name = list(argument_name = vector_or_list_of_alternatives)

## ----SAspecsAggweights, eval=F------------------------------------------------
#  # example entry in SA_specs list of sensitivity() [not used here]
#  aggregate = list(agweights = c("Weights1", "Weights2", "Weights3"))

## ----runSA, eval = F----------------------------------------------------------
#  # This will take a few minutes to run
#  SAresults <- sensitivity(ASEM, v_targ = "Index",
#                           SA_specs = SAspecs,
#                           N = 500,
#                           SA_type = "SA", Nboot = 1000)

## ---- echo=F, message=F-------------------------------------------------------
SAresults <- readRDS("SAresults_ASEMexample.rds")

## ----plotUAranks, message=F, warning=F, fig.width=7, fig.height=4, fig.cap="Confidence intervals on index ranks."----
COINr::plotSARanks(SAresults)

## ----plotSAbar, message=F, warning=F, fig.width=4, fig.height=3, fig.cap="Sensitivity indices of uncertain assumptions."----
# plot bar chart
COINr::plotSA(SAresults, ptype = "bar")

## ----plotSApie, fig.width=4, fig.height=3-------------------------------------
# plot bar chart
COINr::plotSA(SAresults, ptype = "pie") +
  ggplot2::theme(text = ggplot2::element_text(size = 10))
COINr::plotSA(SAresults, ptype = "box") +
  ggplot2::theme(text = ggplot2::element_text(size = 8))

## ---- eval=F------------------------------------------------------------------
#  system.file("UnitReport", "unit_report_source.Rmd", package = "COINr")

## ---- eval=F------------------------------------------------------------------
#  COINr::getUnitReport(ASEM, usel = "NZL", out_type = ".html")

## ---- eval=F------------------------------------------------------------------
#  install.packages("webshot")
#  webshot::install_phantomjs()

