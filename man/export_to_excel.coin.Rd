% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/export.R
\name{export_to_excel.coin}
\alias{export_to_excel.coin}
\title{Export a coin to Excel}
\usage{
\method{export_to_excel}{coin}(x, fname = "coin_export.xlsx", include_log = FALSE, ...)
}
\arguments{
\item{x}{A coin class object}

\item{fname}{The file name/path to write to, as a character string}

\item{include_log}{Logical: if \code{TRUE}, also writes data frames from the \code{.$Log} list inside the coin.}

\item{...}{arguments passed to or from other methods.}
}
\value{
.xlsx file at specified path
}
\description{
Exports the contents of the coin to Excel. This writes all data frames inside the coin to Excel, with each data
frame on a separate tab. Tabs are named according to the position in the coin object. You can write other
data frames by simply attaching them to the coin object somewhere.
}
\examples{
## Here we write a COIN to Excel, but this is done to a temporary directory
## to avoid "polluting" the working directory when running automatic tests.
## In a real case, set fname to a directory of your choice.

# build example coin up to data treatment step
coin <- build_example_coin(up_to = "Treat")

# write to Excel in temporary directory
export_to_excel(coin, fname = paste0(tempdir(), "\\\\ASEM_results.xlsx"))

# spreadsheet is at:
print(paste0(tempdir(), "\\\\ASEM_results.xlsx"))

# now delete temporary file to keep things tidy in testing
unlink(paste0(tempdir(),"\\\\ASEM_results.xlsx"))

}
