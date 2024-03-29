% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sensitivity.R
\name{get_noisy_weights}
\alias{get_noisy_weights}
\title{Noisy replications of weights}
\usage{
get_noisy_weights(w, noise_specs, Nrep)
}
\arguments{
\item{w}{A data frame of weights, in the format found in \code{.$Meta$Weights}.}

\item{noise_specs}{a data frame with columns:
\itemize{
\item \code{Level}: The aggregation level to apply noise to
\item \code{NoiseFactor}: The size of the perturbation: setting e.g. 0.2 perturbs by +/- 20\% of nominal values.
}}

\item{Nrep}{The number of weight replications to generate.}
}
\value{
A list of \code{Nrep} sets of weights (data frames).
}
\description{
Given a data frame of weights, this function returns multiple replicates of the weights, with added
noise. This is intended for use in uncertainty and sensitivity analysis.
}
\details{
Weights are expected to be in a data frame format with columns \code{Level}, \code{iCode} and \code{Weight}, as
used in \code{iMeta}. Note that no \code{NA}s are allowed anywhere in the data frame.

Noise is added using the \code{noise_specs} argument, which is specified by a data frame with columns
\code{Level} and \code{NoiseFactor}. The aggregation level refers to number of the aggregation level to target
while the \code{NoiseFactor} refers to the size of the perturbation. If e.g. a row is \code{Level = 1} and
\code{NoiseFactor = 0.2}, this will allow the weights in aggregation level 1 to deviate by +/- 20\% of their
nominal values (the values in \code{w}).

This function replaces the now-defunct \code{noisyWeights()} from COINr < v1.0.
}
\examples{
# build example coin
coin <- build_example_coin(up_to = "new_coin", quietly = TRUE)

# get nominal weights
w_nom <- coin$Meta$Weights$Original

# build data frame specifying the levels to apply the noise at
# here we vary at levels 2 and 3
noise_specs = data.frame(Level = c(2,3),
                         NoiseFactor = c(0.25, 0.25))

# get 100 replications
noisy_wts <- get_noisy_weights(w = w_nom, noise_specs = noise_specs, Nrep = 100)

# examine one of the noisy weight sets, last few rows
tail(noisy_wts[[1]])

}
\seealso{
\itemize{
\item \code{\link[=get_sensitivity]{get_sensitivity()}} Perform global sensitivity or uncertainty analysis on a COIN
}
}
