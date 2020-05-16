rm(list=ls())
library(tidyverse)
library(readxl)
library(lubridate)
library(stringr)
library(zoo)

remove_acentos <- function(x) iconv(x, to = "ASCII//TRANSLIT")

info_munic <- read.csv2('data/informacoes_municipais_seade.csv', stringsAsFactors = F) %>% 
  mutate(munic = tolower(munic),
         munic = remove_acentos(munic),
         munic = trimws(munic),
         munic = str_replace_all(munic, '-', ' '))

# info_munic %>% 
#   group_by(codigo_ibge) %>% 
#   summarise(n = n_distinct(munic)) %>% 
#   filter(n>1)

arquivo_xlsx <- 'data/Municipios informacoes dia.xlsx'

df <- excel_sheets(arquivo_xlsx) %>% 
  map(function(x){
    tabela <- read_excel(arquivo_xlsx, x)
    
    if(length(tabela) < 3) {
      n <- str_which(tabela[[1]], "Cidade")
      
      tabela_casos <- tabela %>% 
        slice(1:(n-2))
      
      names(tabela_casos) <- c('munic', 'casos')
      
      tabela_obitos <- tabela %>% 
        slice((n+1):n())
      
      names(tabela_obitos) <- c('munic', 'obitos')
      
      tabela <- full_join(tabela_casos, tabela_obitos, by = 'munic')
    }

    tabela <- tabela %>% 
      mutate(dia_mes = x,
             dia = as.numeric(substr(dia_mes, 1,2)),
             mes = substr(dia_mes, 4, 6),
             mes = replace(mes, mes == 'mar', 3),
             mes = replace(mes, mes == 'abr', 4),
             mes = replace(mes, mes == 'mai', 5),
             mes = as.numeric(mes)) %>% 
      select(-dia_mes)
    
    names(tabela) <- c('munic', 'casos', 'obitos', 'dia', 'mes')
    
    tabela <- tabela %>% 
      mutate(munic = tolower(munic),
             munic = remove_acentos(munic),
             munic = str_replace_all(munic, '-', ' '),
             munic = str_replace_all(munic, '\\?', ''),
             munic = str_replace_all(munic, '\\?', ''),
             munic = trimws(munic),
             casos = as.numeric(casos),
             obitos = as.numeric(obitos)) %>% 
      filter(!is.na(munic)) %>%
      filter(munic != 'total') %>% 
    filter(munic != 'total geral')

  })  %>% 
  reduce(bind_rows) %>% 
  left_join(info_munic, by = 'munic') %>% 
  select(-munic) %>% 
  left_join(info_munic %>% 
              filter(grafia_correta == 1) %>% 
              select(codigo_ibge, munic),
            by = 'codigo_ibge') %>% 
  select(munic, casos, obitos, dia, mes, codigo_ibge, latitude, longitude) %>% 
  mutate(datahora = make_date(year = '2020', month = mes, day = dia),
         casos = replace(casos, is.na(casos), 0),
         obitos = replace(obitos, is.na(obitos), 0),
         casos_mm7d = rollapply(casos, 7, mean, align = 'right', fill = NA),
         obitos_mm7d = rollapply(obitos, 7, mean, align = 'right', fill = NA),
         letalidade = obitos / casos
         ) %>% 
  group_by(codigo_ibge) %>% 
  arrange(datahora) %>% 
  mutate(casos_novos = casos - lag(casos, 1),
         obitos_novos = obitos - lag(obitos, 1),
  ) %>% 
  ungroup
  

df <- df %>% 
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
      mutate(pop_60 = Populaçăo.de.60.a.64.Anos. + 
               Populaçăo.de.65.a.69.Anos. +
               Populaçăo.de.70.a.74.Anos.+
               Populaçăo.de.75.Anos.e.Mais.) %>% 
      select(codigo_ibge, pop_60), 
      by = 'codigo_ibge') %>% 
  select(-map_mun, munic) %>% 
  mutate(casos_pc = casos / pop * 100000,
         obitos_pc = obitos / pop * 100000,
         map_leg = cut(x = casos,
                       breaks = c(-Inf, 0, 9, 24, 49, 74, 99, 149, Inf),
                       labels = c('0', '<10', '<25', '<50', '<75', '<100', '<150', '>150')),
         map_leg_s = cut(x = casos,
                         breaks = c(-Inf, 0, 9, 24, 49, 74, 99, 149, Inf),
                         labels = c(8:1))
         ) %>% 
  filter(!is.na(codigo_ibge)) %>% 
  select(nome_munic, codigo_ibge, dia, mes, datahora, 
         casos, casos_novos, casos_pc, casos_mm7d,
         obitos, obitos_novos, obitos_pc, obitos_mm7d,
         letalidade, nome_ra, cod_ra, nome_drs, cod_drs, pop, pop_60, area,
         map_leg, map_leg_s, latitude, longitude)
  
df %>% 
  write_csv2('data/dados_covid_sp.csv')

df %>% 
  write.csv2('data/dados_covid_sp_latin2.csv', row.names = F, fileEncoding = 'Latin2')

df %>% 
  write.csv2('data/dados_covid_sp_latin1.csv', row.names = F, fileEncoding = 'Latin1')

tail(df)
