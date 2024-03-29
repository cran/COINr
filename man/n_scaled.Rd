% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/normalise.R
\name{n_scaled}
\alias{n_scaled}
\title{Scale a vector}
\usage{
n_scaled(x, npara = c(0, 100))
}
\arguments{
\item{x}{A numeric vector}

\item{npara}{Parameters as a vector \code{c(l, u)}. See description.}
}
\value{
Scaled vector
}
\description{
Scales a vector for normalisation using the method applied in the GII2020 for some indicators. This
does \code{x_scaled <- (x-l)/(u-l) * 100}. Note this is \emph{not} the minmax transformation (see \code{\link[=n_minmax]{n_minmax()}}).
This is a linear transformation with shift \code{u} and scaling factor \code{u-l}.
}
\examples{
x <- runif(20)
n_scaled(x, npara = c(1,10))

}
