% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/aggregate.R
\name{Aggregate.data.frame}
\alias{Aggregate.data.frame}
\title{Aggregate data frame}
\usage{
\method{Aggregate}{data.frame}(
  x,
  f_ag = NULL,
  f_ag_para = NULL,
  dat_thresh = NULL,
  by_df = FALSE,
  ...
)
}
\arguments{
\item{x}{Data frame to be aggregated}

\item{f_ag}{The name of an aggregation function, as a string.}

\item{f_ag_para}{Any additional parameters to pass to \code{f_ag}, as a named list.}

\item{dat_thresh}{An optional data availability threshold, specified as a number between 0 and 1. If a row
of \code{x} has data availability lower than this threshold, the aggregated value for that row will be
\code{NA}. Data availability, for a row \code{x_row} is defined as \code{sum(!is.na(x_row))/length(x_row)}, i.e. the
fraction of non-\code{NA} values.}

\item{by_df}{Controls whether to send a numeric vector to \code{f_ag} (if \code{FALSE}, default) or a data frame (if \code{TRUE}) - see
details.}

\item{...}{arguments passed to or from other methods.}
}
\value{
A numeric vector
}
\description{
Aggregates a data frame into a single column using a specified function. Note that COINr has a number of aggregation functions built in,
all of which are of the form \verb{a_*()}, e.g. \code{\link[=a_amean]{a_amean()}}, \code{\link[=a_gmean]{a_gmean()}} and friends.
}
\details{
Aggregation is performed row-wise using the function \code{f_ag}, such that for each row \code{x_row}, the output is
\code{f_ag(x_row, f_ag_para)}, and for the whole data frame, it outputs a numeric vector. The data frame \code{x} must
only contain numeric columns.

The function \code{f_ag} must be supplied as a string, e.g. \code{"a_amean"}, and it must take as a minimum an input
\code{x} which is either a numeric vector (if \code{by_df = FALSE}), or a data frame (if \code{by_df = TRUE}). In the former
case \code{f_ag} should return a single numeric value (i.e. the result of aggregating \code{x}), or in the latter case
a numeric vector (the result of aggregating the whole data frame in one go).

\code{f_ag} can optionally have other parameters, e.g. weights, specified as a list in \code{f_ag_para}.

Note that COINr has a number of aggregation functions built in,
all of which are of the form \verb{a_*()}, e.g. \code{\link[=a_amean]{a_amean()}}, \code{\link[=a_gmean]{a_gmean()}} and friends. To see a list browse COINr functions alphabetically or
type \code{a_} in the R Studio console and press the tab key (after loading COINr), or see the \href{https://bluefoxr.github.io/COINr/articles/aggregate.html#coinr-aggregation-functions}{online documentation}.

Optionally, a data availability threshold can be assigned below which the aggregated value will return
\code{NA} (see \code{dat_thresh} argument). If \code{by_df = TRUE}, this will however be ignored because aggregation is not
done on individual rows. Note that more complex constraints could be built into \code{f_ag} if needed.
}
\examples{
# get some indicator data - take a few columns from built in data set
X <- ASEM_iData[12:15]

# normalise to avoid zeros - min max between 1 and 100
X <- Normalise(X,
               global_specs = list(f_n = "n_minmax",
                                    f_n_para = list(l_u = c(1,100))))

# aggregate using harmonic mean, with some weights
y <- Aggregate(X, f_ag = "a_hmean", f_ag_para = list(w = c(1, 1, 2, 1)))

}
