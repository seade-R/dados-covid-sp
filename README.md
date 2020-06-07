# Repositório de dados sobre casos e óbitos decorrentes do COVID-19 nos municípios do Estado de São Paulo

## Apresentação e dados

O SEADE mantém um painel de dados sobre casos e óbitos relacionados ao coronavírus no Estado de São Paulo a partir de dados oficiais da Secretaria de Estado da Saúde de São Paulo (SES). Os dados estão disponíveis em https://www.seade.gov.br/coronavirus/.

Para desenvolvedoras e desenvolvedores interessados em utilizar os dados de casos e óbitos por municípios e data, disponibilizamos a base em arquivo .csv. Faça **Download dos dados** do SEADE neste [link](https://raw.githubusercontent.com/seade-R/dados-covid-sp/master/data/dados_covid_sp.csv).

Os dados originais: 1) [Até 17.05.20](https://github.com/seade-R/dados-covid-sp/blob/master/data/Municipios%20informacoes%20dia.xlsx); 2) [Após 17.05.20](https://github.com/seade-R/dados-covid-sp/blob/master/data/sp_munic.csv)

Os **Códigos em R** para reorganização dos dados podem ser acessados [aqui](https://github.com/seade-R/dados-covid-sp/blob/master/R).

## Atualizações

- [20.05.20] A partir do dia 20.05.20, combinamos os arquivos enviados à imprensa pela Secretaria de Estado de Saúde com os dados organizados pelo Sistema de Monitoramento Inteligente (SIMI-SP), cuja fonte é também a Secretaria de Estado de Saúde.

Há novas variáveis e correções em relação às versões anteriores. As variáveis existentes desde a primeira versão e seus respectivos nomes foram mantidos.

- [21.05.20] A partir do dia 21.05.20, o SEADE eliminou incosistências nos dados de casos e óbitos totais acumulados, corrigindo decréscimos eventuais.

## Variáveis e notas

|Variável|Descrição|
|---|---|
|nome_munic| Nome do município|
|codigo_ibge| Código do município no IBGE (7 dígitos)|
|dia| Dia|
|mes| Mês|
|datahora| Data no formato YYYY-MM-DD|
|casos| Casos totais registrados até a data|
|casos_novos| Casos novos registrados na data|
|casos_pc| Casos totais por 100 mil habitantes|
|casos_mm7d| Média móvel dos últimos 7 dias dos novos casos|
|obitos| Óbitos totais registrados até a data|
|obitos_novos| Óbitos novos registrados na data|
|obitos_pc| Óbitos totais por 100 mil habitantes|
|obitos_mm7d| Média móvel dos últimos 7 dias dos novos óbitos|
|letalidade| casos / obitos|
|nome_ra| Nome da Região Administrativa|
|cod_ra| Código da Região Administrativa|
|nome_drs| Nome do Dpto. Regional de Saúde|
|cod_drs| Código do Dpto. Regional de Saúde|
|pop| População Estimada (fonte| SEADE)|
|pop60| População Estimada (fonte| SEADE)|
|area| Área do município em Km2|
|map_leg| Rótulo da legenda para mapa|
|map_leg_s| Código da legenda para mapa|
|latitude| Latitude|
|longitude| Longitude|
|semana_epidem| Semana Epidemológica|

Encoding do arquivo dados_covid_sp.csv = UTF-8

## Informações adicionais

Fonte dos dados: Secretaria de Estado da Saúde de São Paulo (SES)

Atualização: diária, definida pelo horário de recebimento dos dados, exceto aos finais de semana e feriados.

Autoria: [Fundação SEADE](https://www.seade.gov.br/)

Dúvidas, críticas e sugestões sobre os dados de casos e óbitos municipais: enviar e-mail para Leonardo [leonardobarone@seade.gov.br](leonardobarone@seade.gov.br) e Cássia [cassiaadduci@seade.gov.br](cassiaadduci@seade.gov.br).

Por favor, pedimos a gentileza para que solicitações de dados não disponibilizados neste repositório sejam enviadas diretamente às fontes primárias.
