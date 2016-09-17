#' Read expenses
#'
#' Read record of expenses of the current database.
#' @return Dataframe with record of expenses of the current database.
#' @export
read_expenses <- function(){
  transactions <- read.table("expenses.txt", header = T, sep = "\t")

  if(nrow(transactions) != 0){
    transactions <- read.table("expenses.txt", header = T, sep = "\t", colClasses = c("character", "numeric", "character", "character", "character", "character", "character"))
  }

  return(transactions)
}

#' Read incomes
#'
#' Read record of incomes of the current database.
#' @return Dataframe with record of incomes of the current database.
#' @export
read_incomes <- function(){
  transactions <- read.table("incomes.txt", header = T, sep = "\t")

  if(nrow(transactions) != 0){
    transactions <- read.table("incomes.txt", header = T, sep = "\t", colClasses = c("character", "numeric", "character", "character", "character", "character"))
  }

  return(transactions)
}

#' Add expense
#'
#'Add an expense to current database
#'@export
spent <- function(date = "default", value = "default", account = "default", situation = "default", type = "default", subtype = "default", obs = "default"){
  expenses <- read_expenses()

  load("info.RData")
  if(date == "default") {
    if(info$expenses_defaults$date == "today") date <- Sys.Date() else date <- info$expenses_defaults$date
  }
  if(value == "default") value <- info$expenses_defaults$value
  if(account == "default") account <- info$expenses_defaults$account
  if(situation == "default") situation <- info$expenses_defaults$situation
  if(type == "default") type <- info$expenses_defaults$type
  if(subtype == "default") subtype <- info$expenses_defaults$subtype
  if(obs == "default") obs <- info$expenses_defaults$obs

  if(class(date) == "Date") date <- as.character(date)

  new.transaction <- c(date, value, account, situation, type, subtype, obs)
  if(length(new.transaction) != 7) stop("Something happened. New transaction has not 7 elements.")

  expenses[nrow(expenses) + 1, ] <- new.transaction

  backup_expenses()

  write.table(expenses, file = "expenses.txt", quote = F, sep = "\t", row.names = F)

  print("Transaction recorded with success!")
}


#' Add income
#'
#'Add an income to current database
#'@export
earned <- function(date = "default", value = "default", account = "default", situation = "default", source = "default", obs = "default"){
  incomes <- read_incomes()

  load("info.RData")
  if(date == "default") {
    if(info$incomes_defaults$date == "today") date <- Sys.Date() else date <- info$incomes_defaults$date
  }
  if(value == "default") value <- info$incomes_defaults$value
  if(account == "default") account <- info$incomes_defaults$account
  if(situation == "default") situation <- info$incomes_defaults$situation
  if(source == "default") source <- info$incomes_defaults$source
  if(obs == "default") obs <- info$incomes_defaults$obs

  if(class(date) == "Date") date <- as.character(date)

  new.transaction <- c(date, value, account, situation, source, obs)
  if(length(new.transaction) != 6) stop("Something happened. New transaction has not 6 elements.")

  incomes[nrow(incomes) + 1, ] <- new.transaction

  backup_incomes()

  write.table(incomes, file = "incomes.txt", quote = F, sep = "\t", row.names = F)

  print("Transaction recorded with success!")
}


#' Erase transaction
#'
#' Erase a transaction from the record.
#' @param n A vector with the positions of the transactions to be excluded, 1 being the most recent one.
#' @param type Type of transaction, either "expenses" or "incomes".
#' @export
erase_transaction <- function(n = 1, type = "expenses"){
  type <- grep(type, c("expenses", "incomes"))
  if(!(type %in% c(1, 2))) stop("Wrong type!")

  transactions <- switch(type,
                         read_expenses(),
                         read_incomes())

  n.transactions <- nrow(transactions)
  n <- (n.transactions:1)[n]

  transactions <- transactions[-n,]

  switch(type,
         backup_expenses(),
         backup_incomes())

  switch(type,
         write.table(transactions, file = "expenses.txt", quote = F, sep = "\t", row.names = F),
         write.table(transactions, file = "incomes.txt", quote = F, sep = "\t", row.names = F))

  cat("Transaction(s) successfully erased from current database.\n\nLast transaction in record:\n\n")
  print(tail(transactions, 1))
}
