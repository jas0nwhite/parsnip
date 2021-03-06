% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/nearest_neighbor.R
\name{nearest_neighbor}
\alias{nearest_neighbor}
\title{General Interface for K-Nearest Neighbor Models}
\usage{
nearest_neighbor(
  mode = "unknown",
  neighbors = NULL,
  weight_func = NULL,
  dist_power = NULL
)
}
\arguments{
\item{mode}{A single character string for the type of model.
Possible values for this model are \code{"unknown"}, \code{"regression"}, or
\code{"classification"}.}

\item{neighbors}{A single integer for the number of neighbors
to consider (often called \code{k}). For \pkg{kknn}, a value of 5
is used if \code{neighbors} is not specified.}

\item{weight_func}{A \emph{single} character for the type of kernel function used
to weight distances between samples. Valid choices are: \code{"rectangular"},
\code{"triangular"}, \code{"epanechnikov"}, \code{"biweight"}, \code{"triweight"},
\code{"cos"}, \code{"inv"}, \code{"gaussian"}, \code{"rank"}, or \code{"optimal"}.}

\item{dist_power}{A single number for the parameter used in
calculating Minkowski distance.}
}
\description{
\code{nearest_neighbor()} is a way to generate a \emph{specification} of a model
before fitting and allows the model to be created using
different packages in R. The main arguments for the
model are:
\itemize{
\item \code{neighbors}: The number of neighbors considered at
each prediction.
\item \code{weight_func}: The type of kernel function that weights the
distances between samples.
\item \code{dist_power}: The parameter used when calculating the Minkowski
distance. This corresponds to the Manhattan distance with \code{dist_power = 1}
and the Euclidean distance with \code{dist_power = 2}.
}
These arguments are converted to their specific names at the
time that the model is fit. Other options and arguments can be
set using \code{set_engine()}. If left to their defaults
here (\code{NULL}), the values are taken from the underlying model
functions. If parameters need to be modified, \code{update()} can be used
in lieu of recreating the object from scratch.
}
\details{
The model can be created using the \code{fit()} function using the
following \emph{engines}:
\itemize{
\item \pkg{R}:  \code{"kknn"}  (the default)
}
}
\section{Engine Details}{
Engines may have pre-set default arguments when executing the model fit
call. For this type of model, the template of the fit calls are below:
\subsection{kknn}{\if{html}{\out{<div class="r">}}\preformatted{nearest_neighbor() \%>\% 
  set_engine("kknn") \%>\% 
  set_mode("regression") \%>\% 
  translate()
}\if{html}{\out{</div>}}\preformatted{## K-Nearest Neighbor Model Specification (regression)
## 
## Computational engine: kknn 
## 
## Model fit template:
## kknn::train.kknn(formula = missing_arg(), data = missing_arg(), 
##     ks = 5)
}\if{html}{\out{<div class="r">}}\preformatted{nearest_neighbor() \%>\% 
  set_engine("kknn") \%>\% 
  set_mode("classification") \%>\% 
  translate()
}\if{html}{\out{</div>}}\preformatted{## K-Nearest Neighbor Model Specification (classification)
## 
## Computational engine: kknn 
## 
## Model fit template:
## kknn::train.kknn(formula = missing_arg(), data = missing_arg(), 
##     ks = 5)
}

For \code{kknn}, the underlying modeling function used is a restricted
version of \code{train.kknn()} and not \code{kknn()}. It is set up in this way so
that \code{parsnip} can utilize the underlying \code{predict.train.kknn} method to
predict on new data. This also means that a single value of that
function’s \code{kernel} argument (a.k.a \code{weight_func} here) can be supplied

For this engine, tuning over \code{neighbors} is very efficient since the
same model object can be used to make predictions over multiple values
of \code{neighbors}.
}

\subsection{Parameter translations}{

The standardized parameter names in parsnip can be mapped to their
original names in each engine that has main parameters. Each engine
typically has a different default value (shown in parentheses) for each
parameter.\tabular{ll}{
   \strong{parsnip} \tab \strong{kknn} \cr
   neighbors \tab ks \cr
   weight_func \tab kernel (optimal) \cr
   dist_power \tab distance (2) \cr
}

}
}

\examples{
show_engines("nearest_neighbor")

nearest_neighbor(neighbors = 11)

}
\seealso{
\code{\link[=fit]{fit()}}
}
