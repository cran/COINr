% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/impute.R
\name{Impute.numeric}
\alias{Impute.numeric}
\title{Impute a numeric vector}
\usage{
\method{Impute}{numeric}(x, f_i = NULL, f_i_para = NULL, ...)
}
\arguments{
\item{x}{A numeric vector, possibly with \code{NA} values to be imputed.}

\item{f_i}{A function that imputes missing values in a numeric vector. See description and details.}

\item{f_i_para}{Optional further arguments to be passed to \code{f_i()}}

\item{...}{arguments passed to or from other methods.}
}
\value{
An imputed numeric vector of the same length of \code{x}.
}
\description{
Imputes missing values in a numeric vector using a function \code{f_i}. This function should return a vector identical
to \code{x} except for \code{NA} values, which can be replaced. The function \code{f_i} is not required to replace \emph{all} \code{NA}
values.
}
\details{
This calls the function \code{f_i()}, with optionally further arguments \code{f_i_para}, to impute any missing
values found in \code{x}. By default, \code{f_i = "i_mean()"}, which simply imputes \code{NA}s with the mean of the
non-\code{NA} values in \code{x}.

COINr has several built-in imputation functions of the form \verb{i_*()} for vectors which can be called by \code{\link[=Impute]{Impute()}}. See the
\href{https://bluefoxr.github.io/COINr/articles/imputation.html#data-frames}{online documentation} for more details.

You could also use one of the imputation functions directly (such as \code{\link[=i_mean]{i_mean()}}). However, this
function offers a few extra advantages, such as checking the input and output formats, and making
sure the resulting imputed vector agrees with the input. It will also skip imputation entirely if
there are no \code{NA}s at all.
}
\examples{
# a vector with a missing value
x <- 1:10
x[3] <- NA
x

# impute using median
# this calls COINr's i_median() function
Impute(x, f_i = "i_median")

}
