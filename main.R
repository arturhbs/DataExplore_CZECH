# libraries import
library(dplyr)
library(ggplot2)
source("transform_data.R")

# Read files

files <- list.files(pattern = "*.asc", path = ".", all.files = TRUE, full.names = TRUE)

df_account_raw <- read.csv2(files[1]) %>% as_tibble()
df_credit_card_raw <- read.csv2(files[2]) %>% as_tibble()
df_client_raw <- read.csv2(files[3]) %>% as_tibble()
df_disposition_raw <- read.csv2(files[4]) %>% as_tibble()
df_district_raw <- read.csv2(files[5]) %>% as_tibble()
df_loan_raw <- read.csv2(files[6]) %>% as_tibble()
df_order_raw <- read.csv2(files[7]) %>% as_tibble()
df_transaction_raw <- read.csv2(files[8]) %>% as_tibble()

df_account_raw 
  # date = YYMMDD // new  POPLATEK MESICNE -> monthly ; POPLATEK TYDNE weekly ; POPLATEK PO OBRATU -> afterTransaction
df_credit_card_raw
  # date = YYMMDD
df_client_raw 
  # birth number - YYMMDD for men and YYMMDD+50DD for women
df_disposition_raw # 
df_district_raw 
  # field names = A1 -> district_id; A2 -> district_name; A3->region; A4-> num_inhabitants; A5-> municipal_499; 
  # A6->  municipal_500K_2K; A7->municipal_2K_10K ; A8 -> municipal_10K; A9 -> num_city; A10 -> ratio_urban_inhabit; 
  # A11 -> avg_salary; A12 -> unemploy_rate_95; A13 -> unemploy_rate_96 ; A14 -> entrepreneurs_1K_inhabit; 
  # A15-> num_crimes_95; A16-> num_crimes_96
df_loan_raw
  # date = YYMMDD
  # status = A -> c_finished; B -> c_finished_loan_unpaid; C -> c_running; D -> c_running_debt
df_order_raw 
  # K_symbol_meaning POJISTNE -> insurrance_payment ; SIPO -> household_payment ; LEASING -> leasing ; UVER -> loan_payment
df_transaction_raw
  # date = YYMMDD
  # type = PRIJEM -> credit VYDAJ -> withdrawal
  # operation = VYBER KARTOU -> credit card withdrawal; VKLAD -> credit_cash ; PREVOD Z UCTU -> collection_another_bank ; VYBER-> withdrawal_cash ; PREVOD NA UCET -> remittance_another_bank
  # k_symbol = POJISTNE -> insurrance_payment ; SLUZBY -> payment_statement ; UROK -> interest_credited; SANKC. UROK -> interested_neg_balance; SIPO -> household_payment ; DUCHOD -> old_age_pension; UVER -> loan_payment




# Call transform data

df_account <- transformAccount(df_account_raw)
df_credit_card <- transformCreditCard(df_credit_card_raw)
df_client <- transformClient(df_client_raw)
df_disposition <- transformDisposition(df_disposition_raw)
df_district <- transformDistrict(df_district_raw)
df_loan <- transformLoan(df_loan_raw)
df_order <- transformOrder(df_order_raw)
df_transaction <- transformTransaction(df_transaction_raw)


df_account %>% as_tibble()
