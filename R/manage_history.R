#' Backup expenses
#'
#' Save a copy of the expenses record in the history folder of the current database.
backup_expenses <- function(){
  file.copy("expenses.txt", paste0("history/expenses ", as.character(Sys.time()), ".txt"))
}

#' Backup incomes
#'
#' Save a copy of the incomes record in the history folder of the current database.
backup_incomes <- function(){
  file.copy("incomes.txt", paste0("history/incomes ", as.character(Sys.time()), ".txt"))
}
