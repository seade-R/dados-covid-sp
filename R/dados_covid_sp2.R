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
         ) %>%  
  group_by(codigo_ibge) %>% 
  arrange(datahora) %>% 
  mutate(casos_interpolacao = round((lead(casos, 1) + lag(casos, 1))/2)) %>% 
  mutate(obitos_interpolacao = round((lead(obitos, 1) + lag(obitos, 1))/2)) %>% 
  mutate(casos_problema = if_else((casos < lag(casos, 1)) & !is.na(lag(casos, 1)), T, F)) %>% 
  mutate(obitos_problema = if_else((obitos < lag(obitos, 1)) & !is.na(lag(obitos, 1)), T, F),
         casos_correcao = casos,
         obitos_correcao = obitos) %>% 
  ungroup()

df$casos_correcao[df$casos_problema == T] <- df$casos_interpolacao[df$casos_problema == T]
df$obitos_correcao[df$obitos_problema == T] <- df$obitos_interpolacao[df$obitos_problema == T]

df <- df %>%
  group_by(codigo_ibge) %>% 
  arrange(datahora) %>% 
  mutate(casos_novos = casos_correcao - lag(casos_correcao, 1),
         obitos_novos = obitos_correcao - lag(obitos_correcao, 1),
  ) %>% 
  ungroup %>% 
  mutate(letalidade = obitos / casos,
         casos_mm7d = rollapply(casos_novos, 7, mean, align = 'right', fill = NA),
         obitos_mm7d = rollapply(obitos_novos, 7, mean, align = 'right', fill = NA)
  ) %>% 
  mutate(casos_novos = replace(casos_novos, casos_novos < 0, 0)) %>% 
  mutate(obitos_novos = replace(obitos_novos, obitos_novos < 0, 0)) %>% 
  mutate(casos_mm7d = replace(casos_mm7d, casos_mm7d < 0, 0)) %>% 
  mutate(obitos_mm7d = replace(obitos_mm7d, obitos_mm7d < 0, 0)) 
  
# df %>%
  # filter(munic == 'vinhedo') %>% View
  # filter(casos_problema) %>% 
  # filter(!is.na(codigo_ibge)) %>% 
  # filter(casos_novos < 0) %>%
  # filter(munic == 'itapeva') %>%
  # select(datahora, munic, codigo_ibge, casos, casos_novos, casos_interpolacao, casos_problema) %>% 
  # View
         



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

# 
# 
# df2 %>% 
#   filter(nome_munic == 'Santos') %>% 
#   select(casos, casos_novos, casos_interpolacao, casos_correcao, datahora)
# 
# 
# 
#          correcoes[1] <- F
# correcoes[length(correcoes)] <- F
# 
# df$casos_novos[correcoes]
# df$casos_correcao <- df$casos
# df$casos_correcao[correcoes] <- (round((lead(df$casos, 1) + lag(df$casos, 1))/2) - 1)[correcoes]
# 
# 
# df2 <- df %>% 
#   filter(nome_munic == 'Santos') %>% 
#   group_by(codigo_ibge) %>% 
#   arrange(datahora) %>% 
#   mutate(casos_novos2 = casos_correcao - lag(casos_correcao, 1)) 
# 
# df2$casos_correcao
# 
# df2 %>% 
#   filter(nome_munic == 'Santos') %>% 
#   ggplot(aes(x = datahora, y = casos_novos)) +
#   geom_line()
# 
# df2 %>% 
#   filter(nome_munic == 'Santos') %>% 
#   ggplot(aes(x = datahora, y = casos_novos2)) +
#   geom_line()
# 
# 
# i_correcoes <- (df$casos_novos < 0)
# 
# df[i_correcoes | is.na(i_correcoes),]
# [2:(nrow(df) - 1)]
# i_correcoes
# 
# df$casos_correcao <- NA
# df$casos_correcao
# 
# ?lag
