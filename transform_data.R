library(dplyr)

# transform id in char


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
  # birth number - YYMMDD for men and YYMMDD+50DD for women
  ## getting gender
  dataset <- dataset %>% 
    mutate(gender = ifelse(as.integer(substring(as.character(birth_number), 3,4))>50, "female", "male"))
  
  ## get birth date (ps: -5000 for women and +19000000 for transform)
  
  dataset <- dataset %>% 
    mutate(birth_date = ifelse(as.integer(substring(as.character(birth_number), 3,4))>50, 
                               birth_number-5000+19000000, birth_number+19000000))
  dataset$birth_date <- as.Date(as.character(dataset[["birth_date"]]), "%Y%m%d")
  
  # remove column
  dataset$birth_number <- NULL
  
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
  
  
  # type char
  dataset['district_id'] <- as.character(dataset[['district_id']])
  

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
  # date = YYMMDD
  dataset["date"] <- as.Date(as.character(dataset[["date"]]), "%y%m%d")
  # type = PRIJEM -> credit VYDAJ -> withdrawal
  dataset <- dataset %>% 
    mutate(type_description = 
             case_when(type == "PRIJEM" ~ "credit",
                       type == "VYDAJ" ~ "withdrawal"))
  # operation = VYBER KARTOU -> credit_card_withdrawal; VKLAD -> credit_cash ; PREVOD Z UCTU -> collection_another_bank ; VYBER-> withdrawal_cash ; PREVOD NA UCET -> remittance_another_bank
  dataset <- dataset %>% 
    mutate(operation_description = 
             case_when(operation == "VYBER KARTOU" ~ "credit_card_withdrawal",
                       operation == "VKLAD" ~ "credit_cash",
                       operation == "PREVOD Z UCTU" ~ "collection_another_bank",
                       operation == "VYBER" ~ "withdrawal_cash",
                       operation == "PREVOD NA UCET" ~ "remittance_another_bank" ))
  # k_symbol = POJISTNE -> insurance_payment ; SLUZBY -> payment_statement ; UROK -> interest_credited; SANKC. UROK -> interested_neg_balance; SIPO -> household_payment ; DUCHOD -> old_age_pension; UVER -> loan_payment
  dataset <- dataset %>% 
    mutate(operation_description = 
             case_when(operation == "POJISTNE" ~ "insurance_payment",
                       operation == "SLUZBY" ~ "payment_statement",
                       operation == "UROK" ~ "interest_credited",
                       operation == "SANKC. UROK" ~ "interested_neg_balance",
                       operation == "SIPO" ~ "household_payment",
                       operation == "DUCHOD" ~ "old_age_pension",
                       operation == "UVER" ~ "loan_payment"))
  
  return(dataset)
}
