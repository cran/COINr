% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/treat.R
\name{Treat.data.frame}
\alias{Treat.data.frame}
\title{Treat a data frame for outliers}
\usage{
\method{Treat}{data.frame}(x, global_specs = NULL, indiv_specs = NULL, combine_treat = FALSE, ...)
}
\arguments{
\item{x}{A data frame. Can have both numeric and non-numeric columns.}

\item{global_specs}{First stage data treatment function}

\item{indiv_specs}{First stage data treatment function parameters}

\item{combine_treat}{By default, if \code{f1} fails to pass \code{f_pass}, then \code{f2} is applied to the original \code{x},
rather than the treated output of \code{f1}. If \code{combine_treat = TRUE}, \code{f2} will instead be applied to the output
of \code{f1}, so the two treatments will be combined.}

\item{...}{arguments passed to or from other methods.}
}
\value{
A treated data frame of data
}
\description{
Operates a two-stage data treatment process, based on two data treatment functions, and a pass/fail
function which detects outliers. This function is set up to allow any functions to be passed as the
data treatment functions (\code{f1} and \code{f2}), as well as any function to be passed as the outlier detection
function \code{f_pass}.
}
\details{
The arrangement of this function is inspired by a fairly standard data treatment process applied to
indicators, which consists of checking skew and kurtosis, then if the criteria are not met, applying
Winsorisation up to a specified limit. Then if Winsorisation still does not bring skew and kurtosis
within limits, applying a nonlinear transformation such as log or Box-Cox.

This function generalises this process by using the following general steps:
\enumerate{
\item Check if variable passes or fails using \code{f_pass}
\item If \code{f_pass} returns \code{FALSE}, apply \code{f1}, else return \code{x} unmodified
\item Check again using *\code{f_pass}
\item If \code{f_pass} still returns \code{FALSE}, apply \code{f2}
\item Return the modified \code{x} as well as other information.
}

For the "typical" case described above \code{f1} is a Winsorisation function, \code{f2} is a nonlinear transformation
and \code{f_pass} is a skew and kurtosis check. Parameters can be passed to each of these three functions in
a named list, for example to specify a maximum number of points to Winsorise, or Box-Cox parameters, or anything
else. The constraints are that:
\itemize{
\item All of \code{f1}, \code{f2} and \code{f_pass} must follow the format \verb{function(x, f_para)}, where \code{x} is a
numerical vector, and \code{f_para} is a list of other function parameters to be passed to the function, which
is specified by \code{f1_para} for \code{f1} and similarly for the other functions. If the function has no parameters
other than \code{x}, then \code{f_para} can be omitted.
\item \code{f1} and \code{f2} should return either a list with \code{.$x} as the modified numerical vector, and any other information
to be attached to the list, OR, simply \code{x} as the only output.
\item \code{f_pass} must return a logical value, where \code{TRUE} indicates that the \code{x} passes the criteria (and
therefore doesn't need any (more) treatment), and \code{FALSE} means that it fails to meet the criteria.
}

See also \code{vignette("treat")}.
}
\examples{
# select three indicators
df1 <- ASEM_iData[c("Flights", "Goods", "Services")]

# treat the data frame using defaults
l_treat <- Treat(df1)

# details of data treatment for each column
l_treat$Dets_Table

}
