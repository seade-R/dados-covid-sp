df1 <- read_csv2('data/sp_munic.csv') %>%
  rename(
    datahora = date, 
    casos = cases, 
    obitos = deaths, 
    codigo_ibge = city_ibge_code,
    nome_munic = city,
  ) %>%
  mutate(
    datahora = ymd(datahora),
  ) %>% 
  select(codigo_ibge, datahora, casos, obitos)
