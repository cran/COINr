% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/correlations.R
\name{get_denom_corr}
\alias{get_denom_corr}
\title{Correlations between indicators and denominators}
\usage{
get_denom_corr(
  coin,
  dset,
  cor_thresh = 0.6,
  cortype = "pearson",
  nround = 2,
  use_directions = FALSE
)
}
\arguments{
\item{coin}{A coin class object.}

\item{dset}{The name of the data set to apply the function to, which should be accessible in \code{.$Data}.}

\item{cor_thresh}{A correlation threshold: the absolute value of any correlations between indicator-denominator pairs above this
threshold will be flagged.}

\item{cortype}{The type of correlation: to be passed to the \code{method} argument of \code{stats::cor}.}

\item{nround}{Optional number of decimal places to round correlation values to. Default 2, set \code{NULL} to
disable.}

\item{use_directions}{Logical: if \code{TRUE} the extracted data is adjusted using directions found inside the coin (i.e. the "Direction"
column input in \code{iMeta}. See comments on this argument in \code{\link[=get_corr]{get_corr()}}.}
}
\value{
A data frame of pairwise correlations that exceed the threshold.
}
\description{
Get a data frame containing any correlations between indicators and denominators that exceed a given
threshold. This can be useful when \emph{whether} to denominate an indicator and \emph{by what} may not be obvious.
If an indicator is strongly correlated with a denominator, this may suggest to denominate it by that
denominator.
}
\examples{
# build example coin
coin <- build_example_coin(up_to = "new_coin", quietly = TRUE)

# get correlations >0.7 of any indicator with denominators
get_denom_corr(coin, dset = "Raw", cor_thresh = 0.7)

}
