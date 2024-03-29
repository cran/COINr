% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/trends.R
\name{CAGR}
\alias{CAGR}
\title{Compound annual growth rate}
\usage{
CAGR(y, x)
}
\arguments{
\item{y}{A numeric vector}

\item{x}{A numeric vector of the same length as \code{y}, indexing \code{y} in time. No \code{NA} values are allowed
in \code{x}. This vector is assumed to be years, otherwise the result must be interpreted differently.}
}
\value{
A scalar value (CAGR)
}
\description{
Given a variable \code{y} indexed by a time vector \code{x}, calculates the compound annual growth rate. Note that CAGR assumes
that the \code{x} refer to years. Also it is only calculated using the first and latest observed values.
}
\examples{
# random points over 10 years
x <- 2011:2020
y <- runif(10)

CAGR(y, x)

}
