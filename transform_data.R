library(dplyr)



transformAccount <- function(dataset){
 
  # date = YYMMDD 
  dataset["date"] <- as.Date(as.character(dataset[["date"]]), "%y%m%d")
  # add new column for frequency description
  dataset <- dataset %>% 
    mutate(frequency_description = 
             case_when(frequency == "POPLATEK MESICNE" ~ "monthly",
                       frequency == "POPLATEK TYDNE" ~ "weekly", 
                       frequency == "POPLATEK PO OBRATU" ~ "after transaction"))
  return(dataset)
}


transformCreditCard <- function(dataset){
  dataset["issued"] <- as.Date(dataset[["issued"]], "%y%m%d %H:%M:%S")
  return(dataset)
}


transformClient <- function(dataset){
  
  return(dataset)
}

transformDisposition <- function(dataset){
  
  return(dataset)
}

transformDistrict <- function(dataset){
  
  return(dataset)
}

transformLoan <- function(dataset){
  
  return(dataset)
}

transformOrder <- function(dataset){
  
  return(dataset)
}

transformTransaction <- function(dataset){
  
  return(dataset)
}