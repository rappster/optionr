% Generated by roxygen2 (4.0.2): do not edit by hand
\docType{methods}
\name{existsAnywhereOption,character,ANY-method}
\alias{existsAnywhereOption,character,ANY-method}
\alias{existsAnywhereOption-char-any-method}
\title{Check Existence of an Anywhere Option (char-any)}
\usage{
\S4method{existsAnywhereOption}{character,ANY}(id,
  where = tryCatch(devtools::as.package(".")$package, error = function(cond) {
      stop("Invalid default value for `where`") }), strict = c(0, 1, 2), ...)
}
\arguments{
\item{id}{\code{\link{character}}.}

\item{where}{\code{\link{ANY}}.}

\item{strict}{\code{\link{logical}}.
 Controls what happens when \code{id} points to a non-existing option object:
\itemize{
       \item{0: }{ignore and return \code{FALSE} to signal that the
             assignment process was not successful or \code{fail_value} depending
             on the value of \code{return_status}}
         \item{1: }{ignore and with warning and return \code{FALSE}}
         \item{2: }{ignore and with error}
   }}

\item{...}{Further arguments to be passed to subsequent functions/methods.}
}
\value{
See method
   \code{\link[optionr]{existsAnywhereOption-char-env-method}}
}
\description{
See generic: \code{\link[optionr]{existsAnywhereOption}}
}
\examples{
\dontrun{

##------------------------------------------------------------------------------
## Basics //
##------------------------------------------------------------------------------

setAnywhereOption(id = "test", value = TRUE)
existsAnywhereOption(id = "test")

setAnywhereOption(id = "a/b/c", value = 10)
existsAnywhereOption(id = "a")
existsAnywhereOption(id = "a/b")
existsAnywhereOption(id = "a/b/c")
existsAnywhereOption(id = "a/b/c/d")

existsAnywhereOption(id = "c")
existsAnywhereOption(id = "c/d/e")
  
##------------------------------------------------------------------------------
## Strictness levels //
##------------------------------------------------------------------------------

## Empty ID //
existsAnywhereOption(id = character())
try(existsAnywhereOption(id = character(), strict = 1))
try(existsAnywhereOption(id = character(), strict = 2))

## Not-existing //  
existsAnywhereOption(id = "c/d/e")
try(existsAnywhereOption(id = "c/d/e", strict = 1))
try(existsAnywhereOption(id = "c/d/e", strict = 2))

##------------------------------------------------------------------------------
## Explicit `where` //
##------------------------------------------------------------------------------

where <- new.env()
setAnywhereOption(id = "a/b/c", value = 10, where = where)
existsAnywhereOption(id = "a/b/c", where = where)
existsAnywhereOption(id = "a/b/c/d", where = where)
existsAnywhereOption(id = "c/d/e", where = where)

}
}
\author{
Janko Thyson \email{janko.thyson@gmail.com}
}
\references{
\url{http://github.com/Rappster/optionr}
}
\seealso{
\code{
   \link[optionr]{existsAnywhereOption}
}
}

