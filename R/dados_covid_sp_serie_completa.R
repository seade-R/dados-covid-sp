rm(list=ls())
library(tidyverse)
library(readxl)
library(lubridate)
library(stringr)
library(zoo)

source('R/dados_covid_sp_20200225_a_2020517.R')
source('R/dados_covid_sp_apos_2020517.R')


df_semana_epidem <- NULL

j = 3
s = 1

for (i in 0:365){
  
  df_semana_epidem <- bind_rows(
    df_semana_epidem,
    data.frame(
      datahora = ymd('2020-01-01') + i,
      semana_epidem = s
    )
  )
  
  j <- j + 1
  
  if(j == 7) {
    j <- 0
    s <- s + 1
  }
}  


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

# df %>% 
#   write_csv2('data/dados_covid_sp_nao_corrigida.csv')

# Correcao da serie
df <- df %>%
  arrange(codigo_ibge, datahora)

for(i in nrow(df):2) {
  
  print(i)
  
  if(df$codigo_ibge[i - 1] == df$codigo_ibge[i]){
    
    if(df$casos[i - 1] > df$casos[i]){
      
      j <- i
      
      l <- 0
      
      while(df$casos[j - 1] > df$casos[i]) {
        j <- j -1
        l <- l + 1
      }
      
      h <- (df$casos[i] - df$casos[j - 1]) / (l + 1)
      
      m <- 1
      
      for(k in j:(i-1)) {
        df$casos[k] <- round(df$casos[j - 1] + h * m)
        m <- m + 1
      }
      
    }
    
  }
  
}

for(i in nrow(df):2) {
  
  print(i)
  
  if(df$codigo_ibge[i - 1] == df$codigo_ibge[i]){
    
    if(df$obitos[i - 1] > df$obitos[i]){
      
      j <- i
      
      l <- 0
      
      while(df$obitos[j - 1] > df$obitos[i]) {
        j <- j -1
        l <- l + 1
      }
      
      h <- (df$obitos[i] - df$obitos[j - 1]) / (l + 1)
      
      m <- 1
      
      for(k in j:(i-1)) {
        df$obitos[k] <- round(df$obitos[j - 1] + h * m)
        m <- m + 1
      }
      
    }
    
  }
  
}

df <- df %>% 
  group_by(codigo_ibge) %>% 
  arrange(datahora) %>% 
  mutate(
    casos_novos = casos - lag(casos, 1),
    obitos_novos = obitos - lag(obitos, 1),
    casos_novos = replace(casos_novos, datahora == min(datahora), 0),
    obitos_novos = replace(obitos_novos, datahora == min(datahora), 0),
    casos_novos = replace(casos_novos, datahora == min(datahora) & nome_munic == 'Sao Paulo', 1),
    casos_mm7d = rollapply(casos_novos, 7, mean, align = 'right', fill = NA),
    obitos_mm7d = rollapply(obitos_novos, 7, mean, align = 'right', fill = NA)
  ) %>%   ungroup %>% 
  mutate(
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

df_sp_munic <- df %>% 
  filter(codigo_ibge != 9999999) %>%
  group_by(datahora) %>% 
  summarise(casos = sum(casos),
            obitos = sum(obitos)) 

df_sp_uf <- read_csv2('data/sp.csv') %>%  
  rename(casos_sp = casos_acum, obitos_sp = obitos_acum) %>% 
  select(datahora, casos_sp, obitos_sp) 

df_sp_munic <- df_sp_munic %>% 
  left_join(df_sp_uf, by = 'datahora') %>% 
  mutate(
    casos_sp = replace_na(casos_sp, replace = 0),
    obitos_sp = replace_na(obitos_sp, replace = 0),
    casos = casos_sp - casos,
    obitos = obitos_sp - obitos,
    casos_novos = casos - lag(casos, 1),
    obitos_novos = obitos - lag(obitos, 1),
    casos_novos = replace(casos_novos, datahora == min(datahora), 0),
    obitos_novos = replace(obitos_novos, datahora == min(datahora), 0),
    casos_mm7d = rollapply(casos_novos, 7, mean, align = 'right', fill = NA),
    obitos_mm7d = rollapply(obitos_novos, 7, mean, align = 'right', fill = NA),
    codigo_ibge = 9999999,
    nome_munic = 'Ignorado',
    letalidade = obitos / casos,
    dia = day(datahora),
    mes = month(datahora),
    casos_pc = 0,
    obitos_pc = 0,
    map_leg = '',
    map_leg_s = '',
    nome_ra = '',
    cod_ra = 0,
    nome_drs = '',
    cod_drs = 0,
    pop = 0,
    pop_60 = 0,
    area = 0,
    latitude = 0,
    longitude = 0
  ) %>% 
  select(-casos_sp, -obitos_sp)

df <- df %>% 
  filter(codigo_ibge != 9999999) %>%
    bind_rows(
    df_sp_munic
  ) %>% 
  mutate(
    letalidade = replace(letalidade, casos == 0, 0),
    casos_mm7d = replace_na(casos_mm7d,0),
    obitos_mm7d = replace_na(obitos_mm7d,0)
  )  %>% 
  left_join(
    df_semana_epidem,
    by = 'datahora'
  )
  

df %>% View

df %>% 
  write_csv2('data/dados_covid_sp.csv')

df %>% 
  # filter(casos != 0) %>% 
  write.csv2('data/dados_covid_sp_latin1.csv', row.names = F, fileEncoding = 'Latin1')

# df %>% nrow
# 
# df %>% 
#   filter(casos != 0) %>% nrow
#   