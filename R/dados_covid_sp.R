rm(list=ls())
library(tidyverse)
library(readxl)
library(lubridate)
library(stringr)

remove_acentos <- function(x) iconv(x, to = "ASCII//TRANSLIT")

info_munic <- read.csv2('data/informacoes_municipais_seade.csv') %>% 
  mutate(munic = tolower(munic),
         munic = remove_acentos(munic),
         munic = trimws(munic),
         munic = str_replace_all(munic, '-', ' '))

info_munic %>% 
  group_by(codigo_ibge) %>% 
  summarise(n = n_distinct(munic)) %>% 
  filter(n>1)

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
  mutate(casos = replace(casos, is.na(casos), 0),
         obitos = replace(obitos, is.na(obitos), 0))

df <- df %>% 
  left_join(
    read_csv2('data/ra.csv') %>% 
      select(-munic), 
    by = 'codigo_ibge') %>% 
  left_join(
    read.csv2('data/imp.csv', fileEncoding = 'Latin2', )[,c(1, 3,10)] %>% 
      rename(codigo_ibge = `Cód..IBGE`, pop = `Populaçăo.`, nome_munic = Localidades),
    by = 'codigo_ibge') %>% 
  left_join(
    read_csv2('data/drs.csv') %>% 
      select(-cod_ra), 
    by = 'codigo_ibge') %>% 
  left_join(
    read_csv2('data/nome_drs.csv'), 
    by = 'cod_drs') %>% 
  mutate(datahora = make_date(year = '2020', month = mes, day = dia)) %>%
  select(-map_mun, munic) %>% 
  mutate(map_leg = cut(x = casos,
                       breaks = c(-Inf, 0, 9, 24, 49, 74, 99, 149, Inf),
                       labels = c('0', '<10', '<25', '<50', '<75', '<100', '<150', '>150')),
         map_leg_s = cut(x = casos,
                         breaks = c(-Inf, 0, 9, 24, 49, 74, 99, 149, Inf),
                         labels = c(8:1)),
         letalidade = obitos / casos ) %>% 
  filter(!is.na(codigo_ibge)) %>% 
  select(nome_munic, codigo_ibge, dia, mes, datahora, casos, obitos, letalidade, 
         nome_ra, cod_ra, nome_drs, cod_drs, pop, map_leg, map_leg_s,
         latitude, longitude, pop)
  
df %>% 
  write_csv2('data/dados_covid_sp.csv')

df %>% 
  write.csv2('data/dados_covid_sp_latin2.csv', row.names = F, fileEncoding = 'Latin2')

tail(df)