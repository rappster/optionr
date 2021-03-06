#' @title
#' Initialize Option Container (generic)
#'
#' @description 
#' Convenience function to initialize the option container that is then stored 
#' as an R option according to the name/ID provided by \code{id}.
#'   	
#' @param id \strong{Signature argument}.
#'    Object containing suitable information to control the distinct creation
#'    process.
#'    In the simplest case, this corresponds
#'    to the name/ID of a package/package project. But it can also be an 
#'    instance of a class for which methods for 
#'    \code{\link[optionr]{initializeProjectOptions}}, 
#'    \code{\link[optionr]{initializeMeta}} and 
#'    \code{\link[optionr]{initializeRegistry}} exist.
#' @param sub_id \code{\link{character}}.
#'    Optional ID for a sub layer. Useful for a hub-like option container 
#'    structure.
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
#'    \code{FALSE}: create only if no container exists yet.
#' @template threedots
#' @example inst/examples/initializeOptionContainer.r
#' @seealso \code{
#'   	\link[optionr]{initializeOptionContainer-char-method},
#'     \link[optionr]{ensureOptionContainer},
#'     \link[optionr]{getOptionContainer}
#' }
#' @template author
#' @template references
setGeneric(
  name = "initializeOptionContainer",
  signature = c(
    "id"
  ),
  def = function(
    id = tryCatch(devtools::as.package(".")$package, error = function(cond) {
      stop("Invalid default value for `id`")
    }),
    sub_id = character(),
    components = c("options", ".meta", ".registry"),
    check = TRUE,
    hidden = TRUE,
    overwrite = FALSE,
    ...
  ) {
    standardGeneric("initializeOptionContainer")       
  }
)

#' @title
#' Initialize Option Container (miss)
#'
#' @description 
#' See generic: \code{\link[optionr]{initializeOptionContainer}}
#'      
#' @inheritParams initializeOptionContainer
#' @param id \code{\link{missing}}.
#' @return See method
#'    \code{\link[optionr]{initializeOptionContainer-char-method}}.
#' @example inst/examples/initializeOptionContainer.r
#' @seealso \code{
#'    \link[optionr]{initializeOptionContainer-char-method},
#'    \link[optionr]{ensureOptionContainer},
#'    \link[optionr]{getOptionContainer}
#' }
#' @template author
#' @template references
#' @aliases initializeOptionContainer-miss-method
#' @export
setMethod(
  f = "initializeOptionContainer", 
  signature = signature(
    id = "missing"
  ), 
  definition = function(
    id,
    sub_id,
    components,
    check,
    hidden,
    overwrite,
    ...
  ) {
    
  return(initializeOptionContainer(
    id = id,
    sub_id = sub_id,
    components = components,
    check = check,
    hidden = hidden,
    overwrite = overwrite,
    ...
  ))    
  
  }
)

