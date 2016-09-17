#' Create a new database
#'
#' Creates a new blank database of finance records in the current working directory.
#'
#' @export

create_db <- function(name = "rdough"){
  in.cur.dir <- readline(prompt = "Create database in the current working directory? (y/n) ")

  if(in.cur.dir == "n"){
    stop("Set the desired directory as the working directory before creating a new database.")
  } else if(in.cur.dir == "y"){

    if(file.exists("info.RData")) stop("There is already a database in the current directory. Please, either change directories or erase existing database before proceeding.")

    system(paste0("echo 'Version: 1.0

RestoreWorkspace: Default
SaveWorkspace: Default
AlwaysSaveHistory: Default

EnableCodeIndexing: Yes
UseSpacesForTab: Yes
NumSpacesForTab: 4
Encoding: UTF-8

RnwWeave: knitr
LaTeX: pdfLaTeX' > ", name, ".Rproj"))

    info <- list(rdough_version = 0.3, date_create = Sys.Date(), last_update = Sys.Date(), accounts = list(accounts = "main", currencies = "EUR"), expenses_defaults = list(date = "today", value = 1, account = "main", situation = "groningen", type = "food", subtype = "groceries", obs = ""), incomes_defaults = list(date = "today", value = 1000, account = "main", situation = "groningen", source = "meme_scholarship", obs = ""))
    save(info, file = "info.RData")

    system("echo 'date\tvalue\taccount\tsituation\ttype\tsubtype\tobs' > expenses.txt")

    system("echo 'date\tvalue\taccount\tsituation\tsource\tobs' > incomes.txt")

    system("mkdir history")

  } else {
    stop("Answer either y (for yes) or n (for no).")
  }
}
