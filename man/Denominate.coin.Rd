% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/denominate.R
\name{Denominate.coin}
\alias{Denominate.coin}
\title{Denominate data set in a coin}
\usage{
\method{Denominate}{coin}(
  x,
  dset,
  denoms = NULL,
  denomby = NULL,
  denoms_ID = NULL,
  f_denom = NULL,
  write_to = NULL,
  out2 = "coin",
  ...
)
}
\arguments{
\item{x}{A coin class object}

\item{dset}{The name of the data set to apply the function to, which should be accessible in \code{.$Data}.}

\item{denoms}{An optional data frame of denominator data. Columns should be denominator data, with column names corresponding
to entries in \code{denomby}. This must also include an ID column identified by \code{denoms_ID} to match rows. If \code{denoms}
is not specified, will extract any potential denominator columns that were attached to \code{iData} when calling \code{\link[=new_coin]{new_coin()}}.}

\item{denomby}{Optional data frame which specifies which denominators to use for each indicator, and any scaling factors
to apply. Should have columns \code{iCode}, \code{Denominator}, \code{ScaleFactor}. \code{iCode} specifies an indicator code found in \code{dset},
\code{Denominator} specifies a column name from \code{denoms} to use to denominate the corresponding column from \code{x}.
\code{ScaleFactor} allows the possibility to scale
denominators if needed, and specifies a factor to multiply the resulting values by. For example, if GDP is a denominator and is measured in
dollars, dividing will create very small numbers (order 1e-10 and smaller) which could cause problems with numerical precision. If \code{denomby}
is not specified, specifications will be taken from the "Denominator" column in \code{iMeta}, if it exists.}

\item{denoms_ID}{An ID column for matching \code{denoms} with the data to be denominated. This column should contain
\code{uMeta} codes to match with the data set extracted from the coin.}

\item{f_denom}{A function which takes two numeric vector arguments and is used to perform the denomination for each
column. By default, this is division, i.e. \code{x[[col]]/denoms[[col]]} for given columns, but any function can be passed
that takes two numeric vectors as inputs and returns a single numeric vector. See details.}

\item{write_to}{If specified, writes the aggregated data to \code{.$Data[[write_to]]}. Default \code{write_to = "Denominated"}.}

\item{out2}{Either \code{"coin"} (default) to return updated coin or \code{"df"} to output the aggregated data set.}

\item{...}{arguments passed to or from other methods}
}
\value{
An updated coin if \code{out2 = "coin"}, else a data frame of denominated data if \code{out2 = "df"}.
}
\description{
"Denominates" or "scales" indicators by other variables. Typically this is done by dividing extensive variables such as
GDP by a scaling variable such as population, to give an intensive variable (GDP per capita).
}
\details{
This function denominates a data set \code{dset} inside the coin. By default, denominating variables are taken from
the coin, specifically as variables in \code{iData} with \code{Type = "Denominator"} in \code{iMeta} (input to \code{\link[=new_coin]{new_coin()}}).
Specifications to map denominators to indicators are also taken by default from \code{iMeta$Denominator}, if it exists.

These specifications can be overridden using the \code{denoms} and \code{denomby} arguments. The operator for denomination
can also be changed using the \code{f_denom} argument.

See also documentation for \code{\link[=Denominate.data.frame]{Denominate.data.frame()}} which is called by this method.
}
\examples{
# build example coin
coin <- build_example_coin(up_to = "new_coin", quietly = TRUE)

# denominate (here, we only need to say which dset to use, takes
# specs and denominators from within the coin)
coin <- Denominate(coin, dset = "Raw")

}
