% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/trends.R
\name{get_trends}
\alias{get_trends}
\title{Get time trends}
\usage{
get_trends(
  purse,
  dset,
  uCodes = NULL,
  iCodes = NULL,
  Time = NULL,
  use_latest = NULL,
  f_trend = "CAGR",
  interp_at = NULL,
  adjust_directions = FALSE
)
}
\arguments{
\item{purse}{A purse object}

\item{dset}{Name of the data set to extract, passed to \code{\link[=get_data.purse]{get_data.purse()}}}

\item{uCodes}{Optional subset of unit codes to extract, passed to \code{\link[=get_data.purse]{get_data.purse()}}}

\item{iCodes}{Optional subset of indicator/aggregate codes to extract, passed to \code{\link[=get_data.purse]{get_data.purse()}}}

\item{Time}{Optional vector of time points to extract, passed to \code{\link[=get_data.purse]{get_data.purse()}}}

\item{use_latest}{A positive integer which specifies to use only the latest "n" data points. If this is specified, it
overrides \code{Time}. If e.g. \code{use_latest = 5}, will use the latest five observations, working backwards from the latest
non-\code{NA} point.}

\item{f_trend}{Function that returns a metric describing the trend of the time series. See details.}

\item{interp_at}{Option to linearly interpolate missing data points in each time series. Must be specified as a vector
of time values where to apply interpolation. If \code{interp_at = "all"}, will attempt to interpolate at every
time point. Uses linear interpolation - note that any \code{NA}s outside of the range of observed values will not
be estimated, i.e. this does not \emph{extrapolate} beyond the range of data. See \code{\link[=approx_df]{approx_df()}}.}

\item{adjust_directions}{Logical: if \code{TRUE}, trend metrics are adjusted according to indicator/aggregate
directions input in \code{iMeta} (i.e. if the corresponding direction is -1, the metric will be multiplied by -1).}
}
\value{
A data frame in long format, with trend metrics for each indicator/unit pair, plus
data availability statistics.
}
\description{
Get time trends from a purse object. This function extracts a panel data set from a purse, and calculates trends
for each indicator/unit pair using a specified function \code{f_trend}. For example, if \code{f_trend = "CAGR"}, this extracts
the time series for each indicator/unit pair and passes it to \code{\link[=CAGR]{CAGR()}}.
}
\details{
This function requires a purse object as an input. The data set is selected using \code{\link[=get_data]{get_data()}}, such that a subset
of the data set can be analysed using the \code{uCodes}, \code{iCodes} and \code{Time} arguments. The latter is useful especially
if only a subset of the time series should be analysed.

The function \code{f_trend} is a function that, given a time series, returns a trend metric. This must follow a
specific format. It must of course be available to call, and \emph{must} have arguments \code{y} and \code{x}, which are
respectively a vector of values and a vector indexing the values in time. See \code{\link[=prc_change]{prc_change()}} and \code{\link[=CAGR]{CAGR()}}
for examples. The function \emph{must} return a single value (not a vector with multiple entries, or a list).
The function can return either numeric or character values.
}
\examples{
#

}
