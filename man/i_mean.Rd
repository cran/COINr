% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/impute.R
\name{i_mean}
\alias{i_mean}
\title{Impute by mean}
\usage{
i_mean(x)
}
\arguments{
\item{x}{A numeric vector}
}
\value{
A numeric vector
}
\description{
Replaces \code{NA}s in a numeric vector with the mean of the non-\code{NA} values.
}
\examples{
x <- c(1,2,3,4, NA)
i_mean(x)

}
