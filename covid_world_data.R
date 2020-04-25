covid_world <- read.csv("https://opendata.ecdc.europa.eu/covid19/casedistribution/csv", na.strings = "", fileEncoding = "UTF-8-BOM") %>% 
  mutate(date = ymd(paste(year, month, day, sep = '-')))

df_sp <- read.csv('/home/lasagna/Downloads/Dados-covid-19-estado(1).csv', sep = ';')

df_gglog <- bind_rows(
  # covid_world %>%
  # group_by(date) %>%
  # summarise(cases = sum(cases),
  #           deaths = sum(deaths)) %>%
  # mutate(countriesAndTerritories = 'World'),
  # df %>% 
  #   filter(munic != 'outros estados' & munic != 'outros países') %>% 
  #   mutate(date = ymd(paste('2020', mes, dia, sep = '-'))) %>% 
  #   group_by(date) %>% 
  #     summarise(cases = sum(casos, na.rm = T)) %>% 
  #     mutate(countriesAndTerritories = 'São Paulo'),
  covid_world %>% 
    filter(countriesAndTerritories %in% c('Brazil', 'Italy', 'United_States_of_America')) %>%
    select(date, cases, deaths, countriesAndTerritories)
) %>% 
  arrange(countriesAndTerritories, date) %>% 
  group_by(countriesAndTerritories) %>% 
  mutate(cum_cases = cumsum(cases))

date_100 <- df_gglog %>% 
  filter(cum_cases > 100) %>% 
  group_by(countriesAndTerritories) %>% 
  summarise(data_inicial = min(date)) %>% 
  mutate(replace)



df_gglog %>% 
  left_join(date_100, by = 'countriesAndTerritories') %>% 
  mutate(diff = as.numeric(date - data_inicial)) %>% 
  filter(diff > 0) -> df_gglog2

df_gglog2 %>% 
  ggplot() +
  # geom_smooth(aes(diff, cum_cases, color = countriesAndTerritories),
  #             method = 'loess', se = F) +
  geom_line(aes(diff, cum_cases, color = countriesAndTerritories)) +
  scale_y_log10() +
  labs(y = 'Casos',
       color = '') +
  theme(legend.position = "bottom") 
  
  
