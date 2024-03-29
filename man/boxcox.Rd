% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/treat.R
\name{boxcox}
\alias{boxcox}
\title{Box Cox transformation}
\usage{
boxcox(x, lambda, makepos = TRUE, na.rm = FALSE)
}
\arguments{
\item{x}{A vector or column of data to transform}

\item{lambda}{The lambda parameter of the Box Cox transform}

\item{makepos}{If \code{TRUE} (default) makes all values positive by subtracting the minimum and adding 1.}

\item{na.rm}{If \code{TRUE}, \code{NA}s will be removed: only relevant if \code{makepos = TRUE} which invokes \code{min()}.}
}
\value{
A vector of length \code{length(x)} with transformed values.
}
\description{
Simple Box Cox, with no optimisation of lambda.
}
\details{
This function replaces the now-defunct \code{BoxCox()} from COINr < v1.0.
}
\examples{
# example data
x <- runif(30)
# Apply Box Cox
xBox <- boxcox(x, lambda = 2)
# plot one against the other
plot(x, xBox)

}
