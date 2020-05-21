remove_acentos <- function(x) iconv(x, to = "ASCII//TRANSLIT")

info_munic <- read.csv2('data/informacoes_municipais_seade.csv', stringsAsFactors = F) %>% 
  mutate(munic = tolower(munic),
         munic = remove_acentos(munic),
         munic = trimws(munic),
         munic = str_replace_all(munic, '-', ' '))

arquivo_xlsx <- 'data/Municipios informacoes dia.xlsx'

df2 <- excel_sheets(arquivo_xlsx) %>% 
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
  mutate(
    datahora = make_date(year = '2020', month = mes, day = dia),
    ) %>% 
  left_join(
    info_munic, 
    by = 'munic') %>% 
  mutate(
    codigo_ibge = replace(codigo_ibge, is.na(codigo_ibge), 9999999)
    ) %>% 
  select(munic, datahora, casos, obitos, dia, mes, codigo_ibge, latitude, longitude) %>% 
  # complete(
  #   datahora, 
  #   nesting(codigo_ibge),
  #   fill = list(casos = 0, obitos = 0)
  # ) %>% 
  filter(datahora > ymd('2020-05-17')) %>% 
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
  select(nome_munic, codigo_ibge, dia, mes, datahora, 
         casos, obitos, latitude, longitude,
         nome_ra, cod_ra, nome_drs, cod_drs, pop, pop_60, area)

