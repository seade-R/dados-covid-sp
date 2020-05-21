rm(list=ls())
library(tidyverse)
library(readxl)
library(lubridate)
library(stringr)
library(zoo)

source('R/dados_covid_sp_20200225_a_2020517.R')
source('R/dados_covid_sp_apos_2020517.R')

df <- bind_rows(df1, df2) %>% 
  complete(
    datahora,
    nesting(codigo_ibge),
    fill = list(casos = 0, obitos = 0)
    ) %>%
  group_by(codigo_ibge) %>% 
  arrange(datahora) %>% 
  mutate(
    casos_novos = casos - lag(casos, 1),
    obitos_novos = obitos - lag(obitos, 1),
    casos_novos = replace(casos_novos, datahora == min(datahora), 0),
    obitos_novos = replace(obitos_novos, datahora == min(datahora), 0),
    casos_novos = replace(casos_novos, datahora == min(datahora) & codigo_ibge == 3550308, 1),
    casos_mm7d = rollapply(casos_novos, 7, mean, align = 'right', fill = NA),
    obitos_mm7d = rollapply(obitos_novos, 7, mean, align = 'right', fill = NA)
  ) %>% 
  ungroup %>% 
  left_join(
    read.csv2('data/informacoes_municipais_seade.csv', stringsAsFactors = F, dec = '.') %>% 
      filter(grafia_correta == 1) %>% 
      select(codigo_ibge, latitude, longitude),
    by = 'codigo_ibge') %>% 
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
    letalidade = obitos / casos,
    casos_pc = casos / pop * 100000,
    obitos_pc = obitos / pop * 100000,
    map_leg = cut(x = casos,
                  breaks = c(-Inf, 0, 9, 24, 49, 74, 99, 149, Inf),
                  labels = c('0', '<10', '<25', '<50', '<75', '<100', '<150', '>150')),
    map_leg_s = cut(x = casos,
                    breaks = c(-Inf, 0, 9, 24, 49, 74, 99, 149, Inf),
                    labels = 8:1)
  ) %>% 
  select(nome_munic, codigo_ibge, dia, mes, datahora, 
         casos, casos_novos, casos_pc, casos_mm7d,
         obitos, obitos_novos, obitos_pc, obitos_mm7d,
         letalidade, nome_ra, cod_ra, nome_drs, cod_drs,
         pop, pop_60, area, map_leg, map_leg_s, latitude, longitude)

df %>% 
  write_csv2('data/dados_covid_sp.csv')

df %>% 
  write.csv2('data/dados_covid_sp_latin2.csv', row.names = F, fileEncoding = 'Latin2')

df %>% 
  write.csv2('data/dados_covid_sp_latin1.csv', row.names = F, fileEncoding = 'Latin1')

tail(df)