#' @title
#' Initialize Option Container (any)
#'
#' @description 
#' See generic: \code{\link[optionr]{initializeOptionContainer}}
#'      
#' @inheritParams initializeOptionContainer
#' @param id \code{\link{ANY}}.
#' @return \code{\link{environment}}. The option container.
#' @example inst/examples/initializeOptionContainer.r
#' @seealso \code{
#'    \link[optionr]{initializeOptionContainer}
#' }
#' @template author
#' @template references
#' @aliases initializeOptionContainer-any-method
#' @import conditionr
#' @export
setMethod(
  f = "initializeOptionContainer", 
  signature = signature(
    id = "ANY"
  ), 
  definition = function(
    id,
    sub_id,
    components,
    check,
    hidden,
    overwrite,
    ...
  ) {
  
  components <- match.arg(components, c("options", ".meta", ".registry"),
    several = TRUE) 
  sub_id <- as.character(sub_id)
  
  if (is.null(id$id)) {
    conditionr::signalCondition(
      condition = "MissingIdField",
      msg = c(
        Reason = "name/ID field is missing, can not determine determine parent option"
      ),
      ns = "optionr",
      type = "error"
    )
  }
  
  id_char_0 <- id$id
  id_char <- id_char_0
  if (hidden) {
    id_char <- paste0(".", id$id)
  } 
    
  out <- if (is.null(getOption(id_char))) {
    opts <- ensureOptionContainer(id = id, sub_id = sub_id, 
      check = check, hidden = hidden)
    if (length(sub_id)) {
      opts <- opts[[sub_id]]
    }
    if ("options" %in% components) {
      initializeProjectOptions(id = id, where = opts)
    }
    if (".meta" %in% components) {
      initializeMeta(id = id, where = opts)
    }
    if (".registry" %in% components) {
      initializeRegistry(id = id, where = opts)
    }
    opts
  } else {
    ## This ensures that pass-by-reference still works as the same environment
    ## object is re-used again //
    if (overwrite) {
      opts <- getOption(id_char)  
      if (length(sub_id)) {
        if (!exists(sub_id, envir = opts, inherits = FALSE)) {
          assign(sub_id, new.env(parent = emptyenv()), envir = opts)  
        }
        opts <- opts[[sub_id]]
      }
      rm(list = ls(opts, all.names = TRUE), envir = opts)
      if ("options" %in% components) {
        initializeProjectOptions(id = id, where = opts)
      }
      if (".meta" %in% components) {
        initializeMeta(id = id, where = opts)
      }
      if (".registry" %in% components) {
        initializeRegistry(id = id, where = opts)
      }
      opts
    } else {
      opts <- getOption(id_char)  
      if (!exists(sub_id, envir = opts, inherits = FALSE)) {
          assign(sub_id, new.env(parent = emptyenv()), envir = opts)  
        }
      if (length(sub_id)) {
        opts <- opts[[sub_id]]
      }
    }
  }
  out
    
  }
)

#' @title
#' Initialize Option Container (char)
#'
#' @description 
#' See generic: \code{\link[optionr]{initializeOptionContainer}}
#'      
#' @inheritParams initializeOptionContainer
#' @param id \code{\link{character}}.
#' @return \code{\link{environment}}. The option container.
#' @example inst/examples/initializeOptionContainer.r
#' @seealso \code{
#'    \link[optionr]{initializeOptionContainer}
#' }
#' @template author
#' @template references
#' @aliases initializeOptionContainer-char-method
#' @export
setMethod(
  f = "initializeOptionContainer", 
  signature = signature(
    id = "character"
  ), 
  definition = function(
    id,
    sub_id,
    components,
    check,
    hidden,
    overwrite,
    ...
  ) {
  
  components <- match.arg(components, c("options", ".meta", ".registry"),
    several.ok = TRUE)    
  sub_id <- as.character(sub_id)
    
  id_0 <- id
  if (hidden) {
    id <- paste0(".", id)
  } 

  out <- if (is.null(getOption(id))) {    
    opts <- ensureOptionContainer(id = id_0, sub_id = sub_id, 
      check = check, hidden = hidden)
    if (length(sub_id)) {
      if (!exists(sub_id, envir = opts, inherits = FALSE)) {
        assign(sub_id, new.env(parent = emptyenv()), envir = opts)  
      }
      opts <- opts[[sub_id]]
    }
    if ("options" %in% components) {
      initializeProjectOptions(where = opts)
    }
    if (".meta" %in% components) {
      initializeMeta(where = opts)
    }
    if (".registry" %in% components) {
      initializeRegistry(where = opts)
    }
    opts
  } else {
    ## This ensures that pass-by-reference still works as the same environment
    ## object is re-used again //
    if (overwrite) {
      opts <- getOption(id)  
      if (length(sub_id)) {
        if (!exists(sub_id, envir = opts, inherits = FALSE)) {
          assign(sub_id, new.env(parent = emptyenv()), envir = opts)  
        }
        opts <- opts[[sub_id]]
      }
      rm(list = ls(opts, all.names = TRUE), envir = opts)
      if ("options" %in% components) {
        initializeProjectOptions(where = opts)
      }
      if (".meta" %in% components) {
        initializeMeta(where = opts)
      }
      if (".registry" %in% components) {
        initializeRegistry(where = opts)
      }
      opts
    } else {
      opts <- getOption(id)  
      if (!exists(sub_id, envir = opts, inherits = FALSE)) {
        assign(sub_id, new.env(parent = emptyenv()), envir = opts)  
      }
      if (length(sub_id)) {
        opts <- opts[[sub_id]]
      }
    }
  }
  out
    
  }
)

