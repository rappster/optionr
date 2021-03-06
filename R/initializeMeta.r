#' @title
#' Initialize Meta Information (generic)
#'
#' @description 
#' Convenience function to initialize a meta information environment inside an
#' option container.
#'   	
#' @param id \strong{Signature argument}.
#'    Object containing ID information.
#' @param where \strong{Signature argument}.
#'    Object containing location information.
#' @template threedots
#' @example inst/examples/initializeMeta.r
#' @seealso \code{
#'   	\link[optionr]{initializeMeta-char-char-method},
#'    \link[optionr]{setMetaValue},
#'    \link[optionr]{getMetaValue},
#'    \link[optionr]{rmtMetaValue}
#' }
#' @template author
#' @template references
setGeneric(
  name = "initializeMeta",
  signature = c(
    "id",
    "where"
  ),
  def = function(
    id = ".meta",
    where,
    ...
  ) {
    standardGeneric("initializeMeta")       
  }
)

#' @title
#' Initialize Meta Information (miss-miss)
#'
#' @description 
#' See generic: \code{\link[optionr]{initializeMeta}}
#'      
#' @inheritParams initializeMeta
#' @param id \code{\link{missing}}.
#' @param where \code{\link{missing}}.
#' @return See method
#'    \code{\link[optionr]{initializeMeta-char-env-method}}.
#' @example inst/examples/initializeMeta.r
#' @seealso \code{
#'    \link[optionr]{initializeMeta-char-env-method},
#'    \link[optionr]{setMetaValue},
#'    \link[optionr]{getMetaValue},
#'    \link[optionr]{rmMetaValue}
#' }
#' @template author
#' @template references
#' @aliases initializeMeta-miss-miss-method
#' @export
setMethod(
  f = "initializeMeta", 
  signature = signature(
    id = "missing",
    where= "missing"
  ), 
  definition = function(
    id,
    where,
    ...
  ) {
    
  return(initializeMeta(
    id = id,
    where = where,
    ...
  ))    
  
  }
)

#' @title
#' Initialize Meta Information (miss-envir)
#'
#' @description 
#' See generic: \code{\link[optionr]{initializeMeta}}
#'      
#' @inheritParams initializeMeta
#' @param id \code{\link{missing}}.
#' @param where \code{\link{environment}}.
#' @return See method
#'    \code{\link[optionr]{initializeMeta-char-env-method}}.
#' @example inst/examples/initializeMeta.r
#' @seealso \code{
#'    \link[optionr]{initializeMeta}
#' }
#' @template author
#' @template references
#' @aliases initializeMeta-miss-env-method
#' @export
setMethod(
  f = "initializeMeta", 
  signature = signature(
    id = "missing",
    where= "environment"
  ), 
  definition = function(
    id,
    where,
    ...
  ) {
    
  return(initializeMeta(
    id = id,
    where = where,
    ...
  ))    
  
  }
)

#' @title
#' Initialize Meta Information (any-envir)
#'
#' @description 
#' See generic: \code{\link[optionr]{initializeMeta}}
#'      
#' @inheritParams initializeMeta
#' @param id \code{\link{ANY}}.
#' @param where \code{\link{environment}}.
#' @return \code{\link{environment}}. Environment containing the options.
#' @example inst/examples/initializeMeta.r
#' @seealso \code{
#'    \link[optionr]{initializeMeta}
#' }
#' @template author
#' @template references
#' @aliases initializeMeta-any-env-method
#' @export
setMethod(
  f = "initializeMeta", 
  signature = signature(
    id = "ANY",
    where= "environment"
  ), 
  definition = function(
    id,
    where,
    ...
  ) {
    
  assign(".meta", new.env(parent = emptyenv()), envir = where)
    
  }
)

#' @title
#' Initialize Meta Information (char-envir)
#'
#' @description 
#' See generic: \code{\link[optionr]{initializeMeta}}
#'      
#' @inheritParams initializeMeta
#' @param id \code{\link{character}}.
#' @param where \code{\link{environment}}.
#' @return \code{\link{environment}}. Environment containing the options.
#' @example inst/examples/initializeMeta.r
#' @seealso \code{
#'    \link[optionr]{initializeMeta}
#' }
#' @template author
#' @template references
#' @aliases initializeMeta-char-env-method
#' @export
setMethod(
  f = "initializeMeta", 
  signature = signature(
    id = "character",
    where= "environment"
  ), 
  definition = function(
    id,
    where,
    ...
  ) {
  
  assign(id, new.env(parent = emptyenv()), envir = where)
    
  }
)

