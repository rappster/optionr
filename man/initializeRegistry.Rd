% Generated by roxygen2 (4.0.2): do not edit by hand
\name{initializeRegistry}
\alias{initializeRegistry}
\title{Initialize Registry (generic)}
\usage{
initializeRegistry(id = ".registry", where, ...)
}
\arguments{
\item{id}{\strong{Signature argument}.
Object containing ID information.}

\item{where}{\strong{Signature argument}.
Object containing location information.}

\item{...}{Further arguments to be passed to subsequent functions/methods.}
}
\description{
Convenience function to initialize a registry environment inside an
option container.
}
\examples{
\dontrun{

## Default `id` //  
container <- ensureOptionContainer(overwrite = TRUE)  
initializeRegistry(where = container)
exists(".registry", container)

## Different `id` //
container <- ensureOptionContainer(overwrite = TRUE)  
initializeRegistry(id = "REGISTRY", where = container)
exists("REGISTRY", container)

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
  	\link[optionr]{initializeRegistry-char-env-method},
   \link[optionr]{setRegistryValue},
   \link[optionr]{getRegistryValue},
   \link[optionr]{rmRegistryValue}
}
}

