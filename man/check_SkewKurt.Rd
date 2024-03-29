% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/treat.R
\name{check_SkewKurt}
\alias{check_SkewKurt}
\title{Check skew and kurtosis of a vector}
\usage{
check_SkewKurt(x, na.rm = FALSE, skew_thresh = 2, kurt_thresh = 3.5)
}
\arguments{
\item{x}{A numeric vector.}

\item{na.rm}{Set \code{TRUE} to remove \code{NA} values, otherwise returns \code{NA}.}

\item{skew_thresh}{A threshold for absolute skewness (positive). Default 2.25.}

\item{kurt_thresh}{A threshold for kurtosis. Default 3.5.}
}
\value{
A list with \code{.$Pass} is a Logical, where \code{TRUE} is pass, \code{FALSE} is fail, and \code{.$Details} is a
sub-list with skew and kurtosis values.
}
\description{
Logical test: if \code{abs(skewness) < skew_thresh} OR \code{kurtosis < kurt_thresh}, returns \code{TRUE}, else \code{FALSE}
}
\examples{
set.seed(100)
x <- runif(20)
# this passes
check_SkewKurt(x)
# if we add an outlier, doesn't pass
check_SkewKurt(c(x, 1000))

}
