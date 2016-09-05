#' View current accounts
#'
#' Returns a list with the names and currencies of the accounts in the current database.
#' @return A list in which the first element is a vector of the names, and the second one is a vector of the currencies of each of the accounts in the current database.
#' @export

view_accounts <- function(){
  load("info.RData")
  return(info$accounts)
}

#' Add new account
#'
#' Add new account to current database.
#' @export
add_account <- function(name, currency){
  load("info.RData")

  if((name %in% info$accounts$accounts)) stop("Account names must be unique. Please, choose another name for the new account.")

  info$accounts$accounts <- append(info$accounts$accounts, name)
  info$accounts$currencies <- append(info$accounts$currencies, currency)
  save(info, file = "info.RData")
}

#' Delete existing account
#'
#' Delete existing account from current database.
#' @export
rm_account <- function(name){
  load("info.RData")

  if(!(name %in% info$accounts$accounts)) stop("There is no account with such a name in the current database.")

  pos <- which(info$accounts$accounts == name)

  info$accounts$accounts <- info$accounts$accounts[-pos]
  info$accounts$currencies <- info$accounts$currencies[-pos]

  save(info, file = "info.RData")
}
