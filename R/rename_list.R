
#' Rename Data Nested within a List
#'
#' Loops through the elements of a list and adds a file id column corresponding to the provided names.
#'
#' @param list a list; list elements may or may not have names
#' @param names the names for the outer loop of the list if not already specified in the list names
#'
#' @return a list
#'
#' @export
#'
#' @examples
#'
#' #############
#' # Example 1 #
#' #############
#' # load up a directory of files
#' paths <- list.files(directory)
#' files <- lapply(paths, fread)
#'
#' # put file names into the individual files
#' rename_list(list = files, names = paths)
#'
#'
#' #############
#' # Example 2 #
#' #############
#' # This example is similar to ea_extract, but note that we don't have to provide model descriptions up front
#'
#' # generate data: think of these functions as va functions
#' library(plyr)
#' regression <- function(){
#'   x1 <- matrix(1:100, nrow = 50)
#'   x2 <- data.frame(a = runif(14), b = rnorm(14))
#'   x3 <- data.frame(rdply(56, sample(rnorm(50), 2)))
#'   x4 <- list(a = data.frame(rdply(20, rnorm(3))),
#'   		b = data.frame(rdply(5, runif(5))))
#'   return(list(va_ests_out = x2, va_coeffs_out = x2, va_studresids_out = x3, va_varcov_out = x4))
#' }
#'
#' within_r2 <- function(){
#' 	x = data.frame(resid_var = rnorm(1), within_r2 = sample(1:10, 1))
#' 	return(x)
#' }
#'
#' ---------------------------------------------------------------------
#'
#' # run analysis on different models - will not have model descriptions
#' output <- lapply(1:5, function(i){
#' 	rg <- regression()
#' 	r2 <- within_r2()
#' 	if(i%%2==0) test_null <- NULL else test_null <- c(1,2,3)
#' 	return( list(regression = rg, r2 = r2, test_null = test_null) )
#' })
#'
#' # rename the outer elements of output list
#' names(output) <- paste0("model_", 1:5)
#'
#' # rename the nested elements of list (all the nested data structures)
#' named_output <- rename_list(output)
#'
#' # extract data - now has model descriptions
#' extract <- extract_list(named_output)
#'

# main function
rename_list <- function(list, names = NULL){

  ########################################
  # Extract List Name and Error Checking #
  ########################################

  # if the names are provided as a vector
  if( !is.null(names) ){

    # error message: if the names provided are not the same length as list
    if( length(list) != length(names) ) stop("Number of names provided not consistent with length of list")

    # if names are not provided, extract them from the list
  } else{
    # extract names
    names = names(list)

    # error message: if there are entries without names
    if( sum(names == "") > 0 ) stop("Please ensure all entries in list have names")
    # error message: if there are duplicated names
    if( sum(duplicated(names)) > 0 ) stop("Please ensure all entries in list has a unique name")
  }

  # run recursive function on all elements of the list
  new_l <- Map(function(l, n) aux_rename_list(l, n), list, names)

  # return the new list with names added as columns
  return(new_l)
}