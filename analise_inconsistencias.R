df %>% 
  filter(casos_novos < 0) %>% 
  group_by(casos_novos) %>% 
  count %>% 
  arrange(-n, -casos_novos) %>% 
  ungroup() %>% 
  mutate(Percentual = n / sum(n)) %>% 
  rename(Contagem = n,
         `Valor incosistente` = casos_novos) %>% 
  write.csv2('contagem_erros.csv', row.names = F)

df %>% 
  filter(casos_novos < 0) %>% 
  group_by(casos_novos) %>% 
  count %>% 
  arrange(-n, -casos_novos) %>% 
  ungroup() %>% 
  mutate(Percentual = n / sum(n)) %>% 
  rename(Contagem = n,
         `Valor incosistente` = casos_novos) %>% 
  slice(3:8) %>% 
  pull(Percentual) %>% 
  sum

unique(c(  
  df %>% 
    filter(casos_novos < 0) %>% 
    group_by(codigo_ibge, nome_munic) %>% 
    count %>% 
    pull(codigo_ibge),
  df %>% 
    filter(casos_novos < 0) %>% 
    group_by(codigo_ibge, nome_munic) %>% 
    count %>% 
    pull(codigo_ibge)))

df %>% 
  filter(casos_novos < 0) %>% 
  group_by(codigo_ibge, nome_munic) %>% 
  count %>% 
  arrange(-n) %>% 
  ungroup %>% 
  filter(n>=3) %>% 
  rename(`Codigo IBGE` = codigo_ibge,
         `Municipio` = nome_munic,
         Contagem = n) %>% 
  write_csv2('erros_municipios.csv')

df %>% 
  filter(casos_novos < -5) %>% 
  select(codigo_ibge, nome_munic, datahora, casos_novos) %>% 
  arrange(casos_novos) %>% 
  rename(`Codigo IBGE` = codigo_ibge,
         `Municipio` = nome_munic,
         `Data` = datahora,
         `Valor incosistente` = casos_novos) %>% 
  write_csv2('maiores_erros.csv')

df %>% filter(codigo_ibge  == 3548807) %>% 
  filter(datahora >= ymd('2020-05-10')) %>% 
  select(codigo_ibge, nome_munic, datahora, casos, casos_novos) %>% 
  rename(`Código IBGE` = codigo_ibge,
         `Municipio` = nome_munic,
         `Data` = datahora,
         `Total de casos` = casos,
         `Casos Novos` = casos_novos) %>%
  head %>% 
  write_csv2('sao_caetanos.csv')

df %>% filter(codigo_ibge  == 3509502) %>% 
  filter(datahora >= ymd('2020-05-05')) %>%
  # filter(casos_novos < 0) %>% 
  select(codigo_ibge, nome_munic, datahora, casos, casos_novos) %>% 
  rename(`Código IBGE` = codigo_ibge,
         `Municipio` = nome_munic,
         `Data` = datahora,
         `Total de casos` = casos,
         `Casos Novos` = casos_novos) %>%
  head %>% 
  write_csv2('campinas.csv')


df %>% 
  filter(obitos_novos < 0) %>% 
  group_by(obitos_novos) %>% 
  count 

df %>% 
  filter(casos_novos < 0 | obitos_novos <0) %>% 
  select(datahora, codigo_ibge, nome_munic, casos, casos_novos, obitos, obitos_novos) %>% 
  write_csv2('dados_covid_sp_inconsistencias.csv')
