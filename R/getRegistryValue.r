#' @title
#' Get Registry Value (generic)
#'
#' @description 
#' Retrieves registry value from the respective environment for registry information
#' inside an option container (see \code{\link[optionr]{initializeOptionContainer}}).
#' 
#' @template path-like-ids
#'   	
#' @param id \strong{Signature argument}.
#'    Object containing path-like name/ID information.
#' @param where \strong{Signature argument}.
#'    Object containing information about the location of the option container
#'    that is to be used. Typically, this either corresponds to the name/ID
#'    of a package/package project or an instance of a custom class for which
#'    suitable methods in the context of managing options are defined 
#'    (see other methods of this package that have signature arguments 
#'    \code{id} or \code{where}). 
#' @param sub_id \code{\link{character}}.
#'    Optional ID for a sub layer. Useful for a hub-like option container 
#'    structure. 
#' @param default \code{\link{ANY}}. 
#'    Value to be returned if option does not exist. 
#'    See \code{\link[base]{getOption}} and \code{\link[nestr]{getNested}}.
#' @param strict \code{\link{logical}}.
#'     Controls what happens when \code{id} points to a non-existing registry object:
#'    \itemize{
#'     	\item{0: }{ignore and return \code{FALSE} to signal that the 
#' 				assignment process was not successful or \code{fail_value} depending
#' 				on the value of \code{return_status}} 
#' 			\item{1: }{ignore and with warning and return \code{FALSE}}
#' 			\item{2: }{ignore and with error}
#'   	}
#' @template threedots
#' @example inst/examples/setRegistryValue.r
#' @seealso \code{
#'   	\link[optionr]{getRegistryValue-char-char-method},
#'    \link[optionr]{setRegistryValue},
#'    \link[optionr]{existsRegistryValue},
#'    \link[optionr]{rmRegistryValue}
#' }
#' @template author
#' @template references
#' @import devtools
#' @export 
setGeneric(
  name = "getRegistryValue",
  signature = c(
    "id",
    "where"
  ),
  def = function(
    id,
    where = tryCatch(devtools::as.package(".")$package, error = function(cond) {
      stop("Invalid default value for `where`")
    }),
    sub_id = character(),
    default = NULL,
    strict = c(0, 1, 2), 
    ...
  ) {
    standardGeneric("getRegistryValue")       
  }
)

#' @title
#' Get Registry Value (char-miss)
#'
#' @description 
#' See generic: \code{\link[optionr]{getRegistryValue}}
#'      
#' @inheritParams getRegistryValue
#' @param id \code{\link{character}}.
#' @param where \code{\link{missing}}.
#' @return See method 
#'    \code{\link[optionr]{getRegistryValue-char-char-method}}
#' @example inst/examples/setRegistryValue.r
#' @seealso \code{
#'    \link[optionr]{getRegistryValue}
#' }
#' @template author
#' @template references
#' @aliases getRegistryValue-char-miss-method
#' @export
setMethod(
  f = "getRegistryValue", 
  signature = signature(
    id = "character",
    where = "missing"
  ), 
  definition = function(
    id,
    where,
    sub_id,
    default,
    strict,
    ...
  ) {
 
  getRegistryValue(
    id = id,
    where = where,
    sub_id = sub_id,
    default = default,
    strict = strict,
    ...
  )    
    
  }
)

#' @title
#' Get Registry Value (char-any)
#'
#' @description 
#' See generic: \code{\link[optionr]{getRegistryValue}}
#'      
#' @inheritParams getRegistryValue
#' @param id \code{\link{character}}.
#' @param where \code{\link{ANY}}.
#' @return See method 
#'    \code{\link[optionr]{getRegistryValue-char-env-method}}
#' @example inst/examples/setRegistryValue.r
#' @seealso \code{
#'    \link[optionr]{getRegistryValue}
#' }
#' @template author
#' @template references
#' @aliases getRegistryValue-char-any-method
#' @import conditionr
#' @export
setMethod(
  f = "getRegistryValue", 
  signature = signature(
    id = "character",
    where = "ANY"
  ), 
  definition = function(
    id,
    where,
    default,
    strict,
    ...
  ) {
 
  if (is.null(where$id)) {
    conditionr::signalCondition(
      condition = "Invalid",
      msg = c(
        Reason = "cannot determine value of `where`"
      ),
      ns = "optionr",
      type = "error"
    )
  }        
    
  getRegistryValue(
    id = id,
    where = where$id,
    default = default,
    strict = strict,
    ...
  )  
    
  }
)

#' @title
#' Get Registry Value (char-env)
#'
#' @description 
#' See generic: \code{\link[optionr]{getRegistryValue}}
#'      
#' @inheritParams getRegistryValue
#' @param id \code{\link{character}}.
#' @param where \code{\link{environment}}.
#' @return See method 
#'    \code{\link[optionr]{getRegistryValue-char-char-method}}
#' @example inst/examples/setRegistryValue.r
#' @seealso \code{
#'    \link[optionr]{getRegistryValue}
#' }
#' @template author
#' @template references
#' @aliases getRegistryValue-char-env-method
#' @import conditionr
#' @export
setMethod(
  f = "getRegistryValue", 
  signature = signature(
    id = "character",
    where = "environment"
  ), 
  definition = function(
    id,
    where,
    sub_id,
    default,
    strict,
    ...
  ) {
 
  sub_id <- as.character(sub_id)    
  getAnywhereOption(
    id = if (!length(sub_id)) {
      file.path(".registry", id)
    } else {
      file.path(sub_id, ".registry", id)
    },
    where = where,
    default = default,
    strict = strict,
    ...
  )    
    
  }
)

#' @title
#' Get Registry Value (char-char)
#'
#' @description 
#' See generic: \code{\link[optionr]{getRegistryValue}}
#'   	 
#' @inheritParams getRegistryValue
#' @param id \code{\link{character}}.
#' @param where \code{\link{character}}.
#' @return \code{\link{ANY}}. Component value or for invalid argument input 
#' 		and non-existing component the value of \code{default} unless 
#' 		\code{strict == 1} in which case a warning is issued or
#' 		\code{strict == 2} in which case an error is thrown.
#' @example inst/examples/setRegistryValue.r
#' @seealso \code{
#'    \link[optionr]{getRegistryValue}
#' }
#' @template author
#' @template references
#' @aliases getRegistryValue-char-miss-method
#' @export
setMethod(
  f = "getRegistryValue", 
  signature = signature(
    id = "character",
    where = "character"
  ), 
  definition = function(
    id,
    where,
    sub_id,
    default,
    strict,
    ...
  ) {

  sub_id <- as.character(sub_id)    
  getAnywhereOption(
    id = if (!length(sub_id)) {
      file.path(".registry", id)
    } else {
      file.path(sub_id, ".registry", id)
    },
    where = where,
    default = default,
    strict = strict,
    ...
  ) 
    
  }
)
