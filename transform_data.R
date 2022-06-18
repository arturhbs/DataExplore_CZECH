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
  # field names = A1 -> district_id; A2 -> district_name; A3->region; A4-> num_inhabitants; A5-> municipal_499; 
  # A6->  municipal_500K_2K; A7->municipal_2K_10K ; A8 -> municipal_10K; A9 -> num_city; A10 -> ratio_urban_inhabit; 
  # A11 -> avg_salary; A12 -> unemploy_rate_95; A13 -> unemploy_rate_96 ; A14 -> entrepreneurs_1K_inhabit; 
  # A15-> num_crimes_95; A16-> num_crimes_96

  header <- c("district_id", "district_name", "region", "num_inhabitants", "municipal_499", "municipal_500K_2K",
              "municipal_2K_10K", "municipal_10K", "num_city", "ratio_urban_inhabit", "avg_salary", "unemploy_rate_95", 
              "unemploy_rate_96", "entrepreneurs_1K_inhabit", "num_crimes_95", "num_crimes_96")
  
  colnames(dataset) <- header

  return(dataset)
}

transformLoan <- function(dataset){
  # date = YYMMDD
  dataset["date"] <- as.Date(as.character(dataset[["date"]]), "%y%m%d")
  # status = A -> c_finished; B -> c_finished_loan_unpaid; C -> c_running; D -> c_running_debt
  dataset <- dataset %>% 
    mutate(status_description = 
             case_when(status == "A" ~ "c_finished",
                       status == "B" ~ "c_finished_loan_unpaid", 
                       status == "C" ~ "c_running",
                       status == "D" ~ "c_running_debt"))
  return(dataset)
}

transformOrder <- function(dataset){
  # K_symbol_meaning POJISTNE -> insurrance_payment ; SIPO -> household_payment ; LEASING -> leasing ; UVER -> loan_payment
  dataset <- dataset %>% 
    mutate(k_symbol_description = 
             case_when(k_symbol == "POJISTNE" ~ "insurrance_payment",
                       k_symbol == "SIPO" ~ "household_payment", 
                       k_symbol == "LEASING" ~ "leasing",
                       k_symbol == "UVER" ~ "loan_payment"))
  return(dataset)
}

transformTransaction <- function(dataset){
  
  return(dataset)
}