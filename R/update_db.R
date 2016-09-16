#' Update database
#'
#' Updates current database to the most recent version of rdough.
#' @export
update_db <- function(){
  load("info.RData")
  if(info$rdough_version == 0.1){
    info$rdough_version <- 0.2
    save(info, file = "info.RData")
    cat("v0.1 --> v0.2\tOK\n")
  } else {stop("ERROR! Unknown version!")}
}
