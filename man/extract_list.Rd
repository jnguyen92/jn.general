% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/extract_list.R
\name{extract_list}
\alias{extract_list}
\title{Extract Data Accumulated in a List}
\usage{
extract_list(l, rbind = TRUE, recursive = TRUE)
}
\arguments{
\item{l}{a list}

\item{rbind}{logical; if TRUE rbinds/stacks all extracted elements into a data.table (if they are data frames);
else they are returned as lists. Elements that are not data frames are returned as lists}

\item{recursive}{logical; if TRUE extraction applied to list components of x}
}
\value{
a list
}
\description{
Loops through an iterative list and rearranges data structures. Accumulates structures of the same
name into a subsetted list which can be accessed using \code{$}. \cr
See \code{\link{is_iterative_list}} to see what qualifies.
}
\examples{
x <- purrr::rerun(3, 
  WI = list(a = matrix(1:6, nrow = 2), b = data.frame(i = 1:10, j = 1:10)),
  MN = list(cold = list(blue = runif(5), red = runif(15)), hot = rnorm(3)),
  CA = LETTERS
)
lst <- extract_list(x)
lst$MN$cold$red

}
