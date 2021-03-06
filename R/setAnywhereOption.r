#' @title
#' Set Anywhere Option (generic)
#'
#' @description 
#' Sets generic option inside an option container created via 
#' \code{\link[optionr]{initializeOptionContainer}} or any of its subcontainers.
#' 
#' @template path-like-ids
#'   	
#' @param id \strong{Signature argument}.
#'    Object containing path-like ID information.
#' @param value \strong{Signature argument}.
#'    Object containing value information.
#' @param where \strong{Signature argument}.
#'    Object containing information about the location of the option container
#'    that is to be used. Typically, this either corresponds to the name/ID
#'    of a package/package project or an instance of a custom class for which
#'    suitable methods in the context of managing options are defined 
#'    (see other methods of this package that have signature arguments 
#'    \code{id} or \code{where}).  
#' @param fail_value \code{\link{ANY}}.
#'     Value that is returned if assignment failed and \code{return_status = FALSE}.
#' @param gap \code{\link{logical}}. 
#'    \code{TRUE}: when \code{dirname(id)} points to a non-existing parent
#'    branch or if there are any missing branches in the nested structure, 
#'    then auto-create all missing branches; 
#'    \code{FALSE}: either return with \code{fail_value} or throw a condition 
#'     in such cases (depending on \code{strict});
#' @param force \code{\link{logical}}. 
#'    \code{TRUE}: when \code{dirname(id)} points to a \emph{leaf} instead of a 
#'    \emph{branch} (i.e. \code{dirname(id)} is not an \code{environment}), 
#'    overwrite it to turn it into a branch and vice versa when \code{id} points
#'    to a branch that is to be transformed into a leaf;
#'    \code{FALSE}: either return with \code{fail_value} or signal condition
#'    depending on value of \code{strict}. 
#' @param must_exist \code{\link{logical}}. 
#'    \code{TRUE}: \code{id} pointing to a non-existing option object either results 
#'    in return value \code{fail_value} or signal a condition
#'    depending on \code{strict}; 
#'    \code{FALSE}: option object that \code{id} points to is set.
#' @param reactive \code{\link{logical}}. 
#'    \code{TRUE}: set reactive option object via 
#'    \code{\link[reactr]{setShinyReactive}}.
#'    \code{FALSE}: set regular/non-reactive option object value.
#'    Note that if \code{value} inherits from \code{ReactiveExpression}
#'    (which it does if \code{\link[reactr]{reactiveExpression}} or wrappers
#'    around this function are used), \code{reactive} is 
#'    automatically set to \code{TRUE}.
#' @param return_status \code{\link{logical}}.
#'   	\code{TRUE}: return status (\code{TRUE} for successful assignment, 
#' 			\code{FALSE} for failed assignment);
#'    \code{FALSE}: return actual assignment value (\code{value}) or 
#'    \code{fail_value}.
#' @param strict \code{\link{logical}}.
#' 		Controls what happens when \code{id} points to a non-existing option object:
#'    \itemize{
#' 			\item{0: }{ignore and return \code{FALSE} to signal that the 
#' 				assignment process was not successful or \code{fail_value} depending
#' 				on the value of \code{return_status}} 
#' 			\item{1: }{ignore and with warning and return \code{FALSE}}
#' 			\item{2: }{ignore and with error}
#'   	}
#' @param typed \code{\link{logical}}. 
#'    \code{TRUE}: create an implicitly typed option object; 
#'    \code{FALSE}: create a regular option object.
#' @param Further arguments to be passed along to subsequent functions.
#'    In particular: 
#'    \itemize{
#'      \item{\code{\link[nestr]{setNested}} and any function that it calls and
#'        that take \code{...}}
#'    }
#' @example inst/examples/setAnywhereOption.r
#' @seealso \code{
#'   	\link[optionr]{setAnywhereOption-char-any-char-method},
#'     \link[optionr]{getAnywhereOption},
#'     \link[optionr]{existsAnywhereOption},
#'     \link[optionr]{rmAnywhereOption}
#' }
#' @template author
#' @template references
#' @import devtools
#' @export 
setGeneric(
  name = "setAnywhereOption",
  signature = c(
    "id",
    "value",
    "where"
  ),
  def = function(
    id,
    value,
    where = tryCatch(devtools::as.package(".")$package, error = function(cond) {
      stop("Invalid default value for `where`")
    }),
    fail_value = NULL,
    force = FALSE,
    gap = TRUE,
    must_exist = FALSE,
    reactive = FALSE,
    return_status = TRUE,
    strict = c(0, 1, 2),
    typed = FALSE,
    ...
  ) {
    standardGeneric("setAnywhereOption")       
  }
)

