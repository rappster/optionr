% Generated by roxygen2 (4.0.2): do not edit by hand
\docType{methods}
\name{existsMetaValue,character,ANY-method}
\alias{existsMetaValue,character,ANY-method}
\alias{existsMetaValue-char-any-method}
\title{Check Existence of Meta Value (char-any)}
\usage{
\S4method{existsMetaValue}{character,ANY}(id,
  where = tryCatch(devtools::as.package(".")$package, error = function(cond) {
      stop("Invalid default value for `where`") }), sub_id = character(),
  default = NULL, strict = c(0, 1, 2), ...)
}
\arguments{
\item{id}{\code{\link{character}}.}

\item{where}{\code{\link{ANY}}.}
}
\value{
See method
   \code{\link[optionr]{existsMetaValue-char-env-method}}
}
\description{
See generic: \code{\link[optionr]{existsMetaValue}}
}
\examples{
\dontrun{

##------------------------------------------------------------------------------
## Basics //
##------------------------------------------------------------------------------

setMetaValue(id = "test", value = TRUE)
existsMetaValue(id = "test")

setMetaValue(id = "a/b/c", value = 10)
existsMetaValue(id = "a")
existsMetaValue(id = "a/b")
existsMetaValue(id = "a/b/c")
existsMetaValue(id = "a/b/c/d")

existsMetaValue(id = "c")
existsMetaValue(id = "c/d/e")
  
##------------------------------------------------------------------------------
## Strictness levels //
##------------------------------------------------------------------------------

## Empty ID //
existsMetaValue(id = character())
try(existsMetaValue(id = character(), strict = 1))
try(existsMetaValue(id = character(), strict = 2))

## Not-existing //  
existsMetaValue(id = "c/d/e")
try(existsMetaValue(id = "c/d/e", strict = 1))
try(existsMetaValue(id = "c/d/e", strict = 2))

##------------------------------------------------------------------------------
## Explicit `where` //
##------------------------------------------------------------------------------

where <- new.env()
setMetaValue(id = "a/b/c", value = 10, where = where)
existsMetaValue(id = "a/b/c", where = where)
existsMetaValue(id = "a/b/c/d", where = where)
existsMetaValue(id = "c/d/e", where = where)

##------------------------------------------------------------------------------
## Sub ID //
##------------------------------------------------------------------------------

where <- new.env()
setMetaValue(id = "a/b/c", value = 10, where = where, sub_id = "sub")
ls(where)
existsMetaValue(id = "a/b/c", where = where, sub_id = "sub")
existsMetaValue(id = "a/b/c/d", where = where, sub_id = "sub")
existsMetaValue(id = "c/d/e", where = where, sub_id = "sub")

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
   \link[optionr]{existsMetaValue}
}
}

