#' @title
#' Ensure Option Container (generic)
#'
#' @description 
#' Ensures the existence of an \code{environment} that serves as an option
#' container. The container will be assigned to R option based on signature 
#' argument \code{id}.
#'   	
#' @param id \strong{Signature argument}.
#'    Object containing suitable information to control the actual ensurance
#'    process.
#'    In the simplest case, this corresponds
#'    to the name/ID of a package/package project. But it can also be an 
#'    instance of a custom class for which a suitable methods are defined.
#' @param container \strong{Signature argument}.
#'    Object containing container information.
#' @param check \code{\link{logical}}.
#'    \code{TRUE}: check if an R option with name/ID according to the information
#'    in \code{id} already exists (in which case an error is thrown); 
#'    \code{FALSE}: no check for existing R options.
#'    Note that \code{overwrite} will overrule \code{check}.
#' @param hidden \code{\link{logical}}.
#'    \code{TRUE}: make sure name/ID information in \code{id} 
#'    is preprended with a dot to hide it; 
#'    \code{FALSE}: use name/ID information in \code{id} as is.
#'    The former reduces the risk of accidentially overwriting existing R 
#'    options and thus is used by default.
#' @param overwrite \code{\link{logical}}.
#'    \code{TRUE}: overwrite existing container; 
#'    \code{FALSE}: keep existing container.
#' @template threedots
#' @example inst/examples/ensureOptionContainer.r
#' @seealso \code{
#'   	\link[rapp]{ensureOptionContainer-missing-method}
#' }
#' @template author
#' @template references
#' @export 
setGeneric(
  name = "ensureOptionContainer",
  signature = c(
    "id",
    "container"
  ),
  def = function(
    id = tryCatch(devtools::as.package(".")$package, error = function(cond) {
      stop("Invalid default value for `id`")
    }),
    container = new.env(),
    check = TRUE,
    hidden = TRUE,
    overwrite = FALSE,
    ...
  ) {
    standardGeneric("ensureOptionContainer")       
  }
)

#' @title
#' Ensure Option Container (miss-miss)
#'
#' @description 
#' See generic: \code{\link[rapp]{ensureOptionContainer}}
#'   	 
#' @inheritParams ensureOptionContainer
#' @param id \code{\link{missing}}.
#' @param container \code{\link{missing}}.
#' @return \code{\link{logical}}. \code{TRUE}.
#' @example inst/examples/ensureOptionContainer.r
#' @seealso \code{
#'    \link[rapp]{ensureOptionContainer}
#' }
#' @template author
#' @template references
#' @export
setMethod(
  f = "ensureOptionContainer", 
  signature = signature(
    id = "missing",
    container = "missing"
  ), 
  definition = function(
    id,
    container,
    check,
    hidden,
    overwrite,
    ...
  ) {
    
  ensureOptionContainer(
    id = id,
    container = container,
    check = check,
    hidden = hidden,
    overwrite = overwrite,
    ...
  )
  
  }
)

#' @title
#' Ensure Option Container (any-miss)
#'
#' @description 
#' See generic: \code{\link[rapp]{ensureOptionContainer}}
#'      
#' @inheritParams ensureOptionContainer
#' @param id \code{\link{ANY}}.
#' @param container \code{\link{missing}}.
#' @return \code{\link{logical}}. \code{TRUE}.
#' @example inst/examples/ensureOptionContainer.r
#' @seealso \code{
#'    \link[rapp]{ensureOptionContainer}
#' }
#' @template author
#' @template references
#' @export
setMethod(
  f = "ensureOptionContainer", 
  signature = signature(
    id = "ANY",
    container = "missing"
  ), 
  definition = function(
    id,
    container,
    check,
    hidden,
    overwrite,
    ...
  ) {
    
  ensureOptionContainer(
    id = id,
    container = container,
    check = check,
    hidden = hidden,
    overwrite = overwrite,
    ...
  )
  
  }
)

#' @title
#' Ensure Option Container (any-env)
#'
#' @description 
#' See generic: \code{\link[rapp]{ensureOptionContainer}}
#'      
#' @inheritParams ensureOptionContainer
#' @param id \code{\link{ANY}}.
#' @param container \code{\link{environment}}.
#' @return \code{\link{logical}}. \code{TRUE}.
#' @example inst/examples/ensureOptionContainer.r
#' @seealso \code{
#'    \link[rapp]{ensureOptionContainer}
#' }
#' @template author
#' @template references
#' @import conditionr
#' @export
setMethod(
  f = "ensureOptionContainer", 
  signature = signature(
    id = "ANY",
    container = "environment"
  ), 
  definition = function(
    id,
    container,
    check,
    hidden,
    overwrite,
    ...
  ) {
  
  if (is.null(id$id)) {
    conditionr::signalCondition(
      condition = "MissingIdField",
      msg = c(
        Reason = "name/ID field is missing"
      ),
      ns = "optionr",
      type = "error"
    )
  }    
    
  if (hidden) {
    id$id <- paste0(".", id$id)
  }    
  
  if (check && !overwrite && id$id %in% names(options())) {
    conditionr::signalCondition(
      condition = "ExistingOption",
      msg = c(
        Reason = "option already exists",
        ID = id$id
      ),
      ns = "optionr",
      type = "error"
    )
  }
  
  opts <- getOption(id$id)
  if (is.null(opts)) {
    eval(parse(text = sprintf("options(%s = container)", id$id)))
  } else {
    if (overwrite) {
      rm(list = ls(opts, all.names = TRUE), envir = opts)
    }
  }
  return(getOption(id$id))
    
  }
)

#' @title
#' Ensure Option Container (char-env)
#'
#' @description 
#' See generic: \code{\link[rapp]{ensureOptionContainer}}
#'      
#' @inheritParams ensureOptionContainer
#' @param id \code{\link{character}}.
#' @param container \code{\link{environment}}.
#' @return \code{\link{logical}}. \code{TRUE}.
#' @example inst/examples/ensureOptionContainer.r
#' @seealso \code{
#'    \link[rapp]{ensureOptionContainer}
#' }
#' @template author
#' @template references
#' @import conditionr
#' @export
setMethod(
  f = "ensureOptionContainer", 
  signature = signature(
    id = "character",
    container = "environment"
  ), 
  definition = function(
    id,
    container,
    check,
    hidden,
    overwrite,
    ...
  ) {
    
  if (hidden) {
    id <- paste0(".", id)
  }    
  
  if (check && !overwrite && id %in% names(options())) {
    conditionr::signalCondition(
      condition = "ExistingOption",
      msg = c(
        Reason = "option already exists",
        ID = id
      ),
      ns = "optionr",
      type = "error"
    )
  }
  
  opts <- getOption(id)
  if (is.null(opts)) {
    eval(parse(text = sprintf("options(%s = container)", id)))
  } else {
    if (overwrite) {
      rm(list = ls(opts, all.names = TRUE), envir = opts)
    }
  }
  return(getOption(id))
  
  }
)