#' @title
#' Set Anywhere Option (char-any-miss)
#'
#' @description 
#' See generic: \code{\link[optionr]{setAnywhereOption}}
#'      
#' @inheritParams setAnywhereOption
#' @param id \code{\link{character}}.
#' @param value \code{\link{ANY}}.
#' @param where \code{\link{missing}}.
#' @return See method
#'    \code{\link{setAnywhereOption-char-any-char-method}}.
#' @example inst/examples/setAnywhereOption.r
#' @seealso \code{
#'    \link[optionr]{setAnywhereOption}
#' }
#' @template author
#' @template references
#' @aliases setAnywhereOption-char-any-miss-method
#' @export
setMethod(
  f = "setAnywhereOption", 
  signature = signature(
    id = "character",
    value = "ANY",
    where = "missing"
  ), 
  definition = function(
    id,
    value,
    where,
    fail_value,
    force,
    gap,
    must_exist,
    reactive,
    return_status,
    strict,
    typed,
    ...
  ) {
    
  setAnywhereOption(
    id = id,
    value = value,
    where = where,
    fail_value = fail_value,
    force = force,
    gap = gap,
    must_exist = must_exist,
    return_status = return_status,
    reactive = reactive,
    strict = strict,
    typed = typed,
    ...
  )    
    
  }
)

#' @title
#' Set Anywhere Option (char-any-any)
#'
#' @description 
#' See generic: \code{\link[optionr]{setAnywhereOption}}
#'      
#' @inheritParams setAnywhereOption
#' @param id \code{\link{character}}.
#' @param value \code{\link{ANY}}.
#' @param where \code{\link{ANY}}.
#' @return See method
#'    \code{\link{setAnywhereOption-char-any-char-method}}.
#' @example inst/examples/setAnywhereOption.r
#' @seealso \code{
#'    \link[optionr]{setAnywhereOption}
#' }
#' @template author
#' @template references
#' @aliases setAnywhereOption-char-any-any-method
#' @import conditionr
#' @export
setMethod(
  f = "setAnywhereOption", 
  signature = signature(
    id = "character",
    value = "ANY",
    where = "ANY"
  ), 
  definition = function(
    id,
    value,
    where,
    fail_value,
    force,
    gap,
    must_exist,
    reactive,
    return_status,
    strict,
    typed,
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
    
  setAnywhereOption(
    id = id,
    value = value,
    where = where$id,
    fail_value = fail_value,
    force = force,
    gap = gap,
    must_exist = must_exist,
    return_status = return_status,
    reactive = reactive,
    strict = strict,
    typed = typed,
    ...
  )    
    
  }
)

#' @title
#' Set Anywhere Option (char-any-env)
#'
#' @description 
#' See generic: \code{\link[optionr]{setAnywhereOption}}
#'      
#' @inheritParams setAnywhereOption
#' @param id \code{\link{character}}.
#' @param value \code{\link{ANY}}.
#' @param where \code{\link{environment}}.
#' @return See method
#'    \code{\link{setAnywhereOption-char-any-char-method}}.
#' @example inst/examples/setAnywhereOption.r
#' @seealso \code{
#'    \link[optionr]{setAnywhereOption}
#' }
#' @template author
#' @template references
#' @aliases setAnywhereOption-char-any-env-method
#' @import conditionr
#' @export
setMethod(
  f = "setAnywhereOption", 
  signature = signature(
    id = "character",
    value = "ANY",
    where = "environment"
  ), 
  definition = function(
    id,
    value,
    where,
    fail_value,
    force,
    gap,
    must_exist,
    reactive,
    return_status,
    strict,
    typed,
    ...
  ) {
    
  setNested(
    id = id, 
    value = value, 
    where = where, 
    fail_value = fail_value,
    force = force,
    gap = gap,
    must_exist = must_exist,
    return_status = return_status,
    reactive = reactive,
    strict = strict,
    typed = typed,
    ...
  )  
    
  }
)

#' @title
#' Set Anywhere Option (char-any-char)
#'
#' @description 
#' See generic: \code{\link[optionr]{setAnywhereOption}}
#'   	 
#' @inheritParams setAnywhereOption
#' @param id \code{\link{character}}.
#' @param value \code{\link{ANY}}.
#' @param where \code{\link{character}}.
#' @return \code{\link{logical}}. \code{TRUE}.
#' @example inst/examples/setAnywhereOption.r
#' @seealso \code{
#'    \link[optionr]{setAnywhereOption}
#' }
#' @template author
#' @template references
#' @aliases setAnywhereOption-char-any-char-method
#' @import nestr
#' @export
setMethod(
  f = "setAnywhereOption", 
  signature = signature(
    id = "character",
    value = "ANY",
    where = "character"
  ), 
  definition = function(
    id,
    value,
    where,
    fail_value,
    force,
    gap,
    must_exist,
    reactive,
    return_status,
    strict,
    typed,
    ...
  ) {
    
  container <- ensureOptionContainer(id = where, check = FALSE)
  
  setNested(
    id = id, 
    value = value, 
    where = container, 
    fail_value = fail_value,
    force = force,
    gap = gap,
    must_exist = must_exist,
    return_status = return_status,
    reactive = reactive,
    strict = strict,
    typed = typed,
    ...
  )
  
  }
)
