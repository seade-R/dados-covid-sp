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
  select(codigo_ibge, nome_munic, datahora, casos, obitos) %>% 
  # complete(
  #   datahora, 
  #   nesting(codigo_ibge, nome_munic),
  #   fill = list(casos = 0, obitos = 0)
  #   ) %>% 
  left_join(
    read.csv2('data/informacoes_municipais_seade.csv', stringsAsFactors = F) %>% 
      filter(grafia_correta == 1) %>% 
      select(codigo_ibge, latitude, longitude),
    by = 'codigo_ibge') %>% 
  select(-nome_munic) %>% 
  left_join(
    read_csv2('data/ra.csv'), 
    by = 'codigo_ibge') %>% 
  left_join(
    read_csv2('data/drs.csv') %>% 
      select(-cod_ra), 
    by = 'codigo_ibge') %>% 
  left_join(
    read_csv2('data/nome_drs.csv'), 
    by = 'cod_drs') %>% 
  left_join(
    read.csv2('data/imp.csv', fileEncoding = 'Latin2') %>% 
      mutate(
        pop_60 = Populaçăo.de.60.a.64.Anos. + 
          Populaçăo.de.65.a.69.Anos. +
          Populaçăo.de.70.a.74.Anos.+
          Populaçăo.de.75.Anos.e.Mais.
        ) %>% 
      select(
        codigo_ibge,
        pop_60), 
    by = 'codigo_ibge') %>% 
  mutate(
    dia = day(datahora),
    mes = month(datahora),
  ) %>% 
  select(nome_munic, codigo_ibge, dia, mes, datahora, 
         casos, obitos, latitude, longitude,
         nome_ra, cod_ra, nome_drs, cod_drs, pop, pop_60, area)
